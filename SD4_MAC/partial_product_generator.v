module partial_product_generator(input [7:0] image, 
                                 input [3:0] weight, 
                                 output reg [4:0] signed_pp, 
                                 output reg [4:0] exp);
    
    integer i;
    reg sign;
    reg image_zero;
    reg weight_zero;
    reg zero;
    
    always @ (image or weight) begin
        // signed significant
        sign = image[7] ^ weight[3];

        // zero detect        
        image_zero = 1;
        for (i=0; i<7; i=i+1) begin
            if (image[i]) image_zero = 0;
        end
        weight_zero = weight[0] & weight[1] & weight[2];
        zero = image_zero | weight_zero;

        // signed_pp mux and exp mux
        if (zero) begin
            signed_pp = 5'b0;
            exp = 5'b0; 
        end
        else begin
            signed_pp = {sign, 1'b1, image[2:0]};
            exp = image[6:3] + weight[2:0];
        end
    end

endmodule