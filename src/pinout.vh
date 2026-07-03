// Caravel pad assignment

`ifndef _PINOUT_VH
`define _PINOUT_VH

`define PAD_CARAVELIO_0 0
`define PAD_GPIO        13
`define PAD_FLASH_CSB   14
`define PAD_FLASH_CLK   15
`define PAD_FLASH_IO0   16
`define PAD_FLASH_IO1   17

`define PAD_CARAVEL_END `PAD_FLASH_IO1

// zTimer
`define PAD_ZTIMER_SCK   18
`define PAD_ZTIMER_CSB   19
`define PAD_ZTIMER_SDI   20
`define PAD_ZTIMER_SDO   21
`define PAD_ZTIMER_END   `PAD_ZTIMER_SDO
// ztimer control inputs
`define PAD_ZTIMER_ROSC_EN 35
`define PAD_ZTIMER_START   36
`define PAD_ZTIMER_STOP    37

// MII
`define PAD_MII_RST     22
`define PAD_MII_RX_CLK  23
`define PAD_MII_RX_DV   24
`define PAD_MII_RX_DAT0 25
`define PAD_MII_RX_DAT1 26
`define PAD_MII_RX_DAT2 27
`define PAD_MII_RX_DAT3 28
`define PAD_MII_TX_CLK  29
`define PAD_MII_TX_EN   30
`define PAD_MII_TX_DAT0 31
`define PAD_MII_TX_DAT1 32
`define PAD_MII_TX_DAT2 33
`define PAD_MII_TX_DAT3 34

`endif
