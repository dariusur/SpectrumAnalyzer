-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
-- Date        : Sat Jan  6 16:03:21 2024
-- Host        : DESKTOP-7B2FBLM running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/Darius/Desktop/coding_stuff/projects_for_resume/SpectrumAnalyzer/Vivado/DFT_TEST_2/DFT_TEST_2.gen/sources_1/ip/dft_0/dft_0_stub.vhdl
-- Design      : dft_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35ticsg324-1L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dft_0 is
  Port ( 
    CLK : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    XN_RE : in STD_LOGIC_VECTOR ( 11 downto 0 );
    XN_IM : in STD_LOGIC_VECTOR ( 11 downto 0 );
    FD_IN : in STD_LOGIC;
    FWD_INV : in STD_LOGIC;
    SIZE : in STD_LOGIC_VECTOR ( 5 downto 0 );
    RFFD : out STD_LOGIC;
    XK_RE : out STD_LOGIC_VECTOR ( 11 downto 0 );
    XK_IM : out STD_LOGIC_VECTOR ( 11 downto 0 );
    BLK_EXP : out STD_LOGIC_VECTOR ( 3 downto 0 );
    FD_OUT : out STD_LOGIC;
    DATA_VALID : out STD_LOGIC
  );

end dft_0;

architecture stub of dft_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK,SCLR,XN_RE[11:0],XN_IM[11:0],FD_IN,FWD_INV,SIZE[5:0],RFFD,XK_RE[11:0],XK_IM[11:0],BLK_EXP[3:0],FD_OUT,DATA_VALID";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dft_v4_2_3,Vivado 2022.2";
begin
end;
