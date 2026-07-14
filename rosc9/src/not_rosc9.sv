/*
 * Copyright (c) 2026 Zedulo Sweden AB
 * SPDX-License-Identifier: Apache-2.0
 */
/*********************************************************************
// This module makes the ring oscillator scalable
// It instantiates the inverter module and has a loop enable feature 
**********************************************************************/

module not_rosc9 #(
    parameter integer N = 9     // number of not gates, must be odd & >= 3
)(
    input wire rosc_enable,		// Enable ring oscillator
	output wire rosc_out		// Ring oscillator out 
);

  wire [N-1:0] inv_in;
  wire [N-1:0] inv_out;

  assign inv_in[0] = rosc_enable ? inv_out[N-1] : 1'b1;
  assign inv_in[N-1:1] = inv_out[N-2:0];

  assign rosc_out = inv_in[N-1];

  (* keep, dont_touch *) gf180mcu_fd_sc_mcu7t5v0__inv_1 inv[N-1:0]( 
      .I  (inv_in), 
      .ZN (inv_out) 
  );
    
endmodule

