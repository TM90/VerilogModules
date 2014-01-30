tclsh ../scripts/timescale.tcl -da ../RAM/RAM.f 1ns/1ns
iverilog -o RAM -c RAM.f
tclsh ../scripts/timescale.tcl -d ../RAM/RAM.f
vvp -n RAM 
gtkwave RAM.vcd