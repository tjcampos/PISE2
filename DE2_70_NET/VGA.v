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

module VGA (
             // inputs:
              avs_s1_address_iADDR,
              avs_s1_chipselect_iCS,
              avs_s1_clk_iCLK,
              avs_s1_export_iCLK_25,
              avs_s1_read_iRD,
              avs_s1_reset_n_iRST_N,
              avs_s1_write_iWR,
              avs_s1_writedata_iDATA,

             // outputs:
              avs_s1_export_VGA_B,
              avs_s1_export_VGA_BLANK,
              avs_s1_export_VGA_CLK,
              avs_s1_export_VGA_G,
              avs_s1_export_VGA_HS,
              avs_s1_export_VGA_R,
              avs_s1_export_VGA_SYNC,
              avs_s1_export_VGA_VS,
              avs_s1_readdata_oDATA
           )
;

  output  [  9: 0] avs_s1_export_VGA_B;
  output           avs_s1_export_VGA_BLANK;
  output           avs_s1_export_VGA_CLK;
  output  [  9: 0] avs_s1_export_VGA_G;
  output           avs_s1_export_VGA_HS;
  output  [  9: 0] avs_s1_export_VGA_R;
  output           avs_s1_export_VGA_SYNC;
  output           avs_s1_export_VGA_VS;
  output  [ 15: 0] avs_s1_readdata_oDATA;
  input   [ 18: 0] avs_s1_address_iADDR;
  input            avs_s1_chipselect_iCS;
  input            avs_s1_clk_iCLK;
  input            avs_s1_export_iCLK_25;
  input            avs_s1_read_iRD;
  input            avs_s1_reset_n_iRST_N;
  input            avs_s1_write_iWR;
  input   [ 15: 0] avs_s1_writedata_iDATA;

  wire    [  9: 0] avs_s1_export_VGA_B;
  wire             avs_s1_export_VGA_BLANK;
  wire             avs_s1_export_VGA_CLK;
  wire    [  9: 0] avs_s1_export_VGA_G;
  wire             avs_s1_export_VGA_HS;
  wire    [  9: 0] avs_s1_export_VGA_R;
  wire             avs_s1_export_VGA_SYNC;
  wire             avs_s1_export_VGA_VS;
  wire    [ 15: 0] avs_s1_readdata_oDATA;
  VGA_NIOS_CTRL the_VGA_NIOS_CTRL
    (
      .avs_s1_address_iADDR    (avs_s1_address_iADDR),
      .avs_s1_chipselect_iCS   (avs_s1_chipselect_iCS),
      .avs_s1_clk_iCLK         (avs_s1_clk_iCLK),
      .avs_s1_export_VGA_B     (avs_s1_export_VGA_B),
      .avs_s1_export_VGA_BLANK (avs_s1_export_VGA_BLANK),
      .avs_s1_export_VGA_CLK   (avs_s1_export_VGA_CLK),
      .avs_s1_export_VGA_G     (avs_s1_export_VGA_G),
      .avs_s1_export_VGA_HS    (avs_s1_export_VGA_HS),
      .avs_s1_export_VGA_R     (avs_s1_export_VGA_R),
      .avs_s1_export_VGA_SYNC  (avs_s1_export_VGA_SYNC),
      .avs_s1_export_VGA_VS    (avs_s1_export_VGA_VS),
      .avs_s1_export_iCLK_25   (avs_s1_export_iCLK_25),
      .avs_s1_read_iRD         (avs_s1_read_iRD),
      .avs_s1_readdata_oDATA   (avs_s1_readdata_oDATA),
      .avs_s1_reset_n_iRST_N   (avs_s1_reset_n_iRST_N),
      .avs_s1_write_iWR        (avs_s1_write_iWR),
      .avs_s1_writedata_iDATA  (avs_s1_writedata_iDATA)
    );
  defparam the_VGA_NIOS_CTRL.RAM_SIZE = 307200;


endmodule

