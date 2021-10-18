module tb;
    reg [19:0] signed_sum;
    reg [5:0] exp_max;
    wire sign;
    wire [10:0] norm_sum;
    wire [6:0] exp_final;

    initial begin
        signed_sum = 20'b00000000000000011111;
        exp_max = 6'b000111;
        
        #1
        $display("sign: %b", sign);
        $display("norm_sum: %b", norm_sum);
        $display("exp_final: %b", exp_final);
    end

    // subnormal_handling s(.exp_final(exp_final), 
    //                      .sign(sign), 
    //                      .norm_sum(norm_sum), 
    //                      .out(out));

    // partial_product_generator ppg(.image(image), .weight(weight), .signed_pp(signed_pp), .exp(exp));

    // max_exponent max_ex(.exp_0(exp_0), .exp_1(exp_1), .exp_2(exp_2), .exp_3(exp_3), .exp_4(exp_4), .exp_5(exp_5), .exp_6(exp_6), .exp_7(exp_7), .exp_8(exp_8), .exp_max(exp_max));

    // alignment align(.exp(exp), .exp_max(exp_max), .signed_pp(signed_pp), .aligned_pp(aligned_pp));

    // adder_tree add(.aligned_pp_0(aligned_pp_0), .aligned_pp_1(aligned_pp_1), .aligned_pp_2(aligned_pp_2), 
    //                .aligned_pp_3(aligned_pp_3), .aligned_pp_4(aligned_pp_4), .aligned_pp_5(aligned_pp_5), 
    //                .aligned_pp_6(aligned_pp_6), .aligned_pp_7(aligned_pp_7), .aligned_pp_8(aligned_pp_8), 
    //                .signed_sum(signed_sum));

    normalization normal(.signed_sum(signed_sum), .exp_max(exp_max), .sign(sign), .norm_sum(norm_sum), .exp_final(exp_final));

endmodule