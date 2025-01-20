`timescale 1ns/1ps
module tb_button_handler;

logic clk;
logic button_0, button_1;
logic a_rst, s_rst;
logic next_count, start_send;

button_handler tb (
    .clk(clk),
    .button_0(button_0),
    .button_1(button_1),
    .a_rst(a_rst),
    .s_rst(s_rst),
    .next_count(next_count),
    .start_send(start_send)
);

initial begin
    clk = 0;
    button_0 = 0;
    button_1 = 0;
    a_rst = 0;
    s_rst = 0;
end

// Генерация тактового сигнала
initial forever #10 clk = ~clk;

// Сбросы
initial begin
    #60 a_rst = 1;   // Глобальный сброс
    #100 a_rst = 0;
    #310 s_rst = 1;  // Локальный сброс
    #320 s_rst = 0;
end

// Симуляция кнопки 0
initial begin
    #120 button_0 = 1;
    #170 button_0 = 0;

    #200 button_0 = 1;
    #250 button_0 = 0;

    #300 button_0 = 1;
    #350 button_0 = 0;
end

// Симуляция кнопки 1
initial begin
    #400 button_1 = 1;
    #450 button_1 = 0;
end

endmodule
