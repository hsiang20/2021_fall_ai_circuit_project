
`include "adder_tree.v"
module stage3 (
    input clk,
    input rst, 
    input signed [15:0] aligned_pp_0, aligned_pp_1, aligned_pp_2, aligned_pp_3, aligned_pp_4, aligned_pp_5, aligned_pp_6, aligned_pp_7, aligned_pp_8,
    output signed [19:0] signed_sum
);
    reg signed [19:0] signed_sum_r;
    wire signed [19:0] signed_sum_w;

    assign signed_sum = signed_sum_r;

    adder_tree add(.aligned_pp_0(aligned_pp_0), .aligned_pp_1(aligned_pp_1), .aligned_pp_2(aligned_pp_2), .aligned_pp_3(aligned_pp_3), .aligned_pp_4(aligned_pp_4), 
        .aligned_pp_5(aligned_pp_5), .aligned_pp_6(aligned_pp_6), .aligned_pp_7(aligned_pp_7), .aligned_pp_8(aligned_pp_8), 
        .signed_sum(signed_sum_w));
    
  

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            signed_sum_r <= 20'b0;
        end
        else begin
            signed_sum_r <= signed_sum_w;
        end
    end
endmodule