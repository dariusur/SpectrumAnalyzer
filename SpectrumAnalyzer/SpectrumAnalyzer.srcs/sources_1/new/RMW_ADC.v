/* 
Synchronous read-write memory (RWM).
*/
`define MEM_SIZE 1200

module RWM_ADC(input clk, we,
               input [10:0] addr,
               input [11:0] din,
               output reg [11:0] dout);

reg [11:0] mem [0:(`MEM_SIZE-1)];

always @ (posedge clk) begin
    if (we) begin
        mem[addr] <= din;
    end
    else begin
        dout <= mem[addr];
    end
end

endmodule