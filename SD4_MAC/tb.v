module tb;
    reg [19:0] signed_sum;
    reg [5:0] exp_max;
    wire sign;
    wire [10:0] norm_sum;
    wire [6:0] exp_final;

    initial begin
        signed_sum = 20'b01010101010101010101;
        exp_max = 6'b001110;
        #1 exp_max = 6'b001111; 
        $display("sign: ", sign);
        $display("norm_sum: %b", norm_sum);
        $display("exp_final: %b", exp_final);
    end

    normalization n(.signed_sum(signed_sum), 
                    .exp_max(exp_max), 
                    .sign(sign), 
                    .norm_sum(norm_sum), 
                    .exp_final(exp_final));
endmodule