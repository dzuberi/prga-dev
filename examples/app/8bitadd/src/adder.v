module adder#(
    parameter WIDTH=8
)(
    input wire pulse,
    input wire clk,
    output wire out
);

(* keep *) wire[WIDTH-1:0] a;
(* keep *) wire[WIDTH-1:0] b;
(* keep *) reg[WIDTH-1:0] sum;

assign a[WIDTH-1:0] = {WIDTH{1'b1}};
assign b[WIDTH-1:1] = {WIDTH-1{1'b0}};
assign b[0] = pulse;
assign out = sum[WIDTH-1];

always @(posedge clk) begin
    sum <= a + b;
end

endmodule