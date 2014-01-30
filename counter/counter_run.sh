tclsh ../scripts/timescale.tcl -da ../counter/counter.f 1ns/1ns
iverilog -o counter -c counter.f
tclsh ../scripts/timescale.tcl -d ../counter/counter.f
vvp -n counter 
gtkwave counter.vcd