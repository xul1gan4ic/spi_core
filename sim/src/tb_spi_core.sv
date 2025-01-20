`timescale 1ns/1ps
module tb_spi_core;
parameter p_data_width = 8;

logic clk_100;
logic a_rst, s_rst;
logic button_0, button_1;
logic sck;
logic cs_n;
logic mosi;

spi_core tb (
    .clk_100(clk_100),
    .a_rst(a_rst),
    .s_rst(s_rst),
    .button_0(button_0),
    .button_1(button_1),
    .sck(sck),
    .cs_n(cs_n),
    .mosi(mosi)
);

initial
begin
    clk_100  = 0;
    a_rst    = 0;
    s_rst    = 0;
    button_0 = 0;
    button_1 = 0;
end

initial forever #10 clk_100 = ~clk_100;

initial
begin
    #50 a_rst = '1;
    #25 a_rst = '0;
end

initial
begin
    #100 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_1 = '1;
    # 40 button_1 = '0;

    #600 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_1 = '1;
    # 40 button_1 = '0;

    # 40 button_0 = '1;
    # 40 button_0 = '0;

    # 40 button_1 = '1;
    # 40 button_1 = '0;
end

initial
begin
    #30000 s_rst = '1;
    # 30   s_rst = '0;
end

endmodule
