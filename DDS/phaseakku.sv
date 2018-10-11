/*
Author: Tobias Markus

initiation template
phaseakku #(        
        .WIDTH()
    )
phaseakku_I (
		.clk(),
		.res_n(),
	    .freq_cntrl(),
	    .akku_out()
	);
*/
module phaseakku
	#(
	    parameter WIDTH = 32 
  	)
	(
		input logic clk,
		input logic res_n,
	    input logic[WIDTH/2-1:0] freq_cntrl,
	    output logic[WIDTH-1:0] akku_out
	);
	
	always @(posedge clk) 
	begin
		if (res_n == 0) 
		begin
			akku_out <= {WIDTH{1'b0}};
		end
		else
		begin
			akku_out <= akku_out + freq_cntrl;
		end
	end
endmodule
