module tb;
    reg [4:0] exp, exp_max, signed_pp;
    wire [15:0] aligned_pp;

    initial begin
        exp = 5'b00011;
        exp_max = 5'b00100;
        signed_pp = 5'b10101;

        #1
        // $display("signed_pp: %b", signed_pp);
        $display("aligned_pp: %b", aligned_pp);
    end

    // subnormal_handling s(.exp_final(exp_final), 
    //                      .sign(sign), 
    //                      .norm_sum(norm_sum), 
    //                      .out(out));

    // partial_product_generator ppg(.image(image), .weight(weight), .signed_pp(signed_pp), .exp(exp));

    // max_exponent max_ex(.exp_0(exp_0), .exp_1(exp_1), .exp_2(exp_2), .exp_3(exp_3), .exp_4(exp_4), .exp_5(exp_5), .exp_6(exp_6), .exp_7(exp_7), .exp_8(exp_8), .exp_max(exp_max));

    alignment align(.exp(exp), .exp_max(exp_max), .signed_pp(signed_pp), .aligned_pp(aligned_pp));


endmodule