module alignment (input signed [4:0] exp, exp_max, signed_pp, 
                  output signed [15:0] aligned_pp);
                  
    wire signed [4:0] exp_diff;
    wire [14:0] pp_shifted;

    assign exp_diff = exp_max - exp;

    assign pp_shifted = {signed_pp[3:0], 11'b0} >> exp_diff;
      
    assign aligned_pp = (signed_pp[4])? -pp_shifted : {1'b0, pp_shifted};
      
endmodule