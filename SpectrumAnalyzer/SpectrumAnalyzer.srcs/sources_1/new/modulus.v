/*
modulus.v computes the modulus of a complex number.
Addition and multiplication is performed with DSP while the square root is performed with CORDIC.

-------------------- COMMENTS ABOUT DATA FORMATTING --------------------
PROBLEM:
The DFT outputs RE and IM numbers in block floating-point representation Z = (RE + IM)*2^(BLK).
CORDIC module accepts fixed-point numbers as unsigned fraction in the range of [0 <= X <2]. 

SOLUTION:
The math works out in such way that it doesnt matter if you multiply RE and IM by BLK before modulus
or after the modulus operation. The result is the same.
Since RE and IM without the BLK are still represented as 2's complement fixed-point numbers, this allows to perform
fixed point arithemtic on RE and IM alone, rather than floating-point with BLK included. 
The output from DFT of 12 bit RE and IM numbers can take a range of [-1 <= X < 1] possible values (in decimal).
This means that the greatest absolute value number is abs(-1) = 1. In binary this is [1.000_0000_0000].
Multiplication of 1*1 that is stored in 2x12bit registers will require 2x12-1 = 23 bits to
store the output so that the MSB would represent the whole number part.
However, the problem is that CORDIC module takes only values in range of 0 <= X < 2.
So the addition, that follows multiplication of two 1's, would result in 2 which can't be represented.
The result of 2 would also require two whole part bits but the module accepts only one.
This is why within the range of output values that DFT provides (-1 <= x < 1) -1 is a problematic value and should be avoided.
To correct for this, error catching of -1 is done.
If -1 is detected then it is converted to a lower negative value which is -0.9995.
*/

(* use_dsp = "yes" *)
module modulus(input clk,
               input signed [11:0] din_re, din_im,
               input tvalid_in,
               output tvalid_out,
               output [11:0] dout_mod);

reg signed [11:0] din_re_err, din_im_err;
reg [23:0] re_err_square, im_err_square;
reg [23:0] re_im_err_square;
reg [23:0] re_im_err_square_shift;

always @ (posedge clk) begin
    // Error catching of -1
    if (din_re == 12'b1000_0000_0000) din_re_err <= din_re + 1;
    else din_re_err <= din_re;
    if (din_im == 12'b1000_0000_0000) din_im_err <= din_im + 1;
    else din_im_err <= din_im;
    // Take the absolute value of a complex number by squaring and adding RE and IM parts and then perfroming the square root
    re_err_square <= din_re_err * din_re_err;
    im_err_square <= din_im_err * din_im_err;
    re_im_err_square <= re_err_square + im_err_square;
    re_im_err_square_shift <= re_im_err_square << 1;
end

wire [23:0] tdata;
cordic_0 CORDIC (.aclk(clk), .s_axis_cartesian_tdata(re_im_err_square_shift), .s_axis_cartesian_tvalid(tvalid_in), .m_axis_dout_tdata(tdata), .m_axis_dout_tvalid(tvalid_out));

assign dout_mod = tdata[23:12];

endmodule