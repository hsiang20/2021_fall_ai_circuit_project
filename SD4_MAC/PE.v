`include "MAC.v"
`include "img_buff.v"
`include "clock_gating.v"
module PE (input clk, rst, en, 
           input [4:0] exp_bias, 
           input [23:0] image_in, 
           input [35:0] weight, 
           input [15:0] psum, 
           output [15:0] psum_out);

    wire [71:0] image;
    wire [15:0] mac_out_w;
    reg [15:0] mac_out_r;
    wire [35:0] o_weight;
    reg [4:0] psum_out_exp;
    reg psum_out_sign;
    reg [9:0] psum_out_mantissa;
    reg signed [11:0] mantissa_1, mantissa_2, mantissa_temp;

    assign psum_out = {psum_out_sign, psum_out_exp, psum_out_mantissa};
    always @ (mac_out_r or psum) begin
        // fp16 adder
        // floating point regulation: sign(1)/exp(5)/mantissa(10)
        if (mac_out_r[14:10] > psum[14:10]) begin
            psum_out_exp = mac_out_r[14:10];
            if (mac_out_r[15]) mantissa_1 = ~{2'b0, mac_out_r[9:0]} + 1;
            else mantissa_1 = {2'b0, mac_out_r[9:0]};
            if (psum[15]) mantissa_2 = ~({2'b0, psum[9:0]} >> (mac_out_r[14:10] - psum[14:10])) + 1;
            else mantissa_2 = {2'b0, psum[9:0]} >> (mac_out_r[14:10] - psum[14:10]);
        end
        else begin
            psum_out_exp = psum[14:10];
            if (psum[15]) mantissa_1 = ~{2'b00, psum[9:0]} + 1;
            else mantissa_1 = {2'b0, psum[9:0]};
            if (mac_out_r[15]) mantissa_2 = ~({2'b00, mac_out_r[9:0]} >> (psum[14:10] - mac_out_r[14:10])) + 1;
            else mantissa_2 = {2'b0, mac_out_r[9:0]} >> (psum[14:10] - mac_out_r[14:10]);
        end

        mantissa_temp = mantissa_1 + mantissa_2;
        psum_out_sign = mantissa_temp[11];
        if (mantissa_temp[11]) begin
            mantissa_temp = ~(mantissa_temp - 1);
        end
        if (mantissa_temp[10]) begin
            psum_out_exp += 1;
            psum_out_mantissa = mantissa_temp[10:1];
        end
        else if (mantissa_temp[9]) begin
            psum_out_mantissa = mantissa_temp[9:0];
        end
        else if (mantissa_temp[8]) begin
            psum_out_exp -= 1;
            psum_out_mantissa = {mantissa_temp[8:0], 1'b0};
        end
        else if (mantissa_temp[7]) begin
            psum_out_exp -= 2;
            psum_out_mantissa = {mantissa_temp[7:0], 2'b0};
        end
        else if (mantissa_temp[6]) begin
            psum_out_exp -= 3;
            psum_out_mantissa = {mantissa_temp[6:0], 3'b0};
        end
        else if (mantissa_temp[5]) begin
            psum_out_exp -= 4;
            psum_out_mantissa = {mantissa_temp[5:0], 4'b0};
        end
        else if (mantissa_temp[4]) begin
            psum_out_exp -= 5;
            psum_out_mantissa = {mantissa_temp[4:0], 5'b0};
        end
        else if (mantissa_temp[3]) begin
            psum_out_exp -= 6;
            psum_out_mantissa = {mantissa_temp[3:0], 6'b0};
        end
        else if (mantissa_temp[2]) begin
            psum_out_exp -= 7;
            psum_out_mantissa = {mantissa_temp[2:0], 7'b0};
        end
        else if (mantissa_temp[1]) begin
            psum_out_exp -= 8;
            psum_out_mantissa = {mantissa_temp[1:0], 8'b0};
        end
        else if (mantissa_temp[0]) begin
            psum_out_exp -= 9;
            psum_out_mantissa = {mantissa_temp[0], 9'b0};
        end
        else begin
            psum_out_exp -= 10;
            psum_out_mantissa = 0;
        end
    end
    
    // mac output reg
    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            mac_out_r <= 0;
        end
        else begin
            mac_out_r <= mac_out_w;
        end
    end

    MAC mac(.clk(clk), .rst(rsk), .image(image), .weight(o_weight), .exp_bias(exp_bias), .out(mac_out_w));

    img_buff img_buff(.clk(clk), .rst(rst), .image_in(image_in), .image_out(image));

    clock_gating clock_gating(.clk(clk), .i_weight(weight), .en(en), .o_weight(o_weight));

endmodule