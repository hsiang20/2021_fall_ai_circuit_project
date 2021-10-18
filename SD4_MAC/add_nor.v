module add_nor (
    input clk, rst, 
    input [19:0] signed_sum_in, 
    input [5:0] exp_max_in, 
    output reg [19:0] signed_sum_out, 
    output reg [5:0] exp_max_out
);
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            signed_sum_out <= 0;
            exp_max_out <= 0;
        end
        else begin
            signed_sum_out <= signed_sum_in;
            exp_max_out <= exp_max_in;
        end
    end
endmodule