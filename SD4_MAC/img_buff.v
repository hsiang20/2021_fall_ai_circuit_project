module img_buff (input clk, rst, 
                 input [23:0] image_in, 
                 output reg [71:0] image_out);
    
    reg [23:0] image1, image2, image3;

    always @ (*) begin
        image_out = {image1, image2, image3};
    end

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            image1 <= 24'b0;
            image2 <= 24'b0;
            image3 <= 24'b0;
        end
        else begin
            image3 <= image2;
            image2 <= image1;
            image1 <= image_in;
        end 
    end

    
endmodule