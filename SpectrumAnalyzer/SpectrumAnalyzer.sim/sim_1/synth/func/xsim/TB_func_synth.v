// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Sun Aug  6 15:59:35 2023
// Host        : DESKTOP-7B2FBLM running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               C:/Users/Darius/Desktop/Vivado/ROM_FFT_UART/ROM_FFT_UART.sim/sim_1/synth/func/xsim/TB_func_synth.v
// Design      : TOP
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module MEMORY
   (Q,
    clk_IBUF_BUFG,
    \dout_reg[0]_0 ,
    \dout_reg[0]_1 );
  output [3:0]Q;
  input clk_IBUF_BUFG;
  input \dout_reg[0]_0 ;
  input \dout_reg[0]_1 ;

  wire [3:0]Q;
  wire clk_IBUF_BUFG;
  wire \dout[0]_i_1_n_0 ;
  wire \dout[1]_i_1_n_0 ;
  wire \dout[2]_i_1_n_0 ;
  wire \dout[3]_i_1_n_0 ;
  wire \dout_reg[0]_0 ;
  wire \dout_reg[0]_1 ;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \dout[0]_i_1 
       (.I0(\dout_reg[0]_0 ),
        .I1(\dout_reg[0]_1 ),
        .O(\dout[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \dout[1]_i_1 
       (.I0(\dout_reg[0]_1 ),
        .I1(\dout_reg[0]_0 ),
        .O(\dout[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \dout[2]_i_1 
       (.I0(\dout_reg[0]_0 ),
        .I1(\dout_reg[0]_1 ),
        .O(\dout[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \dout[3]_i_1 
       (.I0(\dout_reg[0]_0 ),
        .I1(\dout_reg[0]_1 ),
        .O(\dout[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dout_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\dout[0]_i_1_n_0 ),
        .Q(Q[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \dout_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\dout[1]_i_1_n_0 ),
        .Q(Q[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \dout_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\dout[2]_i_1_n_0 ),
        .Q(Q[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \dout_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\dout[3]_i_1_n_0 ),
        .Q(Q[3]),
        .R(1'b0));
endmodule

(* RDY = "2'b00" *) (* SEND = "2'b01" *) (* WAIT = "2'b10" *) 
(* NotValidForBitStream *)
module TOP
   (clk,
    reset,
    uart_rxd_out);
  input clk;
  input reset;
  output uart_rxd_out;

  wire \addr_reg_n_0_[0] ;
  wire \addr_reg_n_0_[1] ;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire [3:0]dout;
  wire module_2_n_1;
  wire module_2_n_2;
  wire module_2_n_3;
  wire module_2_n_4;
  wire reset;
  wire reset_IBUF;
  wire send_i_1_n_0;
  wire send_reg_n_0;
  wire [1:0]state;
  wire uart_rxd_out;
  wire uart_rxd_out_OBUF;

  (* FSM_ENCODED_STATES = "SEND:01,WAIT:10,RDY:00,iSTATE:11" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(module_2_n_2),
        .Q(state[0]),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "SEND:01,WAIT:10,RDY:00,iSTATE:11" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(module_2_n_1),
        .Q(state[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \addr_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(module_2_n_4),
        .Q(\addr_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \addr_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(module_2_n_3),
        .Q(\addr_reg_n_0_[1] ),
        .R(1'b0));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF #(
    .CCIO_EN("TRUE")) 
    clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  MEMORY module_1
       (.Q(dout),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .\dout_reg[0]_0 (\addr_reg_n_0_[1] ),
        .\dout_reg[0]_1 (\addr_reg_n_0_[0] ));
  UART_TX module_2
       (.D(dout),
        .\FSM_onehot_state_reg[0]_0 (module_2_n_4),
        .\FSM_sequential_state_reg[0] (module_2_n_1),
        .\FSM_sequential_state_reg[0]_0 (module_2_n_2),
        .\addr_reg[0] (module_2_n_3),
        .\addr_reg[1] (\addr_reg_n_0_[0] ),
        .\addr_reg[1]_0 (\addr_reg_n_0_[1] ),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .reset_IBUF(reset_IBUF),
        .state(state),
        .\txData_reg[1]_0 (send_reg_n_0),
        .uart_rxd_out_OBUF(uart_rxd_out_OBUF));
  IBUF #(
    .CCIO_EN("TRUE")) 
    reset_IBUF_inst
       (.I(reset),
        .O(reset_IBUF));
  LUT3 #(
    .INIT(8'hB2)) 
    send_i_1
       (.I0(state[0]),
        .I1(state[1]),
        .I2(send_reg_n_0),
        .O(send_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    send_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(send_i_1_n_0),
        .Q(send_reg_n_0),
        .R(1'b0));
  OBUF uart_rxd_out_OBUF_inst
       (.I(uart_rxd_out_OBUF),
        .O(uart_rxd_out));
endmodule

module UART_TX
   (uart_rxd_out_OBUF,
    \FSM_sequential_state_reg[0] ,
    \FSM_sequential_state_reg[0]_0 ,
    \addr_reg[0] ,
    \FSM_onehot_state_reg[0]_0 ,
    clk_IBUF_BUFG,
    reset_IBUF,
    state,
    \addr_reg[1] ,
    \addr_reg[1]_0 ,
    D,
    \txData_reg[1]_0 );
  output uart_rxd_out_OBUF;
  output \FSM_sequential_state_reg[0] ;
  output \FSM_sequential_state_reg[0]_0 ;
  output \addr_reg[0] ;
  output \FSM_onehot_state_reg[0]_0 ;
  input clk_IBUF_BUFG;
  input reset_IBUF;
  input [1:0]state;
  input \addr_reg[1] ;
  input \addr_reg[1]_0 ;
  input [3:0]D;
  input \txData_reg[1]_0 ;

  wire [3:0]D;
  wire \FSM_onehot_state[0]_i_1_n_0 ;
  wire \FSM_onehot_state[1]_i_1_n_0 ;
  wire \FSM_onehot_state[1]_i_2_n_0 ;
  wire \FSM_onehot_state[2]_i_1_n_0 ;
  wire \FSM_onehot_state[2]_i_2_n_0 ;
  wire \FSM_onehot_state[2]_i_3_n_0 ;
  wire \FSM_onehot_state[2]_i_4_n_0 ;
  wire \FSM_onehot_state[2]_i_5_n_0 ;
  wire \FSM_onehot_state[2]_i_6_n_0 ;
  wire \FSM_onehot_state_reg[0]_0 ;
  wire \FSM_onehot_state_reg_n_0_[0] ;
  wire \FSM_onehot_state_reg_n_0_[1] ;
  wire \FSM_onehot_state_reg_n_0_[2] ;
  wire \FSM_sequential_state_reg[0] ;
  wire \FSM_sequential_state_reg[0]_0 ;
  wire \addr_reg[0] ;
  wire \addr_reg[1] ;
  wire \addr_reg[1]_0 ;
  wire [3:1]bitIndex;
  wire \bitIndex[0]_i_1_n_0 ;
  wire \bitIndex_reg_n_0_[0] ;
  wire \bitIndex_reg_n_0_[1] ;
  wire \bitIndex_reg_n_0_[2] ;
  wire \bitIndex_reg_n_0_[3] ;
  wire clk_IBUF_BUFG;
  wire [13:1]data0;
  wire reset_IBUF;
  wire reset_reg;
  wire [1:0]state;
  wire [13:0]timer;
  wire timer0_carry__0_n_0;
  wire timer0_carry__0_n_1;
  wire timer0_carry__0_n_2;
  wire timer0_carry__0_n_3;
  wire timer0_carry__1_n_0;
  wire timer0_carry__1_n_1;
  wire timer0_carry__1_n_2;
  wire timer0_carry__1_n_3;
  wire timer0_carry_n_0;
  wire timer0_carry_n_1;
  wire timer0_carry_n_2;
  wire timer0_carry_n_3;
  wire \timer[0]_i_1_n_0 ;
  wire \timer[13]_i_1_n_0 ;
  wire \timer[13]_i_2_n_0 ;
  wire \timer[13]_i_3_n_0 ;
  wire txBit;
  wire txBit1_out;
  wire txBit_i_2_n_0;
  wire txBit_i_3_n_0;
  wire \txData[4]_i_1_n_0 ;
  wire \txData_reg[1]_0 ;
  wire \txData_reg_n_0_[1] ;
  wire \txData_reg_n_0_[2] ;
  wire \txData_reg_n_0_[3] ;
  wire \txData_reg_n_0_[4] ;
  wire uart_rxd_out_OBUF;
  wire [3:0]NLW_timer0_carry__2_CO_UNCONNECTED;
  wire [3:1]NLW_timer0_carry__2_O_UNCONNECTED;

  LUT5 #(
    .INIT(32'hFFFF2E22)) 
    \FSM_onehot_state[0]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(\FSM_onehot_state[2]_i_2_n_0 ),
        .I2(\FSM_onehot_state[1]_i_2_n_0 ),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(reset_reg),
        .O(\FSM_onehot_state[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000EEE2E2E2)) 
    \FSM_onehot_state[1]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[1] ),
        .I1(\FSM_onehot_state[2]_i_2_n_0 ),
        .I2(\FSM_onehot_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_state[1]_i_2_n_0 ),
        .I4(\FSM_onehot_state_reg_n_0_[2] ),
        .I5(reset_reg),
        .O(\FSM_onehot_state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hEFFF)) 
    \FSM_onehot_state[1]_i_2 
       (.I0(\bitIndex_reg_n_0_[0] ),
        .I1(\bitIndex_reg_n_0_[2] ),
        .I2(\bitIndex_reg_n_0_[1] ),
        .I3(\bitIndex_reg_n_0_[3] ),
        .O(\FSM_onehot_state[1]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \FSM_onehot_state[2]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[2] ),
        .I1(\FSM_onehot_state[2]_i_2_n_0 ),
        .I2(\FSM_onehot_state_reg_n_0_[1] ),
        .I3(reset_reg),
        .O(\FSM_onehot_state[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAAA)) 
    \FSM_onehot_state[2]_i_2 
       (.I0(\FSM_onehot_state[2]_i_3_n_0 ),
        .I1(\FSM_onehot_state[2]_i_4_n_0 ),
        .I2(\FSM_onehot_state[2]_i_5_n_0 ),
        .I3(\FSM_onehot_state[2]_i_6_n_0 ),
        .I4(timer[0]),
        .I5(\FSM_onehot_state_reg_n_0_[2] ),
        .O(\FSM_onehot_state[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hF8)) 
    \FSM_onehot_state[2]_i_3 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(\txData_reg[1]_0 ),
        .I2(\FSM_onehot_state_reg_n_0_[1] ),
        .O(\FSM_onehot_state[2]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEFF)) 
    \FSM_onehot_state[2]_i_4 
       (.I0(timer[1]),
        .I1(timer[12]),
        .I2(timer[13]),
        .I3(timer[2]),
        .I4(timer[3]),
        .O(\FSM_onehot_state[2]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    \FSM_onehot_state[2]_i_5 
       (.I0(timer[5]),
        .I1(timer[4]),
        .I2(timer[6]),
        .I3(timer[7]),
        .O(\FSM_onehot_state[2]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hFFF7)) 
    \FSM_onehot_state[2]_i_6 
       (.I0(timer[9]),
        .I1(timer[8]),
        .I2(timer[11]),
        .I3(timer[10]),
        .O(\FSM_onehot_state[2]_i_6_n_0 ));
  (* FSM_ENCODED_STATES = "SEND_BIT:100,LOAD_BIT:010,RDY:001" *) 
  FDRE #(
    .INIT(1'b1)) 
    \FSM_onehot_state_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\FSM_onehot_state[0]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[0] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "SEND_BIT:100,LOAD_BIT:010,RDY:001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\FSM_onehot_state[1]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[1] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "SEND_BIT:100,LOAD_BIT:010,RDY:001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\FSM_onehot_state[2]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[2] ),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h0004)) 
    \FSM_sequential_state[0]_i_1 
       (.I0(state[0]),
        .I1(\FSM_onehot_state_reg_n_0_[0] ),
        .I2(reset_reg),
        .I3(state[1]),
        .O(\FSM_sequential_state_reg[0]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h04AA)) 
    \FSM_sequential_state[1]_i_1 
       (.I0(state[0]),
        .I1(\FSM_onehot_state_reg_n_0_[0] ),
        .I2(reset_reg),
        .I3(state[1]),
        .O(\FSM_sequential_state_reg[0] ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'hFFFD0002)) 
    \addr[0]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(reset_reg),
        .I2(state[0]),
        .I3(state[1]),
        .I4(\addr_reg[1] ),
        .O(\FSM_onehot_state_reg[0]_0 ));
  LUT6 #(
    .INIT(64'hFFFDFFFF00020000)) 
    \addr[1]_i_1 
       (.I0(\addr_reg[1] ),
        .I1(state[1]),
        .I2(state[0]),
        .I3(reset_reg),
        .I4(\FSM_onehot_state_reg_n_0_[0] ),
        .I5(\addr_reg[1]_0 ),
        .O(\addr_reg[0] ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \bitIndex[0]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[1] ),
        .I1(\bitIndex_reg_n_0_[0] ),
        .O(\bitIndex[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h28)) 
    \bitIndex[1]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[1] ),
        .I1(\bitIndex_reg_n_0_[1] ),
        .I2(\bitIndex_reg_n_0_[0] ),
        .O(bitIndex[1]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h2888)) 
    \bitIndex[2]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[1] ),
        .I1(\bitIndex_reg_n_0_[2] ),
        .I2(\bitIndex_reg_n_0_[0] ),
        .I3(\bitIndex_reg_n_0_[1] ),
        .O(bitIndex[2]));
  LUT3 #(
    .INIT(8'h32)) 
    \bitIndex[3]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[1] ),
        .I1(reset_reg),
        .I2(\FSM_onehot_state_reg_n_0_[0] ),
        .O(txBit1_out));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h28888888)) 
    \bitIndex[3]_i_2 
       (.I0(\FSM_onehot_state_reg_n_0_[1] ),
        .I1(\bitIndex_reg_n_0_[3] ),
        .I2(\bitIndex_reg_n_0_[2] ),
        .I3(\bitIndex_reg_n_0_[1] ),
        .I4(\bitIndex_reg_n_0_[0] ),
        .O(bitIndex[3]));
  FDRE #(
    .INIT(1'b0)) 
    \bitIndex_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(txBit1_out),
        .D(\bitIndex[0]_i_1_n_0 ),
        .Q(\bitIndex_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \bitIndex_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(txBit1_out),
        .D(bitIndex[1]),
        .Q(\bitIndex_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \bitIndex_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(txBit1_out),
        .D(bitIndex[2]),
        .Q(\bitIndex_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \bitIndex_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(txBit1_out),
        .D(bitIndex[3]),
        .Q(\bitIndex_reg_n_0_[3] ),
        .R(1'b0));
  FDPE #(
    .INIT(1'b1)) 
    reset_reg_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(1'b0),
        .PRE(reset_IBUF),
        .Q(reset_reg));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 timer0_carry
       (.CI(1'b0),
        .CO({timer0_carry_n_0,timer0_carry_n_1,timer0_carry_n_2,timer0_carry_n_3}),
        .CYINIT(timer[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[4:1]),
        .S(timer[4:1]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 timer0_carry__0
       (.CI(timer0_carry_n_0),
        .CO({timer0_carry__0_n_0,timer0_carry__0_n_1,timer0_carry__0_n_2,timer0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[8:5]),
        .S(timer[8:5]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 timer0_carry__1
       (.CI(timer0_carry__0_n_0),
        .CO({timer0_carry__1_n_0,timer0_carry__1_n_1,timer0_carry__1_n_2,timer0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[12:9]),
        .S(timer[12:9]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 timer0_carry__2
       (.CI(timer0_carry__1_n_0),
        .CO(NLW_timer0_carry__2_CO_UNCONNECTED[3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_timer0_carry__2_O_UNCONNECTED[3:1],data0[13]}),
        .S({1'b0,1'b0,1'b0,timer[13]}));
  LUT5 #(
    .INIT(32'hF0F30808)) 
    \timer[0]_i_1 
       (.I0(\timer[13]_i_3_n_0 ),
        .I1(\FSM_onehot_state_reg_n_0_[2] ),
        .I2(reset_reg),
        .I3(\FSM_onehot_state_reg_n_0_[0] ),
        .I4(timer[0]),
        .O(\timer[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h02020232)) 
    \timer[13]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(reset_reg),
        .I2(\FSM_onehot_state_reg_n_0_[2] ),
        .I3(\timer[13]_i_3_n_0 ),
        .I4(timer[0]),
        .O(\timer[13]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h32)) 
    \timer[13]_i_2 
       (.I0(\FSM_onehot_state_reg_n_0_[2] ),
        .I1(reset_reg),
        .I2(\FSM_onehot_state_reg_n_0_[0] ),
        .O(\timer[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFBFF)) 
    \timer[13]_i_3 
       (.I0(\FSM_onehot_state[2]_i_6_n_0 ),
        .I1(timer[5]),
        .I2(timer[4]),
        .I3(timer[6]),
        .I4(timer[7]),
        .I5(\FSM_onehot_state[2]_i_4_n_0 ),
        .O(\timer[13]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\timer[0]_i_1_n_0 ),
        .Q(timer[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(\timer[13]_i_2_n_0 ),
        .D(data0[10]),
        .Q(timer[10]),
        .R(\timer[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(\timer[13]_i_2_n_0 ),
        .D(data0[11]),
        .Q(timer[11]),
        .R(\timer[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(\timer[13]_i_2_n_0 ),
        .D(data0[12]),
        .Q(timer[12]),
        .R(\timer[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(\timer[13]_i_2_n_0 ),
        .D(data0[13]),
        .Q(timer[13]),
        .R(\timer[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\timer[13]_i_2_n_0 ),
        .D(data0[1]),
        .Q(timer[1]),
        .R(\timer[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\timer[13]_i_2_n_0 ),
        .D(data0[2]),
        .Q(timer[2]),
        .R(\timer[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\timer[13]_i_2_n_0 ),
        .D(data0[3]),
        .Q(timer[3]),
        .R(\timer[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\timer[13]_i_2_n_0 ),
        .D(data0[4]),
        .Q(timer[4]),
        .R(\timer[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(\timer[13]_i_2_n_0 ),
        .D(data0[5]),
        .Q(timer[5]),
        .R(\timer[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(\timer[13]_i_2_n_0 ),
        .D(data0[6]),
        .Q(timer[6]),
        .R(\timer[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(\timer[13]_i_2_n_0 ),
        .D(data0[7]),
        .Q(timer[7]),
        .R(\timer[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(\timer[13]_i_2_n_0 ),
        .D(data0[8]),
        .Q(timer[8]),
        .R(\timer[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(\timer[13]_i_2_n_0 ),
        .D(data0[9]),
        .Q(timer[9]),
        .R(\timer[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFBAAAAABABAAAAA)) 
    txBit_i_1
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(\bitIndex_reg_n_0_[3] ),
        .I2(txBit_i_2_n_0),
        .I3(txBit_i_3_n_0),
        .I4(\FSM_onehot_state_reg_n_0_[1] ),
        .I5(\bitIndex_reg_n_0_[0] ),
        .O(txBit));
  LUT5 #(
    .INIT(32'h002C0020)) 
    txBit_i_2
       (.I0(\txData_reg_n_0_[4] ),
        .I1(\bitIndex_reg_n_0_[1] ),
        .I2(\bitIndex_reg_n_0_[2] ),
        .I3(\bitIndex_reg_n_0_[0] ),
        .I4(\txData_reg_n_0_[2] ),
        .O(txBit_i_2_n_0));
  LUT5 #(
    .INIT(32'hCECFCECC)) 
    txBit_i_3
       (.I0(\txData_reg_n_0_[3] ),
        .I1(\bitIndex_reg_n_0_[3] ),
        .I2(\bitIndex_reg_n_0_[2] ),
        .I3(\bitIndex_reg_n_0_[1] ),
        .I4(\txData_reg_n_0_[1] ),
        .O(txBit_i_3_n_0));
  FDRE #(
    .INIT(1'b0)) 
    txBit_reg
       (.C(clk_IBUF_BUFG),
        .CE(txBit1_out),
        .D(txBit),
        .Q(uart_rxd_out_OBUF),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h40)) 
    \txData[4]_i_1 
       (.I0(reset_reg),
        .I1(\FSM_onehot_state_reg_n_0_[0] ),
        .I2(\txData_reg[1]_0 ),
        .O(\txData[4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txData_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\txData[4]_i_1_n_0 ),
        .D(D[0]),
        .Q(\txData_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txData_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\txData[4]_i_1_n_0 ),
        .D(D[1]),
        .Q(\txData_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txData_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\txData[4]_i_1_n_0 ),
        .D(D[2]),
        .Q(\txData_reg_n_0_[3] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txData_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\txData[4]_i_1_n_0 ),
        .D(D[3]),
        .Q(\txData_reg_n_0_[4] ),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
