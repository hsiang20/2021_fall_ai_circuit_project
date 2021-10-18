module MAC(output clk, rst, 
           output [71:0] image, 
           output [35:0] weight, 
           output [4:0] exp_bias, 
           output reg [15:0] out);
    
    wire [71:0] image_out;
    wire [35:0] weight_out;
    wire [4:0] exp_bias_out;

    wire [4:0] pp_0, pp_1, pp_2, pp_3, pp_4, pp_5, pp_6, pp_7, pp_8;
    wire [4:0] exp_0, exp_1, exp_2, exp_3, exp_4, exp_5, exp_6, exp_7, exp_8;

    wire [4:0] exp_max;

    wire [4:0] pp_0_out, pp_1_out, pp_2_out, pp_3_out, pp_4_out, pp_5_out, pp_6_out, pp_7_out, pp_8_out;
    wire [4:0] exp_0_out, exp_1_out, exp_2_out, exp_3_out, exp_4_out, exp_5_out, exp_6_out, exp_7_out, exp_8_out, 
    wire [4:0] exp_max_out, exp_bias_out;

    wire [15:0] aligned_pp_0, aligned_pp_1, aligned_pp_2, aligned_pp_3, aligned_pp_4, aligned_pp_5, aligned_pp_6, aligned_pp_7, aligned_pp_8;
    
    wire [15:0] aligned_pp_0_out, aligned_pp_1_out, aligned_pp_2_out, aligned_pp_3_out, aligned_pp_4_out, aligned_pp_5_out, aligned_pp_6_out, aligned_pp_7_out, aligned_pp_8_out;

    wire [19:0] signed_sum;

    wire [19:0] signed_sum_out;
    wire [5:0] exp_max_out_out;

    wire sign;
    wire [10:0] norm_sum;
    wire [6:0] exp_final;

    wire sign_out;
    wire [10:0] norm_sum_out;
    wire [6:0] exp_final_out;


    out output(.clk(clk), .rst(rst), .image_out(image), .weight_out(weight), .exp_bias_out(exp_bias), 
        .image_out(image_out), .weight_out(weight_out), .exp_bias_out(exp_bias_out));

    ppg0 partial_product_generator(.image(image_out[71:64]), .weight(weight_out[35:32]), .signed_pp(pp_0), .exp(exp_0));
    ppg1 partial_product_generator(.image(image_out[63:56]), .weight(weight_out[31:28]), .signed_pp(pp_1), .exp(exp_1));
    ppg2 partial_product_generator(.image(image_out[55:48]), .weight(weight_out[27:24]), .signed_pp(pp_2), .exp(exp_2));
    ppg3 partial_product_generator(.image(image_out[47:40]), .weight(weight_out[23:20]), .signed_pp(pp_3), .exp(exp_3));
    ppg4 partial_product_generator(.image(image_out[39:32]), .weight(weight_out[19:16]), .signed_pp(pp_4), .exp(exp_4));
    ppg5 partial_product_generator(.image(image_out[31:24]), .weight(weight_out[15:12]), .signed_pp(pp_5), .exp(exp_5));
    ppg6 partial_product_generator(.image(image_out[23:16]), .weight(weight_out[11:8]), .signed_pp(pp_6), .exp(exp_6));
    ppg7 partial_product_generator(.image(image_out[15:8]), .weight(weight_out[7:4]), .signed_pp(pp_7), .exp(exp_7));
    ppg8 partial_product_generator(.image(image_out[7:0]), .weight(weight_out[3:0]), .signed_pp(pp_8), .exp(exp_8));

    max_exp max_exponent(.exp_0(exp_0), .exp_1(exp_1), .exp_2(exp_2), .exp_3(exp_3), .exp_4(exp_4), .exp_5(exp_5), .exp_6(exp_6), .exp_7(exp_7), .exp_8(exp_8), 
        .exp_max(exp_max));

    ppg_align ppg_align(.clk(clk), .rst(rst), 
        .pp_0_out(pp_0), .pp_1_out(pp_1), .pp_2_out(pp_2), .pp_3_out(pp_3), .pp_4_out(pp_4), .pp_5_out(pp_5), .pp_6_out(pp_6), .pp_7_out(pp_7), .pp_8_out(pp_8), 
        .exp_0_out(exp_0), .exp_1_out(exp_1), .exp_2_out(exp_2), .exp_3_out(exp_3), .exp_4_out(exp_4), .exp_5_out(exp_5), .exp_6_out(exp_6), .exp_7_out(exp_7), .exp_8_out(exp_8), 
        .exp_max_out(exp_max), .exp_bias_out(exp_bias), 
        .pp_0_out(pp_0_out), .pp_1_out(pp_1_out), .pp_2_out(pp_2_out), .pp_3_out(pp_3_out), .pp_4_out(pp_4_out), .pp_5_out(pp_5_out), .pp_6_out(pp_6_out), .pp_7_out(pp_7_out), .pp_8_out(pp_8_out), 
        .exp_0_out(exp_0_out), .exp_1_out(exp_1_out), .exp_2_out(exp_2_out), .exp_3_out(exp_3_out), .exp_4_out(exp_4_out), .exp_5_out(exp_5_out), .exp_6_out(exp_6_out), .exp_7_out(exp_7_out), .exp_8_out(exp_8_out), 
        .exp_max_out(exp_max_out), .exp_bias_out(exp_bias_out)
        );

    align0 alignment(.exp(exp_0_out), .exp_max(exp_max_out), .signed_pp(pp_0_out), .aligned_pp(aligned_pp_0));
    align1 alignment(.exp(exp_1_out), .exp_max(exp_max_out), .signed_pp(pp_1_out), .aligned_pp(aligned_pp_1));
    align2 alignment(.exp(exp_2_out), .exp_max(exp_max_out), .signed_pp(pp_2_out), .aligned_pp(aligned_pp_2));
    align3 alignment(.exp(exp_3_out), .exp_max(exp_max_out), .signed_pp(pp_3_out), .aligned_pp(aligned_pp_3));
    align4 alignment(.exp(exp_4_out), .exp_max(exp_max_out), .signed_pp(pp_4_out), .aligned_pp(aligned_pp_4));
    align5 alignment(.exp(exp_5_out), .exp_max(exp_max_out), .signed_pp(pp_5_out), .aligned_pp(aligned_pp_5));
    align6 alignment(.exp(exp_6_out), .exp_max(exp_max_out), .signed_pp(pp_6_out), .aligned_pp(aligned_pp_6));
    align7 alignment(.exp(exp_7_out), .exp_max(exp_max_out), .signed_pp(pp_7_out), .aligned_pp(aligned_pp_7));
    align8 alignment(.exp(exp_8_out), .exp_max(exp_max_out), .signed_pp(pp_8_out), .aligned_pp(aligned_pp_8));

    align_add align_add(.clk(clk), .rst(rst), 
        .aligned_pp_0_in(aligned_pp_0), .aligned_pp_1_in(aligned_pp_1), .aligned_pp_2_in(aligned_pp_2), .aligned_pp_3_in(aligned_pp_3), .aligned_pp_4_in(aligned_pp_4),
        .aligned_pp_5_in(aligned_pp_5), .aligned_pp_6_in(aligned_pp_6), .aligned_pp_7_in(aligned_pp_7), .aligned_pp_8_in(aligned_pp_8), 
        .aligned_pp_0_out(aligned_pp_0_out), .aligned_pp_1_out(aligned_pp_1_out), .aligned_pp_2_out(aligned_pp_2_out), .aligned_pp_3_out(aligned_pp_3_out), .aligned_pp_4_out(aligned_pp_4_out),
        .aligned_pp_5_out(aligned_pp_5_out), .aligned_pp_6_out(aligned_pp_6_out), .aligned_pp_7_out(aligned_pp_7_out), .aligned_pp_8_out(aligned_pp_8_out)
        );
    
    add adder_tree(.aligned_pp_0(aligned_pp_0_out), .aligned_pp_1(aligned_pp_1_out), .aligned_pp_2(aligned_pp_2_out), .aligned_pp_3(aligned_pp_3_out), .aligned_pp_4(aligned_pp_4_out), 
        .aligned_pp_5(aligned_pp_5_out), .aligned_pp_6(aligned_pp_6_out), .aligned_pp_7(aligned_pp_7_out), .aligned_pp_8(aligned_pp_8_out), 
        .signed_sum(signed_sum));

    add add_nor(.clk(clk), .rst(rst), 
        .signed_sum_in(signed_sum), .exp_max_in({1'b0, exp_max_out}), .signed_sum_out(signed_sum_out), .exp_max_out(exp_max_out_out));

    nor normalization(.signed_sum(signed_sum_out), .exp_max(exp_max_out_out), .sign(sign), .norm_sum(norm_sum), .exp_final(exp_final));

    nor_sub nor_sub(.clk(clk), .rst(rst), 
        .sign_in(sign), .norm_sum_in(norm_sum), .exp_final_in(exp_final), 
        .sign_out(sign_out), .norm_sum_out(norm_sum_out), .exp_final_out(exp_final_out)
        );

    sub subnormal_handling(.exp_final(exp_final_out), .sign(sign_out), .norm_sum(norm_sum_out), .out(out));


    always @ (image or weight or exp_bias) begin
        
    end
        


endmodule