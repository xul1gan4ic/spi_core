module button_handler (
    input clk,
    input button_0, button_1,
    input s_rst, a_rst,
    output logic next_count, start_send
);

logic button_res_0, button_res_1;

always_ff @ (posedge clk or posedge a_rst)
begin
    if (a_rst || s_rst)
    begin
        button_res_0 <= '0;
        button_res_1 <= '0;
    end
    else
    begin
        button_res_0 <= button_0;
        button_res_1 <= button_1;
    end
end

always_ff @ (posedge clk or posedge a_rst)
begin
    if (a_rst | s_rst)
    begin
        next_count <= '0;
        start_send <= '0;
    end
    else if (~button_0 & button_res_0)
        next_count <= '1;
    else if (~button_1 & button_res_1) 
        start_send <= '1;
    else
    begin
        next_count <= '0;
        start_send <= '0;
    end
end
    
endmodule
