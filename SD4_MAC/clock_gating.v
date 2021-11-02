module clock_gating (
    input clk, 
    input [35:0] i_weight, 
    input en, 
    output reg [35:0] o_weight);
    
    reg dff_clk;
    wire en_w;
    reg en_r;
    wire [35:0] i_weight_w;

    assign i_weight_w = i_weight;
    assign en_w = en;

    always @(en or clk) begin
        dff_clk = en_r & clk;
    end

    always @(posedge dff_clk) begin
        o_weight <= i_weight_w;
    end

    always @(negedge clk) begin
        en_r <= en_w;
    end

endmodule