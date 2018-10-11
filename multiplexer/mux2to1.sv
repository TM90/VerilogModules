module mux2to1 #(
    parameter WIDTH = 32
) (
    input logic[WIDTH-1:0] IN_A,
    input logic[WIDTH-1:0] IN_B,
    input logic SEL,
    output logic[WIDTH-1:0] OUT
);

assign OUT = SEL ? IN_B:IN_A;

endmodule
