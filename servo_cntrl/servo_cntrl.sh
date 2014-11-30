tclsh ../scripts/timescale.tcl -da ../servo_cntrl/servo_cntrl.f 1ns/1ns
iverilog -o servo_cntrl -c servo_cntrl.f
tclsh ../scripts/timescale.tcl -d ../servo_cntrl/servo_cntrl.f
vvp -n servo_cntrl
gtkwave servo_cntrl.vcd
