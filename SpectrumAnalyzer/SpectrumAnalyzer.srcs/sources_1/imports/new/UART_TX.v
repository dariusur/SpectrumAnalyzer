module UART_TX(input clk, reset, send, [7:0] din,
               output dout, ready);

parameter baud_rate = 3000000;
parameter bit_index_max = 10;
parameter [13:0] baud_timer = 100000000 / baud_rate;
localparam RDY = 2'b00, LOAD_BIT = 2'b01, SEND_BIT = 2'b10;

reg [1:0] state;
reg [13:0] timer;
reg [9:0] txData;
reg [3:0] bitIndex;
reg txBit;

always @ (posedge clk) begin
if (reset) state <= RDY;
else begin
    case (state)
    RDY :
        begin
            if (send) begin
                txData <= {1'b1, din, 1'b0};
                state <= LOAD_BIT;
            end
            timer <= 14'b0;
            bitIndex <= 4'b0;
            txBit <= 1'b1;
        end
    LOAD_BIT :
        begin
            txBit <= txData[bitIndex];
            bitIndex <= bitIndex + 1'b1;
            state <= SEND_BIT;
        end
    SEND_BIT :
        begin
        if (timer == baud_timer) begin
            timer <= 14'b0;
            if (bitIndex == bit_index_max) state <= RDY;
            else state <= LOAD_BIT;
        end
        else timer <= timer + 1'b1;
        end
    default :
        state <= RDY;
    endcase
end
end

assign dout = txBit;
assign ready = (state == RDY);

endmodule
