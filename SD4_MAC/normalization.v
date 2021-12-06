module normalization (input signed [19:0] signed_sum, 
                      input signed [5:0] exp_max, 
                      output reg sign, 
                      output reg [10:0] norm_sum, 
                      output reg signed [6:0] exp_final);
    integer i;
    reg [19:0] unsign_sum, unsign_sum_tmp;
    reg [4:0] leading_one;
    reg [10:0] shifted_sum;
    reg signed [4:0] exp_diff;
    reg [10:0] temp;
    reg signed exp_carry;
    
    
    always @ (signed_sum or exp_max) begin
        // sign
        sign = signed_sum[19];

        // Unsign
        if (sign) begin
            temp = 20'b10000000000000000000;
            temp = temp - signed_sum[18:0];
            unsign_sum = temp;
        end
        else unsign_sum = signed_sum;

        // Leading One Detector 0
        // leading_one = 0;
        // for (i=0; i<19; i=i+1) begin
        //     if (unsign_sum[i]) begin
        //         leading_one = i + 1;
        //     end
        // end


        // Leading One Detector 1
        // leading_one = 0;
        // unsign_sum_tmp = unsign_sum;
        // for (i=0; i<19; i=i+4) begin
        //     if (unsign_sum_tmp[3:0] != 4'b0) begin
        //         if (unsign_sum_tmp[3]) leading_one = i + 4;
        //         else if (unsign_sum_tmp[2]) leading_one = i + 3;
        //         else if (unsign_sum_tmp[1]) leading_one = i + 2;
        //         else leading_one = i + 1;
        //     end
        //     else begin
        //         unsign_sum_tmp = unsign_sum_tmp >> 4;
        //     end
        // end
        
        // Leading One Detector 2
        leading_one = 0;
        if (unsign_sum[19:16] != 4'b0) begin
            if (unsign_sum_tmp[19]) leading_one = 19;
            else if (unsign_sum_tmp[18]) leading_one = 18;
            else if (unsign_sum_tmp[17]) leading_one = 17;
            else leading_one = 16;
        end
        else if (unsign_sum[15:12] != 4'b0) begin
            if (unsign_sum_tmp[15]) leading_one = 15;
            else if (unsign_sum_tmp[14]) leading_one = 14;
            else if (unsign_sum_tmp[13]) leading_one = 13;
            else leading_one = 12;
        end
        else if (unsign_sum[11:8] != 4'b0) begin
                if (unsign_sum_tmp[11]) leading_one = 11;
                else if (unsign_sum_tmp[10]) leading_one = 10;
                else if (unsign_sum_tmp[9]) leading_one = 9;
                else leading_one = 8;
        end
        else if (unsign_sum[7:4] != 4'b0) begin
                if (unsign_sum_tmp[7]) leading_one = 7;
                else if (unsign_sum_tmp[6]) leading_one = 6;
                else if (unsign_sum_tmp[5]) leading_one = 5;
                else leading_one = 4;
        end
        else begin
                if (unsign_sum_tmp[3]) leading_one = 3;
                else if (unsign_sum_tmp[2]) leading_one = 2;
                else if (unsign_sum_tmp[1]) leading_one = 1;
                else leading_one = 0;
        end
        
        // Leading One Detector 3
        // leading_one = 0;
        // if (unsign_sum[19:16] != 4'b0) begin
        //     case (unsign_sum[19:16])
        //         15 : leading_one = 19;
        //         14 : leading_one = 19;
        //         13 : leading_one = 19;
        //         12 : leading_one = 19;
        //         11 : leading_one = 19;
        //         10 : leading_one = 19;
        //         9  : leading_one = 19; 
        //         8  : leading_one = 19;
        //         7  : leading_one = 18;
        //         6  : leading_one = 18;
        //         5  : leading_one = 18;
        //         4  : leading_one = 18;
        //         3  : leading_one = 17;
        //         2  : leading_one = 17;
        //         default: leading_one = 16;
        //     endcase
        // end
        // else if (unsign_sum[15:12] != 4'b0) begin
        //     case (unsign_sum[15:12])
        //         15 : leading_one = 15;
        //         14 : leading_one = 15;
        //         13 : leading_one = 15;
        //         12 : leading_one = 15;
        //         11 : leading_one = 15;
        //         10 : leading_one = 15;
        //         9  : leading_one = 15; 
        //         8  : leading_one = 15;
        //         7  : leading_one = 14;
        //         6  : leading_one = 14;
        //         5  : leading_one = 14;
        //         4  : leading_one = 14;
        //         3  : leading_one = 13;
        //         2  : leading_one = 13;
        //         default: leading_one = 12;
        //     endcase
        // end
        // else if (unsign_sum[11:8] != 4'b0) begin
        //     case (unsign_sum[11:8])
        //         15 : leading_one = 11;
        //         14 : leading_one = 11;
        //         13 : leading_one = 11;
        //         12 : leading_one = 11;
        //         11 : leading_one = 11;
        //         10 : leading_one = 11;
        //         9  : leading_one = 11; 
        //         8  : leading_one = 11;
        //         7  : leading_one = 10;
        //         6  : leading_one = 10;
        //         5  : leading_one = 10;
        //         4  : leading_one = 10;
        //         3  : leading_one = 9;
        //         2  : leading_one = 9;
        //         default leading_one = 8;
        //     endcase
        // end
        // else if (unsign_sum[7:4] != 4'b0) begin
        //     case (unsign_sum[7:4])
        //         15 : leading_one = 7;
        //         14 : leading_one = 7;
        //         13 : leading_one = 7;
        //         12 : leading_one = 7;
        //         11 : leading_one = 7;
        //         10 : leading_one = 7;
        //         9  : leading_one = 7; 
        //         8  : leading_one = 7;
        //         7  : leading_one = 6;
        //         6  : leading_one = 6;
        //         5  : leading_one = 6;
        //         4  : leading_one = 6;
        //         3  : leading_one = 5;
        //         2  : leading_one = 5;
        //         default: leading_one = 4;
        //     endcase
        // end
        // else begin
        //     case (unsign_sum[3:0])
        //         15 : leading_one = 3;
        //         14 : leading_one = 3;
        //         13 : leading_one = 3;
        //         12 : leading_one = 3;
        //         11 : leading_one = 3;
        //         10 : leading_one = 3;
        //         9  : leading_one = 3; 
        //         8  : leading_one = 3;
        //         7  : leading_one = 2;
        //         6  : leading_one = 2;
        //         5  : leading_one = 2;
        //         4  : leading_one = 2;
        //         3  : leading_one = 1;
        //         2  : leading_one = 1;
        //         default: leading_one = 0;
        //     endcase
        // end

        // LUT-based Shifter
        case (leading_one) 
            19 : shifted_sum = unsign_sum[18:8];
            18 : shifted_sum = unsign_sum[17:7];
            17 : shifted_sum = unsign_sum[16:6];
            16 : shifted_sum = unsign_sum[15:5];
            15 : shifted_sum = unsign_sum[14:4];
            14 : shifted_sum = unsign_sum[13:3];
            13 : shifted_sum = unsign_sum[12:2];
            12 : shifted_sum = unsign_sum[11:1];
            11 : shifted_sum = unsign_sum[10:0];
            10 : shifted_sum = {unsign_sum[9:0], 1'b0};
            9 : shifted_sum = {unsign_sum[8:0], 2'b0};
            8 : shifted_sum = {unsign_sum[7:0], 3'b0};
            7 : shifted_sum = {unsign_sum[6:0], 4'b0};
            6 : shifted_sum = {unsign_sum[5:0], 5'b0};
            5 : shifted_sum = {unsign_sum[4:0], 6'b0};
            4 : shifted_sum = {unsign_sum[3:0], 7'b0};
            3 : shifted_sum = {unsign_sum[2:0], 8'b0};
            2 : shifted_sum = {unsign_sum[1:0], 9'b0};
            1 : shifted_sum = {unsign_sum[0], 10'b0};
            default : shifted_sum = 0;
        endcase

        // Exponent Difference
        exp_diff = leading_one - 11;
        // $display("exp_diff: ", exp_diff);

        // Round to Nearest Even
        // Q: Why Even?
        if (shifted_sum[0]) begin
            temp = 11'b11111111111;
            temp = temp - shifted_sum;
            if (temp) begin
                exp_carry = 0;
                shifted_sum = shifted_sum + 1;
                norm_sum = {shifted_sum[10:1], 1'b0};
            end
            else begin
                exp_carry = 1;
                norm_sum = 11'b10000000000;
            end
        end
        else begin
            norm_sum = shifted_sum;
            exp_carry = 0;
        end

        // Signed Adder
        exp_final = exp_max + exp_diff + exp_carry;

    end
    
endmodule
