/*
 * Copyright (c) 2026 Zedulo Sweden AB
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none (* keep_hierarchy *)

module not_gate (
    input  wire i,
    output wire o   
);

    assign o = ~i;

endmodule


