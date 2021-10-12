module adder_tree (input [15:0] aligned_pp_0,
                   input [15:0] aligned_pp_1,
                   input [15:0] aligned_pp_2, 
                   input [15:0] aligned_pp_3, 
                   input [15:0] aligned_pp_4, 
                   input [15:0] aligned_pp_5, 
                   input [15:0] aligned_pp_6, 
                   input [15:0] aligned_pp_7, 
                   input [15:0] aligned_pp_8,
                   output reg [19:0] signed_sum); 

    reg [16:0] sum01, sum23, sum45, sum67;
    reg [17:0] sum0123, sum4567;
    reg [18:0] sum01234567;
    
    always @ (*) begin
        sum01 <= aligned_pp_0 + aligned_pp_1;
        sum23 <= aligned_pp_2 + aligned_pp_3;
        sum45 <= aligned_pp_4 + aligned_pp_5;
        sum67 <= aligned_pp_6 + aligned_pp_7;
        sum0123 <= sum01 + sum23;
        sum4567 <= sum45 + sum67;
        sum01234567 <= sum0123 + sum4567;
        signed_sum <= sum01234567 + aligned_pp_8;
    end
    
endmodule