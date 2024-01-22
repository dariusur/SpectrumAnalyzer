vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu  \
"../../../../DFT_TEST_4.gen/sources_1/ip/debouncer_0/sources_1/new/debouncer.v" \
"../../../../DFT_TEST_4.gen/sources_1/ip/debouncer_0/sim/debouncer_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

