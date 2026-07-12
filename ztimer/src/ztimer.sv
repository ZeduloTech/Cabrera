/*
 * Copyright (c) 2026 Zedulo Sweden AB
 * SPDX-License-Identifier: Apache-2.0
 */
 
/************************************************************************
// Integration of not_rosc, clk_timer to SPI interface to read and clear register(s)
// This modules takes an input clock, this could be either a stable clock source 
// or a ring oscillator.
// When start is triggered, the timer begins to count
// Triggering stop, ends the timing session and stores the count value(s) 
// that corresponds to the elapsed time within the elapsed_time registers.
// It also instantiates an SPI module that comes to read or clear the registers of 
// interest 
**************************************************************************/ 

module ztimer #(
    parameter integer N_REGS = 5,   //Number of registers
	parameter integer FLAT_COUNTER_REGISTERS = (N_REGS * 32)
)(
    input wire clk_i,
    input wire rst_ni,
    
    input wire cio_sck_i,
    input wire cio_csb_i,
    input wire cio_sd_i,
    output wire cio_sd_o,

    input wire start_i,
    input wire stop_i
);	 

    wire [31:0] t0_elapsed_time;
    wire [31:0] t1_elapsed_time;
    wire [31:0] t2_elapsed_time;
	wire [31:0] t3_elapsed_time;
	wire [31:0] t4_elapsed_time;
	 

    wire [FLAT_COUNTER_REGISTERS - 1:0] counters_i;
    wire [3:0] cnt_idx;
    wire cnt_rst_en;
	 
	 
   assign counters_i[0 * 32 +: 32] = t0_elapsed_time;
   assign counters_i[1 * 32 +: 32] = t1_elapsed_time;
   assign counters_i[2 * 32 +: 32] = t2_elapsed_time;
   assign counters_i[3 * 32 +: 32] = t3_elapsed_time;
   assign counters_i[4 * 32 +: 32] = t4_elapsed_time;


	wire rosc3_out;
	(* keep, dont_touch *) not_rosc3 rosc3 (    
		.rosc_enable(1'b1),			// Enable ring oscillator
		.rosc_out(rosc3_out)		// Ring oscillator out 
	);

	wire rosc5_out;
	(* keep, dont_touch *) not_rosc5 rosc5 (
		.rosc_enable(1'b1),			// Enable ring oscillator
		.rosc_out(rosc5_out)		// Ring oscillator out 
	);

	wire rosc9_out;
	(* keep, dont_touch *) not_rosc9 rosc9 (
		.rosc_enable(1'b1),			// Enable ring oscillator
		.rosc_out(rosc9_out)		// Ring oscillator out 
	);

	wire rosc27_out;
	(* keep, dont_touch *) not_rosc27 rosc27 (
		.rosc_enable(1'b1),			// Enable ring oscillator
		.rosc_out(rosc27_out)	    // Ring oscillator out 
	);


	 clk_timer u_timer_xtal (
		  .clk_i         (clk_i),
		  .rst_n         (rst_ni),
		  .clear         (cnt_rst_en && (cnt_idx == 4'd0)),
		  .start         (start_i),
		  .stop          (stop_i),
		  .elapsed_count (t0_elapsed_time)
	);
	
	 clk_timer u_timer_rosc27 (
		  .clk_i         (rosc27_out),
		  .rst_n         (rst_ni),
		  .clear         (cnt_rst_en && (cnt_idx == 4'd1)),
		  .start         (start_i),
		  .stop          (stop_i),
		  .elapsed_count (t1_elapsed_time)
	);
	
	 clk_timer u_timer_rosc9 (
		  .clk_i         (rosc9_out),
		  .rst_n         (rst_ni),
		  .clear         (cnt_rst_en && (cnt_idx == 4'd2)),
		  .start         (start_i),
		  .stop          (stop_i),
		  .elapsed_count (t2_elapsed_time)
	);

	clk_timer u_timer_rosc5 (
		  .clk_i         (rosc5_out),
		  .rst_n         (rst_ni),
		  .clear         (cnt_rst_en && (cnt_idx == 4'd3)),
		  .start         (start_i),
		  .stop          (stop_i),
		  .elapsed_count (t3_elapsed_time)
	);

	 clk_timer u_timer_rosc3 (
		  .clk_i         (rosc3_out),
		  .rst_n         (rst_ni),
		  .clear         (cnt_rst_en && (cnt_idx == 4'd4)),
		  .start         (start_i),
		  .stop          (stop_i),
		  .elapsed_count (t4_elapsed_time)
	);

	
    spi_device #(
	    .FLAT_COUNTER_REGISTERS (FLAT_COUNTER_REGISTERS),
	    .N_REGS (N_REGS)
	 ) spi_device (
        .clk_i      (clk_i),
        .rst_ni     (rst_ni),

        .cio_sck_i  (cio_sck_i),
        .cio_csb_i  (cio_csb_i),
        .cio_sd_i   (cio_sd_i),
        .cio_sd_o   (cio_sd_o),

        .counters_i (counters_i),
        .cnt_idx    (cnt_idx),
        .cnt_rst_en (cnt_rst_en)
    );

endmodule

