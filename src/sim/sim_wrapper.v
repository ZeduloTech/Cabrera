// Simulation wrapper around chip_top to test Caravel

`default_nettype wire
`include "pinout.vh"
`include "defines.v"
    
module chip_wrapper #(
    parameter NUM_INPUT_PADS = 4,
    parameter NUM_BIDIR_PADS = 42,
    parameter NUM_ANALOG_PADS = 8
) (
    `ifdef USE_POWER_PINS
    inout VDD,        
    inout VSS,        
    `endif
    inout gpio,        
    inout [`MPRJ_IO_PADS-1:0] mprj_io,
    input clock,    
    input resetb,    

    inout flash_csb,
    inout flash_clk,
    inout flash_io0,
    inout flash_io1
);

    reg self_sufficient = 1'b0;
    wire [NUM_INPUT_PADS-1:0] in_pads = {self_sufficient, {NUM_INPUT_PADS-1{1'b0}}};
    wire [NUM_BIDIR_PADS-1:0] bidir_pads;
    wire [NUM_ANALOG_PADS-1:0] analog_pads;

    wire mii_rst, mii_rx_clk, mii_rx_dv, mii_tx_clk, mii_tx_en;
    wire [3:0] mii_rx_dat;
    wire [3:0] mii_tx_dat;

    wire phy_cmos_rxn, phy_cmos_rxp, phy_clk;

    // short the PHY pads
    assign phy_cmos_rxp = analog_pads[`PADA_10BT_TXP];
    assign phy_cmos_rxn = analog_pads[`PADA_10BT_TXN];

    chip_top chip (
        `ifdef USE_POWER_PINS
        .VDD(VDD),
        .VSS(VSS),
        `endif
    
        .clk_PAD(clock),
        .rst_n_PAD(resetb),

        .analog_PAD(analog_pads),
        .input_PAD(in_pads),
        .bidir_PAD({bidir_pads[NUM_BIDIR_PADS-1:`PAD_LAST+1], 
            phy_cmos_rxn, phy_cmos_rxp, phy_clk,
            mii_tx_dat, mii_tx_en, mii_tx_clk, mii_rx_dat, mii_rx_dv, mii_rx_clk, mii_rst, 
            bidir_pads[`PAD_MII_RST-1:`PAD_CARAVEL_END+1], 
            flash_io1, flash_io0, flash_clk, flash_csb, gpio, mprj_io[`MPRJ_IO_PADS-1:`MPRJ_IO_PADS-`MPRJ_TO_CARAVEL_HI], mprj_io[`MPRJ_TO_CARAVEL_LO-1:0]})
    );

endmodule
