module not_rosc9 (rosc_enable,
    rosc_out);
 input rosc_enable;
 output rosc_out;

 wire net1;

 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_0_18 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_16 FILLER_0_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_0_36 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_0_44 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_0_48 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_0_50 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_1_18 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_16 FILLER_1_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_16 FILLER_1_27 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_1_43 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_32 FILLER_2_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_2_34 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_2_37 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_2_45 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_2_49 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_32 FILLER_3_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_16 FILLER_3_34 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_3_50 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_32 FILLER_4_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_4_34 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_4_37 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_4_45 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_4_49 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_32 FILLER_5_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_5_36 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_5_44 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_5_48 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_5_50 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_0_Left_6 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_0_Right_0 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_1_Left_7 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_1_Right_1 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_2_Left_8 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_2_Right_2 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_3_Left_9 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_3_Right_3 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_4_Left_10 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_4_Right_4 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_5_Left_11 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_5_Right_5 ();
 gf180mcu_fd_sc_mcu7t5v0__filltie TAP_TAPCELL_ROW_0_12 ();
 gf180mcu_fd_sc_mcu7t5v0__filltie TAP_TAPCELL_ROW_2_13 ();
 gf180mcu_fd_sc_mcu7t5v0__filltie TAP_TAPCELL_ROW_4_14 ();
 gf180mcu_fd_sc_mcu7t5v0__filltie TAP_TAPCELL_ROW_5_15 ();
 gf180mcu_fd_sc_mcu7t5v0__nand2_1 _0_ (.A1(rosc_enable),
    .A2(net1),
    .ZN(net1));
 gf180mcu_fd_sc_mcu7t5v0__clkbuf_3 wire1 (.I(net1),
    .Z(rosc_out));
endmodule
