`timescale 1ns/1ps
module tb_data_former;
parameter p_data_width = 8;

logic clk;
logic next_count, start_send;
logic a_rst, s_rst;
logic ready, valid;
logic [p_data_width - 1:0] data;

data_former tb (
    .clk(clk),
    .next_count(next_count),
    .start_send(start_send),
    .a_rst(a_rst),
    .s_rst(s_rst),
    .ready(ready),
    .valid(valid),
    .data(data)
);

initial begin
    clk = 0;
    a_rst = 0;
    s_rst = 0;
    next_count = 0;
    start_send = 0;
    ready = 0;
end

initial forever #10 clk = ~clk;

initial begin
    #50  a_rst <= '1;
    #100 a_rst <= '0;
end

initial begin
    #160 next_count <= '1;
    #40  next_count <= '0;

    #40 next_count <= '1;
    #40 next_count <= '0;

    #40 next_count <= '1;
    #40 next_count <= '0;

    #40 next_count <= '1;
    #40 next_count <= '0;
end

initial begin
    #450 start_send <= '1;
    #40  start_send <= '0;
end

initial begin
    #500 ready <= '1;
    #540 ready <= '0;
end

endmodule