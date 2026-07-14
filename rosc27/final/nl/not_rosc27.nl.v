module not_rosc27 (rosc_enable,
    rosc_out);
 input rosc_enable;
 output rosc_out;

 wire _0_;
 wire \inv_in[0] ;
 wire \inv_in[10] ;
 wire \inv_in[11] ;
 wire \inv_in[12] ;
 wire \inv_in[13] ;
 wire \inv_in[14] ;
 wire \inv_in[15] ;
 wire \inv_in[16] ;
 wire \inv_in[17] ;
 wire \inv_in[18] ;
 wire \inv_in[19] ;
 wire \inv_in[1] ;
 wire \inv_in[20] ;
 wire \inv_in[21] ;
 wire \inv_in[22] ;
 wire \inv_in[23] ;
 wire \inv_in[24] ;
 wire \inv_in[25] ;
 wire \inv_in[2] ;
 wire \inv_in[3] ;
 wire \inv_in[4] ;
 wire \inv_in[5] ;
 wire \inv_in[6] ;
 wire \inv_in[7] ;
 wire \inv_in[8] ;
 wire \inv_in[9] ;
 wire \inv_out[26] ;

 gf180mcu_fd_sc_mcu7t5v0__clkinv_1 _1_ (.I(\inv_out[26] ),
    .ZN(_0_));
 gf180mcu_fd_sc_mcu7t5v0__nand2_1 _2_ (.A1(_0_),
    .A2(rosc_enable),
    .ZN(\inv_in[0] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[0]  (.I(\inv_in[0] ),
    .ZN(\inv_in[1] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[10]  (.I(\inv_in[10] ),
    .ZN(\inv_in[11] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[11]  (.I(\inv_in[11] ),
    .ZN(\inv_in[12] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[12]  (.I(\inv_in[12] ),
    .ZN(\inv_in[13] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[13]  (.I(\inv_in[13] ),
    .ZN(\inv_in[14] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[14]  (.I(\inv_in[14] ),
    .ZN(\inv_in[15] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[15]  (.I(\inv_in[15] ),
    .ZN(\inv_in[16] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[16]  (.I(\inv_in[16] ),
    .ZN(\inv_in[17] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[17]  (.I(\inv_in[17] ),
    .ZN(\inv_in[18] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[18]  (.I(\inv_in[18] ),
    .ZN(\inv_in[19] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[19]  (.I(\inv_in[19] ),
    .ZN(\inv_in[20] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[1]  (.I(\inv_in[1] ),
    .ZN(\inv_in[2] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[20]  (.I(\inv_in[20] ),
    .ZN(\inv_in[21] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[21]  (.I(\inv_in[21] ),
    .ZN(\inv_in[22] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[22]  (.I(\inv_in[22] ),
    .ZN(\inv_in[23] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[23]  (.I(\inv_in[23] ),
    .ZN(\inv_in[24] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[24]  (.I(\inv_in[24] ),
    .ZN(\inv_in[25] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[25]  (.I(\inv_in[25] ),
    .ZN(rosc_out));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[26]  (.I(rosc_out),
    .ZN(\inv_out[26] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[2]  (.I(\inv_in[2] ),
    .ZN(\inv_in[3] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[3]  (.I(\inv_in[3] ),
    .ZN(\inv_in[4] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[4]  (.I(\inv_in[4] ),
    .ZN(\inv_in[5] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[5]  (.I(\inv_in[5] ),
    .ZN(\inv_in[6] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[6]  (.I(\inv_in[6] ),
    .ZN(\inv_in[7] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[7]  (.I(\inv_in[7] ),
    .ZN(\inv_in[8] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[8]  (.I(\inv_in[8] ),
    .ZN(\inv_in[9] ));
 gf180mcu_fd_sc_mcu7t5v0__inv_1 \inv[9]  (.I(\inv_in[9] ),
    .ZN(\inv_in[10] ));
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
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_0_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_0_27 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_0_31 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_0_33 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_0_36 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_0_44 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_0_48 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_0_50 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_1_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_1_4 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_1_13 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_16 FILLER_1_23 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_1_39 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_1_47 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_2_11 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_2_13 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_2_22 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_2_30 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_2_34 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_2_37 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_2_45 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_2_49 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_3_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_3_4 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_3_17 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_16 FILLER_3_35 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_4_34 ();
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
