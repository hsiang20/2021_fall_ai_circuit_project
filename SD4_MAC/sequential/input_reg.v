module input_reg (input clk, rst, 
    input [71:0] image_in,
    input [35:0] weight_in, 
    input [4:0] exp_bias_in, 
    output reg [71:0] image_out, 
    output reg [35:0] weight_out, 
    output reg [4:0] exp_bias_out);

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            image_out <= 0;
            weight_out <= 0;
        end
        else begin
            image_out <= image_in;
            weight_out <= weight_in;
            exp_bias_out <= exp_bias_in;
        end
    end
    
endmodule