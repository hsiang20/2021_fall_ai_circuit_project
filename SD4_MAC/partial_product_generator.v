module partial_product_generator(input [7:0] image, 
                                 input [3:0] weight, 
                                 output [4:0] signed_pp, 
                                 output [4:0] exp);
    
    wire sign;
    wire image_zero;
    wire weight_zero;
    wire zero;
    
    // signed significant
    assign sign = image[7] ^ weight[3];

    assign image_zero = image[6:0] == 7'b0;
    assign weight_zero = weight[0] & weight[1] & weight[2];
    assign zero = image_zero | weight_zero;

    assign signed_pp = (zero)? 5'b0 : {sign, 1'b1, image[2:0]};
    assign exp = (zero)? 5'b0 : image[6:3] + weight[2:0];

endmodule
