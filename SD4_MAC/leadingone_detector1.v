module leadingone_detector1 (input clk, 
                             input [19:0] unsign_sum, 
                             output [4:0] leading_one);

    reg [4:0] leading_one_w, leading_one_r;
    assign leading_one = leading_one_r;

    always @ (unsign_sum) begin
        // design 1
        leading_one_w = 0;
        if (unsign_sum[19:16] != 4'b0) begin
            if (unsign_sum[19]) leading_one_w = 19;
            else if (unsign_sum[18]) leading_one_w = 18;
            else if (unsign_sum[17]) leading_one_w = 17;
            else leading_one_w = 16;
        end
        // else if (unsign_sum[15:12] != 4'b0) begin
        //     if (unsign_sum[15]) leading_one_w = 15;
        //     else if (unsign_sum[14]) leading_one_w = 14;
        //     else if (unsign_sum[13]) leading_one_w = 13;
        //     else leading_one_w = 12;
        // end
        // else if (unsign_sum[11:8] != 4'b0) begin
        //     if (unsign_sum[11]) leading_one_w = 11;
        //     else if (unsign_sum[10]) leading_one_w = 10;
        //     else if (unsign_sum[9]) leading_one_w = 9;
        //     else leading_one_w = 8;
        // end
        // else if (unsign_sum[7:4] != 4'b0) begin
        //     if (unsign_sum[7]) leading_one_w = 7;
        //     else if (unsign_sum[6]) leading_one_w = 6;
        //     else if (unsign_sum[5]) leading_one_w = 5;
        //     else leading_one_w = 4;
        // end
        // else begin
        //     if (unsign_sum[3]) leading_one_w = 3;
        //     else if (unsign_sum[2]) leading_one_w = 2;
        //     else if (unsign_sum[1]) leading_one_w = 1;
        //     else leading_one_w = 0;
        // end

    end  

    always @ (posedge clk) begin
        leading_one_r <= leading_one_w;        
    end  


endmodule
