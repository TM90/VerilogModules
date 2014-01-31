//Author: Tobias Markus
module counter_tb();
	
	parameter PERIOD = 10;
	parameter COUNTER_SIZE = 32;

	wire clk;
	reg res_n;
	reg enable;
	reg load;
	reg dir;
	reg[COUNTER_SIZE-1:0] cnt_in;
	wire[COUNTER_SIZE-1:0] cnt_out;
	wire overflow;

	clk_gen #(.period(PERIOD)) clk_gen_I (.clk_out(clk));

	counter #(      
				.counter_size(COUNTER_SIZE)
        	)
	counter_I (
	            .clk(clk),
	            .res_n(res_n),        
	            .enable(enable),
	            .load(load),
	            .dir(dir),
	            .cnt_in(cnt_in),
	            .cnt_out(cnt_out),
	            .overflow(overflow)
       		);
	
	initial
	begin
		$dumpfile("counter.vcd");
        $dumpvars(0,counter_tb);
		res_n <= 1'b0;
		enable <= 1'b1;
		load <= 1'b0;
		dir <= 1'b0;
		cnt_in <= {COUNTER_SIZE{1'b0}};
		#20
		res_n <= 1'b1;
		#100
		@(negedge(clk));
		enable <= 1'b0;
		#100
		@(negedge(clk));
		enable <= 1'b1;
		dir <=1'b1;
		#50
		$stop;
	end
endmodule
