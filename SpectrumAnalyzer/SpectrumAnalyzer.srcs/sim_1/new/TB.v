`timescale 1ns / 1ps

module TB();

reg clk, reset_btn, start_btn;
wire uart_rxd_out;

TOP DUT (.clk(clk), .reset_btn(reset_btn), .start_btn(start_btn), .vaux5_n(0), .vaux5_p(0), .uart_rxd_out(uart_rxd_out));

initial begin
    clk = 0;
    reset_btn = 1;
    start_btn = 0;
#120 reset_btn = 0;    
#55 start_btn = 1;
#30 start_btn = 0; 
end

always #5 clk = ~clk;

endmodule
