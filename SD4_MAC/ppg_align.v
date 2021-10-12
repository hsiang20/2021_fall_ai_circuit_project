module ppg_align (
    input clk, rst, 
    input [4:0] pp_0_in, pp_1_in, pp_2_in, pp_3_in, pp_4_in, pp_5_in, pp_6_in, pp_7_in, pp_8_in,
    input [4:0] exp_0_in, exp_1_in, exp_2_in, exp_3_in, exp_4_in, exp_5_in, exp_6_in, exp_7_in, exp_8_in, 
    input [4:0] exp_max_in, exp_bias_in, 
    output reg [4:0] pp_0_out, pp_1_out, pp_2_out, pp_3_out, pp_4_out, pp_5_out, pp_6_out, pp_7_out, pp_8_out,
    output reg [4:0] exp_0_out, exp_1_out, exp_2_out, exp_3_out, exp_4_out, exp_5_out, exp_6_out, exp_7_out, exp_8_out, 
    output reg [4:0] exp_max_out, exp_bias_out
);
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            pp_0_out <= 0;
            pp_1_out <= 0;
            pp_2_out <= 0;
            pp_3_out <= 0;
            pp_4_out <= 0;
            pp_5_out <= 0;
            pp_6_out <= 0;
            pp_7_out <= 0;
            pp_8_out <= 0;
            exp_0_out <= 0;
            exp_1_out <= 0;
            exp_2_out <= 0;
            exp_3_out <= 0;
            exp_4_out <= 0;
            exp_5_out <= 0;
            exp_6_out <= 0;
            exp_7_out <= 0;
            exp_8_out <= 0;
            exp_max_out <= 0;
            exp_bias_out <= 0;
        end
        else begin
            pp_0_out <= pp_0_in;
            pp_1_out <= pp_1_in;
            pp_2_out <= pp_2_in;
            pp_3_out <= pp_3_in; 
            pp_4_out <= pp_4_in;
            pp_5_out <= pp_5_in;
            pp_6_out <= pp_6_in;
            pp_7_out <= pp_7_in;
            pp_8_out <= pp_8_in;
            exp_0_out <= exp_0_in;
            exp_1_out <= exp_1_in;
            exp_2_out <= exp_2_in;
            exp_3_out <= exp_3_in;
            exp_4_out <= exp_4_in;
            exp_5_out <= exp_5_in;
            exp_6_out <= exp_6_in;
            exp_7_out <= exp_7_in;
            exp_8_out <= exp_8_in;
            exp_max_out <= exp_max_in;
            exp_bias_out <= exp_bias_in;
        end
    end
endmodule