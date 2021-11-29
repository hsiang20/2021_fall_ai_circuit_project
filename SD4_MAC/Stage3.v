module adder_tree (input signed [15:0] aligned_pp_0,
                   input signed [15:0] aligned_pp_1,
                   input signed [15:0] aligned_pp_2, 
                   input signed [15:0] aligned_pp_3, 
                   input signed [15:0] aligned_pp_4, 
                   input signed [15:0] aligned_pp_5, 
                   input signed [15:0] aligned_pp_6, 
                   input signed [15:0] aligned_pp_7, 
                   input signed [15:0] aligned_pp_8,
                   output reg signed [19:0] signed_sum); 

    reg signed [16:0] sum01, sum23, sum45, sum67;
    reg signed [17:0] sum0123, sum4567;
    reg signed [18:0] sum01234567;
    
    always @ (*) begin
        sum01 = {aligned_pp_0[15], aligned_pp_0} + {aligned_pp_1[15], aligned_pp_1};
        sum23 = {aligned_pp_2[15], aligned_pp_2} + {aligned_pp_3[15], aligned_pp_3};
        sum45 = {aligned_pp_4[15], aligned_pp_4} + {aligned_pp_5[15], aligned_pp_5};
        sum67 = {aligned_pp_6[15], aligned_pp_6} + {aligned_pp_7[15], aligned_pp_7};
        sum0123 = {sum01[16], sum01} + {sum23[16], sum23};
        sum4567 = {sum45[16], sum45} + {sum67[16], sum67};
        sum01234567 = {sum0123[17], sum0123} + {sum4567[17], sum4567};
        signed_sum = {sum01234567[18], sum01234567} + aligned_pp_8;
    end
    
endmodule

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