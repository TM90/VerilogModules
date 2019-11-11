//Authors: Sebastian Wittka, Tobias Markus
module clk_gen #(
    parameter period =10)
   (output reg clk_out=0);

always
    begin
        #(period/2) clk_out <= ~clk_out;
    end
endmodule         


