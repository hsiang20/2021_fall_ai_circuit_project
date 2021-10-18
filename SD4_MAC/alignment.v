module alignment (input signed [4:0] exp, exp_max, signed_pp, 
                  output reg [15:0] aligned_pp);
    reg signed [4:0] exp_diff;
    reg [14:0] pp_shifted;
    reg [15:0] temp;

    always @ (exp or exp_max or signed_pp) begin
        exp_diff = exp_max - exp;
        pp_shifted = {signed_pp[3:0], 11'b0} >> exp_diff;
        if (signed_pp[4]) begin
            temp = 16'b1000000000000000;
            temp = temp - pp_shifted;
            aligned_pp = {signed_pp[4], temp[14:0]};
        end        
        else aligned_pp = {signed_pp[4], pp_shifted};
    end    
endmodule