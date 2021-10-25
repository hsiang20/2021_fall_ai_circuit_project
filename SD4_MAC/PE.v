module PE (input clk, rst, 
           input [4:0] exp_bias, 
           input [23:0] image_in, 
           input [35:0] weight, 
           input [15:0] psum, 
           output reg [15:0] psum_out);

    reg [71:0] image;
    reg [15:0] mac_out_r, mac_out;

    assign psum_out = psum + mac_out;
    
    // mac output reg
    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            mac_out <= 0;
        else begin
            mac_out <= mac_out_r;
        end
    end

    MAC mac(.clk(clk), .rst(rsk), .image(image), .weight(weight), .exp_bias(exp_bias), .out(mac_out_r));

    img_buff img_buff(.clk(clk), .rst(rst), .image_in(image_in), .image_out(image));

endmodule