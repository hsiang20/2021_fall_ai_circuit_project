module subnormal_handling (input [6:0] exp_final, 
                           input sign, 
                           input [10:0] norm_sum, 
                           output reg [15:0] out);
    reg [5:0] exp_final_unsign;
    reg [10:0] temp;

    always @ (exp_final or sign or norm_sum) begin
        // exp_final < 0
        if (exp_final[6]) begin
            exp_final_unsign = 7'b1000000 - exp_final[5:0];
            temp = norm_sum >> exp_final_unsign;
            out = {sign, 5'b0, temp[9:0]};
        end

        // exp_final >= 0
        else begin
            out = {sign, exp_final[4:0], norm_sum[9:0]};
        end
    end
    
endmodule