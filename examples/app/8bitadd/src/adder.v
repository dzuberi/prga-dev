module adder#(
    parameter WIDTH=15
)(
    input wire pulse,
    input wire clk,
    output reg[WIDTH:0] out
);

(* keep *) wire[WIDTH-1:0] a;
(* keep *) wire[WIDTH-1:0] b;

assign a[WIDTH-1:0] = {WIDTH{1'b1}};
assign b[WIDTH-1:1] = {WIDTH-1{1'b0}};
assign b[0] = pulse;

always @(posedge clk) begin
    out <= a + b;
end

endmodule