onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+dft_0  -L xbip_utils_v3_0_10 -L dft_v4_2_3 -L xil_defaultlib -L secureip -O5 xil_defaultlib.dft_0

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {dft_0.udo}

run 1000ns

endsim

quit -force
