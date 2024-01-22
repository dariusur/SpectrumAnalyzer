/*
data_multiplexer.v routes the output data from the DFT core to UART_TX.v input.

PROBLEM:
RE, IM data is 12 bits long. BLK is 4 bits long.
UART module can only send packets of 8 bits in length.

SOLUTION:
The output from the DFT core contains 12 bit real and imaginary data, while the block exponent is 4 bits.
data_packer.v packs 12 bit data into two 8 bit packets by padding with zeros.
The block exponent is sent as a single 8 bit packet with leading zero padding.

EXAMPLE:
RE, IM | [1100_0000_1111] -> [0000_1100] + [0000_1111]
BLK | [1011] -> [0000_1011]
*/

module data_multiplexer(input [1:0] sel,
                        input [11:0] din_mod,
                        input [3:0] din_blk,
                        output [7:0] dout);

assign dout = (sel == 0)? din_mod[7:0] :
              (sel == 1)? {4'b0000, din_mod[11:8]} :
              (sel == 2)? {4'b0000, din_blk} : 0;
              
endmodule