`include "subnormal_handling.v"
module Stage5 (
    input clk,
    input rst, 
    input [6:0] exp_final, 
    input sign, 
    input [10:0] norm_sum, 
    output [15:0] out
);
    reg [15:0] out_r;
    wire [15:0] out_w;


    assign out = out_r;

    subnormal_handling sub(.exp_final(exp_final), .sign(sign), .norm_sum(norm_sum), .out(out_w));
    
   
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            out_r <= 16'b0;
        end
        else begin
            out_r <= out_w;
        end
    end
endmodule