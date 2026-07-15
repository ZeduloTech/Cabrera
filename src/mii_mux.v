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

    output wire          mii_rx_clk_pad_oe,
    output wire          mii_tx_clk_pad_oe,
    output wire          mii_rx_dat_pad_oe,
    output wire           mii_rx_dv_pad_oe,
    output wire          mii_tx_dat_pad_oe,
    output wire          mii_tx_ena_pad_oe,  
    output wire           phy_reset_pad_oe,

    input wire     [1:0] select
);

localparam SEL_PHYMAC = 2'b00;
localparam SEL_PADPHY = 2'b01;
localparam SEL_PADMAC = 2'b10;

assign mii_rx_clk_mac = (select == SEL_PHYMAC) ? mii_rx_clk_phy : mii_rx_clk_padi;
assign mii_tx_clk_mac = (select == SEL_PHYMAC) ? mii_tx_clk_phy : mii_tx_clk_padi;
assign mii_rx_dat_mac = (select == SEL_PHYMAC) ? mii_rx_dat_phy : mii_rx_dat_padi;
assign  mii_rx_dv_mac = (select == SEL_PHYMAC) ?  mii_rx_dv_phy : ((select == SEL_PADPHY) ? mii_rx_dv_padi : 1'b0);

assign mii_tx_dat_phy = (select == SEL_PHYMAC) ? mii_tx_dat_mac : mii_tx_dat_padi;
assign mii_tx_ena_phy = (select == SEL_PHYMAC) ? mii_tx_ena_mac : ((select == SEL_PADPHY) ? mii_tx_ena_padi : 1'b0);
assign phy_reset_phy  = (select == SEL_PHYMAC) ?  phy_reset_mac :  phy_reset_padi;


assign mii_rx_clk_pado = mii_rx_clk_phy;
assign mii_tx_clk_pado = mii_tx_clk_phy;
assign mii_rx_dat_pado = mii_rx_dat_phy;
assign  mii_rx_dv_pado = (select == SEL_PADPHY) ?  mii_rx_dv_phy : 1'b0;
assign  phy_reset_pado = (select == SEL_PADPHY) ?  phy_reset_mac : 1'b0;

assign mii_tx_dat_pado = mii_tx_dat_mac;
assign mii_tx_ena_pado = (select == SEL_PADMAC) ? mii_tx_ena_mac : 1'b0;

assign mii_rx_clk_pad_oe = (select == SEL_PADPHY);
assign mii_tx_clk_pad_oe = (select == SEL_PADPHY);
assign mii_rx_dat_pad_oe = (select == SEL_PADPHY);
assign mii_rx_dv_pad_oe  = (select == SEL_PADPHY);
assign mii_tx_dat_pad_oe = (select == SEL_PADMAC);
assign mii_tx_ena_pad_oe = (select == SEL_PADMAC);
assign phy_reset_pad_oe  = (select == SEL_PADMAC);

endmodule