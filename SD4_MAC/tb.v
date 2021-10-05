module tb;
    reg [6:0] exp_final;
    reg sign;
    reg [10:0] norm_sum;
    wire [15:0] out;

    initial begin
        exp_final = 7'b1111101;
        sign = 0;
        norm_sum = 11'b01010101010;
        #1 exp_final = 7'b0011110; 
        $display("out: %b", out);
        // $display("norm_sum: %b", norm_sum);
        // $display("exp_final: %b", exp_final);
    end

    subnormal_handling s(.exp_final(exp_final), 
                         .sign(sign), 
                         .norm_sum(norm_sum), 
                         .out(out));
endmodule