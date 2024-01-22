/* 
Synchronous read-write memory (RWM).
*/
`define MEM_SIZE 1200

module RWM_DFT(input clk, we,
               input [10:0] addr,
               input [11:0] din_re, din_im,
               input [3:0] din_blk,
               output reg [11:0] dout_re, dout_im,
               output reg [3:0] dout_blk);

//MEMORY STRUCTURE
//RE (MEM_SIZE) | IM (MEM_SIZE) | BLK (1)

reg [11:0] mem_re [0:(`MEM_SIZE-1)];
reg [11:0] mem_im [0:(`MEM_SIZE-1)];
reg [3:0] mem_blk;

always @ (posedge clk) begin
    if (we) begin
        mem_re[addr] <= din_re;
        mem_im[addr] <= din_im;
        mem_blk <= din_blk;
    end
    else begin
        dout_re <= mem_re[addr];
        dout_im <= mem_im[addr];
        dout_blk <= mem_blk;
    end
end

endmodule