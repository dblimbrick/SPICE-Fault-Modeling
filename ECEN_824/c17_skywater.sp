* C17 Simulation

* Include SkyWater sky130 device models
.lib "/home/daniel/.volare/sky130A/libs.tech/ngspice/sky130.lib.spice" tt  ; Replace with your actual path if different
.include "/home/daniel/.volare/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice"  ; Replace if needed
.param mc_mm_switch=0

.param pVDD = 1.8

* supply voltages
VDD vdd 0 dc {pVDD}
VSS vss 0 0

* include the design under test 
.include c17_synth_wolf.sp

* instantiate the design under test 
Xc17 n1 n2 n3 n5 n7 VDD VSS n22 n23 c17

*.ends

.option gmin=1e-15
.option scale=1e-6

* Transient analysis to see the NAND2 logic operation
.tran 0.1n 20n

* Define pulse sources for inputs (example)
Vpulse1 n1 0 PULSE (0 {pVDD} 0 1n 1n 10n 20n)
Vpulse2 n2 0 PULSE (0 {pVDD} 5n 1n 1n 10n 20n) ; Delayed pulse
Vpulse3 n3 0 PULSE (0 {pVDD} 5n 1n 1n 10n 20n) ; Delayed pulse
Vpulse4 n5 0 PULSE (0 {pVDD} 5n 1n 1n 10n 20n) ; Delayed pulse
Vpulse5 n7 0 PULSE (0 {pVDD} 5n 1n 1n 10n 20n) ; Delayed pulse

.control
    run
    set color0 = white
    set color1 = black
    plot n1 n2 n22 n23
.endc

.end
