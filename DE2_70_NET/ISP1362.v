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

module ISP1362 (
                 // inputs:
                  avs_dc_address_iADDR,
                  avs_dc_chipselect_n_iCS_N,
                  avs_dc_clk_iCLK,
                  avs_dc_export_OTG_INT1,
                  avs_dc_read_n_iRD_N,
                  avs_dc_reset_n_iRST_N,
                  avs_dc_write_n_iWR_N,
                  avs_dc_writedata_iDATA,
                  avs_hc_address_iADDR,
                  avs_hc_chipselect_n_iCS_N,
                  avs_hc_clk_iCLK,
                  avs_hc_export_OTG_INT0,
                  avs_hc_read_n_iRD_N,
                  avs_hc_reset_n_iRST_N,
                  avs_hc_write_n_iWR_N,
                  avs_hc_writedata_iDATA,

                 // outputs:
                  avs_dc_irq_n_oINT0_N,
                  avs_dc_readdata_oDATA,
                  avs_hc_export_OTG_ADDR,
                  avs_hc_export_OTG_CS_N,
                  avs_hc_export_OTG_DATA,
                  avs_hc_export_OTG_RD_N,
                  avs_hc_export_OTG_RST_N,
                  avs_hc_export_OTG_WR_N,
                  avs_hc_irq_n_oINT0_N,
                  avs_hc_readdata_oDATA
               )
;

  output           avs_dc_irq_n_oINT0_N;
  output  [ 15: 0] avs_dc_readdata_oDATA;
  output  [  1: 0] avs_hc_export_OTG_ADDR;
  output           avs_hc_export_OTG_CS_N;
  inout   [ 15: 0] avs_hc_export_OTG_DATA;
  output           avs_hc_export_OTG_RD_N;
  output           avs_hc_export_OTG_RST_N;
  output           avs_hc_export_OTG_WR_N;
  output           avs_hc_irq_n_oINT0_N;
  output  [ 15: 0] avs_hc_readdata_oDATA;
  input            avs_dc_address_iADDR;
  input            avs_dc_chipselect_n_iCS_N;
  input            avs_dc_clk_iCLK;
  input            avs_dc_export_OTG_INT1;
  input            avs_dc_read_n_iRD_N;
  input            avs_dc_reset_n_iRST_N;
  input            avs_dc_write_n_iWR_N;
  input   [ 15: 0] avs_dc_writedata_iDATA;
  input            avs_hc_address_iADDR;
  input            avs_hc_chipselect_n_iCS_N;
  input            avs_hc_clk_iCLK;
  input            avs_hc_export_OTG_INT0;
  input            avs_hc_read_n_iRD_N;
  input            avs_hc_reset_n_iRST_N;
  input            avs_hc_write_n_iWR_N;
  input   [ 15: 0] avs_hc_writedata_iDATA;

  wire             avs_dc_irq_n_oINT0_N;
  wire    [ 15: 0] avs_dc_readdata_oDATA;
  wire    [  1: 0] avs_hc_export_OTG_ADDR;
  wire             avs_hc_export_OTG_CS_N;
  wire    [ 15: 0] avs_hc_export_OTG_DATA;
  wire             avs_hc_export_OTG_RD_N;
  wire             avs_hc_export_OTG_RST_N;
  wire             avs_hc_export_OTG_WR_N;
  wire             avs_hc_irq_n_oINT0_N;
  wire    [ 15: 0] avs_hc_readdata_oDATA;
  ISP1362_IF the_ISP1362_IF
    (
      .avs_dc_address_iADDR      (avs_dc_address_iADDR),
      .avs_dc_chipselect_n_iCS_N (avs_dc_chipselect_n_iCS_N),
      .avs_dc_clk_iCLK           (avs_dc_clk_iCLK),
      .avs_dc_export_OTG_INT1    (avs_dc_export_OTG_INT1),
      .avs_dc_irq_n_oINT0_N      (avs_dc_irq_n_oINT0_N),
      .avs_dc_read_n_iRD_N       (avs_dc_read_n_iRD_N),
      .avs_dc_readdata_oDATA     (avs_dc_readdata_oDATA),
      .avs_dc_reset_n_iRST_N     (avs_dc_reset_n_iRST_N),
      .avs_dc_write_n_iWR_N      (avs_dc_write_n_iWR_N),
      .avs_dc_writedata_iDATA    (avs_dc_writedata_iDATA),
      .avs_hc_address_iADDR      (avs_hc_address_iADDR),
      .avs_hc_chipselect_n_iCS_N (avs_hc_chipselect_n_iCS_N),
      .avs_hc_clk_iCLK           (avs_hc_clk_iCLK),
      .avs_hc_export_OTG_ADDR    (avs_hc_export_OTG_ADDR),
      .avs_hc_export_OTG_CS_N    (avs_hc_export_OTG_CS_N),
      .avs_hc_export_OTG_DATA    (avs_hc_export_OTG_DATA),
      .avs_hc_export_OTG_INT0    (avs_hc_export_OTG_INT0),
      .avs_hc_export_OTG_RD_N    (avs_hc_export_OTG_RD_N),
      .avs_hc_export_OTG_RST_N   (avs_hc_export_OTG_RST_N),
      .avs_hc_export_OTG_WR_N    (avs_hc_export_OTG_WR_N),
      .avs_hc_irq_n_oINT0_N      (avs_hc_irq_n_oINT0_N),
      .avs_hc_read_n_iRD_N       (avs_hc_read_n_iRD_N),
      .avs_hc_readdata_oDATA     (avs_hc_readdata_oDATA),
      .avs_hc_reset_n_iRST_N     (avs_hc_reset_n_iRST_N),
      .avs_hc_write_n_iWR_N      (avs_hc_write_n_iWR_N),
      .avs_hc_writedata_iDATA    (avs_hc_writedata_iDATA)
    );


endmodule

