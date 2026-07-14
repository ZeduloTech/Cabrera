`default_nettype none

// Selects one of the 3 states: PHY<->MAC (0), PADS<->PHY(1), PADS<->MAC(2)
module mii_mux(
    output wire          mii_rx_clk_mac,
    output wire          mii_tx_clk_mac,
    output wire    [3:0] mii_rx_dat_mac,
    output wire          mii_rx_dv_mac,
    input  wire    [3:0] mii_tx_dat_mac,
    input  wire          mii_tx_ena_mac,    
    input  wire          phy_reset_mac,    
    
    input  wire          mii_rx_clk_phy,
    input  wire          mii_tx_clk_phy,
    input  wire    [3:0] mii_rx_dat_phy,
    input  wire          mii_rx_dv_phy,
    output wire    [3:0] mii_tx_dat_phy,
    output wire          mii_tx_ena_phy,  
    output wire          phy_reset_phy,  

    output wire          mii_rx_clk_pado,
    output wire          mii_tx_clk_pado,
    output wire    [3:0] mii_rx_dat_pado,
    output wire           mii_rx_dv_pado,
    input  wire    [3:0] mii_tx_dat_padi,
    input  wire          mii_tx_ena_padi,    
    input  wire           phy_reset_padi,   
    
    input  wire          mii_rx_clk_padi,
    input  wire          mii_tx_clk_padi,
    input  wire    [3:0] mii_rx_dat_padi,
    input  wire           mii_rx_dv_padi,
    output wire    [3:0] mii_tx_dat_pado,
    output wire          mii_tx_ena_pado,  
    output wire           phy_reset_pado,

    input wire     [1:0] select
);

assign mii_rx_clk_mac = (select == 2'b00) ? mii_rx_clk_phy : mii_rx_clk_padi;
assign mii_tx_clk_mac = (select == 2'b00) ? mii_tx_clk_phy : mii_tx_clk_padi;
assign mii_rx_dat_mac = (select == 2'b00) ? mii_rx_dat_phy : mii_rx_dat_padi;
assign  mii_rx_dv_mac = (select == 2'b00) ?  mii_rx_dv_phy : ((select == 2'b10) ? mii_rx_dv_padi : 1'b0);

assign mii_tx_dat_phy = (select == 2'b00) ? mii_tx_dat_mac : mii_tx_dat_padi;
assign mii_tx_ena_phy = (select == 2'b00) ? mii_tx_ena_mac : ((select == 2'b01) ? mii_tx_ena_padi : 1'b0);
assign phy_reset_phy  = (select == 2'b00) ?  phy_reset_mac :  phy_reset_padi;


assign mii_rx_clk_pado = mii_rx_clk_phy;
assign mii_tx_clk_pado = mii_tx_clk_phy;
assign mii_rx_dat_pado = mii_rx_dat_phy;
assign  mii_rx_dv_pado = (select == 2'b01) ?  mii_rx_dv_phy : 1'b0;

assign mii_tx_dat_pado = mii_tx_dat_mac;
assign mii_tx_ena_pado = (select == 2'b10) ? mii_tx_ena_mac : 1'b0;

endmodule