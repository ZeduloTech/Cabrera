`default_nettype none

module tenbaset_phy_top(
    input  wire          phy_rst_i,
    input  wire          phy_clk_i,         // 80 MHz

    output wire          mii_rx_clk_o,
    output wire          mii_tx_clk_o,
    output wire    [3:0] mii_rx_dat_o,
    output wire          mii_rx_dv_o,
    input  reg     [3:0] mii_tx_dat_i,
    input  reg           mii_tx_ena_i,

    input wire           phy_cmos_rxp_i,
    input wire           phy_cmos_rxn_i,

    output wire          phy_txp_o,
    output wire          phy_txn_o
);

    wire [3:0]  tx_dac_n;
    wire [3:0]  tx_dac_p;
    wire        phy_clk;

    wire        rx_dat;
    wire        rx_active;

    (* keep, dont_touch *) gf180mcu_fd_sc_mcu7t5v0__clkbuf_8 phy_clk_buf (
        .I(phy_clk_i),
        .Z(phy_clk)
    );

    // TX digital part
    tenbaset_tx tx (
        .clk_i(phy_clk), 
        .rst_i(phy_rst_i), 
        .mii_tx_ena_i(mii_tx_ena_i), 
        .mii_tx_dat_i(mii_tx_dat_i), 
        .mii_tx_clk_o(mii_tx_clk_o), 
        .tx_dac_n_o(tx_dac_n), 
        .tx_dac_p_o(tx_dac_p)
    );

    // TX analog part
    (* keep *) tenbaset_tx_driver tenbaset_tx_driver (
        .D0P(tx_dac_p[0]),
        .D1P(tx_dac_p[1]),
        .D2P(tx_dac_p[2]),
        .D0N(tx_dac_n[0]),
        .D1N(tx_dac_n[1]),
        .D2N(tx_dac_n[2]),

        .TXP_PADOUT(phy_txp_o),
        .TXN_PADOUT(phy_txn_o)
    );

    // RX digital part
    assign rx_dat = phy_cmos_rxp_i;
    assign rx_active = (phy_cmos_rxp_i !== phy_cmos_rxn_i);
    tenbaset_rx rx (
        .clk_i(phy_clk), 
        .rst_i(phy_rst_i), 
        .mii_rx_ena_o(mii_rx_dv_o), 
        .mii_rx_dat_o(mii_rx_dat_o), 
        .mii_rx_clk_o(mii_rx_clk_o), 
        .rx_dat_i(rx_dat), 
        .rx_active_i(rx_active)
    );

endmodule