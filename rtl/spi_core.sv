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

logic sync_btn_0, sync_btn_1;
logic btn_0_ne, btn_0_pe;
logic btn_1_ne, btn_1,pe;
logic ready, valid;
logic [p_data_width - 1:0] data;

sync # (
    .p_sync_stages(2)
) sync_button_0 (
    .clk(clk_100),
    .d(button_0),
    .d_o(sync_btn_0),
    .d_o_ne(btn_0_ne),
    .d_o_pe(btn_0_pe)
);

sync # (
    .p_sync_stages(2)
) sync_button_1 (
    .clk(clk_100),
    .d(button_1),
    .d_o(sync_btn_1),
    .d_o_ne(btn_1_ne),
    .d_o_pe(btn_1_pe)
);

data_former #(
    .p_data_width(p_data_width)  
) df (
    .clk(clk_100),
    .a_rst(a_rst),
    .s_rst(s_rst),
    .next_count(btn_0_pe),
    .start_send(btn_1_pe),
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
