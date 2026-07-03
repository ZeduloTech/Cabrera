// SPDX-FileCopyrightText: © 2025 egorxe
// SPDX-License-Identifier: Apache-2.0

`timescale 1 ns / 1 ps
`default_nettype none
`include "pinout.vh"
`include "defines.v" // from Caravel

module chip_core #(
    parameter NUM_INPUT_PADS,
    parameter NUM_BIDIR_PADS,
    parameter NUM_ANALOG_PADS
    )(
    `ifdef USE_POWER_PINS
    inout  wire VDD,
    inout  wire VSS,
    `endif
    
    input  wire clk,       // clock
    input  wire rst_n,     // reset (active low)
    
    input  wire [NUM_INPUT_PADS-1:0] input_in,   // Input value
    output wire [NUM_INPUT_PADS-1:0] input_pu,   // Pull-up
    output wire [NUM_INPUT_PADS-1:0] input_pd,   // Pull-down

    input  wire [NUM_BIDIR_PADS-1:0] bidir_in,   // Input value
    output wire [NUM_BIDIR_PADS-1:0] bidir_out,  // Output value
    output wire [NUM_BIDIR_PADS-1:0] bidir_oe,   // Output enable
    output wire [NUM_BIDIR_PADS-1:0] bidir_cs,   // Input type (0=CMOS Buffer, 1=Schmitt Trigger)
    output wire [NUM_BIDIR_PADS-1:0] bidir_sl,   // Slew rate (0=fast, 1=slow)
    output wire [NUM_BIDIR_PADS-1:0] bidir_ie,   // Input enable
    output wire [NUM_BIDIR_PADS-1:0] bidir_pu,   // Pull-up
    output wire [NUM_BIDIR_PADS-1:0] bidir_pd,   // Pull-down

    inout  wire [NUM_ANALOG_PADS-1:0] analog  // Analog
);

    // Wishbone from Caravel
    wire user_wb_clk_prebuf;
    wire user_wb_clk;
    
    wire user_wb_rst;
    wire user_wb_cyc;
    wire user_wb_stb;
    wire user_wb_we;
    wire user_wb_ack;
    wire [3:0]  user_wb_sel;
    wire [31:0] user_wb_adr;
    wire [31:0] user_wb_dat_wr;
    wire [31:0] user_wb_dat_rd;
    
    wire user_wb_reg_rst;
    wire user_wb_reg_cyc;
    wire user_wb_reg_stb;
    wire user_wb_reg_we;
    wire user_wb_reg_ack;
    wire [3:0]  user_wb_reg_sel;
    wire [31:0] user_wb_reg_adr;
    wire [31:0] user_wb_reg_dat_wr;
    wire [31:0] user_wb_reg_dat_rd;

    // Additional Caravel signals
    wire npor;
    wire caravel_start_mode;
    
    // Disable pull-up and pull-down for input
    assign input_pu = '0;
    assign input_pd = '1; //0
    
    // set pad config for flash & GPIO
    assign bidir_pu[`PAD_FLASH_IO1:`PAD_GPIO] = 5'b0010;
    assign bidir_pd[`PAD_FLASH_IO1:`PAD_GPIO] = 5'b0000;
    assign bidir_sl[`PAD_FLASH_IO1:`PAD_GPIO] = 5'b0000;
    assign bidir_cs[`PAD_FLASH_IO1:`PAD_GPIO] = 5'b0000;
/*    
    // set all other bidirs
    assign bidir_pu[NUM_BIDIR_PADS-1:`PAD_CARAVEL_END+1] = '0;
    assign bidir_pd[NUM_BIDIR_PADS-1:`PAD_CARAVEL_END+1] = '0;
    assign bidir_sl[NUM_BIDIR_PADS-1:`PAD_CARAVEL_END+1] = '0;
    assign bidir_cs[NUM_BIDIR_PADS-1:`PAD_CARAVEL_END+1] = '0;
    assign bidir_ie[NUM_BIDIR_PADS-1:`PAD_CARAVEL_END+1] = '0;
    assign bidir_oe[NUM_BIDIR_PADS-1:`PAD_CARAVEL_END+1] = '0;
 */   

    // ztimer SPI pad config [CSB, SDI, SCK, SDO]
    assign bidir_pu[`PAD_ZTIMER_SPI_HI:`PAD_ZTIMER_SPI_LO] = 4'b1000; // CSB pull-up
    assign bidir_pd[`PAD_ZTIMER_SPI_HI:`PAD_ZTIMER_SPI_LO] = 4'b0110; // SCK & SDI pull-down
    assign bidir_sl[`PAD_ZTIMER_SPI_HI:`PAD_ZTIMER_SPI_LO] = 4'b0000; // fast slew
    assign bidir_cs[`PAD_ZTIMER_SPI_HI:`PAD_ZTIMER_SPI_LO] = 4'b1110; // Schmitt on 3 inputs
    assign bidir_ie[`PAD_ZTIMER_SPI_HI:`PAD_ZTIMER_SPI_LO] = 4'b1110; // inputs enabled
    assign bidir_oe[`PAD_ZTIMER_SPI_HI:`PAD_ZTIMER_SPI_LO] = 4'b0001; // SDO output enabled


