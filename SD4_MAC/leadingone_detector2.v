module leadingone_detector2 (input clk, 
                             input [19:0] unsign_sum, 
                             output [4:0] leading_one);

    reg [4:0] leading_one_w, leading_one_r;
    assign leading_one = leading_one_r;

    always @ (unsign_sum) begin
        // design 2
        leading_one_w = 0;
        if (unsign_sum[19:16] != 4'b0) begin
            case (unsign_sum[19:17])
                7  : leading_one_w = 19;
                6  : leading_one_w = 19;
                5  : leading_one_w = 19;
                4  : leading_one_w = 19;
                3  : leading_one_w = 18;
                2  : leading_one_w = 18;
                1  : leading_one_w = 17;
                default: leading_one_w = 16;
            endcase
        end
        // else if (unsign_sum[15:12] != 4'b0) begin
        //     case (unsign_sum[15:13])
        //         7  : leading_one_w = 15;
        //         6  : leading_one_w = 15;
        //         5  : leading_one_w = 15;
        //         4  : leading_one_w = 15;
        //         3  : leading_one_w = 14;
        //         2  : leading_one_w = 14;
        //         1  : leading_one_w = 13;
        //         default: leading_one_w = 12;
        //     endcase
        // end
        // else if (unsign_sum[11:8] != 4'b0) begin
        //     case (unsign_sum[11:9])
        //         7  : leading_one_w = 11;
        //         6  : leading_one_w = 11;
        //         5  : leading_one_w = 11;
        //         4  : leading_one_w = 11;
        //         3  : leading_one_w = 10;
        //         2  : leading_one_w = 10;
        //         1  : leading_one_w = 9;
        //         default: leading_one_w = 8;
        //     endcase
        // end
        // else if (unsign_sum[7:4] != 4'b0) begin
        //     case (unsign_sum[7:5])
        //         7  : leading_one_w = 7;
        //         6  : leading_one_w = 7;
        //         5  : leading_one_w = 7;
        //         4  : leading_one_w = 7;
        //         3  : leading_one_w = 6;
        //         2  : leading_one_w = 6;
        //         1  : leading_one_w = 5;
        //         default: leading_one_w = 4;
        //     endcase
        // end
        // else begin
        //     case (unsign_sum[3:1])
        //         7  : leading_one_w = 3;
        //         6  : leading_one_w = 3;
        //         5  : leading_one_w = 3;
        //         4  : leading_one_w = 3;
        //         3  : leading_one_w = 2;
        //         2  : leading_one_w = 2;
        //         1  : leading_one_w = 1;
        //         default: leading_one_w = 0;
        //     endcase
        // end

    end  

    always @ (posedge clk) begin
        leading_one_r <= leading_one_w;        
    end  


endmodule
