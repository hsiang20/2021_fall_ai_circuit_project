module PE (input clk, rst, 
           input [4:0] exp_bias, 
           input [23:0] image_in, 
           input [35:0] weight, 
           input [15:0] psum, 
           output [15:0] psum_out);

    wire [71:0] image;
    wire [15:0] mac_out_w;
    reg [15:0] mac_out;

    assign psum_out = psum + mac_out;
    
    // mac output reg
    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            mac_out <= 0;
        end
        else begin
            mac_out <= mac_out_w;
        end
    end

    MAC mac(.clk(clk), .rst(rsk), .image(image), .weight(weight), .exp_bias(exp_bias), .out(mac_out_w));

    img_buff img_buff(.clk(clk), .rst(rst), .image_in(image_in), .image_out(image));

endmodule