/*
    // set all other bidirs above the ztimer block to default zero
    assign bidir_pu[NUM_BIDIR_PADS-1:`PAD_ZTIMER_END+1] = '0;
    assign bidir_pd[NUM_BIDIR_PADS-1:`PAD_ZTIMER_END+1] = '0;
    assign bidir_sl[NUM_BIDIR_PADS-1:`PAD_ZTIMER_END+1] = '0;
    assign bidir_cs[NUM_BIDIR_PADS-1:`PAD_ZTIMER_END+1] = '0;
    assign bidir_ie[NUM_BIDIR_PADS-1:`PAD_ZTIMER_END+1] = '0;
    assign bidir_oe[NUM_BIDIR_PADS-1:`PAD_ZTIMER_END+1] = '0;
*/
    wire mii_rst_n;
    wire mii_rx_clk;
    wire mii_tx_clk;
    wire [3:0] mii_rx_data;
    wire mii_rx_dv;
    wire [3:0] mii_tx_data;
    wire mii_tx_en;

    assign bidir_out[`PAD_MII_RST]      = mii_rst_n;
    assign bidir_out[`PAD_MII_TX_EN]    = mii_tx_en;
    assign bidir_out[`PAD_MII_TX_DAT0]  = mii_tx_data[0];
    assign bidir_out[`PAD_MII_TX_DAT1]  = mii_tx_data[1];
    assign bidir_out[`PAD_MII_TX_DAT2]  = mii_tx_data[2];
    assign bidir_out[`PAD_MII_TX_DAT3]  = mii_tx_data[3];
    
    assign mii_rx_clk   = bidir_in[`PAD_MII_RX_CLK];
    assign mii_tx_clk   = bidir_in[`PAD_MII_TX_CLK];
    assign mii_rx_dv    = bidir_in[`PAD_MII_RX_DV];
    assign mii_rx_data  = {bidir_in[`PAD_MII_RX_DAT3], bidir_in[`PAD_MII_RX_DAT2], bidir_in[`PAD_MII_RX_DAT1], bidir_in[`PAD_MII_RX_DAT0]};
    
    wb_reg wb_reg (
        .clk(user_wb_clk),
        .rst(user_wb_rst),
        
        .wbm_adr_i(user_wb_adr),   
        .wbm_dat_i(user_wb_dat_wr),
        .wbm_dat_o(user_wb_dat_rd),
        .wbm_we_i (user_wb_we),    
        .wbm_sel_i(user_wb_sel),   
        .wbm_stb_i(user_wb_stb),   
        .wbm_ack_o(user_wb_ack),   
        .wbm_cyc_i(user_wb_cyc),   
        
        .wbs_adr_o(user_wb_reg_adr),   
        .wbs_dat_i(user_wb_reg_dat_rd),
        .wbs_dat_o(user_wb_reg_dat_wr),
        .wbs_we_o (user_wb_reg_we),    
        .wbs_sel_o(user_wb_reg_sel),   
        .wbs_stb_o(user_wb_reg_stb),   
        .wbs_ack_i(user_wb_reg_ack),   
        .wbs_cyc_o(user_wb_reg_cyc),
        .wbs_err_i(0),
        .wbs_rty_i(0)   
    );

    liteeth_core eth_mac (
        .mii_clocks_rx(mii_rx_clk),
        .mii_clocks_tx(mii_tx_clk),
        .mii_rst_n(mii_rst_n),
        .mii_rx_data(mii_rx_data),
        .mii_rx_dv(mii_rx_dv),
        .mii_tx_data(mii_tx_data),
        .mii_tx_en(mii_tx_en),
        .sys_clock(user_wb_clk),
        .sys_reset(rst_n),
        .wishbone_ack(user_wb_reg_ack),
        .wishbone_adr(user_wb_reg_adr),
        .wishbone_bte(0),
        .wishbone_cti(0),
        .wishbone_cyc(user_wb_reg_cyc),
        .wishbone_dat_r(user_wb_reg_dat_rd),
        .wishbone_dat_w(user_wb_reg_dat_wr),
        .wishbone_sel(user_wb_reg_sel),
        .wishbone_stb(user_wb_reg_stb),
        .wishbone_we(user_wb_reg_we)
    );

    // Buffer wb clock
    (* keep, dont_touch *) gf180mcu_fd_sc_mcu7t5v0__clkbuf_8 wb_clk_buf (
        .I(user_wb_clk_prebuf),
        .Z(user_wb_clk)
    );

    //
    // ztimer
    //
    rosc_spi_bridge  u_ztimer (
        .clk_i         (clk),
        .rst_ni        (rst_n),

        // SPI slave
        .cio_sck_i     (bidir_in[`PAD_ZTIMER_SCK]),
        .cio_csb_i     (bidir_in[`PAD_ZTIMER_CSB]),
        .cio_sd_i      (bidir_in[`PAD_ZTIMER_SDI]),
        .cio_sd_o      (bidir_out[`PAD_ZTIMER_SDO]),

        // controls
        .rosc_enable_i (input_in [`PADI_ZTIMER_ROSC_EN]),
        .start_i       (analog[`PADA_ZTIMER_START]),
        .stop_i        (analog[`PADA_ZTIMER_STOP])
    );
   
    caravel_core caravel (
        `ifdef USE_POWER_PINS
        .VDD(VDD),		
        .VSS(VSS),		
        `endif
        // SoC Core Interface
        .rstb(rst_n),
        .clock_core(clk),
        .gpio_out_core(bidir_out[`PAD_GPIO]),
        .gpio_in_core(bidir_in[`PAD_GPIO]),
        .gpio_outenb_core(bidir_oe[`PAD_GPIO]),
        .gpio_inenb_core(bidir_ie[`PAD_GPIO]),
        
        .flash_csb_frame(bidir_out[`PAD_FLASH_CSB]),
        .flash_clk_frame(bidir_out[`PAD_FLASH_CLK]),
        .flash_csb_oe(bidir_oe[`PAD_FLASH_CSB]),
        .flash_clk_oe(bidir_oe[`PAD_FLASH_CLK]),
        .flash_io0_oe(bidir_oe[`PAD_FLASH_IO0]),
        .flash_io1_oe(bidir_oe[`PAD_FLASH_IO1]),
        .flash_io0_ie(bidir_ie[`PAD_FLASH_IO0]),
        .flash_io1_ie(bidir_ie[`PAD_FLASH_IO1]),
        .flash_io0_do(bidir_out[`PAD_FLASH_IO0]),
        .flash_io1_do(bidir_out[`PAD_FLASH_IO1]),
        .flash_io0_di(bidir_in[`PAD_FLASH_IO0]),
        .flash_io1_di(bidir_in[`PAD_FLASH_IO1]),
        
        .caravel_io_in(bidir_in[`CARAVEL_IO_PADS-1:0]),
        .caravel_io_out(bidir_out[`CARAVEL_IO_PADS-1:0]),
        .caravel_io_oe(bidir_oe[`CARAVEL_IO_PADS-1:0]),
        .caravel_io_ie(bidir_ie[`CARAVEL_IO_PADS-1:0]),
        .caravel_io_schmitt_sel(bidir_cs[`CARAVEL_IO_PADS-1:0]),
        .caravel_io_pullup_sel(bidir_pu[`CARAVEL_IO_PADS-1:0]),
        .caravel_io_pulldown_sel(bidir_pd[`CARAVEL_IO_PADS-1:0]),
        .caravel_io_slew_sel(bidir_sl[`CARAVEL_IO_PADS-1:0]),
        
        // User wishbone stub
        .user_wb_clk_o(user_wb_clk_prebuf),
        .user_wb_rst_o(user_wb_rst),
        .user_wb_cyc_o(user_wb_cyc),
        .user_wb_stb_o(user_wb_stb),
        .user_wb_we_o (user_wb_we),
        .user_wb_sel_o(user_wb_sel),
        .user_wb_adr_o(user_wb_adr),
        .user_wb_dat_o(user_wb_dat_wr),
        .user_wb_dat_i(user_wb_dat_rd),
        .user_wb_ack_i(user_wb_ack),
        
        .user_irq_core(1'b0),
        
        // User IO stub
        .user_gpio_out({`CARAVEL_IO_PADS{1'b0}}),
        .user_gpio_oeb({`CARAVEL_IO_PADS{1'b1}}),
        
        .npor(npor),
        .start_mode(caravel_start_mode)
    );
    assign caravel_start_mode = 1'b0;

    // 10Base-T PHY ip
    (* keep *) tenbaset_tx_driver tenbaset_tx_driver (
        .D0P(0),
        .D0N(0),
        .D1P(0),
        .D1N(0),
        .D2P(0),
        .D2N(0),
        
        .TXP_PADOUT(analog[6]),
        .TXN_PADOUT(analog[7])
    );

    // flash ip
    (* keep *) flash_ip flash_ip ();

endmodule

`default_nettype wire
