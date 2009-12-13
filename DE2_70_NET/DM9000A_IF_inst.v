//Legal Notice: (C)2007 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module DM9000A_IF_inst (
                         // inputs:
                          avs_s1_address_iCMD,
                          avs_s1_chipselect_n_iCS_N,
                          avs_s1_clk_iCLK,
                          avs_s1_export_ENET_INT,
                          avs_s1_read_n_iRD_N,
                          avs_s1_reset_n_iRST_N,
                          avs_s1_write_n_iWR_N,
                          avs_s1_writedata_iDATA,

                         // outputs:
                          avs_s1_export_ENET_CLK,
                          avs_s1_export_ENET_CMD,
                          avs_s1_export_ENET_CS_N,
                          avs_s1_export_ENET_DATA,
                          avs_s1_export_ENET_RD_N,
                          avs_s1_export_ENET_RST_N,
                          avs_s1_export_ENET_WR_N,
                          avs_s1_irq_oINT,
                          avs_s1_readdata_oDATA
                       )
;

  output           avs_s1_export_ENET_CLK;
  output           avs_s1_export_ENET_CMD;
  output           avs_s1_export_ENET_CS_N;
  inout   [ 15: 0] avs_s1_export_ENET_DATA;
  output           avs_s1_export_ENET_RD_N;
  output           avs_s1_export_ENET_RST_N;
  output           avs_s1_export_ENET_WR_N;
  output           avs_s1_irq_oINT;
  output  [ 15: 0] avs_s1_readdata_oDATA;
  input            avs_s1_address_iCMD;
  input            avs_s1_chipselect_n_iCS_N;
  input            avs_s1_clk_iCLK;
  input            avs_s1_export_ENET_INT;
  input            avs_s1_read_n_iRD_N;
  input            avs_s1_reset_n_iRST_N;
  input            avs_s1_write_n_iWR_N;
  input   [ 15: 0] avs_s1_writedata_iDATA;

  wire             avs_s1_export_ENET_CLK;
  wire             avs_s1_export_ENET_CMD;
  wire             avs_s1_export_ENET_CS_N;
  wire    [ 15: 0] avs_s1_export_ENET_DATA;
  wire             avs_s1_export_ENET_RD_N;
  wire             avs_s1_export_ENET_RST_N;
  wire             avs_s1_export_ENET_WR_N;
  wire             avs_s1_irq_oINT;
  wire    [ 15: 0] avs_s1_readdata_oDATA;
  DM9000A_IF the_DM9000A_IF
    (
      .avs_s1_address_iCMD       (avs_s1_address_iCMD),
      .avs_s1_chipselect_n_iCS_N (avs_s1_chipselect_n_iCS_N),
      .avs_s1_clk_iCLK           (avs_s1_clk_iCLK),
      .avs_s1_export_ENET_CLK    (avs_s1_export_ENET_CLK),
      .avs_s1_export_ENET_CMD    (avs_s1_export_ENET_CMD),
      .avs_s1_export_ENET_CS_N   (avs_s1_export_ENET_CS_N),
      .avs_s1_export_ENET_DATA   (avs_s1_export_ENET_DATA),
      .avs_s1_export_ENET_INT    (avs_s1_export_ENET_INT),
      .avs_s1_export_ENET_RD_N   (avs_s1_export_ENET_RD_N),
      .avs_s1_export_ENET_RST_N  (avs_s1_export_ENET_RST_N),
      .avs_s1_export_ENET_WR_N   (avs_s1_export_ENET_WR_N),
      .avs_s1_irq_oINT           (avs_s1_irq_oINT),
      .avs_s1_read_n_iRD_N       (avs_s1_read_n_iRD_N),
      .avs_s1_readdata_oDATA     (avs_s1_readdata_oDATA),
      .avs_s1_reset_n_iRST_N     (avs_s1_reset_n_iRST_N),
      .avs_s1_write_n_iWR_N      (avs_s1_write_n_iWR_N),
      .avs_s1_writedata_iDATA    (avs_s1_writedata_iDATA)
    );


endmodule

