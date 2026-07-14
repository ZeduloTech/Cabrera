module not_rosc3 (rosc_enable,
    rosc_out);
 input rosc_enable;
 output rosc_out;

 wire _0_;
 wire \inv_in[0] ;
 wire \inv_in[1] ;
 wire \inv_out[2] ;

 gf180mcu_fd_sc_mcu7t5v0__clkinv_1 _1_ (.I(\inv_out[2] ),
    .ZN(_0_));
 gf180mcu_fd_sc_mcu7t5v0__nand2_1 _2_ (.A1(_0_),
    .A2(rosc_enable),
    .ZN(\inv_in[0] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[0]  (.I(\inv_in[0] ),
    .ZN(\inv_in[1] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[1]  (.I(\inv_in[1] ),
    .ZN(rosc_out));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[2]  (.I(rosc_out),
    .ZN(\inv_out[2] ));
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_0_Right_0 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_1_Right_1 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_2_Right_2 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_3_Right_3 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_4_Right_4 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_5_Right_5 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_6_Right_6 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_0_Left_7 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_1_Left_8 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_2_Left_9 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_3_Left_10 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_4_Left_11 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_5_Left_12 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_6_Left_13 ();
 gf180mcu_fd_sc_mcu7t5v0__filltie TAP_TAPCELL_ROW_0_14 ();
 gf180mcu_fd_sc_mcu7t5v0__filltie TAP_TAPCELL_ROW_2_15 ();
 gf180mcu_fd_sc_mcu7t5v0__filltie TAP_TAPCELL_ROW_4_16 ();
 gf180mcu_fd_sc_mcu7t5v0__filltie TAP_TAPCELL_ROW_6_17 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_32 FILLER_0_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_0_36 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_0_44 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_0_48 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_0_50 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_32 FILLER_1_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_16 FILLER_1_34 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_1_50 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_32 FILLER_2_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_2_34 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_2_37 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_2_45 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_2_49 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_16 FILLER_3_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_16 FILLER_3_27 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_3_43 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_16 FILLER_4_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_4_18 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_4_31 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_4_37 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_4_45 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_4_49 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_32 FILLER_5_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_16 FILLER_5_34 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_5_50 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_32 FILLER_6_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_6_36 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_6_44 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_6_48 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_6_50 ();
endmodule
