module align_add (
    input clk, rst, 
    input [15:0] aligned_pp_0_in, aligned_pp_1_in, aligned_pp_2_in, aligned_pp_3_in, aligned_pp_4_in, aligned_pp_5_in, aligned_pp_6_in, aligned_pp_7_in, aligned_pp_8_in, 
    output reg [15:0] aligned_pp_0_out, aligned_pp_1_out, aligned_pp_2_out, aligned_pp_3_out, aligned_pp_4_out, aligned_pp_5_out, aligned_pp_6_out, aligned_pp_7_out, aligned_pp_8_out 
);
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            aligned_pp_0_out <= 0;
            aligned_pp_1_out <= 0;
            aligned_pp_2_out <= 0;
            aligned_pp_3_out <= 0;
            aligned_pp_4_out <= 0;
            aligned_pp_5_out <= 0;
            aligned_pp_6_out <= 0;
            aligned_pp_7_out <= 0;
            aligned_pp_8_out <= 0;
        end
        else begin
            aligned_pp_0_out <= aligned_pp_0_in;
            aligned_pp_1_out <= aligned_pp_1_in;
            aligned_pp_2_out <= aligned_pp_2_in;
            aligned_pp_3_out <= aligned_pp_3_in;
            aligned_pp_4_out <= aligned_pp_4_in;
            aligned_pp_5_out <= aligned_pp_5_in;
            aligned_pp_6_out <= aligned_pp_6_in;
            aligned_pp_7_out <= aligned_pp_7_in;
            aligned_pp_8_out <= aligned_pp_8_in;
        end
    end
endmodule