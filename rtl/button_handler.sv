module button_handler (
    input clk,
    input button_0, button_1,
    input s_rst, a_rst,
    output logic next_count, start_send
);

logic sync_btn_0, sync_btn_1;
logic btn_0_ne, btn_0_pe;
logic btn_1_ne, btn_1,pe;

sync # (
    .p_sync_stages(2)
) sync_button_0 (
    .clk(clk),
    .d(button_0),
    .d_o(sync_btn_0),
    .d_o_ne(btn_0_ne),
    .d_o_pe(btn_0_pe)
);

sync # (
    .p_sync_stages(2)
) sync_button_1 (
    .clk(clk),
    .d(button_1),
    .d_o(sync_btn_1),
    .d_o_ne(btn_1_ne),
    .d_o_pe(btn_1_pe)
);

always_ff @ (posedge clk or posedge a_rst)
begin
    if (a_rst || s_rst)
    begin
        next_count <= '0;
        start_send <= '0;
    end
    else if (btn_0_pe)
        next_count <= '1;
    else if (btn_1_pe) 
        start_send <= '1;
    else
    begin
        next_count <= '0;
        start_send <= '0;
    end
end
    
endmodule
