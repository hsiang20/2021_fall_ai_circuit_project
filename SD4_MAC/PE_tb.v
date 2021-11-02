module PE_tb;
    reg clk;
    reg rst;
    reg en;

    reg [4:0] exp_bias;
    reg [23:0] image;
    reg [35:0] weight;
    reg [15:0] psum;

    wire [15:0] psum_out;

    initial begin
        en = 0;
        clk = 0;
        rst = 1;
        image = 24'b0;
        weight = 36'b0;
        exp_bias = 5'b0;
        psum = 16'b0;
        #1
        rst = 0;
        #1
        rst = 1;
        #4
        
        image = 24'b000100111101000010011110;
        weight = 36'b100111000011011001101100000101111110;
        exp_bias = 5'b11110;
        psum = 16'b0000000000001111;
        $display("psum_out: %b", psum_out);
        #5

        image = 24'b101011101101101100100010;
        weight = 36'b011110000011000010111000100001100110;
        exp_bias = 5'b00111;
        psum = 16'b0000000000001111;
        $display("psum_out: %b", psum_out);
        #5
        weight = 1;
        #5
        weight = 2;
        en = 1;
        #2
        en = 0;
        #3
        weight = 36'bx;
        #15
        weight = 3;
        en = 1;
        #2
        en = 0;
        #3
        weight = 36'bx;

        $display("psum_out: %b", psum_out);
        #100 $finish;
        $display("psum_out: %b", psum_out);
    end

    
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, PE_tb);
    end

    always #1 begin
        clk = ~clk;
    end

    PE PE1(.clk(clk), .rst(rst), .en(en), 
        .exp_bias(exp_bias), .image_in(image), .weight(weight), .psum(psum), 
        .psum_out(psum_out));

    
endmodule