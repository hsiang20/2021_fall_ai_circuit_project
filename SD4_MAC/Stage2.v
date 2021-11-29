module alignment (input signed [4:0] exp, exp_max, signed_pp, 
                  output reg signed [15:0] aligned_pp);
    reg signed [4:0] exp_diff;
    reg [14:0] pp_shifted;
    reg [15:0] temp;

    always @ (exp or exp_max or signed_pp) begin
        exp_diff = exp_max - exp;
        pp_shifted = {signed_pp[3:0], 11'b0} >> exp_diff;
        if (signed_pp[4]) begin
            // temp = 16'b1000000000000000;
            // temp = temp - pp_shifted;
            // aligned_pp = {signed_pp[4], temp[14:0]};
            aligned_pp = -pp_shifted;
        end        
        else aligned_pp = {signed_pp[4], pp_shifted};
    end    
endmodule
module stage2 (
    input clk,
    input rst, 
    input signed [4:0] signed_pp_0, signed_pp_1, signed_pp_2, signed_pp_3, signed_pp_4, signed_pp_5, signed_pp_6, signed_pp_7, signed_pp_8,
    input signed [4:0] exp_0, exp_1, exp_2, exp_3, exp_4, exp_5, exp_6, exp_7, exp_8,
    input signed [4:0] exp_max,
    //input [4:0] exp_bias ???
    output signed [15:0] aligned_pp_0, aligned_pp_1, aligned_pp_2, aligned_pp_3, aligned_pp_4, aligned_pp_5, aligned_pp_6, aligned_pp_7, aligned_pp_8
);
    reg [15:0] aligned_pp_0_r, aligned_pp_1_r, aligned_pp_2_r, aligned_pp_3_r, aligned_pp_4_r, aligned_pp_5_r, aligned_pp_6_r, aligned_pp_7_r, aligned_pp_8_r;
    wire [15:0] aligned_pp_0_w, aligned_pp_1_w, aligned_pp_2_w, aligned_pp_3_w, aligned_pp_4_w, aligned_pp_5_w, aligned_pp_6_w, aligned_pp_7_w, aligned_pp_8_w;
 

    assign aligned_pp_0 = aligned_pp_0_r;
    assign aligned_pp_1 = aligned_pp_1_r;
    assign aligned_pp_2 = aligned_pp_2_r;
    assign aligned_pp_3 = aligned_pp_3_r;
    assign aligned_pp_4 = aligned_pp_4_r;
    assign aligned_pp_5 = aligned_pp_5_r;
    assign aligned_pp_6 = aligned_pp_6_r;
    assign aligned_pp_7 = aligned_pp_7_r;
    assign aligned_pp_8 = aligned_pp_8_r;

    alignment align0(.exp(exp_0), .exp_max(exp_max), .signed_pp(signed_pp_0), .aligned_pp(aligned_pp_0_w));
    alignment align1(.exp(exp_1), .exp_max(exp_max), .signed_pp(signed_pp_1), .aligned_pp(aligned_pp_1_w));
    alignment align2(.exp(exp_2), .exp_max(exp_max), .signed_pp(signed_pp_2), .aligned_pp(aligned_pp_2_w));
    alignment align3(.exp(exp_3), .exp_max(exp_max), .signed_pp(signed_pp_3), .aligned_pp(aligned_pp_3_w));
    alignment align4(.exp(exp_4), .exp_max(exp_max), .signed_pp(signed_pp_4), .aligned_pp(aligned_pp_4_w));
    alignment align5(.exp(exp_5), .exp_max(exp_max), .signed_pp(signed_pp_5), .aligned_pp(aligned_pp_5_w));
    alignment align6(.exp(exp_6), .exp_max(exp_max), .signed_pp(signed_pp_6), .aligned_pp(aligned_pp_6_w));
    alignment align7(.exp(exp_7), .exp_max(exp_max), .signed_pp(signed_pp_7), .aligned_pp(aligned_pp_7_w));
    alignment align8(.exp(exp_8), .exp_max(exp_max), .signed_pp(signed_pp_8), .aligned_pp(aligned_pp_8_w));
    
    always @(*) begin
        aligned_pp_0_w = aligned_pp_0_r;
        aligned_pp_1_w = aligned_pp_1_r;
        aligned_pp_2_w = aligned_pp_2_r;
        aligned_pp_3_w = aligned_pp_3_r;
        aligned_pp_4_w = aligned_pp_4_r;
        aligned_pp_5_w = aligned_pp_5_r;
        aligned_pp_6_w = aligned_pp_6_r;
        aligned_pp_7_w = aligned_pp_7_r;
        aligned_pp_8_w = aligned_pp_8_r;
    end

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            aligned_pp_0_r = 15'b0;
            aligned_pp_1_r = 15'b0;
            aligned_pp_2_r = 15'b0;
            aligned_pp_3_r = 15'b0;
            aligned_pp_4_r = 15'b0;
            aligned_pp_5_r = 15'b0;
            aligned_pp_6_r = 15'b0;
            aligned_pp_7_r = 15'b0;
            aligned_pp_8_r = 15'b0;
        end
        else begin
            aligned_pp_0_r <= aligned_pp_0_w;
            aligned_pp_1_r <= aligned_pp_1_w;
            aligned_pp_2_r <= aligned_pp_2_w;
            aligned_pp_3_r <= aligned_pp_3_w;
            aligned_pp_4_r <= aligned_pp_4_w;
            aligned_pp_5_r <= aligned_pp_5_w;
            aligned_pp_6_r <= aligned_pp_6_w;
            aligned_pp_7_r <= aligned_pp_7_w;
            aligned_pp_8_r <= aligned_pp_8_w;
        end
    end
endmodule