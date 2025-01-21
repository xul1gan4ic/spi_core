module spi_core(clk_100, button_0, button_1, a_rst, s_rst, sck, cs_n, mosi);
    parameter p_data_width = 8;
    parameter p_clk_div    = 4;  
    parameter p_cs_polar   = 1;

    input clk_100;
    input button_0, button_1;
    input a_rst, s_rst;
    output logic sck;
    output logic cs_n;
    output logic mosi;

logic next_count, start_send;
logic ready, valid;
logic [p_data_width - 1:0] data;

button_handler bh (
    .clk(clk_100),
    .a_rst(a_rst),
    .s_rst(s_rst),
    .button_0(button_0),
    .button_1(button_1),
    .next_count(next_count),
    .start_send(start_send)
);

data_former #(
    .p_data_width(p_data_width)  
) df (
    .clk(clk_100),
    .a_rst(a_rst),
    .s_rst(s_rst),
    .next_count(next_count),
    .start_send(start_send),
    .ready(ready),
    .valid(valid),
    .data(data)
);

transmitter # (
    .p_data_width(p_data_width),
    .p_clk_div(p_clk_div),
    .p_cs_polar(p_cs_polar)
) trs (
    .clk(clk_100),
    .a_rst(a_rst),
    .s_rst(s_rst),
    .valid(valid),
    .data(data),
    .ready(ready),
    .cs_n(cs_n),
    .mosi(mosi),
    .sck_hp(sck),
    .sck_lp(),
    .sck_hn(),
    .sck_ln()
);

endmodule
