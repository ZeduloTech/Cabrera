module tenbaset_tx_driver (
    `ifdef USE_POWER_PINS
    inout VDD,
    inout VSS,
    `endif
    input D0P,
    input D0N,
    input D1P,
    input D1N,
    input D2P,
    input D2N,
    
    output TXP_PADOUT,
    output TXN_PADOUT
);
    `ifdef SIM
    // very simple model to pass simulation tests
    wire [2:0] dn = {D2N, D1N, D0N};
    wire [2:0] dp = {D2P, D1P, D0P};
    
    assign TXN_PADOUT = (dn > dp) ? 1'b1 : 1'b0;
    assign TXP_PADOUT = (dp > dn) ? 1'b1 : 1'b0;
    `endif
endmodule
