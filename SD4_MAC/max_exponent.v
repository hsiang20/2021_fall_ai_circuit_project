module max_exponent (input [4:0] exp_0, exp_1, exp_2, exp_3, exp_4, exp_5, exp_6, exp_7, exp_8,
                     output [4:0] exp_max);
    
    wire [4:0] exp012, exp345, exp678;
    
    
    assign exp012  = (exp_0 > exp_1 && exp_0 > exp_2 ) ? exp_0 :
                     (exp_1 > exp_2)                   ? exp_1 : exp_2;
    assign exp345  = (exp_3 > exp_4 && exp_3 > exp_5 ) ? exp_3 :
                     (exp_4 > exp_5)                   ? exp_4 : exp_5;
    assign exp678  = (exp_6 > exp_7 && exp_6 > exp_8 ) ? exp_6 :
                     (exp_7 > exp_8)                   ? exp_7 : exp_8;
    assign exp_max = (exp012 > exp345 && exp012 > exp678 ) ? exp012 :
                     (exp345 > exp678)                     ? exp345 : exp678;
    
    
endmodule


