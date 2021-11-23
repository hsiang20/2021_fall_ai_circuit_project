module max_exponent (input [4:0] exp_0, exp_1, exp_2, exp_3, exp_4, exp_5, exp_6, exp_7, exp_8,
                     output reg [4:0] exp_max);
    
    reg [4:0] exp01, exp23, exp45, exp67, exp0123, exp4567, exp01234567;
    
    always @(*) begin
        exp01 = (exp_0 > exp_1) ? exp_0 : exp_1;
        exp23 = (exp_2 > exp_3) ? exp_2 : exp_3;
        exp45 = (exp_4 > exp_5) ? exp_4 : exp_5;
        exp67 = (exp_6 > exp_7) ? exp_6 : exp_7;
        exp0123 = (exp01 > exp23) ? exp01 : exp23;
        exp4567 = (exp45 > exp67) ? exp45 : exp67;
        exp01234567 = (exp0123 > exp4567) ? exp0123 : exp4567;
        exp_max = (exp01234567 > exp_8) ? exp01234567 : exp_8;
    end
    
endmodule