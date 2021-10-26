module PE_reg (input clk, rst, 
               input [4:0] exp_bias_in, 
               input [23:0] image_in, 
               input [35:0] weight_in, 
               input [15:0] psum_in, 
               output reg [4:0] exp_bias_out, 
               output reg [23:0] image_out, 
               output reg [35:0] weight_out, 
               output reg [15:0] psum_out);

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            exp_bias_out <= 0;
            image_out <= 0;
            weight_out <= 0;
            psum_out <= 0;
        end
        else begin
            exp_bias_out <= exp_bias_in;
            image_out <= image_in;
            weight_out <= weight_in;
            psum_out <= psum_in;
        end
    end
    
endmodule