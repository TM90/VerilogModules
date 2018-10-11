/*
Author: Tobias Markus

initiation template
counter #(      
			.counter_size()
        )
counter_I (
            .clk(),
            .res_n(),        
            .enable(),
            .load(),
            .dir(),
            .cnt_in(),
            .cnt_out(),
            .overflow()
        );
*/

module counter
	#(
	    parameter counter_size = 8 
  	)
	(
	    input logic clk,
	    input logic res_n,
	    input logic enable,
	    input logic load,
	    input logic dir,
	    input logic[counter_size-1:0] cnt_in,
	    output logic[counter_size-1:0] cnt_out,
	    output logic overflow
	);

	always @(posedge clk, negedge res_n) 
	begin
		if (res_n == 0) 
		begin
			cnt_out <= {counter_size{1'b0}};
			overflow <= 1'b0;
		end
		else
		begin
			if (enable == 1'b1) 
			begin
				if (load == 1'b0) 
				begin
					if (dir == 0) 
					begin
						cnt_out <= cnt_out + 1'b1;
					end
					else
					begin
						cnt_out <= cnt_out - 1'b1;
					end
					if (cnt_out == {counter_size{1'b1}}) 
					begin
						overflow <= 1'b1;
					end
					else
					begin
						overflow <= 1'b0;
					end
				end
				else
				begin
					cnt_out <= cnt_in;
				end
			end
		end
	end

endmodule
