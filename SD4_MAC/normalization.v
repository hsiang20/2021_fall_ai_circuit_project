module normalization (input [19:0] signed_sum, 
                      input [5:0] exp_max, 
                      output reg sign, 
                      output reg [10:0] norm_sum, 
                      output reg [6:0] exp_final);
    integer i;
    reg [19:0] unsign_sum;
    reg [4:0] leading_one;
    reg [10:0] shifted_sum;
    reg [4:0] exp_diff;
    reg [10:0] temp;
    reg exp_carry;
    
    
    always @ (signed_sum or exp_max) begin
        // sign
        sign = signed_sum[19];

        // Unsign
        if (sign) begin
            temp = 20'b10000000000000000000;
            temp = temp - signed_sum[18:0];
            unsign_sum = signed_sum;
        end
        else unsign_sum = signed_sum;

        // Leading One Detector
        leading_one = 0;
        for (i=0; i<19; i=i+1) begin
            if (unsign_sum[i]) begin
                leading_one = i + 1;
            end
        end

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
            10 : shifted_sum = unsign_sum[9:0] + 1'b0;
            9 : shifted_sum = unsign_sum[8:0] + 2'b0;
            8 : shifted_sum = unsign_sum[7:0] + 3'b0;
            7 : shifted_sum = unsign_sum[6:0] + 4'b0;
            6 : shifted_sum = unsign_sum[5:0] + 5'b0;
            5 : shifted_sum = unsign_sum[4:0] + 6'b0;
            4 : shifted_sum = unsign_sum[3:0] + 7'b0;
            3 : shifted_sum = unsign_sum[2:0] + 8'b0;
            2 : shifted_sum = unsign_sum[1:0] + 9'b0;
            1 : shifted_sum = unsign_sum[0] + 10'b0;
            default : shifted_sum = 0;
        endcase

        // Exponent Difference
        exp_diff = leading_one - 11;

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
