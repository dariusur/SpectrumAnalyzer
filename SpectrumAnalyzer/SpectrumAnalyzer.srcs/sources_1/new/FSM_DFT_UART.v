/*
FSM_DFT_UART.v controls storage of output from DFT in RWM and transmission via UART.
When all the data points defined by `MEM_SIZE are stored from the DFT, the data is then sent to the to PC via UART.
Since the DFT is computed without any imaginary data input, the two-sided plot will always be symmetrical.
Therefore, threre is no point in sending all 1200 points, instead, only half is sent (601 points).
Along with block exponent, in total, 1203 bytes (9624 bits) of data will be sent.
However, according to the UART protocol, START and STOP bits also need to be sent,
which results in 1503.75 bytes (12030 bits) of data.
For 1200 point size with 100 MHz clock frequency and 3000000 baud UART data rate, sending procedure takes ~4.01 ms,
while the sampling time for 1200 points is 27.14 ms.
This means that no samples are lost during data transmission, as the sampling of data runs in parallel
with transmission via UART.
*/

`timescale 1ns / 1ps
`define MEM_SIZE 1200

module FSM_DFT_UART(input clk, reset, start, data_ready,
                    input [11:0] din,
                    output wire rffd,
                    output wire dout);

reg fwd_inv = 1;
reg [5:0] size = 33;
wire fd_out, data_valid;
wire [11:0] data_re_DFT_RWM, data_im_DFT_RWM;
wire [3:0] data_blk_DFT_RWM;
dft_0 DFT (.CLK(clk), .SCLR(reset), .XN_RE(din), .XN_IM(0),
           .FD_IN(data_ready), .FWD_INV(fwd_inv), .SIZE(size), .RFFD(rffd),
           .XK_RE(data_re_DFT_RWM), .XK_IM(data_im_DFT_RWM), .BLK_EXP(data_blk_DFT_RWM),
           .FD_OUT(fd_out), .DATA_VALID(data_valid));

reg we_RWM;
reg [10:0] addr_RWM;
wire [11:0] data_re_RWM_mod, data_im_RWM_mod;
wire [3:0] data_blk_RWM_mux;
RWM_DFT RWM (.clk(clk), .we(we_RWM), .addr(addr_RWM), .din_re(data_re_DFT_RWM), .din_im(data_im_DFT_RWM),
              .din_blk(data_blk_DFT_RWM), .dout_re(data_re_RWM_mod), .dout_im(data_im_RWM_mod),
              .dout_blk(data_blk_RWM_mux));

wire [11:0] data_mod_mux;
modulus modulus (.clk(clk), .din_re(data_re_RWM_mod), .din_im(data_im_RWM_mod),
                               .tvalid_in(), .tvalid_out(), .dout_mod(data_mod_mux));

reg [1:0] sel_mux = 0;
wire [7:0] data_mux_UART;
data_multiplexer data_multiplexer (.sel(sel_mux), .din_mod(data_mod_mux),
                                   .din_blk(data_blk_RWM_mux), .dout(data_mux_UART));

reg send_UART = 0;
wire ready_UART;
UART_TX UART_TX (.clk(clk), .reset(reset), .send(send_UART),
                 .din(data_mux_UART), .dout(dout), .ready(ready_UART));   

// -------------- FINITE-STATE MACHINE CODE START --------------
reg [2:0] state = 0; 
localparam READY = 0, DFT_CONFIG_MEM = 1, DFT_WAIT_FOR_DATA = 2, DFT_STORE_DATA = 3,
           UART_SEND_BLK = 4, UART_WAIT_BLK = 5, UART_SEND_MOD = 6, UART_WAIT_MOD = 7;  

always @ (posedge clk) begin
if (reset) state <= READY;
else begin
    case (state)
    // DFT CODE START
    READY : if (start) state <= DFT_CONFIG_MEM; // 0
    DFT_CONFIG_MEM : begin // 1
        addr_RWM <= 0;
        we_RWM <= 1;
        state <= DFT_WAIT_FOR_DATA;
    end
    DFT_WAIT_FOR_DATA : begin // 2
        if (fd_out == 1 && data_valid == 1) begin
            addr_RWM <= addr_RWM + 1;
            state <= DFT_STORE_DATA;
        end
    end
    DFT_STORE_DATA : begin // 3
        if (data_valid && addr_RWM < (`MEM_SIZE-1)) addr_RWM <= addr_RWM + 1;
        else begin
            we_RWM <= 0;
            state <= UART_SEND_BLK;
        end 
    end
    // DFT CODE END
    
    // UART TX CODE START
    // Block exponent is sent only once because it's the same for the entire frame.    
    UART_SEND_BLK : begin // 4
        if (ready_UART) begin
            sel_mux <= 2;
            send_UART <= 1;
            addr_RWM <= 0;
            state <= UART_WAIT_BLK;
        end
    end
    UART_WAIT_BLK : begin // 5
        send_UART <= 0;
        if (!ready_UART) begin
            sel_mux <= 0;
            state <= UART_SEND_MOD;
        end
    end
    UART_SEND_MOD : begin // 6
        if (ready_UART) begin
            send_UART <= 1;
            state <= UART_WAIT_MOD;
        end
    end
    UART_WAIT_MOD : begin // 7
        send_UART <= 0;
        if (!ready_UART) begin
            if (sel_mux == 1) begin
                if (addr_RWM == (`MEM_SIZE/2)) state <= DFT_CONFIG_MEM;
                else begin
                    addr_RWM <= addr_RWM + 1;
                    sel_mux <= 0;
                    state <= UART_SEND_MOD;
                end
            end
            else begin
                sel_mux <= sel_mux + 1;
                state <= UART_SEND_MOD;
            end 
        end
    end
    // UART TX CODE END 
    
    default : state <= READY;
    endcase
end
end
// -------------- FINITE-STATE MACHINE CODE END --------------
endmodule