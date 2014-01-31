/*
Author: Tobias Markus

initiation template
DDS #(
	     .WIDTH(),
	     .MAX_AMP(),
	     .INIT_FILE()
  	)
DDS_I (
	    .clk(),
	    .res_n(),
	    .RAM_WR(),
	    .RAM_input(),
	    .RAM_address(),
	    .freq_cntrl(),
	    .AMP(),
	    .dds_out()
	);
*/

module DDS
	#(
	    parameter WIDTH = 10,
	    parameter MAX_AMP = 8,
	    parameter INIT_FILE = "../DDS/sinus.dat"
  	)
	(
	    input clk,
	    input res_n,
	    input RAM_WR,
	    input[MAX_AMP-1:0] RAM_input,
	    input[WIDTH-1:0] RAM_address,
	    input[WIDTH/2-1:0] freq_cntrl,
	    input[MAX_AMP-1:0] AMP,
	    output[MAX_AMP-1:0] dds_out
	);
	
	wire[WIDTH-1:0] address_counter;
	reg[WIDTH-1:0] internal_address;

	phaseakku #(        
        .WIDTH(WIDTH)
    )
	phaseakku_I (
		.clk(clk),
		.res_n(res_n),
	    .freq_cntrl(freq_cntrl),
	    .akku_out(address_counter)
	);

	RAM #(        
        .DEPTH(WIDTH),
        .WIDTH(MAX_AMP),
        .INIT_FILE(INIT_FILE)
    )
	RAM_I (
        .clk(clk),        
        .enable(res_n),
        .wr_en(RAM_WR),
        .address(internal_address),
        .data_in(RAM_input),
        .data_out(dds_out)
    );

	always @(*) 
	begin
		case(RAM_WR)
			0: internal_address <= address_counter;
			1: internal_address <= RAM_address;
		endcase
	end

endmodule
