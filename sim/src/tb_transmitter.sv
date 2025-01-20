`timescale 1ns/1ps
module tb_transmitter;
parameter p_data_width = 8;

logic clk;
logic a_rst, s_rst;
logic valid;
logic [p_data_width - 1:0] data;
logic sck_hp;
logic sck_lp;
logic sck_hn;
logic sck_ln;
logic ready;
logic cs_n;
logic mosi;

transmitter tb (
    .clk(clk),
    .a_rst(a_rst),
    .s_rst(s_rst),
    .valid(valid),
    .data(data),
    .sck_hp(sck_hp),
    .sck_hn(sck_hn),
    .sck_lp(sck_lp),
    .sck_ln(sck_ln),
    .ready(ready),
    .cs_n(cs_n),
    .mosi(mosi)
);

initial
begin
    clk   = '0;
    a_rst = '0;
    s_rst = '0;
    valid = '0;
    data  = '0;
end

initial forever #10 clk = ~clk;

initial 
begin
    #50 a_rst = '1;
    #40 a_rst = '0;
end

initial 
begin
    #120 data  = 8'h14;
    # 50 valid = '1;
    # 30 valid = '0;

    #600 data  = 8'h03;
    #150 valid = '1;
    # 30 valid = '0;

    #100 valid = '1;
    # 40 data  = 8'h57;
    # 30 valid = '0;

    #100 data  = 8'h45;
    # 50 valid = '1;
    # 40 valid = '0; 
end

initial 
begin
    #1000 s_rst = '1;
    # 30 s_rst = '0;
end

endmodule
