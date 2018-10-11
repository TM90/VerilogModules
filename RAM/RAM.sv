/*
Author: Tobias Markus

initiation template
RAM #(        
        .DEPTH(),
        .WIDTH(),
        .INIT_FILE()
    )
RAM_I (
        .clk(),        
        .enable(),
        .wr_en(),
        .address(),
        .data_in(),
        .data_out()
    );
*/

module RAM
    #(
        parameter DEPTH = 4,
        parameter WIDTH = 8,
        parameter INIT_FILE = "data.dat"
    )
    (
        input logic clk,
        input logic enable,
        input logic wr_en,
        input logic[DEPTH-1:0] address,
        input logic[WIDTH-1:0] data_in,
        output logic[WIDTH-1:0] data_out
    );

    logic[WIDTH-1:0] memory [0:2**DEPTH-1];
    
    // init RAM
    initial
    begin
        $readmemh(INIT_FILE, memory) ;
    end

    // control and data path
    always @(posedge clk) // synchronous reset
    begin
        if(enable)
        begin
            if (wr_en)
            begin
                memory[address] <= data_in;
            end
            else
            begin
                data_out <= memory[address];
            end
        end
    end

endmodule
