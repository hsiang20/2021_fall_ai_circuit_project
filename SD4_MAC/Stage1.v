module partial_product_generator(input [7:0] image, 
                                 input [3:0] weight, 
                                 output reg [4:0] signed_pp, 
                                 output reg [4:0] exp);
    
    integer i;
    reg sign;
    reg image_zero;
    reg weight_zero;
    reg zero;
    
    always @ (image or weight) begin
        // signed significant
        sign = image[7] ^ weight[3];

        // zero detect        
        image_zero = 1;
        for (i=0; i<7; i=i+1) begin
            if (image[i]) image_zero = 0;
        end
        weight_zero = weight[0] & weight[1] & weight[2];
        zero = image_zero | weight_zero;

        // signed_pp mux and exp mux
        if (zero) begin
            signed_pp = 5'b0;
            exp = 5'b0; 
        end
        else begin
            signed_pp = {sign, 1'b1, image[2:0]};
            exp = image[6:3] + weight[2:0];
        end
    end

endmodule
module max_exponent (input [4:0] exp_0, exp_1, exp_2, exp_3, exp_4, exp_5, exp_6, exp_7, exp_8,
                     output reg [4:0] exp_max);
    
    reg [4:0] exp012, exp345, exp678;
    
    always @(*) begin
        exp012 = (exp_0 > exp_1 && exp_0 > exp_2 ) ? exp_0 :
                 (exp_1 > exp_2)                   ? exp_1 : exp_2;
        exp345 = (exp_3 > exp_4 && exp_3 > exp_5 ) ? exp_3 :
                 (exp_4 > exp_5)                   ? exp_4 : exp_5;
        exp678 = (exp_6 > exp_7 && exp_6 > exp_8 ) ? exp_6 :
                 (exp_7 > exp_8)                   ? exp_7 : exp_8;
        exp_max = (exp012 > exp345 && exp012 > exp678 ) ? exp012 :
                  (exp345 > exp678)                     ? exp345 : exp678;
    end
    
endmodule

module stage1 (
    input clk,
    input rst, 
    input [71:0] image_in,
    input [35:0] weight_in, 
    input [4:0] exp_bias_in,
    output [4:0] signed_pp_0, signed_pp_1, signed_pp_2, signed_pp_3, signed_pp_4, signed_pp_5, signed_pp_6, signed_pp_7, signed_pp_8, 
    output [4:0] exp_0, exp_1, exp_2, exp_3, exp_4, exp_5, exp_6, exp_7, exp_8, 
    output [4:0] exp_max,
    output reg [4:0] exp_bias
    );

    reg [4:0] signed_pp_0_r, signed_pp_1_r, signed_pp_2_r, signed_pp_3_r, signed_pp_4_r, signed_pp_5_r, signed_pp_6_r, signed_pp_7_r, signed_pp_8_r;
    wire [4:0] signed_pp_0_w, signed_pp_1_w, signed_pp_2_w, signed_pp_3_w, signed_pp_4_w, signed_pp_5_w, signed_pp_6_w, signed_pp_7_w, signed_pp_8_w;
    reg [4:0] exp_0_r, exp_1_r, exp_2_r, exp_3_r, exp_4_r, exp_5_r, exp_6_r, exp_7_r, exp_8_r;
    wire [4:0] exp_0_w, exp_1_w, exp_2_w, exp_3_w, exp_4_w, exp_5_w, exp_6_w, exp_7_w, exp_8_w; 
    reg [4:0] exp_max_r;
    wire [4:0] exp_max_w;

    assign signed_pp_0 = signed_pp_0_r;
    assign signed_pp_1 = signed_pp_1_r;
    assign signed_pp_2 = signed_pp_2_r;
    assign signed_pp_3 = signed_pp_3_r;
    assign signed_pp_4 = signed_pp_4_r;
    assign signed_pp_5 = signed_pp_5_r;
    assign signed_pp_6 = signed_pp_6_r;
    assign signed_pp_7 = signed_pp_7_r;
    assign signed_pp_8 = signed_pp_8_r;
    assign exp_0 = exp_0_r;
    assign exp_1 = exp_1_r;
    assign exp_2 = exp_2_r;
    assign exp_3 = exp_3_r;
    assign exp_4 = exp_4_r;
    assign exp_5 = exp_5_r;
    assign exp_6 = exp_6_r;
    assign exp_7 = exp_7_r;
    assign exp_8 = exp_8_r;
    assign exp_max = exp_max_r;

    partial_product_generator ppg0(.image(image_in[71:64]), .weight(weight_in[35:32]), .signed_pp(signed_pp_0_w), .exp(exp_0_w));
    partial_product_generator ppg1(.image(image_in[63:56]), .weight(weight_in[31:28]), .signed_pp(signed_pp_1_w), .exp(exp_1_w));
    partial_product_generator ppg2(.image(image_in[55:48]), .weight(weight_in[27:24]), .signed_pp(signed_pp_2_w), .exp(exp_2_w));
    partial_product_generator ppg3(.image(image_in[47:40]), .weight(weight_in[23:20]), .signed_pp(signed_pp_3_w), .exp(exp_3_w));
    partial_product_generator ppg4(.image(image_in[39:32]), .weight(weight_in[19:16]), .signed_pp(signed_pp_4_w), .exp(exp_4_w));
    partial_product_generator ppg5(.image(image_in[31:24]), .weight(weight_in[15:12]), .signed_pp(signed_pp_5_w), .exp(exp_5_w));
    partial_product_generator ppg6(.image(image_in[23:16]), .weight(weight_in[11:8]), .signed_pp(signed_pp_6_w), .exp(exp_6_w));
    partial_product_generator ppg7(.image(image_in[15:8]), .weight(weight_in[7:4]), .signed_pp(signed_pp_7_w), .exp(exp_7_w));
    partial_product_generator ppg8(.image(image_in[7:0]), .weight(weight_in[3:0]), .signed_pp(signed_pp_8_w), .exp(exp_8_w));

    max_exponent max_exp(.exp_0(exp_0_w), .exp_1(exp_1_w), .exp_2(exp_2_w), .exp_3(exp_3_w), .exp_4(exp_4_w),
                         .exp_5(exp_5_w), .exp_6(exp_6_w), .exp_7(exp_7_w), .exp_8(exp_8_w), .exp_max(exp_max_w));

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            exp_bias    <= 5'b0;
            signed_pp_0_r <= 5'b0;
            signed_pp_1_r <= 5'b0;
            signed_pp_2_r <= 5'b0;
            signed_pp_3_r <= 5'b0;
            signed_pp_4_r <= 5'b0;
            signed_pp_5_r <= 5'b0;
            signed_pp_6_r <= 5'b0;
            signed_pp_7_r <= 5'b0;
            signed_pp_8_r <= 5'b0;
            exp_0_r       <= 5'b0;
            exp_1_r       <= 5'b0;
            exp_2_r       <= 5'b0;
            exp_3_r       <= 5'b0;
            exp_4_r       <= 5'b0;
            exp_5_r       <= 5'b0;
            exp_6_r       <= 5'b0;
            exp_7_r       <= 5'b0;
            exp_8_r       <= 5'b0;
            exp_max_r   <= 5'b0;

        end
        else begin
            exp_bias      <= exp_bias_in;
            exp_max_r     <= exp_max_w; 
            signed_pp_0_r <= signed_pp_0_w;
            signed_pp_1_r <= signed_pp_1_w;
            signed_pp_2_r <= signed_pp_2_w;
            signed_pp_3_r <= signed_pp_3_w;
            signed_pp_4_r <= signed_pp_4_w;
            signed_pp_5_r <= signed_pp_5_w;
            signed_pp_6_r <= signed_pp_6_w;
            signed_pp_7_r <= signed_pp_7_w;
            signed_pp_8_r <= signed_pp_8_w;
            exp_0_r       <= exp_0_w;
            exp_1_r       <= exp_1_w;
            exp_2_r       <= exp_2_w;
            exp_3_r       <= exp_3_w;
            exp_4_r       <= exp_4_w;
            exp_5_r       <= exp_5_w;
            exp_6_r       <= exp_6_w;
            exp_7_r       <= exp_7_w;
            exp_8_r       <= exp_8_w;
        end
    end
    
endmodule