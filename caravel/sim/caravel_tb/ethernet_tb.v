`default_nettype none
/*
 *  SPDX-FileCopyrightText: 2017  Clifford Wolf, 2018  Tim Edwards
 *
 *  StriVe - A full example SoC using PicoRV32 in SkyWater s8
 *
 *  Copyright (C) 2017  Clifford Wolf <clifford@clifford.at>
 *  Copyright (C) 2018  Tim Edwards <tim@efabless.com>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 *  SPDX-License-Identifier: ISC
 */

`timescale 1 ns / 1 ps

 `include "pinout.vh"

module ethernet_tb;
    reg clock, clk_80;
    reg RSTB;
    reg power1;

    wire gpio;
    wire [15:0] checkbits;
    wire [37:0] mprj_io;
    wire flash_csb;
    wire flash_clk;
    wire flash_io0;
    wire flash_io1;
    wire uart_tx;
    reg uart_rx = 1'b1;
    wire SDO;
    
    reg test_success = 1'b0;

    assign checkbits = mprj_io[31:16];
    assign uart_tx = mprj_io[6];
    assign mprj_io[5] = uart_rx;

    always #25 clock <= (clock === 1'b0);
    always #6.25 clk_80 <= (clk_80 === 1'b0);

    initial begin
        clock = 0;
        clk_80 = 0;
    end
    
    `define CHIP_TOP_HIER uut.chip
    `include "sdf.vh"

    initial begin
        $display("UART Test started");
        
        repeat (450) begin
            repeat (1000) @(posedge clock);
        end
        `ifdef GL
            $display ("Monitor: Timeout, Test Ethernet (GL) Failed");
        `else
            $display ("Monitor: Timeout, Test Ethernet (RTL) Failed");
        `endif
        $finish;
    end

    initial begin
        RSTB <= 1'b0;
        #1000;
        RSTB <= 1'b1;        // Release reset
        #2000;
    end

    initial begin        // Power-up sequence
        power1 <= 1'b0;
        #2000;
        power1 <= 1'b1;
    end

    always @(gpio) begin
        if(gpio == 1'b1) begin
            `ifdef GL
                $display("Ethernet Test (GL) finished");
            `else
                $display("Ethernet Test (RTL) finished");
            `endif
            test_success <= 1'b1;
        end
    end

    wire VDD5V0;
    wire VSS;

    assign VDD5V0 = power1;
    assign VSS = 1'b0;
    
    assign mprj_io[3] = 1'b1;  // Force CSB high.
    assign mprj_io[0] = 1'b0;  // Disable debug mode
    
    assign uut.bidir_pads[`PAD_10BT_CLK] = clk_80;
    assign uut.bidir_pads[`PAD_10BT_CMOS_RXP] = uut.analog_pads[`PADA_10BT_TXP];
    assign uut.bidir_pads[`PAD_10BT_CMOS_RXN] = uut.analog_pads[`PADA_10BT_TXN];

    wire txn = uut.analog_pads[`PADA_10BT_TXN];
    wire txp = uut.analog_pads[`PADA_10BT_TXP];

    caravel uut (
        `ifdef USE_POWER_PINS
        .VDD      (VDD5V0),
        .VSS      (VSS),
        `endif
        .clock      (clock),
        .gpio     (gpio),
        .mprj_io  (mprj_io),
        .flash_csb(flash_csb),
        .flash_clk(flash_clk),
        .flash_io0(flash_io0),
        .flash_io1(flash_io1),
        .resetb      (RSTB)
    );

    spiflash #(
        .FILENAME({`HEX_PREFIX, "ethernet.hex"})
    ) spiflash (
        .csb(flash_csb),
        .clk(flash_clk),
        .io0(flash_io0),
        .io1(flash_io1),
        .io2(),            // not used
        .io3()            // not used
    );

        
endmodule
`default_nettype wire
