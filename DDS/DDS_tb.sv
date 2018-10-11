module DDS_tb();
	parameter PERIOD = 10;
	parameter WIDTH = 10;
	parameter MAX_AMP = 8;
	parameter INIT_FILE = "../DDS/sinus.dat";
	logic clk;
	logic res_n;
	logic RAM_WR;
	logic[MAX_AMP-1:0] RAM_input;
	logic[WIDTH-1:0] RAM_address;
	logic[WIDTH/2-1:0] freq_cntrl;
	logic[MAX_AMP-1:0] AMP;
	logic[MAX_AMP-1:0] dds_out;

	clk_gen #(.period(PERIOD)) clk_gen_I (.clk_out(clk));

	DDS #(
	     .WIDTH(WIDTH),
	     .MAX_AMP(MAX_AMP),
	     .INIT_FILE(INIT_FILE)
  	)
	DDS_I (
	    .clk(clk),
	    .res_n(res_n),
	    .RAM_WR(RAM_WR),
	    .RAM_input(RAM_input),
	    .RAM_address(RAM_address),
	    .freq_cntrl(freq_cntrl),
	    .AMP(AMP),
	    .dds_out(dds_out)
	);

	initial 
	begin
		$dumpfile("dds_out.vcd");
        $dumpvars(0,DDS_tb);
		res_n <= 0;
		RAM_WR <= 0;
		RAM_address <= {WIDTH{1'b0}};
		RAM_input <= {MAX_AMP{1'b0}};
		#20
		res_n <= 1;
		@(negedge(clk));
		freq_cntrl <= 1;
		#40960
		$stop;
	end

endmodule
