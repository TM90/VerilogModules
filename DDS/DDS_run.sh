tclsh ../scripts/timescale.tcl -da ../DDS/DDS.f 1ns/1ns
iverilog -g2012 -o DDS -c DDS.f
tclsh ../scripts/timescale.tcl -d ../DDS/DDS.f
vvp -n DDS 
gtkwave dds_out.vcd
