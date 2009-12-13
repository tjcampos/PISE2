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

module ps2_mouse (
                   // inputs:
                    address,
                    byteenable,
                    chipselect,
                    clk,
                    read,
                    reset,
                    write,
                    writedata,

                   // outputs:
                    PS2_CLK,
                    PS2_DAT,
                    irq,
                    readdata,
                    waitrequest
                 )
;

  inout            PS2_CLK;
  inout            PS2_DAT;
  output           irq;
  output  [ 31: 0] readdata;
  output           waitrequest;
  input            address;
  input   [  3: 0] byteenable;
  input            chipselect;
  input            clk;
  input            read;
  input            reset;
  input            write;
  input   [ 31: 0] writedata;

  wire             PS2_CLK;
  wire             PS2_DAT;
  wire             irq;
  wire    [ 31: 0] readdata;
  wire             waitrequest;
  Altera_UP_Avalon_PS2 the_Altera_UP_Avalon_PS2
    (
      .PS2_CLK     (PS2_CLK),
      .PS2_DAT     (PS2_DAT),
      .address     (address),
      .byteenable  (byteenable),
      .chipselect  (chipselect),
      .clk         (clk),
      .irq         (irq),
      .read        (read),
      .readdata    (readdata),
      .reset       (reset),
      .waitrequest (waitrequest),
      .write       (write),
      .writedata   (writedata)
    );


endmodule

