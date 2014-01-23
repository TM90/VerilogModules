iverilog -o RAM -c RAM.f
vvp -n RAM 
gtkwave RAM.vcd