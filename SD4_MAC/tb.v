module tb;
    reg [71:0] image_out;
    reg [35:0] weight_out;
    reg [4:0] exp_bias_out;

    wire [4:0] pp_0, pp_1, pp_2, pp_3, pp_4, pp_5, pp_6, pp_7, pp_8;
    wire [4:0] exp_0, exp_1, exp_2, exp_3, exp_4, exp_5, exp_6, exp_7, exp_8;
    wire [4:0] exp_max;
    wire [15:0] aligned_pp_0, aligned_pp_1, aligned_pp_2, aligned_pp_3, aligned_pp_4, aligned_pp_5, aligned_pp_6, aligned_pp_7, aligned_pp_8;
    wire [19:0] signed_sum;

    wire [44:0] signed_pp_all;
    wire [44:0] exp_all;
    wire [143:0] aligned_pp_all;

    assign signed_pp_all = {pp_0, pp_1, pp_2, pp_3, pp_4, pp_5, pp_6, pp_7, pp_8};
    assign exp_all = {exp_0, exp_1, exp_2, exp_3, exp_4, exp_5, exp_6, exp_7, exp_8};
    assign aligned_pp_all = {aligned_pp_0, aligned_pp_1, aligned_pp_2, aligned_pp_3, aligned_pp_4, aligned_pp_5, aligned_pp_6, aligned_pp_7, aligned_pp_8};

    initial begin
        image_out = 72'b100110011111100001010001011101001100100001011010100111010001011011110001;
        weight_out = 36'b101011001101101111111101100011010011;
        exp_bias_out = 5'b10001;
        #1
        $display("signed_pp: %b", signed_pp_all);
        $display("exp: %b", exp_all);
        $display("exp_max: %b", exp_max);
        $display("aligned_pp: %b", aligned_pp_all);
        $display("signed_sum: %b", signed_sum);
    end


    partial_product_generator ppg0(.image(image_out[71:64]), .weight(weight_out[35:32]), .signed_pp(pp_0), .exp(exp_0));
    partial_product_generator ppg1(.image(image_out[63:56]), .weight(weight_out[31:28]), .signed_pp(pp_1), .exp(exp_1));
    partial_product_generator ppg2(.image(image_out[55:48]), .weight(weight_out[27:24]), .signed_pp(pp_2), .exp(exp_2));
    partial_product_generator ppg3(.image(image_out[47:40]), .weight(weight_out[23:20]), .signed_pp(pp_3), .exp(exp_3));
    partial_product_generator ppg4(.image(image_out[39:32]), .weight(weight_out[19:16]), .signed_pp(pp_4), .exp(exp_4));
    partial_product_generator ppg5(.image(image_out[31:24]), .weight(weight_out[15:12]), .signed_pp(pp_5), .exp(exp_5));
    partial_product_generator ppg6(.image(image_out[23:16]), .weight(weight_out[11:8]), .signed_pp(pp_6), .exp(exp_6));
    partial_product_generator ppg7(.image(image_out[15:8]), .weight(weight_out[7:4]), .signed_pp(pp_7), .exp(exp_7));
    partial_product_generator ppg8(.image(image_out[7:0]), .weight(weight_out[3:0]), .signed_pp(pp_8), .exp(exp_8));

    max_exponent max_exp(.exp_0(exp_0), .exp_1(exp_1), .exp_2(exp_2), .exp_3(exp_3), .exp_4(exp_4), .exp_5(exp_5), .exp_6(exp_6), .exp_7(exp_7), .exp_8(exp_8), 
        .exp_max(exp_max));

    alignment align0(.exp(exp_0), .exp_max(exp_max), .signed_pp(pp_0), .aligned_pp(aligned_pp_0));
    alignment align1(.exp(exp_1), .exp_max(exp_max), .signed_pp(pp_1), .aligned_pp(aligned_pp_1));
    alignment align2(.exp(exp_2), .exp_max(exp_max), .signed_pp(pp_2), .aligned_pp(aligned_pp_2));
    alignment align3(.exp(exp_3), .exp_max(exp_max), .signed_pp(pp_3), .aligned_pp(aligned_pp_3));
    alignment align4(.exp(exp_4), .exp_max(exp_max), .signed_pp(pp_4), .aligned_pp(aligned_pp_4));
    alignment align5(.exp(exp_5), .exp_max(exp_max), .signed_pp(pp_5), .aligned_pp(aligned_pp_5));
    alignment align6(.exp(exp_6), .exp_max(exp_max), .signed_pp(pp_6), .aligned_pp(aligned_pp_6));
    alignment align7(.exp(exp_7), .exp_max(exp_max), .signed_pp(pp_7), .aligned_pp(aligned_pp_7));
    alignment align8(.exp(exp_8), .exp_max(exp_max), .signed_pp(pp_8), .aligned_pp(aligned_pp_8));

    adder_tree add(.aligned_pp_0(aligned_pp_0), .aligned_pp_1(aligned_pp_1), .aligned_pp_2(aligned_pp_2), 
                   .aligned_pp_3(aligned_pp_3), .aligned_pp_4(aligned_pp_4), .aligned_pp_5(aligned_pp_5), 
                   .aligned_pp_6(aligned_pp_6), .aligned_pp_7(aligned_pp_7), .aligned_pp_8(aligned_pp_8), 
                   .signed_sum(signed_sum));

    // partial_product_generator ppg(.image(image), .weight(weight), .signed_pp(signed_pp), .exp(exp));

    // max_exponent max_ex(.exp_0(exp_0), .exp_1(exp_1), .exp_2(exp_2), .exp_3(exp_3), .exp_4(exp_4), .exp_5(exp_5), .exp_6(exp_6), .exp_7(exp_7), .exp_8(exp_8), .exp_max(exp_max));

    // alignment align(.exp(exp), .exp_max(exp_max), .signed_pp(signed_pp), .aligned_pp(aligned_pp));

    // adder_tree add(.aligned_pp_0(aligned_pp_0), .aligned_pp_1(aligned_pp_1), .aligned_pp_2(aligned_pp_2), 
    //                .aligned_pp_3(aligned_pp_3), .aligned_pp_4(aligned_pp_4), .aligned_pp_5(aligned_pp_5), 
    //                .aligned_pp_6(aligned_pp_6), .aligned_pp_7(aligned_pp_7), .aligned_pp_8(aligned_pp_8), 
    //                .signed_sum(signed_sum));

    // normalization normal(.signed_sum(signed_sum), .exp_max(exp_max), .sign(sign), .norm_sum(norm_sum), .exp_final(exp_final));

    // subnormal_handling s(.exp_final(exp_final), 
    //                      .sign(sign), 
    //                      .norm_sum(norm_sum), 
    //                      .out(out));

endmodule