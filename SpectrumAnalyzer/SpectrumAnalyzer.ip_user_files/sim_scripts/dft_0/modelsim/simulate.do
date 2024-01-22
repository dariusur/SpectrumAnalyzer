onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc "  -L xbip_utils_v3_0_10 -L dft_v4_2_3 -L xil_defaultlib -L secureip -lib xil_defaultlib xil_defaultlib.dft_0

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {dft_0.udo}

run 1000ns

quit -force
