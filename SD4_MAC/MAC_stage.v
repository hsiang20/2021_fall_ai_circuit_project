`include "Stage1.v"
`include "Stage2.v"
`include "Stage3.v"
`include "Stage4.v"
`include "Stage5.v"

module MAC_stage(input clk, rst, 
           input [71:0] image, 
           input [35:0] weight, 
           input [4:0] exp_bias, 
           output [15:0] out);
    

    wire [4:0] pp_0, pp_1, pp_2, pp_3, pp_4, pp_5, pp_6, pp_7, pp_8;
    wire [4:0] exp_0, exp_1, exp_2, exp_3, exp_4, exp_5, exp_6, exp_7, exp_8;
    wire [4:0] exp_max;
    wire [15:0] aligned_pp_0, aligned_pp_1, aligned_pp_2, aligned_pp_3, aligned_pp_4, aligned_pp_5, aligned_pp_6, aligned_pp_7, aligned_pp_8;
    wire [19:0] signed_sum;
    wire sign;
    wire [10:0] norm_sum;
    wire [6:0] exp_final;

    Stage1 s1(.clk(clk), .rst(rst), .image_in(image), .weight_in(weight), .exp_bias_in(exp_bias), .signed_pp_0(pp_0), .signed_pp_1(pp_1), .signed_pp_2(pp_2), .signed_pp_3(pp_3), .signed_pp_4(pp_4),
                .signed_pp_5(pp_5), .signed_pp_6(pp_6), .signed_pp_7(pp_7), .signed_pp_8(pp_8), .exp_0(exp_0), .exp_1(exp_1), .exp_2(exp_2), .exp_3(exp_3), .exp_4(exp_4), .exp_5(exp_5), .exp_6(exp_6), 
                .exp_7(exp_7), .exp_8(exp_8), .exp_max(exp_max), .exp_bias(exp_bias));

    Stage2 s2(.clk(clk), .rst(rst), .signed_pp_0(pp_0), .signed_pp_1(pp_1), .signed_pp_2(pp_2), .signed_pp_3(pp_3), .signed_pp_4(pp_4),
                .signed_pp_5(pp_5), .signed_pp_6(pp_6), .signed_pp_7(pp_7), .signed_pp_8(pp_8), .exp_0(exp_0), .exp_1(exp_1), .exp_2(exp_2), .exp_3(exp_3), .exp_4(exp_4), .exp_5(exp_5), .exp_6(exp_6), 
                .exp_7(exp_7), .exp_8(exp_8), .exp_max(exp_max), .aligned_pp_0(aligned_pp_0), .aligned_pp_1(aligned_pp_1), .aligned_pp_2(aligned_pp_2), .aligned_pp_3(aligned_pp_3), .aligned_pp_4(aligned_pp_4), 
                .aligned_pp_5(aligned_pp_5), .aligned_pp_6(aligned_pp_6), .aligned_pp_7(aligned_pp_7), .aligned_pp_8(aligned_pp_8));

    Stage3 s3(.clk(clk), .rst(rst), .aligned_pp_0(aligned_pp_0), .aligned_pp_1(aligned_pp_1), .aligned_pp_2(aligned_pp_2), .aligned_pp_3(aligned_pp_3), .aligned_pp_4(aligned_pp_4), 
                .aligned_pp_5(aligned_pp_5), .aligned_pp_6(aligned_pp_6), .aligned_pp_7(aligned_pp_7), .aligned_pp_8(aligned_pp_8), .signed_sum(signed_sum));

    Stage4 s4(.clk(clk), .rst(rst), .signed_sum(signed_sum), .exp_max({1'b0,exp_max}), .sign(sign), .norm_sum(norm_sum), .exp_final(exp_final));

    Stage5 s5(.clk(clk), .rst(rst), .sign(sign), .norm_sum(norm_sum), .exp_final(exp_final), .out(out));

        


endmodule