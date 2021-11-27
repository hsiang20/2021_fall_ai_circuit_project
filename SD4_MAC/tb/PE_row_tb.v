module PE_row_tb;
    reg clk;
    reg rst;
    reg en;

    reg [4:0] exp_bias;
    reg [23:0] img1, img2, img3, img4;
    reg [35:0] wgt1, wgt2, wgt3, wgt4;
    reg [15:0] psum;

    wire [15:0] out;

    initial begin
        clk = 0;
        rst = 1;
        img1 = 24'hf;
        img2 = 24'hf;
        img3 = 24'hf;
        img4 = 24'hf;
        wgt1 = 36'h1;
        wgt2 = 36'h1;
        wgt3 = 36'h1;
        wgt4 = 36'h1;
        exp_bias = 5'b0;
        psum = 16'b0;
        #1
        rst = 0;
        #1
        rst = 1;
        #1
        en = 1;
        #2
        en = 0;
        wgt1 = 36'bx;
        wgt2 = 36'bx;
        wgt3 = 36'bx;
        wgt4 = 36'bx;
        #10
        img1 = 24'b111;
        img2 = 24'b111;
        img3 = 24'b111;
        img4 = 24'b111;
        exp_bias = 5'b11110;
        psum = 16'b0000000000001111;
        #10
        img1 = 24'b11111111;
        img2 = 24'b11111111;
        img3 = 24'b11111111;
        img4 = 24'b11111111;
        wgt1 = 36'b1111111;
        wgt2 = 36'b1111111;
        wgt3 = 36'b1111111;
        wgt4 = 36'b1111111;
        exp_bias = 5'b00111;
        psum = 16'b0000000000001111;
        en = 1;
        #2
        en = 0;
        wgt1 = 36'bx;
        wgt2 = 36'bx;
        wgt3 = 36'bx;
        wgt4 = 36'bx;

        #100 $finish;
        
    end

    
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, PE_row_tb);
    end

    always #1 begin
        clk = ~clk;
    end

    PE_row PE_row(.clk(clk), .rst(rst), .en(en), 
        .exp_bias(exp_bias), 
        .img1(img1), .img2(img2), .img3(img3), .img4(img4), 
        .wgt1(wgt1), .wgt2(wgt2), .wgt3(wgt3), .wgt4(wgt4), 
        .psum(psum), 
        .out(out));


    
endmodule