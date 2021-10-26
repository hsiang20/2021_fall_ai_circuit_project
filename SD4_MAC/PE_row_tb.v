module PE_row_tb;
    reg clk;
    reg rst;

    reg [4:0] exp_bias;
    reg [23:0] img1, img2, img3, img4;
    reg [35:0] wgt1, wgt2, wgt3, wgt4;
    reg [15:0] psum;

    wire [15:0] out;

    initial begin
        clk = 0;
        rst = 1;
        img1 = 24'b0;
        img2 = 24'b0;
        img3 = 24'b0;
        img4 = 24'b0;
        wgt1 = 36'b0;
        wgt2 = 36'b0;
        wgt3 = 36'b0;
        wgt4 = 36'b0;
        exp_bias = 5'b0;
        psum = 16'b0;
        #1
        rst = 0;
        #1
        rst = 1;
        
        #10
        img1 = 24'b1111;
        img2 = 24'b1111;
        img3 = 24'b1111;
        img4 = 24'b1111;
        wgt1 = 36'b111;
        wgt2 = 36'b111;
        wgt3 = 36'b111;
        wgt4 = 36'b111;
        exp_bias = 5'b11110;
        psum = 16'b0000000000001111;
        $display("out: %b", out);
        
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
        $display("out: %b", out);
        #5

        $display("out: %b", out);
        #100 $finish;
        
        $display("out: %b", out);
    end

    
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, PE_row_tb);
    end

    always #1 begin
        clk = ~clk;
    end

    PE_row PE_row(.clk(clk), .rst(rst), .exp_bias(exp_bias), 
        .img1(img1), .img2(img2), .img3(img3), .img4(img4), 
        .wgt1(wgt1), .wgt2(wgt2), .wgt3(wgt3), .wgt4(wgt4), 
        .psum(psum), 
        .out(out));


    
endmodule