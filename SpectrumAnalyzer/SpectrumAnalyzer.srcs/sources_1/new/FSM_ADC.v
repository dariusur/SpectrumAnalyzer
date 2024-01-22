/*
FSM_ADC.v controls storage of data sampled from ADC in RWM and data transmission to the DFT module.
When all the data points defined by `MEM_SIZE are collected, the data is then sent to the DFT.
For 1200 point size with 44.21 kHz sampling frequency and 100 MHz clock frequency, sending procedure takes 12 us,
while the sampling period is 22.6 us.
This means that no samples are lost during data transmission.
*/

`timescale 1ns / 1ps
`define MEM_SIZE 1200

module FSM_ADC(input clk, reset, start, vauxn5, vauxp5, rffd,
               output reg data_ready = 0,
               output wire [11:0] dout);

// ADC is used in continuous mode.
// End of conversion (EOC) signal is used as enable signal to immediately output the converted value. 
wire eoc_out, drdy_out;

wire [15:0] do_out; // read only 12 MSB bits [15:4], dont read [3:0]
reg [6:0] daddr_in = 7'h15; // address of auxiliary analog input channel 5 (A1 pin)
xadc_wiz_0 ADC (.dclk_in(clk), .reset_in(reset), .daddr_in(daddr_in), .den_in(eoc_out),
                .vp_in(0), .vn_in(0), .vauxn5(vauxn5), .vauxp5(vauxp5), .do_out(do_out), .eoc_out(eoc_out),
                .drdy_out(drdy_out), .di_in(0), .dwe_in(0), .busy_out(), .channel_out(), .eos_out(),
                .ot_out(), .vccaux_alarm_out(), .vccint_alarm_out(), .user_temp_alarm_out(), .alarm_out());
                
reg we;
reg [10:0] addr;
// Convert ADC unsigned integer to signed integer with 2048 as zero (due to bias of 1.65V).
// This is done by subtracting 2048, which is equivalent to inverting the first bit.
wire [11:0] do_out_conv = {~do_out[15], do_out[14:4]};
RWM_ADC RWM (.clk(clk), .we(drdy_out), .addr(addr), .din(do_out_conv[11:0]), .dout(dout));

// -------------- FINITE-STATE MACHINE CODE START --------------
reg [1:0] state = 0;
localparam READY = 0, STORE_ADC_DATA = 1, SEND_FIRST_DATA = 2, SEND_DATA = 3;

always @ (posedge clk) begin
if (reset) begin
    data_ready = 0;
    addr <= 0;
    state <= READY;
end
else begin
case (state)
READY : if (start) state <= STORE_ADC_DATA;
STORE_ADC_DATA : begin
    if (addr == `MEM_SIZE) begin
        addr <= 0;
        if (rffd == 1) state <= SEND_FIRST_DATA;
    end
    if (drdy_out) addr <= addr + 1;
end
SEND_FIRST_DATA : begin
    data_ready <= 1;
    addr <= addr + 1;
    state <= SEND_DATA;
end
SEND_DATA : begin
    data_ready <= 0;
    if (addr == (`MEM_SIZE-1)) begin
        addr <= 0;
        state <= STORE_ADC_DATA;
    end
    else addr <= addr + 1; 
end
default : state <= READY;
endcase
end
end
// -------------- FINITE-STATE MACHINE CODE END --------------
endmodule
