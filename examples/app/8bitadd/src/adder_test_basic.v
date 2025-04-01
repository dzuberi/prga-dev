module basic (
    input wire tb_clk,
    input wire tb_rst,
    output reg tb_pass,
    output reg tb_fail,
    input wire tb_prog_done,
    input wire [31:0] tb_verbosity,
    input wire [31:0] tb_cycle_cnt,
    
    output wire clk,
    output reg pulse,
    input wire[15:0] out
);

assign clk = tb_clk;

reg fail = 0;
reg[15:0] out_exp;
reg[31:0] cycle = 0;

initial begin
    pulse = 0;
end

always @(posedge tb_clk) begin
    if (tb_rst || ~tb_prog_done) begin 
        pulse <= 1'b0;
        out_exp <= 16'b0;
        cycle = 0;
    end else begin 
        pulse <= ~pulse;
        out_exp[15] <= pulse;
        out_exp[14:0] <= {16-1{~pulse}};
        $display("cycle: %d", cycle);
        $display("out: %b", out);
        $display("out_exp: %b", out_exp);
        if (cycle > 0) begin
            if (out != out_exp) begin
                fail = 0;
            end
            if (cycle >= 1000) begin
                if (fail == 0) begin
                    tb_pass = 1;
                    tb_fail = 0;
                end else begin
                    tb_fail = 1;
                    tb_pass = 0;
                end
            end
        end
        cycle = cycle + 1;
        
    end
end

endmodule