module tb;
    reg [7:0] image;
    reg [3:0] weight;
    wire [4:0] signed_pp;
    wire [4:0] exp;
    
    initial begin
        image = 8'b00000111;
        weight = 4'b0001;
        #1 weight = 4'b0011; 
        $display("signed_pp: ", signed_pp);
        $display("exp: ", exp);
    end

    partial_product_generator p(.image(image), 
                                .weight(weight), 
                                .signed_pp(signed_pp), 
                                .exp(exp));
endmodule