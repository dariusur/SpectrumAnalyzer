`timescale 1ns / 1ps

module debouncer_TB();

reg clk, reset, btn_in;
wire btn_out;

debouncer DUT (.clk(clk), .reset(reset), .btn_in(btn_in), .btn_out(btn_out));

initial begin
clk = 0;
reset = 0;
btn_in = 0;
#50 reset = 1;
#50 reset = 0;
#50 btn_in = 1;
#15 btn_in = ~btn_in;
#13 btn_in = ~btn_in;
#4 btn_in = ~btn_in;
#23 btn_in = ~btn_in;
#33 btn_in = ~btn_in;
#42 btn_in = ~btn_in;
#12 btn_in = ~btn_in;
#27 btn_in = ~btn_in;
#20 btn_in = ~btn_in;
#15 btn_in = ~btn_in;
#10 btn_in = 1;
#3000000 btn_in = 0; 
end

always #5 clk = ~clk;


endmodule
