onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+NTT -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.NTT xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {NTT.udo}

run -all

endsim

quit -force
