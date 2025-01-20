module spi_core(clk_100, button_0, button_1, a_rst, s_rst, sck, cs_n, mosi);
    parameter p_data_width = 8;

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

data_former df (
    .clk(clk_100),
    .a_rst(a_rst),
    .s_rst(s_rst),
    .next_count(next_count),
    .start_send(start_send),
    .ready(ready),
    .valid(valid),
    .data(data)
);

transmitter trs (
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
