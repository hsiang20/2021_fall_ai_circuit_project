`include "PE.v"
`include "PE_reg.v"
module PE_row (input clk, rst, en, 
               input [4:0] exp_bias, 
               input [23:0] img1, img2, img3, img4, 
               input [35:0] wgt1, wgt2, wgt3, wgt4, 
               input [15:0] psum, 
               output [15:0] out);

    wire [4:0] exp_bias_out;
    wire [23:0] img1_out, img2_out, img3_out, img4_out;
    wire [35:0] wgt1_out, wgt2_out, wgt3_out, wgt4_out;
    wire [15:0] psum2_in, psum3_in, psum4_in;
    wire [15:0] psum1_out, psum2_out, psum3_out, psum4_out;

    PE_reg PE_reg1(.clk(clk), .rst(rst),
        .exp_bias_in(exp_bias), .image_in(img1), .weight_in(wgt1), .psum_in(psum), 
        .exp_bias_out(exp_bias_out), .image_out(img1_out), .weight_out(wgt1_out), .psum_out(psum1_out));
    PE PE1(.clk(clk), .rst(rst), .en(en), 
        .exp_bias(exp_bias_out), .image_in(img1_out), .weight(wgt1_out), .psum(psum1_out), 
        .psum_out(psum2_in));

    PE_reg PE_reg2(.clk(clk), .rst(rst),
        .exp_bias_in(exp_bias), .image_in(img2), .weight_in(wgt2), .psum_in(psum2_in), 
        .exp_bias_out(exp_bias_out), .image_out(img2_out), .weight_out(wgt2_out), .psum_out(psum2_out));
    PE PE2(.clk(clk), .rst(rst), .en(en), 
        .exp_bias(exp_bias_out), .image_in(img2_out), .weight(wgt2_out), .psum(psum2_out), 
        .psum_out(psum3_in));
    
    PE_reg PE_reg3(.clk(clk), .rst(rst), 
        .exp_bias_in(exp_bias), .image_in(img3), .weight_in(wgt3), .psum_in(psum3_in), 
        .exp_bias_out(exp_bias_out), .image_out(img3_out), .weight_out(wgt3_out), .psum_out(psum3_out));
    PE PE3(.clk(clk), .rst(rst), .en(en),  
        .exp_bias(exp_bias_out), .image_in(img3_out), .weight(wgt3_out), .psum(psum3_out), 
        .psum_out(psum4_in));
    
    PE_reg PE_reg4(.clk(clk), .rst(rst), 
        .exp_bias_in(exp_bias), .image_in(img4), .weight_in(wgt4), .psum_in(psum4_in), 
        .exp_bias_out(exp_bias_out), .image_out(img4_out), .weight_out(wgt4_out), .psum_out(psum4_out));
    PE PE4(.clk(clk), .rst(rst), .en(en),  
        .exp_bias(exp_bias_out), .image_in(img4_out), .weight(wgt4_out), .psum(psum4_out), 
        .psum_out(out));
endmodule