vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../../DFT_TEST_4.gen/sources_1/ip/debouncer_0/sources_1/new/debouncer.v" \
"../../../../DFT_TEST_4.gen/sources_1/ip/debouncer_0/sim/debouncer_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

