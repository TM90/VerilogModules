//Author: Tobias Markus
module RAM_tb ();
        
    parameter WIDTH = 8;
    parameter DEPTH = 4;
    parameter PERIOD = 10;

    wire clk;
    reg enable;
    reg wr_en;
    reg[DEPTH-1:0] address;
    reg[WIDTH-1:0] data_in;
    wire[WIDTH-1:0] data_out;
    
    clk_gen #(.period(PERIOD)) clk_gen_I (.clk_out(clk));
    
    RAM #(          
        .DEPTH(DEPTH),
        .WIDTH(WIDTH),
        .INIT_FILE("data.dat")
    )
    RAM_I (
        .clk(clk),        
        .enable(enable),
        .wr_en(wr_en),
        .address(address),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial
    begin
        $dumpfile("RAM.vcd");
        $dumpvars(0,RAM_tb);
        enable <= 1;
        wr_en         <= 1'b0;
        #100
        address <= 0;
        #20
        address <= 1;
        #20
        address <= 2;
        #20
        address <= 3;
        #20
        address <= 4;
        #20
        address <= 5;
        wr_en <= 1'b1;
        data_in <= 8'hff;
        #20
        address <= 5;
        wr_en <= 1'b0;
        #20
        $stop;
    end

endmodule
