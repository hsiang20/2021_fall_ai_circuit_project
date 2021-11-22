`include "PE_row.v"
module PE_array (input clk, rst, 
                 input [4:0] exp_bias, 
                 input [23:0] img1, img2, img3, img4, 
                 input [35:0] wgt1, wgt2, wgt3, wgt4, 
                 input [15:0] psum1, psum2, psum3, psum4, 
                 output [15:0] out1, out2, out3, out4);

    reg [35:0] wgt1_2, wgt1_3, wgt1_4;
    reg [35:0] wgt2_2, wgt2_3, wgt2_4;
    reg [35:0] wgt3_2, wgt3_3, wgt3_4;
    reg [35:0] wgt4_2, wgt4_3, wgt4_4;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            wgt1_2 <= 36'b0;
            wgt1_3 <= 36'b0;
            wgt1_4 <= 36'b0;
            wgt2_2 <= 36'b0;
            wgt2_3 <= 36'b0;
            wgt2_4 <= 36'b0;
            wgt3_2 <= 36'b0;
            wgt3_3 <= 36'b0;
            wgt3_4 <= 36'b0;
            wgt4_2 <= 36'b0;
            wgt4_3 <= 36'b0;
            wgt4_4 <= 36'b0;
        end
        else begin
            wgt1_4 <= wgt1_3;
            wgt1_3 <= wgt1_2;
            wgt1_2 <= wgt1;
            wgt2_4 <= wgt2_3;
            wgt2_3 <= wgt2_2;
            wgt2_2 <= wgt2;
            wgt3_4 <= wgt3_3;
            wgt3_3 <= wgt3_2;
            wgt3_2 <= wgt3;
            wgt4_4 <= wgt4_3;
            wgt4_3 <= wgt4_2;
            wgt4_2 <= wgt4;
        end
    end


    PE_row PE_row1(.clk(clk), .rst(rst), .exp_bias(exp_bias), 
        .img1(img1), .img2(img2), .img3(img3), .img4(img4), 
        .wgt1(wgt1), .wgt2(wgt2), .wgt3(wgt3), .wgt4(wgt4), 
        .psum(psum1), 
        .out(out1));

    PE_row PE_row2(.clk(clk), .rst(rst), .exp_bias(exp_bias), 
        .img1(img1), .img2(img2), .img3(img3), .img4(img4), 
        .wgt1(wgt1_2), .wgt2(wgt2_2), .wgt3(wgt3_2), .wgt4(wgt4_2), 
        .psum(psum2), 
        .out(out2));

    PE_row PE_row3(.clk(clk), .rst(rst), .exp_bias(exp_bias), 
        .img1(img1), .img2(img2), .img3(img3), .img4(img4), 
        .wgt1(wgt1_3), .wgt2(wgt2_3), .wgt3(wgt3_3), .wgt4(wgt4_3), 
        .psum(psum3), 
        .out(out3));

    PE_row PE_row4(.clk(clk), .rst(rst), .exp_bias(exp_bias), 
        .img1(img1), .img2(img2), .img3(img3), .img4(img4), 
        .wgt1(wgt1_4), .wgt2(wgt2_4), .wgt3(wgt3_4), .wgt4(wgt4_4), 
        .psum(psum4), 
        .out(out4));

endmodule