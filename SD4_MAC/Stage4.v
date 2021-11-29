`include "normalization.v"
module Stage4 (
    input clk,
    input rst, 
    input signed [19:0] signed_sum,
    input signed [5:0] exp_max, 
    output sign, 
    output [10:0] norm_sum, 
    output signed [6:0] exp_final
);
    reg sign_r;
    wire sign_w;
    reg [10:0] norm_sum_r;
    wire [10:0] norm_sum_w;
    reg signed [6:0] exp_final_r;
    wire signed [6:0] exp_final_w;

    assign sign = sign_r;
    assign norm_sum = norm_sum_r;
    assign exp_final = exp_final_r;

    normalization normal(.signed_sum(signed_sum), .exp_max(exp_max), .sign(sign_w), .norm_sum(norm_sum_w), .exp_final(exp_final_w));
  
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            sign_r      <= 1'b0;
            norm_sum_r    <= 11'b0;
            exp_final_r <= 7'b0;
        end
        else begin
            sign_r      <= sign_w;
            norm_sum_r    <= norm_sum_w;
            exp_final_r <= exp_final_w;
        end
    end
endmodule