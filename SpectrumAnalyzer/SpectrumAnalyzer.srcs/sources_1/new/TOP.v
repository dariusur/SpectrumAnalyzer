/* 
SpectrumAnalyzer performs a 1200-point DFT on data sampled with ADC and sends the computation result via UART to PC.
The code contains a finite-state machine (FSM) that feeds the sampled data stored in RWM (read-write memory)
to the DFT core, writes DFT output to another RWM, performs post processing by taking the modulus of a complex number and
then sends the computation result packed in 8 bit packets via UART to PC.
The received data frame is then graphed on screen with a Python script.
Data flow: ADC -> RWM -> DFT -> RWM -> modulus -> data_multiplexer -> UART -> PC

To run DFT with different point size "`define MEM_SIZE" macro in all files and "size" register FSM_DFT.v need to be selected from the table found in DFT documentation (pg-106-dft).  

SpectrumAnalyzer is the same as DFT_TEST_4.

------------------------------ DOCUMENTATION USED FOR DEVELOPMENT ------------------------------
1. Discrete Fourier Transform v4.2, LogiCORE IP Product Guide, PG106 December 10, 2020 (pg106-dft.pdf).
2. CORDIC v6.0, PG105 August 6, LogiCORE IP Product Guide, 2021 (pg105-cordic.pdf).
3. 7 Series FPGAs and Zynq-7000 SoC XADC Dual 12-Bit 1 MSPS Analog-to-Digital Converter, User Guide, UG480 (v1.11) June 13, 2022 (ug480_7Series_XADC.pdf).
-------------------------------------------------------------------------------------------------
*/

`timescale 1ns / 1ps
`define MEM_SIZE 1200

module TOP(input clk, reset_btn, start_btn, vaux5_n, vaux5_p,
           output uart_rxd_out);

// debounce for 50 ms
wire start_btn_deb;
debouncer_0 start_debouncer (.clk(clk), .btn_in(start_btn), .btn_out(start_btn_deb));
wire reset_btn_deb;
debouncer_0 reset_debouncer (.clk(clk), .btn_in(reset_btn), .btn_out(reset_btn_deb));

wire rffd, data_ready;
wire [11:0] dout;
FSM_ADC FSM_ADC(.clk(clk), .reset(reset_btn_deb), .start(start_btn_deb), .vauxn5(vaux5_n), .vauxp5(vaux5_p), .rffd(rffd), .data_ready(data_ready), .dout(dout));
FSM_DFT_UART FSM_DFT_UART(.clk(clk), .reset(reset_btn_deb), .start(start_btn_deb), .data_ready(data_ready), .din(dout), .rffd(rffd), .dout(uart_rxd_out));

endmodule