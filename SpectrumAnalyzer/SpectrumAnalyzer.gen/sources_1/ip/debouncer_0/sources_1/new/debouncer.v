`timescale 1ns / 1ps

module debouncer(input clk, btn_in,
                 output reg btn_out = 0);

parameter [31:0] delay_cycles = 100000; // clk_period * delay_cycles = delay
reg btn_state = 0;
reg [31:0] counter; // 2^32 = 4,294,967,296
reg reset_reg;

always @ (posedge clk) begin
    if (btn_in != btn_state) begin
        btn_state <= btn_in;
        counter <= 32'b0;
    end
    else if (counter == delay_cycles) btn_out <= btn_state;
    else counter <= counter + 1'b1; 
end

endmodule
