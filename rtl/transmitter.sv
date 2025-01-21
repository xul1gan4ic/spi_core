module transmitter(clk, ready, valid, a_rst, s_rst, data, sck_hp, sck_lp, sck_hn, sck_ln, cs_n, mosi);
parameter p_data_width = 8;
parameter p_clk_div    = 4;  
parameter p_cs_polar   = 1;

input clk;
input valid; 
input a_rst, s_rst;
input logic [p_data_width - 1:0] data;

output logic sck_hp;
output logic sck_lp;
output logic sck_hn;
output logic sck_ln;

output logic ready;
output logic cs_n;
output logic mosi;

logic [p_data_width - 1:0] data_r;
logic [$clog2(p_data_width):0] cnt;
logic [$clog2(p_clk_div):0] clk_div_cnt;
logic clk_div;
logic busy;
logic cs_n_r;
logic clk_div_2;
logic start;

assign cs_n_r = (cs_n == p_cs_polar);

always_ff @ (posedge clk)
begin
    if (~cs_n_r)
    begin
        clk_div_cnt <= clk_div_cnt + 1'b1;
    end
    else
    begin
        clk_div_cnt <= '0;
    end
end

assign clk_div = &clk_div_cnt[$clog2(p_clk_div) - 1:0];
assign clk_div_2 = &clk_div_cnt;

always_ff @ (posedge clk)
begin
    if (clk_div && ~cs_n_r)
    begin
        sck_hp <= ~sck_hp;
        sck_ln <= ~sck_ln;
        sck_hn <= sck_hp;
        sck_lp <= sck_ln;
    end
    else if (cs_n_r)
    begin
        sck_hp <= '1;
        sck_lp <= '0;
        sck_hn <= '1;
        sck_ln <= '0;
    end
end

assign start = ready & valid;

always_ff @ (posedge clk or posedge a_rst)
begin
    if (a_rst || s_rst)
    begin
        ready         <= '1;
        cs_n          <= p_cs_polar;
        mosi          <= '0;
        data_r        <= '0;
        cnt           <= '0;
        clk_div_cnt   <= '0;
        busy          <= '0;
    end
    else if (start)
    begin
        cs_n   <= ~p_cs_polar;
        busy   <= '1;
    end
    else if (~cs_n_r && clk_div_2)
    begin
        cnt    <= cnt + 1'b1;
        mosi    <= data_r [p_data_width - 1];
        data_r  <= {data_r[p_data_width - 2:0], 1'b0};
        if (cnt == p_data_width)
        begin
            cnt   <= '0;
            cs_n  <= p_cs_polar;
            mosi  <= '0;
            ready <= '1;
            busy  <= '0;
        end
    end
end

always_ff @ (posedge clk or posedge a_rst)
begin
    if (a_rst || s_rst)
    begin
        data_r  <= '0;
    end
    else if (busy && ready)
    begin
        data_r  <= data;
        ready   <= '0;
    end
end

endmodule
