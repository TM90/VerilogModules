module mux4to1 #(
    parameter WIDTH = 32
) (
    input logic[WIDTH-1:0] IN_A,
    input logic[WIDTH-1:0] IN_B,
    input logic[WIDTH-1:0] IN_C,
    input logic[WIDTH-1:0] IN_D,
    input logic[1:0] SEL,
    output logic[WIDTH-1:0] OUT
);

always @(*) begin
    case(SEL)
        2'b00: OUT <= IN_A;
        2'b01: OUT <= IN_B;
        2'b10: OUT <= IN_C;
        2'b11: OUT <= IN_D;
    endcase

end
endmodule
