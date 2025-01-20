module data_former(clk, next_count, start_send, a_rst, s_rst, ready, valid, data);
    parameter p_data_width = 8;

    input clk;
    input next_count, start_send;
    input a_rst, s_rst;
    input ready;
    output logic valid;
    output logic [p_data_width - 1:0] data;

logic [p_data_width - 1:0] cnt;
logic [p_data_width - 1:0] data_cnt;

always_ff @ (posedge clk or posedge a_rst)
begin
    if (a_rst || s_rst)
    begin
        cnt      <= '0;
        data_cnt <= '0;
        data     <= '0;
        valid    <= '0;
    end
    else if (next_count)
        cnt <= cnt + 1'b1;
    else if (start_send & ~valid)
    begin
        data_cnt <= cnt;
        valid    <= '1;
        cnt      <= '0;
    end
    else if (ready)
    begin
        valid <= '0;
        data <= data_cnt;
    end
end

endmodule
