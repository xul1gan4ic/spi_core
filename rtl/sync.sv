module sync (clk, d, d_o, d_o_pe, d_o_ne);
parameter p_sync_stages = 2;

input clk;
input d;
output d_o;
output d_o_pe;
output d_o_ne;

logic [p_sync_stages - 1:0] sync_reg;

always_ff @(posedge clk) begin
    sync_reg <= {sync_reg[p_sync_stages - 2:0], d};
end

assign d_o = sync_reg[p_sync_stages - 1];

assign d_o_pe = (sync_reg[p_sync_stages - 2] == 0) && (sync_reg[p_sync_stages - 1] == 1);
assign d_o_ne = (sync_reg[p_sync_stages - 2] == 1) && (sync_reg[p_sync_stages - 1] == 0);

endmodule