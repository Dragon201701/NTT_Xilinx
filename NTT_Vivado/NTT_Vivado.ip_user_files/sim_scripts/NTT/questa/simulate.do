onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib NTT_opt

do {wave.do}

view wave
view structure
view signals

do {NTT.udo}

run -all

quit -force
