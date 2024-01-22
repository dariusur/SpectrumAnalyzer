vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xbip_utils_v3_0_10
vlib questa_lib/msim/dft_v4_2_3
vlib questa_lib/msim/xil_defaultlib

vmap xbip_utils_v3_0_10 questa_lib/msim/xbip_utils_v3_0_10
vmap dft_v4_2_3 questa_lib/msim/dft_v4_2_3
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vcom -work xbip_utils_v3_0_10  -93  \
"../../../ipstatic/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work dft_v4_2_3  -93  \
"../../../ipstatic/hdl/dft_v4_2_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93  \
"../../../../DFT_TEST_2.gen/sources_1/ip/dft_0/sim/dft_0.vhd" \


