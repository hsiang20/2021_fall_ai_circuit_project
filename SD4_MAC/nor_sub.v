module nor_sub (
    input clk, rst, 
    input sign_in, 
    input [10:0] norm_sum_in, 
    input [6:0] exp_final_in, 
    output reg sign_out, 
    output reg [10:0] norm_sum_out, 
    output reg [6:0] exp_final_out, 
);
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            sign_out <= 0;
            norm_sum_out <= 0;
            exp_final_out <= 0;
        end
        else begin
            sign_out <= sign_in;
            norm_sum_out <= norm_sum_in;
            exp_final_out <= exp_final_in;
        end
    end

endmodule