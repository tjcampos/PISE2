//megafunction wizard: %Altera SOPC Builder%
//GENERATION: STANDARD
//VERSION: WM1.0


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

module AUDIO_s1_arbitrator (
                             // inputs:
                              AUDIO_s1_readdata,
                              clk,
                              cpu_data_master_address_to_slave,
                              cpu_data_master_latency_counter,
                              cpu_data_master_read,
                              cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                              cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                              cpu_data_master_write,
                              cpu_data_master_writedata,
                              reset_n,

                             // outputs:
                              AUDIO_s1_address,
                              AUDIO_s1_read,
                              AUDIO_s1_readdata_from_sa,
                              AUDIO_s1_reset,
                              AUDIO_s1_write,
                              AUDIO_s1_writedata,
                              cpu_data_master_granted_AUDIO_s1,
                              cpu_data_master_qualified_request_AUDIO_s1,
                              cpu_data_master_read_data_valid_AUDIO_s1,
                              cpu_data_master_requests_AUDIO_s1,
                              d1_AUDIO_s1_end_xfer
                           )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output  [  4: 0] AUDIO_s1_address;
  output           AUDIO_s1_read;
  output  [ 32: 0] AUDIO_s1_readdata_from_sa;
  output           AUDIO_s1_reset;
  output           AUDIO_s1_write;
  output  [ 32: 0] AUDIO_s1_writedata;
  output           cpu_data_master_granted_AUDIO_s1;
  output           cpu_data_master_qualified_request_AUDIO_s1;
  output           cpu_data_master_read_data_valid_AUDIO_s1;
  output           cpu_data_master_requests_AUDIO_s1;
  output           d1_AUDIO_s1_end_xfer;
  input   [ 32: 0] AUDIO_s1_readdata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  4: 0] AUDIO_s1_address;
  wire             AUDIO_s1_allgrants;
  wire             AUDIO_s1_allow_new_arb_cycle;
  wire             AUDIO_s1_any_bursting_master_saved_grant;
  wire             AUDIO_s1_any_continuerequest;
  wire             AUDIO_s1_arb_counter_enable;
  reg     [  1: 0] AUDIO_s1_arb_share_counter;
  wire    [  1: 0] AUDIO_s1_arb_share_counter_next_value;
  wire    [  1: 0] AUDIO_s1_arb_share_set_values;
  wire             AUDIO_s1_beginbursttransfer_internal;
  wire             AUDIO_s1_begins_xfer;
  wire             AUDIO_s1_end_xfer;
  wire             AUDIO_s1_firsttransfer;
  wire             AUDIO_s1_grant_vector;
  wire             AUDIO_s1_in_a_read_cycle;
  wire             AUDIO_s1_in_a_write_cycle;
  wire             AUDIO_s1_master_qreq_vector;
  wire             AUDIO_s1_non_bursting_master_requests;
  wire             AUDIO_s1_read;
  wire    [ 32: 0] AUDIO_s1_readdata_from_sa;
  reg              AUDIO_s1_reg_firsttransfer;
  wire             AUDIO_s1_reset;
  reg              AUDIO_s1_slavearbiterlockenable;
  wire             AUDIO_s1_slavearbiterlockenable2;
  wire             AUDIO_s1_unreg_firsttransfer;
  wire             AUDIO_s1_waits_for_read;
  wire             AUDIO_s1_waits_for_write;
  wire             AUDIO_s1_write;
  wire    [ 32: 0] AUDIO_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_AUDIO_s1;
  wire             cpu_data_master_qualified_request_AUDIO_s1;
  wire             cpu_data_master_read_data_valid_AUDIO_s1;
  wire             cpu_data_master_requests_AUDIO_s1;
  wire             cpu_data_master_saved_grant_AUDIO_s1;
  reg              d1_AUDIO_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_AUDIO_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_AUDIO_s1_from_cpu_data_master;
  wire             wait_for_AUDIO_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~AUDIO_s1_end_xfer;
    end


  assign AUDIO_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_AUDIO_s1));
  //assign AUDIO_s1_readdata_from_sa = AUDIO_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign AUDIO_s1_readdata_from_sa = AUDIO_s1_readdata;

  assign cpu_data_master_requests_AUDIO_s1 = ({cpu_data_master_address_to_slave[27 : 7] , 7'b0} == 28'h9641000) & (cpu_data_master_read | cpu_data_master_write);
  //AUDIO_s1_arb_share_counter set values, which is an e_mux
  assign AUDIO_s1_arb_share_set_values = 1;

  //AUDIO_s1_non_bursting_master_requests mux, which is an e_mux
  assign AUDIO_s1_non_bursting_master_requests = cpu_data_master_requests_AUDIO_s1;

  //AUDIO_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign AUDIO_s1_any_bursting_master_saved_grant = 0;

  //AUDIO_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign AUDIO_s1_arb_share_counter_next_value = AUDIO_s1_firsttransfer ? (AUDIO_s1_arb_share_set_values - 1) : |AUDIO_s1_arb_share_counter ? (AUDIO_s1_arb_share_counter - 1) : 0;

  //AUDIO_s1_allgrants all slave grants, which is an e_mux
  assign AUDIO_s1_allgrants = |AUDIO_s1_grant_vector;

  //AUDIO_s1_end_xfer assignment, which is an e_assign
  assign AUDIO_s1_end_xfer = ~(AUDIO_s1_waits_for_read | AUDIO_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_AUDIO_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_AUDIO_s1 = AUDIO_s1_end_xfer & (~AUDIO_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //AUDIO_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign AUDIO_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_AUDIO_s1 & AUDIO_s1_allgrants) | (end_xfer_arb_share_counter_term_AUDIO_s1 & ~AUDIO_s1_non_bursting_master_requests);

  //AUDIO_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          AUDIO_s1_arb_share_counter <= 0;
      else if (AUDIO_s1_arb_counter_enable)
          AUDIO_s1_arb_share_counter <= AUDIO_s1_arb_share_counter_next_value;
    end


  //AUDIO_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          AUDIO_s1_slavearbiterlockenable <= 0;
      else if ((|AUDIO_s1_master_qreq_vector & end_xfer_arb_share_counter_term_AUDIO_s1) | (end_xfer_arb_share_counter_term_AUDIO_s1 & ~AUDIO_s1_non_bursting_master_requests))
          AUDIO_s1_slavearbiterlockenable <= |AUDIO_s1_arb_share_counter_next_value;
    end


  //cpu/data_master AUDIO/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = AUDIO_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //AUDIO_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign AUDIO_s1_slavearbiterlockenable2 = |AUDIO_s1_arb_share_counter_next_value;

  //cpu/data_master AUDIO/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = AUDIO_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //AUDIO_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign AUDIO_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_AUDIO_s1 = cpu_data_master_requests_AUDIO_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_AUDIO_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_AUDIO_s1 = cpu_data_master_granted_AUDIO_s1 & cpu_data_master_read & ~AUDIO_s1_waits_for_read;

  //AUDIO_s1_writedata mux, which is an e_mux
  assign AUDIO_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_AUDIO_s1 = cpu_data_master_qualified_request_AUDIO_s1;

  //cpu/data_master saved-grant AUDIO/s1, which is an e_assign
  assign cpu_data_master_saved_grant_AUDIO_s1 = cpu_data_master_requests_AUDIO_s1;

  //allow new arb cycle for AUDIO/s1, which is an e_assign
  assign AUDIO_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign AUDIO_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign AUDIO_s1_master_qreq_vector = 1;

  //~AUDIO_s1_reset assignment, which is an e_assign
  assign AUDIO_s1_reset = ~reset_n;

  //AUDIO_s1_firsttransfer first transaction, which is an e_assign
  assign AUDIO_s1_firsttransfer = AUDIO_s1_begins_xfer ? AUDIO_s1_unreg_firsttransfer : AUDIO_s1_reg_firsttransfer;

  //AUDIO_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign AUDIO_s1_unreg_firsttransfer = ~(AUDIO_s1_slavearbiterlockenable & AUDIO_s1_any_continuerequest);

  //AUDIO_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          AUDIO_s1_reg_firsttransfer <= 1'b1;
      else if (AUDIO_s1_begins_xfer)
          AUDIO_s1_reg_firsttransfer <= AUDIO_s1_unreg_firsttransfer;
    end


  //AUDIO_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign AUDIO_s1_beginbursttransfer_internal = AUDIO_s1_begins_xfer;

  //AUDIO_s1_read assignment, which is an e_mux
  assign AUDIO_s1_read = cpu_data_master_granted_AUDIO_s1 & cpu_data_master_read;

  //AUDIO_s1_write assignment, which is an e_mux
  assign AUDIO_s1_write = cpu_data_master_granted_AUDIO_s1 & cpu_data_master_write;

  assign shifted_address_to_AUDIO_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //AUDIO_s1_address mux, which is an e_mux
  assign AUDIO_s1_address = shifted_address_to_AUDIO_s1_from_cpu_data_master >> 2;

  //d1_AUDIO_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_AUDIO_s1_end_xfer <= 1;
      else if (1)
          d1_AUDIO_s1_end_xfer <= AUDIO_s1_end_xfer;
    end


  //AUDIO_s1_waits_for_read in a cycle, which is an e_mux
  assign AUDIO_s1_waits_for_read = AUDIO_s1_in_a_read_cycle & 0;

  //AUDIO_s1_in_a_read_cycle assignment, which is an e_assign
  assign AUDIO_s1_in_a_read_cycle = cpu_data_master_granted_AUDIO_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = AUDIO_s1_in_a_read_cycle;

  //AUDIO_s1_waits_for_write in a cycle, which is an e_mux
  assign AUDIO_s1_waits_for_write = AUDIO_s1_in_a_write_cycle & 0;

  //AUDIO_s1_in_a_write_cycle assignment, which is an e_assign
  assign AUDIO_s1_in_a_write_cycle = cpu_data_master_granted_AUDIO_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = AUDIO_s1_in_a_write_cycle;

  assign wait_for_AUDIO_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //AUDIO/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module DM9000A_s1_arbitrator (
                               // inputs:
                                DM9000A_s1_irq,
                                DM9000A_s1_readdata,
                                clk,
                                clock_1_out_address_to_slave,
                                clock_1_out_nativeaddress,
                                clock_1_out_read,
                                clock_1_out_write,
                                clock_1_out_writedata,
                                reset_n,

                               // outputs:
                                DM9000A_s1_address,
                                DM9000A_s1_chipselect_n,
                                DM9000A_s1_irq_from_sa,
                                DM9000A_s1_read_n,
                                DM9000A_s1_readdata_from_sa,
                                DM9000A_s1_reset_n,
                                DM9000A_s1_wait_counter_eq_0,
                                DM9000A_s1_write_n,
                                DM9000A_s1_writedata,
                                clock_1_out_granted_DM9000A_s1,
                                clock_1_out_qualified_request_DM9000A_s1,
                                clock_1_out_read_data_valid_DM9000A_s1,
                                clock_1_out_requests_DM9000A_s1,
                                d1_DM9000A_s1_end_xfer
                             )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           DM9000A_s1_address;
  output           DM9000A_s1_chipselect_n;
  output           DM9000A_s1_irq_from_sa;
  output           DM9000A_s1_read_n;
  output  [ 15: 0] DM9000A_s1_readdata_from_sa;
  output           DM9000A_s1_reset_n;
  output           DM9000A_s1_wait_counter_eq_0;
  output           DM9000A_s1_write_n;
  output  [ 15: 0] DM9000A_s1_writedata;
  output           clock_1_out_granted_DM9000A_s1;
  output           clock_1_out_qualified_request_DM9000A_s1;
  output           clock_1_out_read_data_valid_DM9000A_s1;
  output           clock_1_out_requests_DM9000A_s1;
  output           d1_DM9000A_s1_end_xfer;
  input            DM9000A_s1_irq;
  input   [ 15: 0] DM9000A_s1_readdata;
  input            clk;
  input   [  1: 0] clock_1_out_address_to_slave;
  input            clock_1_out_nativeaddress;
  input            clock_1_out_read;
  input            clock_1_out_write;
  input   [ 15: 0] clock_1_out_writedata;
  input            reset_n;

  wire             DM9000A_s1_address;
  wire             DM9000A_s1_allgrants;
  wire             DM9000A_s1_allow_new_arb_cycle;
  wire             DM9000A_s1_any_bursting_master_saved_grant;
  wire             DM9000A_s1_any_continuerequest;
  wire             DM9000A_s1_arb_counter_enable;
  reg              DM9000A_s1_arb_share_counter;
  wire             DM9000A_s1_arb_share_counter_next_value;
  wire             DM9000A_s1_arb_share_set_values;
  wire             DM9000A_s1_beginbursttransfer_internal;
  wire             DM9000A_s1_begins_xfer;
  wire             DM9000A_s1_chipselect_n;
  wire    [  1: 0] DM9000A_s1_counter_load_value;
  wire             DM9000A_s1_end_xfer;
  wire             DM9000A_s1_firsttransfer;
  wire             DM9000A_s1_grant_vector;
  wire             DM9000A_s1_in_a_read_cycle;
  wire             DM9000A_s1_in_a_write_cycle;
  wire             DM9000A_s1_irq_from_sa;
  wire             DM9000A_s1_master_qreq_vector;
  wire             DM9000A_s1_non_bursting_master_requests;
  wire             DM9000A_s1_read_n;
  wire    [ 15: 0] DM9000A_s1_readdata_from_sa;
  reg              DM9000A_s1_reg_firsttransfer;
  wire             DM9000A_s1_reset_n;
  reg              DM9000A_s1_slavearbiterlockenable;
  wire             DM9000A_s1_slavearbiterlockenable2;
  wire             DM9000A_s1_unreg_firsttransfer;
  reg     [  1: 0] DM9000A_s1_wait_counter;
  wire             DM9000A_s1_wait_counter_eq_0;
  wire             DM9000A_s1_waits_for_read;
  wire             DM9000A_s1_waits_for_write;
  wire             DM9000A_s1_write_n;
  wire    [ 15: 0] DM9000A_s1_writedata;
  wire             clock_1_out_arbiterlock;
  wire             clock_1_out_arbiterlock2;
  wire             clock_1_out_continuerequest;
  wire             clock_1_out_granted_DM9000A_s1;
  wire             clock_1_out_qualified_request_DM9000A_s1;
  wire             clock_1_out_read_data_valid_DM9000A_s1;
  wire             clock_1_out_requests_DM9000A_s1;
  wire             clock_1_out_saved_grant_DM9000A_s1;
  reg              d1_DM9000A_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_DM9000A_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             wait_for_DM9000A_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~DM9000A_s1_end_xfer;
    end


  assign DM9000A_s1_begins_xfer = ~d1_reasons_to_wait & ((clock_1_out_qualified_request_DM9000A_s1));
  //assign DM9000A_s1_readdata_from_sa = DM9000A_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign DM9000A_s1_readdata_from_sa = DM9000A_s1_readdata;

  assign clock_1_out_requests_DM9000A_s1 = (1) & (clock_1_out_read | clock_1_out_write);
  //DM9000A_s1_arb_share_counter set values, which is an e_mux
  assign DM9000A_s1_arb_share_set_values = 1;

  //DM9000A_s1_non_bursting_master_requests mux, which is an e_mux
  assign DM9000A_s1_non_bursting_master_requests = clock_1_out_requests_DM9000A_s1;

  //DM9000A_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign DM9000A_s1_any_bursting_master_saved_grant = 0;

  //DM9000A_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign DM9000A_s1_arb_share_counter_next_value = DM9000A_s1_firsttransfer ? (DM9000A_s1_arb_share_set_values - 1) : |DM9000A_s1_arb_share_counter ? (DM9000A_s1_arb_share_counter - 1) : 0;

  //DM9000A_s1_allgrants all slave grants, which is an e_mux
  assign DM9000A_s1_allgrants = |DM9000A_s1_grant_vector;

  //DM9000A_s1_end_xfer assignment, which is an e_assign
  assign DM9000A_s1_end_xfer = ~(DM9000A_s1_waits_for_read | DM9000A_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_DM9000A_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_DM9000A_s1 = DM9000A_s1_end_xfer & (~DM9000A_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //DM9000A_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign DM9000A_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_DM9000A_s1 & DM9000A_s1_allgrants) | (end_xfer_arb_share_counter_term_DM9000A_s1 & ~DM9000A_s1_non_bursting_master_requests);

  //DM9000A_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DM9000A_s1_arb_share_counter <= 0;
      else if (DM9000A_s1_arb_counter_enable)
          DM9000A_s1_arb_share_counter <= DM9000A_s1_arb_share_counter_next_value;
    end


  //DM9000A_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DM9000A_s1_slavearbiterlockenable <= 0;
      else if ((|DM9000A_s1_master_qreq_vector & end_xfer_arb_share_counter_term_DM9000A_s1) | (end_xfer_arb_share_counter_term_DM9000A_s1 & ~DM9000A_s1_non_bursting_master_requests))
          DM9000A_s1_slavearbiterlockenable <= |DM9000A_s1_arb_share_counter_next_value;
    end


  //clock_1/out DM9000A/s1 arbiterlock, which is an e_assign
  assign clock_1_out_arbiterlock = DM9000A_s1_slavearbiterlockenable & clock_1_out_continuerequest;

  //DM9000A_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign DM9000A_s1_slavearbiterlockenable2 = |DM9000A_s1_arb_share_counter_next_value;

  //clock_1/out DM9000A/s1 arbiterlock2, which is an e_assign
  assign clock_1_out_arbiterlock2 = DM9000A_s1_slavearbiterlockenable2 & clock_1_out_continuerequest;

  //DM9000A_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign DM9000A_s1_any_continuerequest = 1;

  //clock_1_out_continuerequest continued request, which is an e_assign
  assign clock_1_out_continuerequest = 1;

  assign clock_1_out_qualified_request_DM9000A_s1 = clock_1_out_requests_DM9000A_s1;
  //DM9000A_s1_writedata mux, which is an e_mux
  assign DM9000A_s1_writedata = clock_1_out_writedata;

  //master is always granted when requested
  assign clock_1_out_granted_DM9000A_s1 = clock_1_out_qualified_request_DM9000A_s1;

  //clock_1/out saved-grant DM9000A/s1, which is an e_assign
  assign clock_1_out_saved_grant_DM9000A_s1 = clock_1_out_requests_DM9000A_s1;

  //allow new arb cycle for DM9000A/s1, which is an e_assign
  assign DM9000A_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign DM9000A_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign DM9000A_s1_master_qreq_vector = 1;

  //DM9000A_s1_reset_n assignment, which is an e_assign
  assign DM9000A_s1_reset_n = reset_n;

  assign DM9000A_s1_chipselect_n = ~clock_1_out_granted_DM9000A_s1;
  //DM9000A_s1_firsttransfer first transaction, which is an e_assign
  assign DM9000A_s1_firsttransfer = DM9000A_s1_begins_xfer ? DM9000A_s1_unreg_firsttransfer : DM9000A_s1_reg_firsttransfer;

  //DM9000A_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign DM9000A_s1_unreg_firsttransfer = ~(DM9000A_s1_slavearbiterlockenable & DM9000A_s1_any_continuerequest);

  //DM9000A_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DM9000A_s1_reg_firsttransfer <= 1'b1;
      else if (DM9000A_s1_begins_xfer)
          DM9000A_s1_reg_firsttransfer <= DM9000A_s1_unreg_firsttransfer;
    end


  //DM9000A_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign DM9000A_s1_beginbursttransfer_internal = DM9000A_s1_begins_xfer;

  //~DM9000A_s1_read_n assignment, which is an e_mux
  assign DM9000A_s1_read_n = ~(((clock_1_out_granted_DM9000A_s1 & clock_1_out_read))& ~DM9000A_s1_begins_xfer);

  //~DM9000A_s1_write_n assignment, which is an e_mux
  assign DM9000A_s1_write_n = ~(((clock_1_out_granted_DM9000A_s1 & clock_1_out_write)) & ~DM9000A_s1_begins_xfer & (DM9000A_s1_wait_counter >= 1));

  //DM9000A_s1_address mux, which is an e_mux
  assign DM9000A_s1_address = clock_1_out_nativeaddress;

  //d1_DM9000A_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_DM9000A_s1_end_xfer <= 1;
      else if (1)
          d1_DM9000A_s1_end_xfer <= DM9000A_s1_end_xfer;
    end


  //DM9000A_s1_waits_for_read in a cycle, which is an e_mux
  assign DM9000A_s1_waits_for_read = DM9000A_s1_in_a_read_cycle & wait_for_DM9000A_s1_counter;

  //DM9000A_s1_in_a_read_cycle assignment, which is an e_assign
  assign DM9000A_s1_in_a_read_cycle = clock_1_out_granted_DM9000A_s1 & clock_1_out_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = DM9000A_s1_in_a_read_cycle;

  //DM9000A_s1_waits_for_write in a cycle, which is an e_mux
  assign DM9000A_s1_waits_for_write = DM9000A_s1_in_a_write_cycle & wait_for_DM9000A_s1_counter;

  //DM9000A_s1_in_a_write_cycle assignment, which is an e_assign
  assign DM9000A_s1_in_a_write_cycle = clock_1_out_granted_DM9000A_s1 & clock_1_out_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = DM9000A_s1_in_a_write_cycle;

  assign DM9000A_s1_wait_counter_eq_0 = DM9000A_s1_wait_counter == 0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          DM9000A_s1_wait_counter <= 0;
      else if (1)
          DM9000A_s1_wait_counter <= DM9000A_s1_counter_load_value;
    end


  assign DM9000A_s1_counter_load_value = ((DM9000A_s1_in_a_write_cycle & DM9000A_s1_begins_xfer))? 2 :
    ((DM9000A_s1_in_a_read_cycle & DM9000A_s1_begins_xfer))? 1 :
    (~DM9000A_s1_wait_counter_eq_0)? DM9000A_s1_wait_counter - 1 :
    0;

  assign wait_for_DM9000A_s1_counter = DM9000A_s1_begins_xfer | ~DM9000A_s1_wait_counter_eq_0;
  //assign DM9000A_s1_irq_from_sa = DM9000A_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign DM9000A_s1_irq_from_sa = DM9000A_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //DM9000A/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module ISP1362_dc_arbitrator (
                               // inputs:
                                ISP1362_dc_irq_n,
                                ISP1362_dc_readdata,
                                clk,
                                cpu_data_master_address_to_slave,
                                cpu_data_master_latency_counter,
                                cpu_data_master_read,
                                cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                cpu_data_master_write,
                                cpu_data_master_writedata,
                                reset_n,

                               // outputs:
                                ISP1362_dc_address,
                                ISP1362_dc_chipselect_n,
                                ISP1362_dc_irq_n_from_sa,
                                ISP1362_dc_read_n,
                                ISP1362_dc_readdata_from_sa,
                                ISP1362_dc_reset_n,
                                ISP1362_dc_wait_counter_eq_0,
                                ISP1362_dc_write_n,
                                ISP1362_dc_writedata,
                                cpu_data_master_granted_ISP1362_dc,
                                cpu_data_master_qualified_request_ISP1362_dc,
                                cpu_data_master_read_data_valid_ISP1362_dc,
                                cpu_data_master_requests_ISP1362_dc,
                                d1_ISP1362_dc_end_xfer
                             )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           ISP1362_dc_address;
  output           ISP1362_dc_chipselect_n;
  output           ISP1362_dc_irq_n_from_sa;
  output           ISP1362_dc_read_n;
  output  [ 15: 0] ISP1362_dc_readdata_from_sa;
  output           ISP1362_dc_reset_n;
  output           ISP1362_dc_wait_counter_eq_0;
  output           ISP1362_dc_write_n;
  output  [ 15: 0] ISP1362_dc_writedata;
  output           cpu_data_master_granted_ISP1362_dc;
  output           cpu_data_master_qualified_request_ISP1362_dc;
  output           cpu_data_master_read_data_valid_ISP1362_dc;
  output           cpu_data_master_requests_ISP1362_dc;
  output           d1_ISP1362_dc_end_xfer;
  input            ISP1362_dc_irq_n;
  input   [ 15: 0] ISP1362_dc_readdata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire             ISP1362_dc_address;
  wire             ISP1362_dc_allgrants;
  wire             ISP1362_dc_allow_new_arb_cycle;
  wire             ISP1362_dc_any_bursting_master_saved_grant;
  wire             ISP1362_dc_any_continuerequest;
  wire             ISP1362_dc_arb_counter_enable;
  reg     [  1: 0] ISP1362_dc_arb_share_counter;
  wire    [  1: 0] ISP1362_dc_arb_share_counter_next_value;
  wire    [  1: 0] ISP1362_dc_arb_share_set_values;
  wire             ISP1362_dc_beginbursttransfer_internal;
  wire             ISP1362_dc_begins_xfer;
  wire             ISP1362_dc_chipselect_n;
  wire    [  4: 0] ISP1362_dc_counter_load_value;
  wire             ISP1362_dc_end_xfer;
  wire             ISP1362_dc_firsttransfer;
  wire             ISP1362_dc_grant_vector;
  wire             ISP1362_dc_in_a_read_cycle;
  wire             ISP1362_dc_in_a_write_cycle;
  wire             ISP1362_dc_irq_n_from_sa;
  wire             ISP1362_dc_master_qreq_vector;
  wire             ISP1362_dc_non_bursting_master_requests;
  wire             ISP1362_dc_read_n;
  wire    [ 15: 0] ISP1362_dc_readdata_from_sa;
  reg              ISP1362_dc_reg_firsttransfer;
  wire             ISP1362_dc_reset_n;
  reg              ISP1362_dc_slavearbiterlockenable;
  wire             ISP1362_dc_slavearbiterlockenable2;
  wire             ISP1362_dc_unreg_firsttransfer;
  reg     [  4: 0] ISP1362_dc_wait_counter;
  wire             ISP1362_dc_wait_counter_eq_0;
  wire             ISP1362_dc_waits_for_read;
  wire             ISP1362_dc_waits_for_write;
  wire             ISP1362_dc_write_n;
  wire    [ 15: 0] ISP1362_dc_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_ISP1362_dc;
  wire             cpu_data_master_qualified_request_ISP1362_dc;
  wire             cpu_data_master_read_data_valid_ISP1362_dc;
  wire             cpu_data_master_requests_ISP1362_dc;
  wire             cpu_data_master_saved_grant_ISP1362_dc;
  reg              d1_ISP1362_dc_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_ISP1362_dc;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_ISP1362_dc_from_cpu_data_master;
  wire             wait_for_ISP1362_dc_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~ISP1362_dc_end_xfer;
    end


  assign ISP1362_dc_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_ISP1362_dc));
  //assign ISP1362_dc_readdata_from_sa = ISP1362_dc_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign ISP1362_dc_readdata_from_sa = ISP1362_dc_readdata;

  assign cpu_data_master_requests_ISP1362_dc = ({cpu_data_master_address_to_slave[27 : 3] , 3'b0} == 28'h96411e0) & (cpu_data_master_read | cpu_data_master_write);
  //ISP1362_dc_arb_share_counter set values, which is an e_mux
  assign ISP1362_dc_arb_share_set_values = 1;

  //ISP1362_dc_non_bursting_master_requests mux, which is an e_mux
  assign ISP1362_dc_non_bursting_master_requests = cpu_data_master_requests_ISP1362_dc;

  //ISP1362_dc_any_bursting_master_saved_grant mux, which is an e_mux
  assign ISP1362_dc_any_bursting_master_saved_grant = 0;

  //ISP1362_dc_arb_share_counter_next_value assignment, which is an e_assign
  assign ISP1362_dc_arb_share_counter_next_value = ISP1362_dc_firsttransfer ? (ISP1362_dc_arb_share_set_values - 1) : |ISP1362_dc_arb_share_counter ? (ISP1362_dc_arb_share_counter - 1) : 0;

  //ISP1362_dc_allgrants all slave grants, which is an e_mux
  assign ISP1362_dc_allgrants = |ISP1362_dc_grant_vector;

  //ISP1362_dc_end_xfer assignment, which is an e_assign
  assign ISP1362_dc_end_xfer = ~(ISP1362_dc_waits_for_read | ISP1362_dc_waits_for_write);

  //end_xfer_arb_share_counter_term_ISP1362_dc arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_ISP1362_dc = ISP1362_dc_end_xfer & (~ISP1362_dc_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //ISP1362_dc_arb_share_counter arbitration counter enable, which is an e_assign
  assign ISP1362_dc_arb_counter_enable = (end_xfer_arb_share_counter_term_ISP1362_dc & ISP1362_dc_allgrants) | (end_xfer_arb_share_counter_term_ISP1362_dc & ~ISP1362_dc_non_bursting_master_requests);

  //ISP1362_dc_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          ISP1362_dc_arb_share_counter <= 0;
      else if (ISP1362_dc_arb_counter_enable)
          ISP1362_dc_arb_share_counter <= ISP1362_dc_arb_share_counter_next_value;
    end


  //ISP1362_dc_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          ISP1362_dc_slavearbiterlockenable <= 0;
      else if ((|ISP1362_dc_master_qreq_vector & end_xfer_arb_share_counter_term_ISP1362_dc) | (end_xfer_arb_share_counter_term_ISP1362_dc & ~ISP1362_dc_non_bursting_master_requests))
          ISP1362_dc_slavearbiterlockenable <= |ISP1362_dc_arb_share_counter_next_value;
    end


  //cpu/data_master ISP1362/dc arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = ISP1362_dc_slavearbiterlockenable & cpu_data_master_continuerequest;

  //ISP1362_dc_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign ISP1362_dc_slavearbiterlockenable2 = |ISP1362_dc_arb_share_counter_next_value;

  //cpu/data_master ISP1362/dc arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = ISP1362_dc_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //ISP1362_dc_any_continuerequest at least one master continues requesting, which is an e_assign
  assign ISP1362_dc_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_ISP1362_dc = cpu_data_master_requests_ISP1362_dc & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_ISP1362_dc, which is an e_mux
  assign cpu_data_master_read_data_valid_ISP1362_dc = cpu_data_master_granted_ISP1362_dc & cpu_data_master_read & ~ISP1362_dc_waits_for_read;

  //ISP1362_dc_writedata mux, which is an e_mux
  assign ISP1362_dc_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_ISP1362_dc = cpu_data_master_qualified_request_ISP1362_dc;

  //cpu/data_master saved-grant ISP1362/dc, which is an e_assign
  assign cpu_data_master_saved_grant_ISP1362_dc = cpu_data_master_requests_ISP1362_dc;

  //allow new arb cycle for ISP1362/dc, which is an e_assign
  assign ISP1362_dc_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign ISP1362_dc_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign ISP1362_dc_master_qreq_vector = 1;

  //ISP1362_dc_reset_n assignment, which is an e_assign
  assign ISP1362_dc_reset_n = reset_n;

  assign ISP1362_dc_chipselect_n = ~cpu_data_master_granted_ISP1362_dc;
  //ISP1362_dc_firsttransfer first transaction, which is an e_assign
  assign ISP1362_dc_firsttransfer = ISP1362_dc_begins_xfer ? ISP1362_dc_unreg_firsttransfer : ISP1362_dc_reg_firsttransfer;

  //ISP1362_dc_unreg_firsttransfer first transaction, which is an e_assign
  assign ISP1362_dc_unreg_firsttransfer = ~(ISP1362_dc_slavearbiterlockenable & ISP1362_dc_any_continuerequest);

  //ISP1362_dc_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          ISP1362_dc_reg_firsttransfer <= 1'b1;
      else if (ISP1362_dc_begins_xfer)
          ISP1362_dc_reg_firsttransfer <= ISP1362_dc_unreg_firsttransfer;
    end


  //ISP1362_dc_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign ISP1362_dc_beginbursttransfer_internal = ISP1362_dc_begins_xfer;

  //~ISP1362_dc_read_n assignment, which is an e_mux
  assign ISP1362_dc_read_n = ~(((cpu_data_master_granted_ISP1362_dc & cpu_data_master_read))& ~ISP1362_dc_begins_xfer & (ISP1362_dc_wait_counter < 8));

  //~ISP1362_dc_write_n assignment, which is an e_mux
  assign ISP1362_dc_write_n = ~(((cpu_data_master_granted_ISP1362_dc & cpu_data_master_write)) & ~ISP1362_dc_begins_xfer & (ISP1362_dc_wait_counter >= 8) & (ISP1362_dc_wait_counter < 16));

  assign shifted_address_to_ISP1362_dc_from_cpu_data_master = cpu_data_master_address_to_slave;
  //ISP1362_dc_address mux, which is an e_mux
  assign ISP1362_dc_address = shifted_address_to_ISP1362_dc_from_cpu_data_master >> 2;

  //d1_ISP1362_dc_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_ISP1362_dc_end_xfer <= 1;
      else if (1)
          d1_ISP1362_dc_end_xfer <= ISP1362_dc_end_xfer;
    end


  //ISP1362_dc_waits_for_read in a cycle, which is an e_mux
  assign ISP1362_dc_waits_for_read = ISP1362_dc_in_a_read_cycle & wait_for_ISP1362_dc_counter;

  //ISP1362_dc_in_a_read_cycle assignment, which is an e_assign
  assign ISP1362_dc_in_a_read_cycle = cpu_data_master_granted_ISP1362_dc & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = ISP1362_dc_in_a_read_cycle;

  //ISP1362_dc_waits_for_write in a cycle, which is an e_mux
  assign ISP1362_dc_waits_for_write = ISP1362_dc_in_a_write_cycle & wait_for_ISP1362_dc_counter;

  //ISP1362_dc_in_a_write_cycle assignment, which is an e_assign
  assign ISP1362_dc_in_a_write_cycle = cpu_data_master_granted_ISP1362_dc & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = ISP1362_dc_in_a_write_cycle;

  assign ISP1362_dc_wait_counter_eq_0 = ISP1362_dc_wait_counter == 0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          ISP1362_dc_wait_counter <= 0;
      else if (1)
          ISP1362_dc_wait_counter <= ISP1362_dc_counter_load_value;
    end


  assign ISP1362_dc_counter_load_value = ((ISP1362_dc_in_a_write_cycle & ISP1362_dc_begins_xfer))? 22 :
    ((ISP1362_dc_in_a_read_cycle & ISP1362_dc_begins_xfer))? 14 :
    (~ISP1362_dc_wait_counter_eq_0)? ISP1362_dc_wait_counter - 1 :
    0;

  assign wait_for_ISP1362_dc_counter = ISP1362_dc_begins_xfer | ~ISP1362_dc_wait_counter_eq_0;
  //assign ISP1362_dc_irq_n_from_sa = ISP1362_dc_irq_n so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign ISP1362_dc_irq_n_from_sa = ISP1362_dc_irq_n;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //ISP1362/dc enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module ISP1362_hc_arbitrator (
                               // inputs:
                                ISP1362_hc_irq_n,
                                ISP1362_hc_readdata,
                                clk,
                                cpu_data_master_address_to_slave,
                                cpu_data_master_latency_counter,
                                cpu_data_master_read,
                                cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                cpu_data_master_write,
                                cpu_data_master_writedata,
                                reset_n,

                               // outputs:
                                ISP1362_hc_address,
                                ISP1362_hc_chipselect_n,
                                ISP1362_hc_irq_n_from_sa,
                                ISP1362_hc_read_n,
                                ISP1362_hc_readdata_from_sa,
                                ISP1362_hc_reset_n,
                                ISP1362_hc_wait_counter_eq_0,
                                ISP1362_hc_write_n,
                                ISP1362_hc_writedata,
                                cpu_data_master_granted_ISP1362_hc,
                                cpu_data_master_qualified_request_ISP1362_hc,
                                cpu_data_master_read_data_valid_ISP1362_hc,
                                cpu_data_master_requests_ISP1362_hc,
                                d1_ISP1362_hc_end_xfer
                             )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           ISP1362_hc_address;
  output           ISP1362_hc_chipselect_n;
  output           ISP1362_hc_irq_n_from_sa;
  output           ISP1362_hc_read_n;
  output  [ 15: 0] ISP1362_hc_readdata_from_sa;
  output           ISP1362_hc_reset_n;
  output           ISP1362_hc_wait_counter_eq_0;
  output           ISP1362_hc_write_n;
  output  [ 15: 0] ISP1362_hc_writedata;
  output           cpu_data_master_granted_ISP1362_hc;
  output           cpu_data_master_qualified_request_ISP1362_hc;
  output           cpu_data_master_read_data_valid_ISP1362_hc;
  output           cpu_data_master_requests_ISP1362_hc;
  output           d1_ISP1362_hc_end_xfer;
  input            ISP1362_hc_irq_n;
  input   [ 15: 0] ISP1362_hc_readdata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire             ISP1362_hc_address;
  wire             ISP1362_hc_allgrants;
  wire             ISP1362_hc_allow_new_arb_cycle;
  wire             ISP1362_hc_any_bursting_master_saved_grant;
  wire             ISP1362_hc_any_continuerequest;
  wire             ISP1362_hc_arb_counter_enable;
  reg     [  1: 0] ISP1362_hc_arb_share_counter;
  wire    [  1: 0] ISP1362_hc_arb_share_counter_next_value;
  wire    [  1: 0] ISP1362_hc_arb_share_set_values;
  wire             ISP1362_hc_beginbursttransfer_internal;
  wire             ISP1362_hc_begins_xfer;
  wire             ISP1362_hc_chipselect_n;
  wire    [  3: 0] ISP1362_hc_counter_load_value;
  wire             ISP1362_hc_end_xfer;
  wire             ISP1362_hc_firsttransfer;
  wire             ISP1362_hc_grant_vector;
  wire             ISP1362_hc_in_a_read_cycle;
  wire             ISP1362_hc_in_a_write_cycle;
  wire             ISP1362_hc_irq_n_from_sa;
  wire             ISP1362_hc_master_qreq_vector;
  wire             ISP1362_hc_non_bursting_master_requests;
  wire             ISP1362_hc_read_n;
  wire    [ 15: 0] ISP1362_hc_readdata_from_sa;
  reg              ISP1362_hc_reg_firsttransfer;
  wire             ISP1362_hc_reset_n;
  reg              ISP1362_hc_slavearbiterlockenable;
  wire             ISP1362_hc_slavearbiterlockenable2;
  wire             ISP1362_hc_unreg_firsttransfer;
  reg     [  3: 0] ISP1362_hc_wait_counter;
  wire             ISP1362_hc_wait_counter_eq_0;
  wire             ISP1362_hc_waits_for_read;
  wire             ISP1362_hc_waits_for_write;
  wire             ISP1362_hc_write_n;
  wire    [ 15: 0] ISP1362_hc_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_ISP1362_hc;
  wire             cpu_data_master_qualified_request_ISP1362_hc;
  wire             cpu_data_master_read_data_valid_ISP1362_hc;
  wire             cpu_data_master_requests_ISP1362_hc;
  wire             cpu_data_master_saved_grant_ISP1362_hc;
  reg              d1_ISP1362_hc_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_ISP1362_hc;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_ISP1362_hc_from_cpu_data_master;
  wire             wait_for_ISP1362_hc_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~ISP1362_hc_end_xfer;
    end


  assign ISP1362_hc_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_ISP1362_hc));
  //assign ISP1362_hc_readdata_from_sa = ISP1362_hc_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign ISP1362_hc_readdata_from_sa = ISP1362_hc_readdata;

  assign cpu_data_master_requests_ISP1362_hc = ({cpu_data_master_address_to_slave[27 : 3] , 3'b0} == 28'h96411d8) & (cpu_data_master_read | cpu_data_master_write);
  //ISP1362_hc_arb_share_counter set values, which is an e_mux
  assign ISP1362_hc_arb_share_set_values = 1;

  //ISP1362_hc_non_bursting_master_requests mux, which is an e_mux
  assign ISP1362_hc_non_bursting_master_requests = cpu_data_master_requests_ISP1362_hc;

  //ISP1362_hc_any_bursting_master_saved_grant mux, which is an e_mux
  assign ISP1362_hc_any_bursting_master_saved_grant = 0;

  //ISP1362_hc_arb_share_counter_next_value assignment, which is an e_assign
  assign ISP1362_hc_arb_share_counter_next_value = ISP1362_hc_firsttransfer ? (ISP1362_hc_arb_share_set_values - 1) : |ISP1362_hc_arb_share_counter ? (ISP1362_hc_arb_share_counter - 1) : 0;

  //ISP1362_hc_allgrants all slave grants, which is an e_mux
  assign ISP1362_hc_allgrants = |ISP1362_hc_grant_vector;

  //ISP1362_hc_end_xfer assignment, which is an e_assign
  assign ISP1362_hc_end_xfer = ~(ISP1362_hc_waits_for_read | ISP1362_hc_waits_for_write);

  //end_xfer_arb_share_counter_term_ISP1362_hc arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_ISP1362_hc = ISP1362_hc_end_xfer & (~ISP1362_hc_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //ISP1362_hc_arb_share_counter arbitration counter enable, which is an e_assign
  assign ISP1362_hc_arb_counter_enable = (end_xfer_arb_share_counter_term_ISP1362_hc & ISP1362_hc_allgrants) | (end_xfer_arb_share_counter_term_ISP1362_hc & ~ISP1362_hc_non_bursting_master_requests);

  //ISP1362_hc_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          ISP1362_hc_arb_share_counter <= 0;
      else if (ISP1362_hc_arb_counter_enable)
          ISP1362_hc_arb_share_counter <= ISP1362_hc_arb_share_counter_next_value;
    end


  //ISP1362_hc_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          ISP1362_hc_slavearbiterlockenable <= 0;
      else if ((|ISP1362_hc_master_qreq_vector & end_xfer_arb_share_counter_term_ISP1362_hc) | (end_xfer_arb_share_counter_term_ISP1362_hc & ~ISP1362_hc_non_bursting_master_requests))
          ISP1362_hc_slavearbiterlockenable <= |ISP1362_hc_arb_share_counter_next_value;
    end


  //cpu/data_master ISP1362/hc arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = ISP1362_hc_slavearbiterlockenable & cpu_data_master_continuerequest;

  //ISP1362_hc_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign ISP1362_hc_slavearbiterlockenable2 = |ISP1362_hc_arb_share_counter_next_value;

  //cpu/data_master ISP1362/hc arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = ISP1362_hc_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //ISP1362_hc_any_continuerequest at least one master continues requesting, which is an e_assign
  assign ISP1362_hc_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_ISP1362_hc = cpu_data_master_requests_ISP1362_hc & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_ISP1362_hc, which is an e_mux
  assign cpu_data_master_read_data_valid_ISP1362_hc = cpu_data_master_granted_ISP1362_hc & cpu_data_master_read & ~ISP1362_hc_waits_for_read;

  //ISP1362_hc_writedata mux, which is an e_mux
  assign ISP1362_hc_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_ISP1362_hc = cpu_data_master_qualified_request_ISP1362_hc;

  //cpu/data_master saved-grant ISP1362/hc, which is an e_assign
  assign cpu_data_master_saved_grant_ISP1362_hc = cpu_data_master_requests_ISP1362_hc;

  //allow new arb cycle for ISP1362/hc, which is an e_assign
  assign ISP1362_hc_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign ISP1362_hc_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign ISP1362_hc_master_qreq_vector = 1;

  //ISP1362_hc_reset_n assignment, which is an e_assign
  assign ISP1362_hc_reset_n = reset_n;

  assign ISP1362_hc_chipselect_n = ~cpu_data_master_granted_ISP1362_hc;
  //ISP1362_hc_firsttransfer first transaction, which is an e_assign
  assign ISP1362_hc_firsttransfer = ISP1362_hc_begins_xfer ? ISP1362_hc_unreg_firsttransfer : ISP1362_hc_reg_firsttransfer;

  //ISP1362_hc_unreg_firsttransfer first transaction, which is an e_assign
  assign ISP1362_hc_unreg_firsttransfer = ~(ISP1362_hc_slavearbiterlockenable & ISP1362_hc_any_continuerequest);

  //ISP1362_hc_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          ISP1362_hc_reg_firsttransfer <= 1'b1;
      else if (ISP1362_hc_begins_xfer)
          ISP1362_hc_reg_firsttransfer <= ISP1362_hc_unreg_firsttransfer;
    end


  //ISP1362_hc_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign ISP1362_hc_beginbursttransfer_internal = ISP1362_hc_begins_xfer;

  //~ISP1362_hc_read_n assignment, which is an e_mux
  assign ISP1362_hc_read_n = ~(((cpu_data_master_granted_ISP1362_hc & cpu_data_master_read))& ~ISP1362_hc_begins_xfer & (ISP1362_hc_wait_counter < 3));

  //~ISP1362_hc_write_n assignment, which is an e_mux
  assign ISP1362_hc_write_n = ~(((cpu_data_master_granted_ISP1362_hc & cpu_data_master_write)) & ~ISP1362_hc_begins_xfer & (ISP1362_hc_wait_counter >= 7) & (ISP1362_hc_wait_counter < 10));

  assign shifted_address_to_ISP1362_hc_from_cpu_data_master = cpu_data_master_address_to_slave;
  //ISP1362_hc_address mux, which is an e_mux
  assign ISP1362_hc_address = shifted_address_to_ISP1362_hc_from_cpu_data_master >> 2;

  //d1_ISP1362_hc_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_ISP1362_hc_end_xfer <= 1;
      else if (1)
          d1_ISP1362_hc_end_xfer <= ISP1362_hc_end_xfer;
    end


  //ISP1362_hc_waits_for_read in a cycle, which is an e_mux
  assign ISP1362_hc_waits_for_read = ISP1362_hc_in_a_read_cycle & wait_for_ISP1362_hc_counter;

  //ISP1362_hc_in_a_read_cycle assignment, which is an e_assign
  assign ISP1362_hc_in_a_read_cycle = cpu_data_master_granted_ISP1362_hc & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = ISP1362_hc_in_a_read_cycle;

  //ISP1362_hc_waits_for_write in a cycle, which is an e_mux
  assign ISP1362_hc_waits_for_write = ISP1362_hc_in_a_write_cycle & wait_for_ISP1362_hc_counter;

  //ISP1362_hc_in_a_write_cycle assignment, which is an e_assign
  assign ISP1362_hc_in_a_write_cycle = cpu_data_master_granted_ISP1362_hc & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = ISP1362_hc_in_a_write_cycle;

  assign ISP1362_hc_wait_counter_eq_0 = ISP1362_hc_wait_counter == 0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          ISP1362_hc_wait_counter <= 0;
      else if (1)
          ISP1362_hc_wait_counter <= ISP1362_hc_counter_load_value;
    end


  assign ISP1362_hc_counter_load_value = ((ISP1362_hc_in_a_read_cycle & ISP1362_hc_begins_xfer))? 8 :
    ((ISP1362_hc_in_a_write_cycle & ISP1362_hc_begins_xfer))? 15 :
    (~ISP1362_hc_wait_counter_eq_0)? ISP1362_hc_wait_counter - 1 :
    0;

  assign wait_for_ISP1362_hc_counter = ISP1362_hc_begins_xfer | ~ISP1362_hc_wait_counter_eq_0;
  //assign ISP1362_hc_irq_n_from_sa = ISP1362_hc_irq_n so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign ISP1362_hc_irq_n_from_sa = ISP1362_hc_irq_n;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //ISP1362/hc enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module SEG7_s1_arbitrator (
                            // inputs:
                             SEG7_s1_readdata,
                             clk,
                             cpu_data_master_address_to_slave,
                             cpu_data_master_byteenable,
                             cpu_data_master_latency_counter,
                             cpu_data_master_read,
                             cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                             cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                             cpu_data_master_write,
                             cpu_data_master_writedata,
                             reset_n,

                            // outputs:
                             SEG7_s1_address,
                             SEG7_s1_read,
                             SEG7_s1_readdata_from_sa,
                             SEG7_s1_reset,
                             SEG7_s1_write,
                             SEG7_s1_writedata,
                             cpu_data_master_granted_SEG7_s1,
                             cpu_data_master_qualified_request_SEG7_s1,
                             cpu_data_master_read_data_valid_SEG7_s1,
                             cpu_data_master_requests_SEG7_s1,
                             d1_SEG7_s1_end_xfer
                          )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output  [  2: 0] SEG7_s1_address;
  output           SEG7_s1_read;
  output  [  7: 0] SEG7_s1_readdata_from_sa;
  output           SEG7_s1_reset;
  output           SEG7_s1_write;
  output  [  7: 0] SEG7_s1_writedata;
  output           cpu_data_master_granted_SEG7_s1;
  output           cpu_data_master_qualified_request_SEG7_s1;
  output           cpu_data_master_read_data_valid_SEG7_s1;
  output           cpu_data_master_requests_SEG7_s1;
  output           d1_SEG7_s1_end_xfer;
  input   [  7: 0] SEG7_s1_readdata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  2: 0] SEG7_s1_address;
  wire             SEG7_s1_allgrants;
  wire             SEG7_s1_allow_new_arb_cycle;
  wire             SEG7_s1_any_bursting_master_saved_grant;
  wire             SEG7_s1_any_continuerequest;
  wire             SEG7_s1_arb_counter_enable;
  reg     [  1: 0] SEG7_s1_arb_share_counter;
  wire    [  1: 0] SEG7_s1_arb_share_counter_next_value;
  wire    [  1: 0] SEG7_s1_arb_share_set_values;
  wire             SEG7_s1_beginbursttransfer_internal;
  wire             SEG7_s1_begins_xfer;
  wire             SEG7_s1_end_xfer;
  wire             SEG7_s1_firsttransfer;
  wire             SEG7_s1_grant_vector;
  wire             SEG7_s1_in_a_read_cycle;
  wire             SEG7_s1_in_a_write_cycle;
  wire             SEG7_s1_master_qreq_vector;
  wire             SEG7_s1_non_bursting_master_requests;
  wire             SEG7_s1_pretend_byte_enable;
  wire             SEG7_s1_read;
  wire    [  7: 0] SEG7_s1_readdata_from_sa;
  reg              SEG7_s1_reg_firsttransfer;
  wire             SEG7_s1_reset;
  reg              SEG7_s1_slavearbiterlockenable;
  wire             SEG7_s1_slavearbiterlockenable2;
  wire             SEG7_s1_unreg_firsttransfer;
  wire             SEG7_s1_waits_for_read;
  wire             SEG7_s1_waits_for_write;
  wire             SEG7_s1_write;
  wire    [  7: 0] SEG7_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_SEG7_s1;
  wire             cpu_data_master_qualified_request_SEG7_s1;
  wire             cpu_data_master_read_data_valid_SEG7_s1;
  wire             cpu_data_master_requests_SEG7_s1;
  wire             cpu_data_master_saved_grant_SEG7_s1;
  reg              d1_SEG7_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_SEG7_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_SEG7_s1_from_cpu_data_master;
  wire             wait_for_SEG7_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~SEG7_s1_end_xfer;
    end


  assign SEG7_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_SEG7_s1));
  //assign SEG7_s1_readdata_from_sa = SEG7_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign SEG7_s1_readdata_from_sa = SEG7_s1_readdata;

  assign cpu_data_master_requests_SEG7_s1 = ({cpu_data_master_address_to_slave[27 : 5] , 5'b0} == 28'h9641100) & (cpu_data_master_read | cpu_data_master_write);
  //SEG7_s1_arb_share_counter set values, which is an e_mux
  assign SEG7_s1_arb_share_set_values = 1;

  //SEG7_s1_non_bursting_master_requests mux, which is an e_mux
  assign SEG7_s1_non_bursting_master_requests = cpu_data_master_requests_SEG7_s1;

  //SEG7_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign SEG7_s1_any_bursting_master_saved_grant = 0;

  //SEG7_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign SEG7_s1_arb_share_counter_next_value = SEG7_s1_firsttransfer ? (SEG7_s1_arb_share_set_values - 1) : |SEG7_s1_arb_share_counter ? (SEG7_s1_arb_share_counter - 1) : 0;

  //SEG7_s1_allgrants all slave grants, which is an e_mux
  assign SEG7_s1_allgrants = |SEG7_s1_grant_vector;

  //SEG7_s1_end_xfer assignment, which is an e_assign
  assign SEG7_s1_end_xfer = ~(SEG7_s1_waits_for_read | SEG7_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_SEG7_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_SEG7_s1 = SEG7_s1_end_xfer & (~SEG7_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //SEG7_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign SEG7_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_SEG7_s1 & SEG7_s1_allgrants) | (end_xfer_arb_share_counter_term_SEG7_s1 & ~SEG7_s1_non_bursting_master_requests);

  //SEG7_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          SEG7_s1_arb_share_counter <= 0;
      else if (SEG7_s1_arb_counter_enable)
          SEG7_s1_arb_share_counter <= SEG7_s1_arb_share_counter_next_value;
    end


  //SEG7_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          SEG7_s1_slavearbiterlockenable <= 0;
      else if ((|SEG7_s1_master_qreq_vector & end_xfer_arb_share_counter_term_SEG7_s1) | (end_xfer_arb_share_counter_term_SEG7_s1 & ~SEG7_s1_non_bursting_master_requests))
          SEG7_s1_slavearbiterlockenable <= |SEG7_s1_arb_share_counter_next_value;
    end


  //cpu/data_master SEG7/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = SEG7_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //SEG7_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign SEG7_s1_slavearbiterlockenable2 = |SEG7_s1_arb_share_counter_next_value;

  //cpu/data_master SEG7/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = SEG7_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //SEG7_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign SEG7_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_SEG7_s1 = cpu_data_master_requests_SEG7_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_SEG7_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_SEG7_s1 = cpu_data_master_granted_SEG7_s1 & cpu_data_master_read & ~SEG7_s1_waits_for_read;

  //SEG7_s1_writedata mux, which is an e_mux
  assign SEG7_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_SEG7_s1 = cpu_data_master_qualified_request_SEG7_s1;

  //cpu/data_master saved-grant SEG7/s1, which is an e_assign
  assign cpu_data_master_saved_grant_SEG7_s1 = cpu_data_master_requests_SEG7_s1;

  //allow new arb cycle for SEG7/s1, which is an e_assign
  assign SEG7_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign SEG7_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign SEG7_s1_master_qreq_vector = 1;

  //~SEG7_s1_reset assignment, which is an e_assign
  assign SEG7_s1_reset = ~reset_n;

  //SEG7_s1_firsttransfer first transaction, which is an e_assign
  assign SEG7_s1_firsttransfer = SEG7_s1_begins_xfer ? SEG7_s1_unreg_firsttransfer : SEG7_s1_reg_firsttransfer;

  //SEG7_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign SEG7_s1_unreg_firsttransfer = ~(SEG7_s1_slavearbiterlockenable & SEG7_s1_any_continuerequest);

  //SEG7_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          SEG7_s1_reg_firsttransfer <= 1'b1;
      else if (SEG7_s1_begins_xfer)
          SEG7_s1_reg_firsttransfer <= SEG7_s1_unreg_firsttransfer;
    end


  //SEG7_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign SEG7_s1_beginbursttransfer_internal = SEG7_s1_begins_xfer;

  //SEG7_s1_read assignment, which is an e_mux
  assign SEG7_s1_read = cpu_data_master_granted_SEG7_s1 & cpu_data_master_read;

  //SEG7_s1_write assignment, which is an e_mux
  assign SEG7_s1_write = ((cpu_data_master_granted_SEG7_s1 & cpu_data_master_write)) & SEG7_s1_pretend_byte_enable;

  assign shifted_address_to_SEG7_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //SEG7_s1_address mux, which is an e_mux
  assign SEG7_s1_address = shifted_address_to_SEG7_s1_from_cpu_data_master >> 2;

  //d1_SEG7_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_SEG7_s1_end_xfer <= 1;
      else if (1)
          d1_SEG7_s1_end_xfer <= SEG7_s1_end_xfer;
    end


  //SEG7_s1_waits_for_read in a cycle, which is an e_mux
  assign SEG7_s1_waits_for_read = SEG7_s1_in_a_read_cycle & 0;

  //SEG7_s1_in_a_read_cycle assignment, which is an e_assign
  assign SEG7_s1_in_a_read_cycle = cpu_data_master_granted_SEG7_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = SEG7_s1_in_a_read_cycle;

  //SEG7_s1_waits_for_write in a cycle, which is an e_mux
  assign SEG7_s1_waits_for_write = SEG7_s1_in_a_write_cycle & 0;

  //SEG7_s1_in_a_write_cycle assignment, which is an e_assign
  assign SEG7_s1_in_a_write_cycle = cpu_data_master_granted_SEG7_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = SEG7_s1_in_a_write_cycle;

  assign wait_for_SEG7_s1_counter = 0;
  //SEG7_s1_pretend_byte_enable byte enable port mux, which is an e_mux
  assign SEG7_s1_pretend_byte_enable = (cpu_data_master_granted_SEG7_s1)? cpu_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //SEG7/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module VGA_s1_arbitrator (
                           // inputs:
                            VGA_s1_readdata,
                            clk,
                            cpu_data_master_address_to_slave,
                            cpu_data_master_latency_counter,
                            cpu_data_master_read,
                            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                            cpu_data_master_write,
                            cpu_data_master_writedata,
                            reset_n,

                           // outputs:
                            VGA_s1_address,
                            VGA_s1_chipselect,
                            VGA_s1_read,
                            VGA_s1_readdata_from_sa,
                            VGA_s1_reset_n,
                            VGA_s1_write,
                            VGA_s1_writedata,
                            cpu_data_master_granted_VGA_s1,
                            cpu_data_master_qualified_request_VGA_s1,
                            cpu_data_master_read_data_valid_VGA_s1,
                            cpu_data_master_requests_VGA_s1,
                            d1_VGA_s1_end_xfer
                         )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output  [ 18: 0] VGA_s1_address;
  output           VGA_s1_chipselect;
  output           VGA_s1_read;
  output  [ 15: 0] VGA_s1_readdata_from_sa;
  output           VGA_s1_reset_n;
  output           VGA_s1_write;
  output  [ 15: 0] VGA_s1_writedata;
  output           cpu_data_master_granted_VGA_s1;
  output           cpu_data_master_qualified_request_VGA_s1;
  output           cpu_data_master_read_data_valid_VGA_s1;
  output           cpu_data_master_requests_VGA_s1;
  output           d1_VGA_s1_end_xfer;
  input   [ 15: 0] VGA_s1_readdata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [ 18: 0] VGA_s1_address;
  wire             VGA_s1_allgrants;
  wire             VGA_s1_allow_new_arb_cycle;
  wire             VGA_s1_any_bursting_master_saved_grant;
  wire             VGA_s1_any_continuerequest;
  wire             VGA_s1_arb_counter_enable;
  reg     [  1: 0] VGA_s1_arb_share_counter;
  wire    [  1: 0] VGA_s1_arb_share_counter_next_value;
  wire    [  1: 0] VGA_s1_arb_share_set_values;
  wire             VGA_s1_beginbursttransfer_internal;
  wire             VGA_s1_begins_xfer;
  wire             VGA_s1_chipselect;
  wire             VGA_s1_end_xfer;
  wire             VGA_s1_firsttransfer;
  wire             VGA_s1_grant_vector;
  wire             VGA_s1_in_a_read_cycle;
  wire             VGA_s1_in_a_write_cycle;
  wire             VGA_s1_master_qreq_vector;
  wire             VGA_s1_non_bursting_master_requests;
  wire             VGA_s1_read;
  wire    [ 15: 0] VGA_s1_readdata_from_sa;
  reg              VGA_s1_reg_firsttransfer;
  wire             VGA_s1_reset_n;
  reg              VGA_s1_slavearbiterlockenable;
  wire             VGA_s1_slavearbiterlockenable2;
  wire             VGA_s1_unreg_firsttransfer;
  wire             VGA_s1_waits_for_read;
  wire             VGA_s1_waits_for_write;
  wire             VGA_s1_write;
  wire    [ 15: 0] VGA_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_VGA_s1;
  wire             cpu_data_master_qualified_request_VGA_s1;
  wire             cpu_data_master_read_data_valid_VGA_s1;
  wire             cpu_data_master_requests_VGA_s1;
  wire             cpu_data_master_saved_grant_VGA_s1;
  reg              d1_VGA_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_VGA_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_VGA_s1_from_cpu_data_master;
  wire             wait_for_VGA_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~VGA_s1_end_xfer;
    end


  assign VGA_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_VGA_s1));
  //assign VGA_s1_readdata_from_sa = VGA_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign VGA_s1_readdata_from_sa = VGA_s1_readdata;

  assign cpu_data_master_requests_VGA_s1 = ({cpu_data_master_address_to_slave[27 : 21] , 21'b0} == 28'h9400000) & (cpu_data_master_read | cpu_data_master_write);
  //VGA_s1_arb_share_counter set values, which is an e_mux
  assign VGA_s1_arb_share_set_values = 1;

  //VGA_s1_non_bursting_master_requests mux, which is an e_mux
  assign VGA_s1_non_bursting_master_requests = cpu_data_master_requests_VGA_s1;

  //VGA_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign VGA_s1_any_bursting_master_saved_grant = 0;

  //VGA_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign VGA_s1_arb_share_counter_next_value = VGA_s1_firsttransfer ? (VGA_s1_arb_share_set_values - 1) : |VGA_s1_arb_share_counter ? (VGA_s1_arb_share_counter - 1) : 0;

  //VGA_s1_allgrants all slave grants, which is an e_mux
  assign VGA_s1_allgrants = |VGA_s1_grant_vector;

  //VGA_s1_end_xfer assignment, which is an e_assign
  assign VGA_s1_end_xfer = ~(VGA_s1_waits_for_read | VGA_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_VGA_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_VGA_s1 = VGA_s1_end_xfer & (~VGA_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //VGA_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign VGA_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_VGA_s1 & VGA_s1_allgrants) | (end_xfer_arb_share_counter_term_VGA_s1 & ~VGA_s1_non_bursting_master_requests);

  //VGA_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          VGA_s1_arb_share_counter <= 0;
      else if (VGA_s1_arb_counter_enable)
          VGA_s1_arb_share_counter <= VGA_s1_arb_share_counter_next_value;
    end


  //VGA_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          VGA_s1_slavearbiterlockenable <= 0;
      else if ((|VGA_s1_master_qreq_vector & end_xfer_arb_share_counter_term_VGA_s1) | (end_xfer_arb_share_counter_term_VGA_s1 & ~VGA_s1_non_bursting_master_requests))
          VGA_s1_slavearbiterlockenable <= |VGA_s1_arb_share_counter_next_value;
    end


  //cpu/data_master VGA/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = VGA_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //VGA_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign VGA_s1_slavearbiterlockenable2 = |VGA_s1_arb_share_counter_next_value;

  //cpu/data_master VGA/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = VGA_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //VGA_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign VGA_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_VGA_s1 = cpu_data_master_requests_VGA_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_VGA_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_VGA_s1 = cpu_data_master_granted_VGA_s1 & cpu_data_master_read & ~VGA_s1_waits_for_read;

  //VGA_s1_writedata mux, which is an e_mux
  assign VGA_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_VGA_s1 = cpu_data_master_qualified_request_VGA_s1;

  //cpu/data_master saved-grant VGA/s1, which is an e_assign
  assign cpu_data_master_saved_grant_VGA_s1 = cpu_data_master_requests_VGA_s1;

  //allow new arb cycle for VGA/s1, which is an e_assign
  assign VGA_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign VGA_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign VGA_s1_master_qreq_vector = 1;

  //VGA_s1_reset_n assignment, which is an e_assign
  assign VGA_s1_reset_n = reset_n;

  assign VGA_s1_chipselect = cpu_data_master_granted_VGA_s1;
  //VGA_s1_firsttransfer first transaction, which is an e_assign
  assign VGA_s1_firsttransfer = VGA_s1_begins_xfer ? VGA_s1_unreg_firsttransfer : VGA_s1_reg_firsttransfer;

  //VGA_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign VGA_s1_unreg_firsttransfer = ~(VGA_s1_slavearbiterlockenable & VGA_s1_any_continuerequest);

  //VGA_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          VGA_s1_reg_firsttransfer <= 1'b1;
      else if (VGA_s1_begins_xfer)
          VGA_s1_reg_firsttransfer <= VGA_s1_unreg_firsttransfer;
    end


  //VGA_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign VGA_s1_beginbursttransfer_internal = VGA_s1_begins_xfer;

  //VGA_s1_read assignment, which is an e_mux
  assign VGA_s1_read = cpu_data_master_granted_VGA_s1 & cpu_data_master_read;

  //VGA_s1_write assignment, which is an e_mux
  assign VGA_s1_write = cpu_data_master_granted_VGA_s1 & cpu_data_master_write;

  assign shifted_address_to_VGA_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //VGA_s1_address mux, which is an e_mux
  assign VGA_s1_address = shifted_address_to_VGA_s1_from_cpu_data_master >> 2;

  //d1_VGA_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_VGA_s1_end_xfer <= 1;
      else if (1)
          d1_VGA_s1_end_xfer <= VGA_s1_end_xfer;
    end


  //VGA_s1_waits_for_read in a cycle, which is an e_mux
  assign VGA_s1_waits_for_read = VGA_s1_in_a_read_cycle & 0;

  //VGA_s1_in_a_read_cycle assignment, which is an e_assign
  assign VGA_s1_in_a_read_cycle = cpu_data_master_granted_VGA_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = VGA_s1_in_a_read_cycle;

  //VGA_s1_waits_for_write in a cycle, which is an e_mux
  assign VGA_s1_waits_for_write = VGA_s1_in_a_write_cycle & 0;

  //VGA_s1_in_a_write_cycle assignment, which is an e_assign
  assign VGA_s1_in_a_write_cycle = cpu_data_master_granted_VGA_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = VGA_s1_in_a_write_cycle;

  assign wait_for_VGA_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //VGA/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module clock_0_in_arbitrator (
                               // inputs:
                                clk,
                                clock_0_in_endofpacket,
                                clock_0_in_readdata,
                                clock_0_in_waitrequest,
                                cpu_data_master_address_to_slave,
                                cpu_data_master_byteenable,
                                cpu_data_master_latency_counter,
                                cpu_data_master_read,
                                cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                cpu_data_master_write,
                                cpu_data_master_writedata,
                                reset_n,

                               // outputs:
                                clock_0_in_address,
                                clock_0_in_byteenable,
                                clock_0_in_endofpacket_from_sa,
                                clock_0_in_nativeaddress,
                                clock_0_in_read,
                                clock_0_in_readdata_from_sa,
                                clock_0_in_reset_n,
                                clock_0_in_waitrequest_from_sa,
                                clock_0_in_write,
                                clock_0_in_writedata,
                                cpu_data_master_granted_clock_0_in,
                                cpu_data_master_qualified_request_clock_0_in,
                                cpu_data_master_read_data_valid_clock_0_in,
                                cpu_data_master_requests_clock_0_in,
                                d1_clock_0_in_end_xfer
                             )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output  [  3: 0] clock_0_in_address;
  output  [  1: 0] clock_0_in_byteenable;
  output           clock_0_in_endofpacket_from_sa;
  output  [  2: 0] clock_0_in_nativeaddress;
  output           clock_0_in_read;
  output  [ 15: 0] clock_0_in_readdata_from_sa;
  output           clock_0_in_reset_n;
  output           clock_0_in_waitrequest_from_sa;
  output           clock_0_in_write;
  output  [ 15: 0] clock_0_in_writedata;
  output           cpu_data_master_granted_clock_0_in;
  output           cpu_data_master_qualified_request_clock_0_in;
  output           cpu_data_master_read_data_valid_clock_0_in;
  output           cpu_data_master_requests_clock_0_in;
  output           d1_clock_0_in_end_xfer;
  input            clk;
  input            clock_0_in_endofpacket;
  input   [ 15: 0] clock_0_in_readdata;
  input            clock_0_in_waitrequest;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  3: 0] clock_0_in_address;
  wire             clock_0_in_allgrants;
  wire             clock_0_in_allow_new_arb_cycle;
  wire             clock_0_in_any_bursting_master_saved_grant;
  wire             clock_0_in_any_continuerequest;
  wire             clock_0_in_arb_counter_enable;
  reg     [  1: 0] clock_0_in_arb_share_counter;
  wire    [  1: 0] clock_0_in_arb_share_counter_next_value;
  wire    [  1: 0] clock_0_in_arb_share_set_values;
  wire             clock_0_in_beginbursttransfer_internal;
  wire             clock_0_in_begins_xfer;
  wire    [  1: 0] clock_0_in_byteenable;
  wire             clock_0_in_end_xfer;
  wire             clock_0_in_endofpacket_from_sa;
  wire             clock_0_in_firsttransfer;
  wire             clock_0_in_grant_vector;
  wire             clock_0_in_in_a_read_cycle;
  wire             clock_0_in_in_a_write_cycle;
  wire             clock_0_in_master_qreq_vector;
  wire    [  2: 0] clock_0_in_nativeaddress;
  wire             clock_0_in_non_bursting_master_requests;
  wire             clock_0_in_read;
  wire    [ 15: 0] clock_0_in_readdata_from_sa;
  reg              clock_0_in_reg_firsttransfer;
  wire             clock_0_in_reset_n;
  reg              clock_0_in_slavearbiterlockenable;
  wire             clock_0_in_slavearbiterlockenable2;
  wire             clock_0_in_unreg_firsttransfer;
  wire             clock_0_in_waitrequest_from_sa;
  wire             clock_0_in_waits_for_read;
  wire             clock_0_in_waits_for_write;
  wire             clock_0_in_write;
  wire    [ 15: 0] clock_0_in_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_clock_0_in;
  wire             cpu_data_master_qualified_request_clock_0_in;
  wire             cpu_data_master_read_data_valid_clock_0_in;
  wire             cpu_data_master_requests_clock_0_in;
  wire             cpu_data_master_saved_grant_clock_0_in;
  reg              d1_clock_0_in_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_clock_0_in;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_clock_0_in_from_cpu_data_master;
  wire             wait_for_clock_0_in_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~clock_0_in_end_xfer;
    end


  assign clock_0_in_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_clock_0_in));
  //assign clock_0_in_readdata_from_sa = clock_0_in_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign clock_0_in_readdata_from_sa = clock_0_in_readdata;

  assign cpu_data_master_requests_clock_0_in = ({cpu_data_master_address_to_slave[27 : 5] , 5'b0} == 28'h96410e0) & (cpu_data_master_read | cpu_data_master_write);
  //assign clock_0_in_waitrequest_from_sa = clock_0_in_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign clock_0_in_waitrequest_from_sa = clock_0_in_waitrequest;

  //clock_0_in_arb_share_counter set values, which is an e_mux
  assign clock_0_in_arb_share_set_values = 1;

  //clock_0_in_non_bursting_master_requests mux, which is an e_mux
  assign clock_0_in_non_bursting_master_requests = cpu_data_master_requests_clock_0_in;

  //clock_0_in_any_bursting_master_saved_grant mux, which is an e_mux
  assign clock_0_in_any_bursting_master_saved_grant = 0;

  //clock_0_in_arb_share_counter_next_value assignment, which is an e_assign
  assign clock_0_in_arb_share_counter_next_value = clock_0_in_firsttransfer ? (clock_0_in_arb_share_set_values - 1) : |clock_0_in_arb_share_counter ? (clock_0_in_arb_share_counter - 1) : 0;

  //clock_0_in_allgrants all slave grants, which is an e_mux
  assign clock_0_in_allgrants = |clock_0_in_grant_vector;

  //clock_0_in_end_xfer assignment, which is an e_assign
  assign clock_0_in_end_xfer = ~(clock_0_in_waits_for_read | clock_0_in_waits_for_write);

  //end_xfer_arb_share_counter_term_clock_0_in arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_clock_0_in = clock_0_in_end_xfer & (~clock_0_in_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //clock_0_in_arb_share_counter arbitration counter enable, which is an e_assign
  assign clock_0_in_arb_counter_enable = (end_xfer_arb_share_counter_term_clock_0_in & clock_0_in_allgrants) | (end_xfer_arb_share_counter_term_clock_0_in & ~clock_0_in_non_bursting_master_requests);

  //clock_0_in_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_0_in_arb_share_counter <= 0;
      else if (clock_0_in_arb_counter_enable)
          clock_0_in_arb_share_counter <= clock_0_in_arb_share_counter_next_value;
    end


  //clock_0_in_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_0_in_slavearbiterlockenable <= 0;
      else if ((|clock_0_in_master_qreq_vector & end_xfer_arb_share_counter_term_clock_0_in) | (end_xfer_arb_share_counter_term_clock_0_in & ~clock_0_in_non_bursting_master_requests))
          clock_0_in_slavearbiterlockenable <= |clock_0_in_arb_share_counter_next_value;
    end


  //cpu/data_master clock_0/in arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = clock_0_in_slavearbiterlockenable & cpu_data_master_continuerequest;

  //clock_0_in_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign clock_0_in_slavearbiterlockenable2 = |clock_0_in_arb_share_counter_next_value;

  //cpu/data_master clock_0/in arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = clock_0_in_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //clock_0_in_any_continuerequest at least one master continues requesting, which is an e_assign
  assign clock_0_in_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_clock_0_in = cpu_data_master_requests_clock_0_in & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_clock_0_in, which is an e_mux
  assign cpu_data_master_read_data_valid_clock_0_in = cpu_data_master_granted_clock_0_in & cpu_data_master_read & ~clock_0_in_waits_for_read;

  //clock_0_in_writedata mux, which is an e_mux
  assign clock_0_in_writedata = cpu_data_master_writedata;

  //assign clock_0_in_endofpacket_from_sa = clock_0_in_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign clock_0_in_endofpacket_from_sa = clock_0_in_endofpacket;

  //master is always granted when requested
  assign cpu_data_master_granted_clock_0_in = cpu_data_master_qualified_request_clock_0_in;

  //cpu/data_master saved-grant clock_0/in, which is an e_assign
  assign cpu_data_master_saved_grant_clock_0_in = cpu_data_master_requests_clock_0_in;

  //allow new arb cycle for clock_0/in, which is an e_assign
  assign clock_0_in_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign clock_0_in_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign clock_0_in_master_qreq_vector = 1;

  //clock_0_in_reset_n assignment, which is an e_assign
  assign clock_0_in_reset_n = reset_n;

  //clock_0_in_firsttransfer first transaction, which is an e_assign
  assign clock_0_in_firsttransfer = clock_0_in_begins_xfer ? clock_0_in_unreg_firsttransfer : clock_0_in_reg_firsttransfer;

  //clock_0_in_unreg_firsttransfer first transaction, which is an e_assign
  assign clock_0_in_unreg_firsttransfer = ~(clock_0_in_slavearbiterlockenable & clock_0_in_any_continuerequest);

  //clock_0_in_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_0_in_reg_firsttransfer <= 1'b1;
      else if (clock_0_in_begins_xfer)
          clock_0_in_reg_firsttransfer <= clock_0_in_unreg_firsttransfer;
    end


  //clock_0_in_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign clock_0_in_beginbursttransfer_internal = clock_0_in_begins_xfer;

  //clock_0_in_read assignment, which is an e_mux
  assign clock_0_in_read = cpu_data_master_granted_clock_0_in & cpu_data_master_read;

  //clock_0_in_write assignment, which is an e_mux
  assign clock_0_in_write = cpu_data_master_granted_clock_0_in & cpu_data_master_write;

  assign shifted_address_to_clock_0_in_from_cpu_data_master = cpu_data_master_address_to_slave;
  //clock_0_in_address mux, which is an e_mux
  assign clock_0_in_address = shifted_address_to_clock_0_in_from_cpu_data_master >> 2;

  //slaveid clock_0_in_nativeaddress nativeaddress mux, which is an e_mux
  assign clock_0_in_nativeaddress = cpu_data_master_address_to_slave >> 2;

  //d1_clock_0_in_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_clock_0_in_end_xfer <= 1;
      else if (1)
          d1_clock_0_in_end_xfer <= clock_0_in_end_xfer;
    end


  //clock_0_in_waits_for_read in a cycle, which is an e_mux
  assign clock_0_in_waits_for_read = clock_0_in_in_a_read_cycle & clock_0_in_waitrequest_from_sa;

  //clock_0_in_in_a_read_cycle assignment, which is an e_assign
  assign clock_0_in_in_a_read_cycle = cpu_data_master_granted_clock_0_in & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = clock_0_in_in_a_read_cycle;

  //clock_0_in_waits_for_write in a cycle, which is an e_mux
  assign clock_0_in_waits_for_write = clock_0_in_in_a_write_cycle & clock_0_in_waitrequest_from_sa;

  //clock_0_in_in_a_write_cycle assignment, which is an e_assign
  assign clock_0_in_in_a_write_cycle = cpu_data_master_granted_clock_0_in & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = clock_0_in_in_a_write_cycle;

  assign wait_for_clock_0_in_counter = 0;
  //clock_0_in_byteenable byte enable port mux, which is an e_mux
  assign clock_0_in_byteenable = (cpu_data_master_granted_clock_0_in)? cpu_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //clock_0/in enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module clock_0_out_arbitrator (
                                // inputs:
                                 clk,
                                 clock_0_out_address,
                                 clock_0_out_granted_pll_s1,
                                 clock_0_out_qualified_request_pll_s1,
                                 clock_0_out_read,
                                 clock_0_out_read_data_valid_pll_s1,
                                 clock_0_out_requests_pll_s1,
                                 clock_0_out_write,
                                 clock_0_out_writedata,
                                 d1_pll_s1_end_xfer,
                                 pll_s1_readdata_from_sa,
                                 reset_n,

                                // outputs:
                                 clock_0_out_address_to_slave,
                                 clock_0_out_readdata,
                                 clock_0_out_reset_n,
                                 clock_0_out_waitrequest
                              )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output  [  3: 0] clock_0_out_address_to_slave;
  output  [ 15: 0] clock_0_out_readdata;
  output           clock_0_out_reset_n;
  output           clock_0_out_waitrequest;
  input            clk;
  input   [  3: 0] clock_0_out_address;
  input            clock_0_out_granted_pll_s1;
  input            clock_0_out_qualified_request_pll_s1;
  input            clock_0_out_read;
  input            clock_0_out_read_data_valid_pll_s1;
  input            clock_0_out_requests_pll_s1;
  input            clock_0_out_write;
  input   [ 15: 0] clock_0_out_writedata;
  input            d1_pll_s1_end_xfer;
  input   [ 15: 0] pll_s1_readdata_from_sa;
  input            reset_n;

  reg              active_and_waiting_last_time;
  reg     [  3: 0] clock_0_out_address_last_time;
  wire    [  3: 0] clock_0_out_address_to_slave;
  reg              clock_0_out_read_last_time;
  wire    [ 15: 0] clock_0_out_readdata;
  wire             clock_0_out_reset_n;
  wire             clock_0_out_run;
  wire             clock_0_out_waitrequest;
  reg              clock_0_out_write_last_time;
  reg     [ 15: 0] clock_0_out_writedata_last_time;
  wire             r_3;
  //r_3 master_run cascaded wait assignment, which is an e_assign
  assign r_3 = 1 & ((~clock_0_out_qualified_request_pll_s1 | ~clock_0_out_read | (1 & ~d1_pll_s1_end_xfer & clock_0_out_read))) & ((~clock_0_out_qualified_request_pll_s1 | ~clock_0_out_write | (1 & clock_0_out_write)));

  //cascaded wait assignment, which is an e_assign
  assign clock_0_out_run = r_3;

  //optimize select-logic by passing only those address bits which matter.
  assign clock_0_out_address_to_slave = clock_0_out_address;

  //clock_0/out readdata mux, which is an e_mux
  assign clock_0_out_readdata = pll_s1_readdata_from_sa;

  //actual waitrequest port, which is an e_assign
  assign clock_0_out_waitrequest = ~clock_0_out_run;

  //clock_0_out_reset_n assignment, which is an e_assign
  assign clock_0_out_reset_n = reset_n;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //clock_0_out_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_0_out_address_last_time <= 0;
      else if (1)
          clock_0_out_address_last_time <= clock_0_out_address;
    end


  //clock_0/out waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else if (1)
          active_and_waiting_last_time <= clock_0_out_waitrequest & (clock_0_out_read | clock_0_out_write);
    end


  //clock_0_out_address matches last port_name, which is an e_process
  always @(active_and_waiting_last_time or clock_0_out_address or clock_0_out_address_last_time)
    begin
      if (active_and_waiting_last_time & (clock_0_out_address != clock_0_out_address_last_time))
        begin
          $write("%0d ns: clock_0_out_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //clock_0_out_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_0_out_read_last_time <= 0;
      else if (1)
          clock_0_out_read_last_time <= clock_0_out_read;
    end


  //clock_0_out_read matches last port_name, which is an e_process
  always @(active_and_waiting_last_time or clock_0_out_read or clock_0_out_read_last_time)
    begin
      if (active_and_waiting_last_time & (clock_0_out_read != clock_0_out_read_last_time))
        begin
          $write("%0d ns: clock_0_out_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //clock_0_out_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_0_out_write_last_time <= 0;
      else if (1)
          clock_0_out_write_last_time <= clock_0_out_write;
    end


  //clock_0_out_write matches last port_name, which is an e_process
  always @(active_and_waiting_last_time or clock_0_out_write or clock_0_out_write_last_time)
    begin
      if (active_and_waiting_last_time & (clock_0_out_write != clock_0_out_write_last_time))
        begin
          $write("%0d ns: clock_0_out_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //clock_0_out_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_0_out_writedata_last_time <= 0;
      else if (1)
          clock_0_out_writedata_last_time <= clock_0_out_writedata;
    end


  //clock_0_out_writedata matches last port_name, which is an e_process
  always @(active_and_waiting_last_time or clock_0_out_write or clock_0_out_writedata or clock_0_out_writedata_last_time)
    begin
      if (active_and_waiting_last_time & (clock_0_out_writedata != clock_0_out_writedata_last_time) & clock_0_out_write)
        begin
          $write("%0d ns: clock_0_out_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module clock_1_in_arbitrator (
                               // inputs:
                                clk,
                                clock_1_in_endofpacket,
                                clock_1_in_readdata,
                                clock_1_in_waitrequest,
                                cpu_data_master_address_to_slave,
                                cpu_data_master_byteenable,
                                cpu_data_master_latency_counter,
                                cpu_data_master_read,
                                cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                cpu_data_master_write,
                                cpu_data_master_writedata,
                                reset_n,

                               // outputs:
                                clock_1_in_address,
                                clock_1_in_byteenable,
                                clock_1_in_endofpacket_from_sa,
                                clock_1_in_nativeaddress,
                                clock_1_in_read,
                                clock_1_in_readdata_from_sa,
                                clock_1_in_reset_n,
                                clock_1_in_waitrequest_from_sa,
                                clock_1_in_write,
                                clock_1_in_writedata,
                                cpu_data_master_granted_clock_1_in,
                                cpu_data_master_qualified_request_clock_1_in,
                                cpu_data_master_read_data_valid_clock_1_in,
                                cpu_data_master_requests_clock_1_in,
                                d1_clock_1_in_end_xfer
                             )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output  [  1: 0] clock_1_in_address;
  output  [  1: 0] clock_1_in_byteenable;
  output           clock_1_in_endofpacket_from_sa;
  output           clock_1_in_nativeaddress;
  output           clock_1_in_read;
  output  [ 15: 0] clock_1_in_readdata_from_sa;
  output           clock_1_in_reset_n;
  output           clock_1_in_waitrequest_from_sa;
  output           clock_1_in_write;
  output  [ 15: 0] clock_1_in_writedata;
  output           cpu_data_master_granted_clock_1_in;
  output           cpu_data_master_qualified_request_clock_1_in;
  output           cpu_data_master_read_data_valid_clock_1_in;
  output           cpu_data_master_requests_clock_1_in;
  output           d1_clock_1_in_end_xfer;
  input            clk;
  input            clock_1_in_endofpacket;
  input   [ 15: 0] clock_1_in_readdata;
  input            clock_1_in_waitrequest;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] clock_1_in_address;
  wire             clock_1_in_allgrants;
  wire             clock_1_in_allow_new_arb_cycle;
  wire             clock_1_in_any_bursting_master_saved_grant;
  wire             clock_1_in_any_continuerequest;
  wire             clock_1_in_arb_counter_enable;
  reg     [  1: 0] clock_1_in_arb_share_counter;
  wire    [  1: 0] clock_1_in_arb_share_counter_next_value;
  wire    [  1: 0] clock_1_in_arb_share_set_values;
  wire             clock_1_in_beginbursttransfer_internal;
  wire             clock_1_in_begins_xfer;
  wire    [  1: 0] clock_1_in_byteenable;
  wire             clock_1_in_end_xfer;
  wire             clock_1_in_endofpacket_from_sa;
  wire             clock_1_in_firsttransfer;
  wire             clock_1_in_grant_vector;
  wire             clock_1_in_in_a_read_cycle;
  wire             clock_1_in_in_a_write_cycle;
  wire             clock_1_in_master_qreq_vector;
  wire             clock_1_in_nativeaddress;
  wire             clock_1_in_non_bursting_master_requests;
  wire             clock_1_in_read;
  wire    [ 15: 0] clock_1_in_readdata_from_sa;
  reg              clock_1_in_reg_firsttransfer;
  wire             clock_1_in_reset_n;
  reg              clock_1_in_slavearbiterlockenable;
  wire             clock_1_in_slavearbiterlockenable2;
  wire             clock_1_in_unreg_firsttransfer;
  wire             clock_1_in_waitrequest_from_sa;
  wire             clock_1_in_waits_for_read;
  wire             clock_1_in_waits_for_write;
  wire             clock_1_in_write;
  wire    [ 15: 0] clock_1_in_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_clock_1_in;
  wire             cpu_data_master_qualified_request_clock_1_in;
  wire             cpu_data_master_read_data_valid_clock_1_in;
  wire             cpu_data_master_requests_clock_1_in;
  wire             cpu_data_master_saved_grant_clock_1_in;
  reg              d1_clock_1_in_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_clock_1_in;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_clock_1_in_from_cpu_data_master;
  wire             wait_for_clock_1_in_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~clock_1_in_end_xfer;
    end


  assign clock_1_in_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_clock_1_in));
  //assign clock_1_in_readdata_from_sa = clock_1_in_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign clock_1_in_readdata_from_sa = clock_1_in_readdata;

  assign cpu_data_master_requests_clock_1_in = ({cpu_data_master_address_to_slave[27 : 3] , 3'b0} == 28'h9641200) & (cpu_data_master_read | cpu_data_master_write);
  //assign clock_1_in_waitrequest_from_sa = clock_1_in_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign clock_1_in_waitrequest_from_sa = clock_1_in_waitrequest;

  //clock_1_in_arb_share_counter set values, which is an e_mux
  assign clock_1_in_arb_share_set_values = 1;

  //clock_1_in_non_bursting_master_requests mux, which is an e_mux
  assign clock_1_in_non_bursting_master_requests = cpu_data_master_requests_clock_1_in;

  //clock_1_in_any_bursting_master_saved_grant mux, which is an e_mux
  assign clock_1_in_any_bursting_master_saved_grant = 0;

  //clock_1_in_arb_share_counter_next_value assignment, which is an e_assign
  assign clock_1_in_arb_share_counter_next_value = clock_1_in_firsttransfer ? (clock_1_in_arb_share_set_values - 1) : |clock_1_in_arb_share_counter ? (clock_1_in_arb_share_counter - 1) : 0;

  //clock_1_in_allgrants all slave grants, which is an e_mux
  assign clock_1_in_allgrants = |clock_1_in_grant_vector;

  //clock_1_in_end_xfer assignment, which is an e_assign
  assign clock_1_in_end_xfer = ~(clock_1_in_waits_for_read | clock_1_in_waits_for_write);

  //end_xfer_arb_share_counter_term_clock_1_in arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_clock_1_in = clock_1_in_end_xfer & (~clock_1_in_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //clock_1_in_arb_share_counter arbitration counter enable, which is an e_assign
  assign clock_1_in_arb_counter_enable = (end_xfer_arb_share_counter_term_clock_1_in & clock_1_in_allgrants) | (end_xfer_arb_share_counter_term_clock_1_in & ~clock_1_in_non_bursting_master_requests);

  //clock_1_in_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_1_in_arb_share_counter <= 0;
      else if (clock_1_in_arb_counter_enable)
          clock_1_in_arb_share_counter <= clock_1_in_arb_share_counter_next_value;
    end


  //clock_1_in_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_1_in_slavearbiterlockenable <= 0;
      else if ((|clock_1_in_master_qreq_vector & end_xfer_arb_share_counter_term_clock_1_in) | (end_xfer_arb_share_counter_term_clock_1_in & ~clock_1_in_non_bursting_master_requests))
          clock_1_in_slavearbiterlockenable <= |clock_1_in_arb_share_counter_next_value;
    end


  //cpu/data_master clock_1/in arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = clock_1_in_slavearbiterlockenable & cpu_data_master_continuerequest;

  //clock_1_in_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign clock_1_in_slavearbiterlockenable2 = |clock_1_in_arb_share_counter_next_value;

  //cpu/data_master clock_1/in arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = clock_1_in_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //clock_1_in_any_continuerequest at least one master continues requesting, which is an e_assign
  assign clock_1_in_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_clock_1_in = cpu_data_master_requests_clock_1_in & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_clock_1_in, which is an e_mux
  assign cpu_data_master_read_data_valid_clock_1_in = cpu_data_master_granted_clock_1_in & cpu_data_master_read & ~clock_1_in_waits_for_read;

  //clock_1_in_writedata mux, which is an e_mux
  assign clock_1_in_writedata = cpu_data_master_writedata;

  //assign clock_1_in_endofpacket_from_sa = clock_1_in_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign clock_1_in_endofpacket_from_sa = clock_1_in_endofpacket;

  //master is always granted when requested
  assign cpu_data_master_granted_clock_1_in = cpu_data_master_qualified_request_clock_1_in;

  //cpu/data_master saved-grant clock_1/in, which is an e_assign
  assign cpu_data_master_saved_grant_clock_1_in = cpu_data_master_requests_clock_1_in;

  //allow new arb cycle for clock_1/in, which is an e_assign
  assign clock_1_in_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign clock_1_in_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign clock_1_in_master_qreq_vector = 1;

  //clock_1_in_reset_n assignment, which is an e_assign
  assign clock_1_in_reset_n = reset_n;

  //clock_1_in_firsttransfer first transaction, which is an e_assign
  assign clock_1_in_firsttransfer = clock_1_in_begins_xfer ? clock_1_in_unreg_firsttransfer : clock_1_in_reg_firsttransfer;

  //clock_1_in_unreg_firsttransfer first transaction, which is an e_assign
  assign clock_1_in_unreg_firsttransfer = ~(clock_1_in_slavearbiterlockenable & clock_1_in_any_continuerequest);

  //clock_1_in_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_1_in_reg_firsttransfer <= 1'b1;
      else if (clock_1_in_begins_xfer)
          clock_1_in_reg_firsttransfer <= clock_1_in_unreg_firsttransfer;
    end


  //clock_1_in_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign clock_1_in_beginbursttransfer_internal = clock_1_in_begins_xfer;

  //clock_1_in_read assignment, which is an e_mux
  assign clock_1_in_read = cpu_data_master_granted_clock_1_in & cpu_data_master_read;

  //clock_1_in_write assignment, which is an e_mux
  assign clock_1_in_write = cpu_data_master_granted_clock_1_in & cpu_data_master_write;

  assign shifted_address_to_clock_1_in_from_cpu_data_master = cpu_data_master_address_to_slave;
  //clock_1_in_address mux, which is an e_mux
  assign clock_1_in_address = shifted_address_to_clock_1_in_from_cpu_data_master >> 2;

  //slaveid clock_1_in_nativeaddress nativeaddress mux, which is an e_mux
  assign clock_1_in_nativeaddress = cpu_data_master_address_to_slave >> 2;

  //d1_clock_1_in_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_clock_1_in_end_xfer <= 1;
      else if (1)
          d1_clock_1_in_end_xfer <= clock_1_in_end_xfer;
    end


  //clock_1_in_waits_for_read in a cycle, which is an e_mux
  assign clock_1_in_waits_for_read = clock_1_in_in_a_read_cycle & clock_1_in_waitrequest_from_sa;

  //clock_1_in_in_a_read_cycle assignment, which is an e_assign
  assign clock_1_in_in_a_read_cycle = cpu_data_master_granted_clock_1_in & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = clock_1_in_in_a_read_cycle;

  //clock_1_in_waits_for_write in a cycle, which is an e_mux
  assign clock_1_in_waits_for_write = clock_1_in_in_a_write_cycle & clock_1_in_waitrequest_from_sa;

  //clock_1_in_in_a_write_cycle assignment, which is an e_assign
  assign clock_1_in_in_a_write_cycle = cpu_data_master_granted_clock_1_in & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = clock_1_in_in_a_write_cycle;

  assign wait_for_clock_1_in_counter = 0;
  //clock_1_in_byteenable byte enable port mux, which is an e_mux
  assign clock_1_in_byteenable = (cpu_data_master_granted_clock_1_in)? cpu_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //clock_1/in enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module clock_1_out_arbitrator (
                                // inputs:
                                 DM9000A_s1_readdata_from_sa,
                                 DM9000A_s1_wait_counter_eq_0,
                                 clk,
                                 clock_1_out_address,
                                 clock_1_out_granted_DM9000A_s1,
                                 clock_1_out_qualified_request_DM9000A_s1,
                                 clock_1_out_read,
                                 clock_1_out_read_data_valid_DM9000A_s1,
                                 clock_1_out_requests_DM9000A_s1,
                                 clock_1_out_write,
                                 clock_1_out_writedata,
                                 d1_DM9000A_s1_end_xfer,
                                 reset_n,

                                // outputs:
                                 clock_1_out_address_to_slave,
                                 clock_1_out_readdata,
                                 clock_1_out_reset_n,
                                 clock_1_out_waitrequest
                              )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output  [  1: 0] clock_1_out_address_to_slave;
  output  [ 15: 0] clock_1_out_readdata;
  output           clock_1_out_reset_n;
  output           clock_1_out_waitrequest;
  input   [ 15: 0] DM9000A_s1_readdata_from_sa;
  input            DM9000A_s1_wait_counter_eq_0;
  input            clk;
  input   [  1: 0] clock_1_out_address;
  input            clock_1_out_granted_DM9000A_s1;
  input            clock_1_out_qualified_request_DM9000A_s1;
  input            clock_1_out_read;
  input            clock_1_out_read_data_valid_DM9000A_s1;
  input            clock_1_out_requests_DM9000A_s1;
  input            clock_1_out_write;
  input   [ 15: 0] clock_1_out_writedata;
  input            d1_DM9000A_s1_end_xfer;
  input            reset_n;

  reg              active_and_waiting_last_time;
  reg     [  1: 0] clock_1_out_address_last_time;
  wire    [  1: 0] clock_1_out_address_to_slave;
  reg              clock_1_out_read_last_time;
  wire    [ 15: 0] clock_1_out_readdata;
  wire             clock_1_out_reset_n;
  wire             clock_1_out_run;
  wire             clock_1_out_waitrequest;
  reg              clock_1_out_write_last_time;
  reg     [ 15: 0] clock_1_out_writedata_last_time;
  wire             r_0;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & ((~clock_1_out_qualified_request_DM9000A_s1 | ~clock_1_out_read | (1 & ((DM9000A_s1_wait_counter_eq_0 & ~d1_DM9000A_s1_end_xfer)) & clock_1_out_read))) & ((~clock_1_out_qualified_request_DM9000A_s1 | ~clock_1_out_write | (1 & ((DM9000A_s1_wait_counter_eq_0 & ~d1_DM9000A_s1_end_xfer)) & clock_1_out_write)));

  //cascaded wait assignment, which is an e_assign
  assign clock_1_out_run = r_0;

  //optimize select-logic by passing only those address bits which matter.
  assign clock_1_out_address_to_slave = clock_1_out_address;

  //clock_1/out readdata mux, which is an e_mux
  assign clock_1_out_readdata = DM9000A_s1_readdata_from_sa;

  //actual waitrequest port, which is an e_assign
  assign clock_1_out_waitrequest = ~clock_1_out_run;

  //clock_1_out_reset_n assignment, which is an e_assign
  assign clock_1_out_reset_n = reset_n;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //clock_1_out_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_1_out_address_last_time <= 0;
      else if (1)
          clock_1_out_address_last_time <= clock_1_out_address;
    end


  //clock_1/out waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else if (1)
          active_and_waiting_last_time <= clock_1_out_waitrequest & (clock_1_out_read | clock_1_out_write);
    end


  //clock_1_out_address matches last port_name, which is an e_process
  always @(active_and_waiting_last_time or clock_1_out_address or clock_1_out_address_last_time)
    begin
      if (active_and_waiting_last_time & (clock_1_out_address != clock_1_out_address_last_time))
        begin
          $write("%0d ns: clock_1_out_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //clock_1_out_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_1_out_read_last_time <= 0;
      else if (1)
          clock_1_out_read_last_time <= clock_1_out_read;
    end


  //clock_1_out_read matches last port_name, which is an e_process
  always @(active_and_waiting_last_time or clock_1_out_read or clock_1_out_read_last_time)
    begin
      if (active_and_waiting_last_time & (clock_1_out_read != clock_1_out_read_last_time))
        begin
          $write("%0d ns: clock_1_out_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //clock_1_out_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_1_out_write_last_time <= 0;
      else if (1)
          clock_1_out_write_last_time <= clock_1_out_write;
    end


  //clock_1_out_write matches last port_name, which is an e_process
  always @(active_and_waiting_last_time or clock_1_out_write or clock_1_out_write_last_time)
    begin
      if (active_and_waiting_last_time & (clock_1_out_write != clock_1_out_write_last_time))
        begin
          $write("%0d ns: clock_1_out_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //clock_1_out_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clock_1_out_writedata_last_time <= 0;
      else if (1)
          clock_1_out_writedata_last_time <= clock_1_out_writedata;
    end


  //clock_1_out_writedata matches last port_name, which is an e_process
  always @(active_and_waiting_last_time or clock_1_out_write or clock_1_out_writedata or clock_1_out_writedata_last_time)
    begin
      if (active_and_waiting_last_time & (clock_1_out_writedata != clock_1_out_writedata_last_time) & clock_1_out_write)
        begin
          $write("%0d ns: clock_1_out_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_jtag_debug_module_arbitrator (
                                          // inputs:
                                           clk,
                                           cpu_data_master_address_to_slave,
                                           cpu_data_master_byteenable,
                                           cpu_data_master_debugaccess,
                                           cpu_data_master_latency_counter,
                                           cpu_data_master_read,
                                           cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                           cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                           cpu_data_master_write,
                                           cpu_data_master_writedata,
                                           cpu_instruction_master_address_to_slave,
                                           cpu_instruction_master_latency_counter,
                                           cpu_instruction_master_read,
                                           cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register,
                                           cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register,
                                           cpu_jtag_debug_module_readdata,
                                           cpu_jtag_debug_module_resetrequest,
                                           reset_n,

                                          // outputs:
                                           cpu_data_master_granted_cpu_jtag_debug_module,
                                           cpu_data_master_qualified_request_cpu_jtag_debug_module,
                                           cpu_data_master_read_data_valid_cpu_jtag_debug_module,
                                           cpu_data_master_requests_cpu_jtag_debug_module,
                                           cpu_instruction_master_granted_cpu_jtag_debug_module,
                                           cpu_instruction_master_qualified_request_cpu_jtag_debug_module,
                                           cpu_instruction_master_read_data_valid_cpu_jtag_debug_module,
                                           cpu_instruction_master_requests_cpu_jtag_debug_module,
                                           cpu_jtag_debug_module_address,
                                           cpu_jtag_debug_module_begintransfer,
                                           cpu_jtag_debug_module_byteenable,
                                           cpu_jtag_debug_module_chipselect,
                                           cpu_jtag_debug_module_debugaccess,
                                           cpu_jtag_debug_module_readdata_from_sa,
                                           cpu_jtag_debug_module_reset,
                                           cpu_jtag_debug_module_reset_n,
                                           cpu_jtag_debug_module_resetrequest_from_sa,
                                           cpu_jtag_debug_module_write,
                                           cpu_jtag_debug_module_writedata,
                                           d1_cpu_jtag_debug_module_end_xfer
                                        )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_cpu_jtag_debug_module;
  output           cpu_data_master_qualified_request_cpu_jtag_debug_module;
  output           cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  output           cpu_data_master_requests_cpu_jtag_debug_module;
  output           cpu_instruction_master_granted_cpu_jtag_debug_module;
  output           cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  output           cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  output           cpu_instruction_master_requests_cpu_jtag_debug_module;
  output  [  8: 0] cpu_jtag_debug_module_address;
  output           cpu_jtag_debug_module_begintransfer;
  output  [  3: 0] cpu_jtag_debug_module_byteenable;
  output           cpu_jtag_debug_module_chipselect;
  output           cpu_jtag_debug_module_debugaccess;
  output  [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  output           cpu_jtag_debug_module_reset;
  output           cpu_jtag_debug_module_reset_n;
  output           cpu_jtag_debug_module_resetrequest_from_sa;
  output           cpu_jtag_debug_module_write;
  output  [ 31: 0] cpu_jtag_debug_module_writedata;
  output           d1_cpu_jtag_debug_module_end_xfer;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input            cpu_data_master_debugaccess;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [ 27: 0] cpu_instruction_master_address_to_slave;
  input   [  2: 0] cpu_instruction_master_latency_counter;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register;
  input   [ 31: 0] cpu_jtag_debug_module_readdata;
  input            cpu_jtag_debug_module_resetrequest;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_cpu_jtag_debug_module;
  wire             cpu_data_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_data_master_requests_cpu_jtag_debug_module;
  wire             cpu_data_master_saved_grant_cpu_jtag_debug_module;
  wire             cpu_instruction_master_arbiterlock;
  wire             cpu_instruction_master_arbiterlock2;
  wire             cpu_instruction_master_continuerequest;
  wire             cpu_instruction_master_granted_cpu_jtag_debug_module;
  wire             cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_instruction_master_requests_cpu_jtag_debug_module;
  wire             cpu_instruction_master_saved_grant_cpu_jtag_debug_module;
  wire    [  8: 0] cpu_jtag_debug_module_address;
  wire             cpu_jtag_debug_module_allgrants;
  wire             cpu_jtag_debug_module_allow_new_arb_cycle;
  wire             cpu_jtag_debug_module_any_bursting_master_saved_grant;
  wire             cpu_jtag_debug_module_any_continuerequest;
  reg     [  1: 0] cpu_jtag_debug_module_arb_addend;
  wire             cpu_jtag_debug_module_arb_counter_enable;
  reg     [  1: 0] cpu_jtag_debug_module_arb_share_counter;
  wire    [  1: 0] cpu_jtag_debug_module_arb_share_counter_next_value;
  wire    [  1: 0] cpu_jtag_debug_module_arb_share_set_values;
  wire    [  1: 0] cpu_jtag_debug_module_arb_winner;
  wire             cpu_jtag_debug_module_arbitration_holdoff_internal;
  wire             cpu_jtag_debug_module_beginbursttransfer_internal;
  wire             cpu_jtag_debug_module_begins_xfer;
  wire             cpu_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_jtag_debug_module_byteenable;
  wire             cpu_jtag_debug_module_chipselect;
  wire    [  3: 0] cpu_jtag_debug_module_chosen_master_double_vector;
  wire    [  1: 0] cpu_jtag_debug_module_chosen_master_rot_left;
  wire             cpu_jtag_debug_module_debugaccess;
  wire             cpu_jtag_debug_module_end_xfer;
  wire             cpu_jtag_debug_module_firsttransfer;
  wire    [  1: 0] cpu_jtag_debug_module_grant_vector;
  wire             cpu_jtag_debug_module_in_a_read_cycle;
  wire             cpu_jtag_debug_module_in_a_write_cycle;
  wire    [  1: 0] cpu_jtag_debug_module_master_qreq_vector;
  wire             cpu_jtag_debug_module_non_bursting_master_requests;
  wire    [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  reg              cpu_jtag_debug_module_reg_firsttransfer;
  wire             cpu_jtag_debug_module_reset;
  wire             cpu_jtag_debug_module_reset_n;
  wire             cpu_jtag_debug_module_resetrequest_from_sa;
  reg     [  1: 0] cpu_jtag_debug_module_saved_chosen_master_vector;
  reg              cpu_jtag_debug_module_slavearbiterlockenable;
  wire             cpu_jtag_debug_module_slavearbiterlockenable2;
  wire             cpu_jtag_debug_module_unreg_firsttransfer;
  wire             cpu_jtag_debug_module_waits_for_read;
  wire             cpu_jtag_debug_module_waits_for_write;
  wire             cpu_jtag_debug_module_write;
  wire    [ 31: 0] cpu_jtag_debug_module_writedata;
  reg              d1_cpu_jtag_debug_module_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_cpu_jtag_debug_module;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module;
  reg              last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module;
  wire    [ 27: 0] shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master;
  wire    [ 27: 0] shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master;
  wire             wait_for_cpu_jtag_debug_module_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~cpu_jtag_debug_module_end_xfer;
    end


  assign cpu_jtag_debug_module_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_cpu_jtag_debug_module | cpu_instruction_master_qualified_request_cpu_jtag_debug_module));
  //assign cpu_jtag_debug_module_readdata_from_sa = cpu_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_jtag_debug_module_readdata_from_sa = cpu_jtag_debug_module_readdata;

  assign cpu_data_master_requests_cpu_jtag_debug_module = ({cpu_data_master_address_to_slave[27 : 11] , 11'b0} == 28'h9640800) & (cpu_data_master_read | cpu_data_master_write);
  //cpu_jtag_debug_module_arb_share_counter set values, which is an e_mux
  assign cpu_jtag_debug_module_arb_share_set_values = 1;

  //cpu_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  assign cpu_jtag_debug_module_non_bursting_master_requests = cpu_data_master_requests_cpu_jtag_debug_module |
    cpu_instruction_master_requests_cpu_jtag_debug_module |
    cpu_data_master_requests_cpu_jtag_debug_module |
    cpu_instruction_master_requests_cpu_jtag_debug_module;

  //cpu_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  assign cpu_jtag_debug_module_any_bursting_master_saved_grant = 0;

  //cpu_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  assign cpu_jtag_debug_module_arb_share_counter_next_value = cpu_jtag_debug_module_firsttransfer ? (cpu_jtag_debug_module_arb_share_set_values - 1) : |cpu_jtag_debug_module_arb_share_counter ? (cpu_jtag_debug_module_arb_share_counter - 1) : 0;

  //cpu_jtag_debug_module_allgrants all slave grants, which is an e_mux
  assign cpu_jtag_debug_module_allgrants = |cpu_jtag_debug_module_grant_vector |
    |cpu_jtag_debug_module_grant_vector |
    |cpu_jtag_debug_module_grant_vector |
    |cpu_jtag_debug_module_grant_vector;

  //cpu_jtag_debug_module_end_xfer assignment, which is an e_assign
  assign cpu_jtag_debug_module_end_xfer = ~(cpu_jtag_debug_module_waits_for_read | cpu_jtag_debug_module_waits_for_write);

  //end_xfer_arb_share_counter_term_cpu_jtag_debug_module arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_cpu_jtag_debug_module = cpu_jtag_debug_module_end_xfer & (~cpu_jtag_debug_module_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //cpu_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  assign cpu_jtag_debug_module_arb_counter_enable = (end_xfer_arb_share_counter_term_cpu_jtag_debug_module & cpu_jtag_debug_module_allgrants) | (end_xfer_arb_share_counter_term_cpu_jtag_debug_module & ~cpu_jtag_debug_module_non_bursting_master_requests);

  //cpu_jtag_debug_module_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_arb_share_counter <= 0;
      else if (cpu_jtag_debug_module_arb_counter_enable)
          cpu_jtag_debug_module_arb_share_counter <= cpu_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_slavearbiterlockenable <= 0;
      else if ((|cpu_jtag_debug_module_master_qreq_vector & end_xfer_arb_share_counter_term_cpu_jtag_debug_module) | (end_xfer_arb_share_counter_term_cpu_jtag_debug_module & ~cpu_jtag_debug_module_non_bursting_master_requests))
          cpu_jtag_debug_module_slavearbiterlockenable <= |cpu_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu/data_master cpu/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = cpu_jtag_debug_module_slavearbiterlockenable & cpu_data_master_continuerequest;

  //cpu_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign cpu_jtag_debug_module_slavearbiterlockenable2 = |cpu_jtag_debug_module_arb_share_counter_next_value;

  //cpu/data_master cpu/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = cpu_jtag_debug_module_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //cpu/instruction_master cpu/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_instruction_master_arbiterlock = cpu_jtag_debug_module_slavearbiterlockenable & cpu_instruction_master_continuerequest;

  //cpu/instruction_master cpu/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_instruction_master_arbiterlock2 = cpu_jtag_debug_module_slavearbiterlockenable2 & cpu_instruction_master_continuerequest;

  //cpu/instruction_master granted cpu/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module <= 0;
      else if (1)
          last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module <= cpu_instruction_master_saved_grant_cpu_jtag_debug_module ? 1 : (cpu_jtag_debug_module_arbitration_holdoff_internal | ~cpu_instruction_master_requests_cpu_jtag_debug_module) ? 0 : last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module;
    end


  //cpu_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_instruction_master_continuerequest = last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module & cpu_instruction_master_requests_cpu_jtag_debug_module;

  //cpu_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  assign cpu_jtag_debug_module_any_continuerequest = cpu_instruction_master_continuerequest |
    cpu_data_master_continuerequest;

  assign cpu_data_master_qualified_request_cpu_jtag_debug_module = cpu_data_master_requests_cpu_jtag_debug_module & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))) | cpu_instruction_master_arbiterlock);
  //local readdatavalid cpu_data_master_read_data_valid_cpu_jtag_debug_module, which is an e_mux
  assign cpu_data_master_read_data_valid_cpu_jtag_debug_module = cpu_data_master_granted_cpu_jtag_debug_module & cpu_data_master_read & ~cpu_jtag_debug_module_waits_for_read;

  //cpu_jtag_debug_module_writedata mux, which is an e_mux
  assign cpu_jtag_debug_module_writedata = cpu_data_master_writedata;

  //mux cpu_jtag_debug_module_debugaccess, which is an e_mux
  assign cpu_jtag_debug_module_debugaccess = cpu_data_master_debugaccess;

  assign cpu_instruction_master_requests_cpu_jtag_debug_module = (({cpu_instruction_master_address_to_slave[27 : 11] , 11'b0} == 28'h9640800) & (cpu_instruction_master_read)) & cpu_instruction_master_read;
  //cpu/data_master granted cpu/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module <= 0;
      else if (1)
          last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module <= cpu_data_master_saved_grant_cpu_jtag_debug_module ? 1 : (cpu_jtag_debug_module_arbitration_holdoff_internal | ~cpu_data_master_requests_cpu_jtag_debug_module) ? 0 : last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module;
    end


  //cpu_data_master_continuerequest continued request, which is an e_mux
  assign cpu_data_master_continuerequest = last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module & cpu_data_master_requests_cpu_jtag_debug_module;

  assign cpu_instruction_master_qualified_request_cpu_jtag_debug_module = cpu_instruction_master_requests_cpu_jtag_debug_module & ~((cpu_instruction_master_read & ((cpu_instruction_master_latency_counter != 0) | (|cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register))) | cpu_data_master_arbiterlock);
  //local readdatavalid cpu_instruction_master_read_data_valid_cpu_jtag_debug_module, which is an e_mux
  assign cpu_instruction_master_read_data_valid_cpu_jtag_debug_module = cpu_instruction_master_granted_cpu_jtag_debug_module & cpu_instruction_master_read & ~cpu_jtag_debug_module_waits_for_read;

  //allow new arb cycle for cpu/jtag_debug_module, which is an e_assign
  assign cpu_jtag_debug_module_allow_new_arb_cycle = ~cpu_data_master_arbiterlock & ~cpu_instruction_master_arbiterlock;

  //cpu/instruction_master assignment into master qualified-requests vector for cpu/jtag_debug_module, which is an e_assign
  assign cpu_jtag_debug_module_master_qreq_vector[0] = cpu_instruction_master_qualified_request_cpu_jtag_debug_module;

  //cpu/instruction_master grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_instruction_master_granted_cpu_jtag_debug_module = cpu_jtag_debug_module_grant_vector[0];

  //cpu/instruction_master saved-grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_instruction_master_saved_grant_cpu_jtag_debug_module = cpu_jtag_debug_module_arb_winner[0] && cpu_instruction_master_requests_cpu_jtag_debug_module;

  //cpu/data_master assignment into master qualified-requests vector for cpu/jtag_debug_module, which is an e_assign
  assign cpu_jtag_debug_module_master_qreq_vector[1] = cpu_data_master_qualified_request_cpu_jtag_debug_module;

  //cpu/data_master grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_data_master_granted_cpu_jtag_debug_module = cpu_jtag_debug_module_grant_vector[1];

  //cpu/data_master saved-grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_data_master_saved_grant_cpu_jtag_debug_module = cpu_jtag_debug_module_arb_winner[1] && cpu_data_master_requests_cpu_jtag_debug_module;

  //cpu/jtag_debug_module chosen-master double-vector, which is an e_assign
  assign cpu_jtag_debug_module_chosen_master_double_vector = {cpu_jtag_debug_module_master_qreq_vector, cpu_jtag_debug_module_master_qreq_vector} & ({~cpu_jtag_debug_module_master_qreq_vector, ~cpu_jtag_debug_module_master_qreq_vector} + cpu_jtag_debug_module_arb_addend);

  //stable onehot encoding of arb winner
  assign cpu_jtag_debug_module_arb_winner = (cpu_jtag_debug_module_allow_new_arb_cycle & | cpu_jtag_debug_module_grant_vector) ? cpu_jtag_debug_module_grant_vector : cpu_jtag_debug_module_saved_chosen_master_vector;

  //saved cpu_jtag_debug_module_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_saved_chosen_master_vector <= 0;
      else if (cpu_jtag_debug_module_allow_new_arb_cycle)
          cpu_jtag_debug_module_saved_chosen_master_vector <= |cpu_jtag_debug_module_grant_vector ? cpu_jtag_debug_module_grant_vector : cpu_jtag_debug_module_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign cpu_jtag_debug_module_grant_vector = {(cpu_jtag_debug_module_chosen_master_double_vector[1] | cpu_jtag_debug_module_chosen_master_double_vector[3]),
    (cpu_jtag_debug_module_chosen_master_double_vector[0] | cpu_jtag_debug_module_chosen_master_double_vector[2])};

  //cpu/jtag_debug_module chosen master rotated left, which is an e_assign
  assign cpu_jtag_debug_module_chosen_master_rot_left = (cpu_jtag_debug_module_arb_winner << 1) ? (cpu_jtag_debug_module_arb_winner << 1) : 1;

  //cpu/jtag_debug_module's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_arb_addend <= 1;
      else if (|cpu_jtag_debug_module_grant_vector)
          cpu_jtag_debug_module_arb_addend <= cpu_jtag_debug_module_end_xfer? cpu_jtag_debug_module_chosen_master_rot_left : cpu_jtag_debug_module_grant_vector;
    end


  assign cpu_jtag_debug_module_begintransfer = cpu_jtag_debug_module_begins_xfer;
  //assign lhs ~cpu_jtag_debug_module_reset of type reset_n to cpu_jtag_debug_module_reset_n, which is an e_assign
  assign cpu_jtag_debug_module_reset = ~cpu_jtag_debug_module_reset_n;

  //cpu_jtag_debug_module_reset_n assignment, which is an e_assign
  assign cpu_jtag_debug_module_reset_n = reset_n;

  //assign cpu_jtag_debug_module_resetrequest_from_sa = cpu_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_jtag_debug_module_resetrequest_from_sa = cpu_jtag_debug_module_resetrequest;

  assign cpu_jtag_debug_module_chipselect = cpu_data_master_granted_cpu_jtag_debug_module | cpu_instruction_master_granted_cpu_jtag_debug_module;
  //cpu_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  assign cpu_jtag_debug_module_firsttransfer = cpu_jtag_debug_module_begins_xfer ? cpu_jtag_debug_module_unreg_firsttransfer : cpu_jtag_debug_module_reg_firsttransfer;

  //cpu_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  assign cpu_jtag_debug_module_unreg_firsttransfer = ~(cpu_jtag_debug_module_slavearbiterlockenable & cpu_jtag_debug_module_any_continuerequest);

  //cpu_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_reg_firsttransfer <= 1'b1;
      else if (cpu_jtag_debug_module_begins_xfer)
          cpu_jtag_debug_module_reg_firsttransfer <= cpu_jtag_debug_module_unreg_firsttransfer;
    end


  //cpu_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign cpu_jtag_debug_module_beginbursttransfer_internal = cpu_jtag_debug_module_begins_xfer;

  //cpu_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign cpu_jtag_debug_module_arbitration_holdoff_internal = cpu_jtag_debug_module_begins_xfer & cpu_jtag_debug_module_firsttransfer;

  //cpu_jtag_debug_module_write assignment, which is an e_mux
  assign cpu_jtag_debug_module_write = cpu_data_master_granted_cpu_jtag_debug_module & cpu_data_master_write;

  assign shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master = cpu_data_master_address_to_slave;
  //cpu_jtag_debug_module_address mux, which is an e_mux
  assign cpu_jtag_debug_module_address = (cpu_data_master_granted_cpu_jtag_debug_module)? (shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master >> 2) :
    (shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master >> 2);

  assign shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master = cpu_instruction_master_address_to_slave;
  //d1_cpu_jtag_debug_module_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_cpu_jtag_debug_module_end_xfer <= 1;
      else if (1)
          d1_cpu_jtag_debug_module_end_xfer <= cpu_jtag_debug_module_end_xfer;
    end


  //cpu_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  assign cpu_jtag_debug_module_waits_for_read = cpu_jtag_debug_module_in_a_read_cycle & cpu_jtag_debug_module_begins_xfer;

  //cpu_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  assign cpu_jtag_debug_module_in_a_read_cycle = (cpu_data_master_granted_cpu_jtag_debug_module & cpu_data_master_read) | (cpu_instruction_master_granted_cpu_jtag_debug_module & cpu_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = cpu_jtag_debug_module_in_a_read_cycle;

  //cpu_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  assign cpu_jtag_debug_module_waits_for_write = cpu_jtag_debug_module_in_a_write_cycle & 0;

  //cpu_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  assign cpu_jtag_debug_module_in_a_write_cycle = cpu_data_master_granted_cpu_jtag_debug_module & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = cpu_jtag_debug_module_in_a_write_cycle;

  assign wait_for_cpu_jtag_debug_module_counter = 0;
  //cpu_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  assign cpu_jtag_debug_module_byteenable = (cpu_data_master_granted_cpu_jtag_debug_module)? cpu_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu/jtag_debug_module enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_granted_cpu_jtag_debug_module + cpu_instruction_master_granted_cpu_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_saved_grant_cpu_jtag_debug_module + cpu_instruction_master_saved_grant_cpu_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module DM9000A_s1_irq_from_sa_clock_crossing_cpu_data_master_module (
                                                                      // inputs:
                                                                       clk,
                                                                       data_in,
                                                                       reset_n,

                                                                      // outputs:
                                                                       data_out
                                                                    )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "MAX_DELAY=\"100ns\" ; PRESERVE_REGISTER=ON"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else if (1)
          data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else if (1)
          data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_data_master_arbitrator (
                                    // inputs:
                                     AUDIO_s1_readdata_from_sa,
                                     DM9000A_s1_irq_from_sa,
                                     ISP1362_dc_irq_n_from_sa,
                                     ISP1362_dc_readdata_from_sa,
                                     ISP1362_dc_wait_counter_eq_0,
                                     ISP1362_hc_irq_n_from_sa,
                                     ISP1362_hc_readdata_from_sa,
                                     ISP1362_hc_wait_counter_eq_0,
                                     SEG7_s1_readdata_from_sa,
                                     VGA_s1_readdata_from_sa,
                                     cfi_flash_s1_wait_counter_eq_0,
                                     clk,
                                     clock_0_in_readdata_from_sa,
                                     clock_0_in_waitrequest_from_sa,
                                     clock_1_in_readdata_from_sa,
                                     clock_1_in_waitrequest_from_sa,
                                     cpu_data_master_address,
                                     cpu_data_master_byteenable_cfi_flash_s1,
                                     cpu_data_master_byteenable_sdram_u1_s1,
                                     cpu_data_master_byteenable_sdram_u2_s1,
                                     cpu_data_master_debugaccess,
                                     cpu_data_master_granted_AUDIO_s1,
                                     cpu_data_master_granted_ISP1362_dc,
                                     cpu_data_master_granted_ISP1362_hc,
                                     cpu_data_master_granted_SEG7_s1,
                                     cpu_data_master_granted_VGA_s1,
                                     cpu_data_master_granted_cfi_flash_s1,
                                     cpu_data_master_granted_clock_0_in,
                                     cpu_data_master_granted_clock_1_in,
                                     cpu_data_master_granted_cpu_jtag_debug_module,
                                     cpu_data_master_granted_i2c_sclk_s1,
                                     cpu_data_master_granted_i2c_sdat_s1,
                                     cpu_data_master_granted_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_granted_lcd_control_slave,
                                     cpu_data_master_granted_onchip_mem_s1,
                                     cpu_data_master_granted_pio_button_s1,
                                     cpu_data_master_granted_pio_green_led_s1,
                                     cpu_data_master_granted_pio_red_led_s1,
                                     cpu_data_master_granted_pio_switch_s1,
                                     cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave,
                                     cpu_data_master_granted_ps2_mouse_avalon_PS2_slave,
                                     cpu_data_master_granted_sd_clk_s1,
                                     cpu_data_master_granted_sd_cmd_s1,
                                     cpu_data_master_granted_sd_dat3_s1,
                                     cpu_data_master_granted_sd_dat_s1,
                                     cpu_data_master_granted_sdram_u1_s1,
                                     cpu_data_master_granted_sdram_u2_s1,
                                     cpu_data_master_granted_ssram_s1,
                                     cpu_data_master_granted_sysid_control_slave,
                                     cpu_data_master_granted_timer_s1,
                                     cpu_data_master_granted_timer_stamp_s1,
                                     cpu_data_master_granted_uart_s1,
                                     cpu_data_master_qualified_request_AUDIO_s1,
                                     cpu_data_master_qualified_request_ISP1362_dc,
                                     cpu_data_master_qualified_request_ISP1362_hc,
                                     cpu_data_master_qualified_request_SEG7_s1,
                                     cpu_data_master_qualified_request_VGA_s1,
                                     cpu_data_master_qualified_request_cfi_flash_s1,
                                     cpu_data_master_qualified_request_clock_0_in,
                                     cpu_data_master_qualified_request_clock_1_in,
                                     cpu_data_master_qualified_request_cpu_jtag_debug_module,
                                     cpu_data_master_qualified_request_i2c_sclk_s1,
                                     cpu_data_master_qualified_request_i2c_sdat_s1,
                                     cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_qualified_request_lcd_control_slave,
                                     cpu_data_master_qualified_request_onchip_mem_s1,
                                     cpu_data_master_qualified_request_pio_button_s1,
                                     cpu_data_master_qualified_request_pio_green_led_s1,
                                     cpu_data_master_qualified_request_pio_red_led_s1,
                                     cpu_data_master_qualified_request_pio_switch_s1,
                                     cpu_data_master_qualified_request_ps2_keyboard_avalon_PS2_slave,
                                     cpu_data_master_qualified_request_ps2_mouse_avalon_PS2_slave,
                                     cpu_data_master_qualified_request_sd_clk_s1,
                                     cpu_data_master_qualified_request_sd_cmd_s1,
                                     cpu_data_master_qualified_request_sd_dat3_s1,
                                     cpu_data_master_qualified_request_sd_dat_s1,
                                     cpu_data_master_qualified_request_sdram_u1_s1,
                                     cpu_data_master_qualified_request_sdram_u2_s1,
                                     cpu_data_master_qualified_request_ssram_s1,
                                     cpu_data_master_qualified_request_sysid_control_slave,
                                     cpu_data_master_qualified_request_timer_s1,
                                     cpu_data_master_qualified_request_timer_stamp_s1,
                                     cpu_data_master_qualified_request_uart_s1,
                                     cpu_data_master_read,
                                     cpu_data_master_read_data_valid_AUDIO_s1,
                                     cpu_data_master_read_data_valid_ISP1362_dc,
                                     cpu_data_master_read_data_valid_ISP1362_hc,
                                     cpu_data_master_read_data_valid_SEG7_s1,
                                     cpu_data_master_read_data_valid_VGA_s1,
                                     cpu_data_master_read_data_valid_cfi_flash_s1,
                                     cpu_data_master_read_data_valid_clock_0_in,
                                     cpu_data_master_read_data_valid_clock_1_in,
                                     cpu_data_master_read_data_valid_cpu_jtag_debug_module,
                                     cpu_data_master_read_data_valid_i2c_sclk_s1,
                                     cpu_data_master_read_data_valid_i2c_sdat_s1,
                                     cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_read_data_valid_lcd_control_slave,
                                     cpu_data_master_read_data_valid_onchip_mem_s1,
                                     cpu_data_master_read_data_valid_pio_button_s1,
                                     cpu_data_master_read_data_valid_pio_green_led_s1,
                                     cpu_data_master_read_data_valid_pio_red_led_s1,
                                     cpu_data_master_read_data_valid_pio_switch_s1,
                                     cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave,
                                     cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave,
                                     cpu_data_master_read_data_valid_sd_clk_s1,
                                     cpu_data_master_read_data_valid_sd_cmd_s1,
                                     cpu_data_master_read_data_valid_sd_dat3_s1,
                                     cpu_data_master_read_data_valid_sd_dat_s1,
                                     cpu_data_master_read_data_valid_sdram_u1_s1,
                                     cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                     cpu_data_master_read_data_valid_sdram_u2_s1,
                                     cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                     cpu_data_master_read_data_valid_ssram_s1,
                                     cpu_data_master_read_data_valid_sysid_control_slave,
                                     cpu_data_master_read_data_valid_timer_s1,
                                     cpu_data_master_read_data_valid_timer_stamp_s1,
                                     cpu_data_master_read_data_valid_uart_s1,
                                     cpu_data_master_requests_AUDIO_s1,
                                     cpu_data_master_requests_ISP1362_dc,
                                     cpu_data_master_requests_ISP1362_hc,
                                     cpu_data_master_requests_SEG7_s1,
                                     cpu_data_master_requests_VGA_s1,
                                     cpu_data_master_requests_cfi_flash_s1,
                                     cpu_data_master_requests_clock_0_in,
                                     cpu_data_master_requests_clock_1_in,
                                     cpu_data_master_requests_cpu_jtag_debug_module,
                                     cpu_data_master_requests_i2c_sclk_s1,
                                     cpu_data_master_requests_i2c_sdat_s1,
                                     cpu_data_master_requests_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_requests_lcd_control_slave,
                                     cpu_data_master_requests_onchip_mem_s1,
                                     cpu_data_master_requests_pio_button_s1,
                                     cpu_data_master_requests_pio_green_led_s1,
                                     cpu_data_master_requests_pio_red_led_s1,
                                     cpu_data_master_requests_pio_switch_s1,
                                     cpu_data_master_requests_ps2_keyboard_avalon_PS2_slave,
                                     cpu_data_master_requests_ps2_mouse_avalon_PS2_slave,
                                     cpu_data_master_requests_sd_clk_s1,
                                     cpu_data_master_requests_sd_cmd_s1,
                                     cpu_data_master_requests_sd_dat3_s1,
                                     cpu_data_master_requests_sd_dat_s1,
                                     cpu_data_master_requests_sdram_u1_s1,
                                     cpu_data_master_requests_sdram_u2_s1,
                                     cpu_data_master_requests_ssram_s1,
                                     cpu_data_master_requests_sysid_control_slave,
                                     cpu_data_master_requests_timer_s1,
                                     cpu_data_master_requests_timer_stamp_s1,
                                     cpu_data_master_requests_uart_s1,
                                     cpu_data_master_write,
                                     cpu_data_master_writedata,
                                     cpu_jtag_debug_module_readdata_from_sa,
                                     d1_AUDIO_s1_end_xfer,
                                     d1_ISP1362_dc_end_xfer,
                                     d1_ISP1362_hc_end_xfer,
                                     d1_SEG7_s1_end_xfer,
                                     d1_VGA_s1_end_xfer,
                                     d1_clock_0_in_end_xfer,
                                     d1_clock_1_in_end_xfer,
                                     d1_cpu_jtag_debug_module_end_xfer,
                                     d1_i2c_sclk_s1_end_xfer,
                                     d1_i2c_sdat_s1_end_xfer,
                                     d1_jtag_uart_avalon_jtag_slave_end_xfer,
                                     d1_lcd_control_slave_end_xfer,
                                     d1_onchip_mem_s1_end_xfer,
                                     d1_pio_button_s1_end_xfer,
                                     d1_pio_green_led_s1_end_xfer,
                                     d1_pio_red_led_s1_end_xfer,
                                     d1_pio_switch_s1_end_xfer,
                                     d1_ps2_keyboard_avalon_PS2_slave_end_xfer,
                                     d1_ps2_mouse_avalon_PS2_slave_end_xfer,
                                     d1_sd_clk_s1_end_xfer,
                                     d1_sd_cmd_s1_end_xfer,
                                     d1_sd_dat3_s1_end_xfer,
                                     d1_sd_dat_s1_end_xfer,
                                     d1_sdram_u1_s1_end_xfer,
                                     d1_sdram_u2_s1_end_xfer,
                                     d1_sysid_control_slave_end_xfer,
                                     d1_timer_s1_end_xfer,
                                     d1_timer_stamp_s1_end_xfer,
                                     d1_tristate_bridge_flash_avalon_slave_end_xfer,
                                     d1_tristate_bridge_ssram_avalon_slave_end_xfer,
                                     d1_uart_s1_end_xfer,
                                     i2c_sdat_s1_readdata_from_sa,
                                     incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0,
                                     incoming_data_to_and_from_the_ssram,
                                     jtag_uart_avalon_jtag_slave_irq_from_sa,
                                     jtag_uart_avalon_jtag_slave_readdata_from_sa,
                                     jtag_uart_avalon_jtag_slave_waitrequest_from_sa,
                                     lcd_control_slave_readdata_from_sa,
                                     lcd_control_slave_wait_counter_eq_0,
                                     onchip_mem_s1_readdata_from_sa,
                                     pio_button_s1_irq_from_sa,
                                     pio_button_s1_readdata_from_sa,
                                     pio_switch_s1_readdata_from_sa,
                                     pll_c0_system,
                                     pll_c0_system_reset_n,
                                     ps2_keyboard_avalon_PS2_slave_irq_from_sa,
                                     ps2_keyboard_avalon_PS2_slave_readdata_from_sa,
                                     ps2_keyboard_avalon_PS2_slave_waitrequest_from_sa,
                                     ps2_mouse_avalon_PS2_slave_irq_from_sa,
                                     ps2_mouse_avalon_PS2_slave_readdata_from_sa,
                                     ps2_mouse_avalon_PS2_slave_waitrequest_from_sa,
                                     reset_n,
                                     sd_cmd_s1_readdata_from_sa,
                                     sd_dat3_s1_readdata_from_sa,
                                     sd_dat_s1_readdata_from_sa,
                                     sdram_u1_s1_readdata_from_sa,
                                     sdram_u1_s1_waitrequest_from_sa,
                                     sdram_u2_s1_readdata_from_sa,
                                     sdram_u2_s1_waitrequest_from_sa,
                                     sysid_control_slave_readdata_from_sa,
                                     timer_s1_irq_from_sa,
                                     timer_s1_readdata_from_sa,
                                     timer_stamp_s1_irq_from_sa,
                                     timer_stamp_s1_readdata_from_sa,
                                     uart_s1_irq_from_sa,
                                     uart_s1_readdata_from_sa,

                                    // outputs:
                                     cpu_data_master_address_to_slave,
                                     cpu_data_master_dbs_address,
                                     cpu_data_master_dbs_write_16,
                                     cpu_data_master_irq,
                                     cpu_data_master_latency_counter,
                                     cpu_data_master_readdata,
                                     cpu_data_master_readdatavalid,
                                     cpu_data_master_waitrequest
                                  )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output  [ 27: 0] cpu_data_master_address_to_slave;
  output  [  1: 0] cpu_data_master_dbs_address;
  output  [ 15: 0] cpu_data_master_dbs_write_16;
  output  [ 31: 0] cpu_data_master_irq;
  output  [  2: 0] cpu_data_master_latency_counter;
  output  [ 31: 0] cpu_data_master_readdata;
  output           cpu_data_master_readdatavalid;
  output           cpu_data_master_waitrequest;
  input   [ 32: 0] AUDIO_s1_readdata_from_sa;
  input            DM9000A_s1_irq_from_sa;
  input            ISP1362_dc_irq_n_from_sa;
  input   [ 15: 0] ISP1362_dc_readdata_from_sa;
  input            ISP1362_dc_wait_counter_eq_0;
  input            ISP1362_hc_irq_n_from_sa;
  input   [ 15: 0] ISP1362_hc_readdata_from_sa;
  input            ISP1362_hc_wait_counter_eq_0;
  input   [  7: 0] SEG7_s1_readdata_from_sa;
  input   [ 15: 0] VGA_s1_readdata_from_sa;
  input            cfi_flash_s1_wait_counter_eq_0;
  input            clk;
  input   [ 15: 0] clock_0_in_readdata_from_sa;
  input            clock_0_in_waitrequest_from_sa;
  input   [ 15: 0] clock_1_in_readdata_from_sa;
  input            clock_1_in_waitrequest_from_sa;
  input   [ 27: 0] cpu_data_master_address;
  input   [  1: 0] cpu_data_master_byteenable_cfi_flash_s1;
  input   [  1: 0] cpu_data_master_byteenable_sdram_u1_s1;
  input   [  1: 0] cpu_data_master_byteenable_sdram_u2_s1;
  input            cpu_data_master_debugaccess;
  input            cpu_data_master_granted_AUDIO_s1;
  input            cpu_data_master_granted_ISP1362_dc;
  input            cpu_data_master_granted_ISP1362_hc;
  input            cpu_data_master_granted_SEG7_s1;
  input            cpu_data_master_granted_VGA_s1;
  input            cpu_data_master_granted_cfi_flash_s1;
  input            cpu_data_master_granted_clock_0_in;
  input            cpu_data_master_granted_clock_1_in;
  input            cpu_data_master_granted_cpu_jtag_debug_module;
  input            cpu_data_master_granted_i2c_sclk_s1;
  input            cpu_data_master_granted_i2c_sdat_s1;
  input            cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_granted_lcd_control_slave;
  input            cpu_data_master_granted_onchip_mem_s1;
  input            cpu_data_master_granted_pio_button_s1;
  input            cpu_data_master_granted_pio_green_led_s1;
  input            cpu_data_master_granted_pio_red_led_s1;
  input            cpu_data_master_granted_pio_switch_s1;
  input            cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave;
  input            cpu_data_master_granted_ps2_mouse_avalon_PS2_slave;
  input            cpu_data_master_granted_sd_clk_s1;
  input            cpu_data_master_granted_sd_cmd_s1;
  input            cpu_data_master_granted_sd_dat3_s1;
  input            cpu_data_master_granted_sd_dat_s1;
  input            cpu_data_master_granted_sdram_u1_s1;
  input            cpu_data_master_granted_sdram_u2_s1;
  input            cpu_data_master_granted_ssram_s1;
  input            cpu_data_master_granted_sysid_control_slave;
  input            cpu_data_master_granted_timer_s1;
  input            cpu_data_master_granted_timer_stamp_s1;
  input            cpu_data_master_granted_uart_s1;
  input            cpu_data_master_qualified_request_AUDIO_s1;
  input            cpu_data_master_qualified_request_ISP1362_dc;
  input            cpu_data_master_qualified_request_ISP1362_hc;
  input            cpu_data_master_qualified_request_SEG7_s1;
  input            cpu_data_master_qualified_request_VGA_s1;
  input            cpu_data_master_qualified_request_cfi_flash_s1;
  input            cpu_data_master_qualified_request_clock_0_in;
  input            cpu_data_master_qualified_request_clock_1_in;
  input            cpu_data_master_qualified_request_cpu_jtag_debug_module;
  input            cpu_data_master_qualified_request_i2c_sclk_s1;
  input            cpu_data_master_qualified_request_i2c_sdat_s1;
  input            cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_qualified_request_lcd_control_slave;
  input            cpu_data_master_qualified_request_onchip_mem_s1;
  input            cpu_data_master_qualified_request_pio_button_s1;
  input            cpu_data_master_qualified_request_pio_green_led_s1;
  input            cpu_data_master_qualified_request_pio_red_led_s1;
  input            cpu_data_master_qualified_request_pio_switch_s1;
  input            cpu_data_master_qualified_request_ps2_keyboard_avalon_PS2_slave;
  input            cpu_data_master_qualified_request_ps2_mouse_avalon_PS2_slave;
  input            cpu_data_master_qualified_request_sd_clk_s1;
  input            cpu_data_master_qualified_request_sd_cmd_s1;
  input            cpu_data_master_qualified_request_sd_dat3_s1;
  input            cpu_data_master_qualified_request_sd_dat_s1;
  input            cpu_data_master_qualified_request_sdram_u1_s1;
  input            cpu_data_master_qualified_request_sdram_u2_s1;
  input            cpu_data_master_qualified_request_ssram_s1;
  input            cpu_data_master_qualified_request_sysid_control_slave;
  input            cpu_data_master_qualified_request_timer_s1;
  input            cpu_data_master_qualified_request_timer_stamp_s1;
  input            cpu_data_master_qualified_request_uart_s1;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_AUDIO_s1;
  input            cpu_data_master_read_data_valid_ISP1362_dc;
  input            cpu_data_master_read_data_valid_ISP1362_hc;
  input            cpu_data_master_read_data_valid_SEG7_s1;
  input            cpu_data_master_read_data_valid_VGA_s1;
  input            cpu_data_master_read_data_valid_cfi_flash_s1;
  input            cpu_data_master_read_data_valid_clock_0_in;
  input            cpu_data_master_read_data_valid_clock_1_in;
  input            cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  input            cpu_data_master_read_data_valid_i2c_sclk_s1;
  input            cpu_data_master_read_data_valid_i2c_sdat_s1;
  input            cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_read_data_valid_lcd_control_slave;
  input            cpu_data_master_read_data_valid_onchip_mem_s1;
  input            cpu_data_master_read_data_valid_pio_button_s1;
  input            cpu_data_master_read_data_valid_pio_green_led_s1;
  input            cpu_data_master_read_data_valid_pio_red_led_s1;
  input            cpu_data_master_read_data_valid_pio_switch_s1;
  input            cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave;
  input            cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave;
  input            cpu_data_master_read_data_valid_sd_clk_s1;
  input            cpu_data_master_read_data_valid_sd_cmd_s1;
  input            cpu_data_master_read_data_valid_sd_dat3_s1;
  input            cpu_data_master_read_data_valid_sd_dat_s1;
  input            cpu_data_master_read_data_valid_sdram_u1_s1;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_read_data_valid_ssram_s1;
  input            cpu_data_master_read_data_valid_sysid_control_slave;
  input            cpu_data_master_read_data_valid_timer_s1;
  input            cpu_data_master_read_data_valid_timer_stamp_s1;
  input            cpu_data_master_read_data_valid_uart_s1;
  input            cpu_data_master_requests_AUDIO_s1;
  input            cpu_data_master_requests_ISP1362_dc;
  input            cpu_data_master_requests_ISP1362_hc;
  input            cpu_data_master_requests_SEG7_s1;
  input            cpu_data_master_requests_VGA_s1;
  input            cpu_data_master_requests_cfi_flash_s1;
  input            cpu_data_master_requests_clock_0_in;
  input            cpu_data_master_requests_clock_1_in;
  input            cpu_data_master_requests_cpu_jtag_debug_module;
  input            cpu_data_master_requests_i2c_sclk_s1;
  input            cpu_data_master_requests_i2c_sdat_s1;
  input            cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_requests_lcd_control_slave;
  input            cpu_data_master_requests_onchip_mem_s1;
  input            cpu_data_master_requests_pio_button_s1;
  input            cpu_data_master_requests_pio_green_led_s1;
  input            cpu_data_master_requests_pio_red_led_s1;
  input            cpu_data_master_requests_pio_switch_s1;
  input            cpu_data_master_requests_ps2_keyboard_avalon_PS2_slave;
  input            cpu_data_master_requests_ps2_mouse_avalon_PS2_slave;
  input            cpu_data_master_requests_sd_clk_s1;
  input            cpu_data_master_requests_sd_cmd_s1;
  input            cpu_data_master_requests_sd_dat3_s1;
  input            cpu_data_master_requests_sd_dat_s1;
  input            cpu_data_master_requests_sdram_u1_s1;
  input            cpu_data_master_requests_sdram_u2_s1;
  input            cpu_data_master_requests_ssram_s1;
  input            cpu_data_master_requests_sysid_control_slave;
  input            cpu_data_master_requests_timer_s1;
  input            cpu_data_master_requests_timer_stamp_s1;
  input            cpu_data_master_requests_uart_s1;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  input            d1_AUDIO_s1_end_xfer;
  input            d1_ISP1362_dc_end_xfer;
  input            d1_ISP1362_hc_end_xfer;
  input            d1_SEG7_s1_end_xfer;
  input            d1_VGA_s1_end_xfer;
  input            d1_clock_0_in_end_xfer;
  input            d1_clock_1_in_end_xfer;
  input            d1_cpu_jtag_debug_module_end_xfer;
  input            d1_i2c_sclk_s1_end_xfer;
  input            d1_i2c_sdat_s1_end_xfer;
  input            d1_jtag_uart_avalon_jtag_slave_end_xfer;
  input            d1_lcd_control_slave_end_xfer;
  input            d1_onchip_mem_s1_end_xfer;
  input            d1_pio_button_s1_end_xfer;
  input            d1_pio_green_led_s1_end_xfer;
  input            d1_pio_red_led_s1_end_xfer;
  input            d1_pio_switch_s1_end_xfer;
  input            d1_ps2_keyboard_avalon_PS2_slave_end_xfer;
  input            d1_ps2_mouse_avalon_PS2_slave_end_xfer;
  input            d1_sd_clk_s1_end_xfer;
  input            d1_sd_cmd_s1_end_xfer;
  input            d1_sd_dat3_s1_end_xfer;
  input            d1_sd_dat_s1_end_xfer;
  input            d1_sdram_u1_s1_end_xfer;
  input            d1_sdram_u2_s1_end_xfer;
  input            d1_sysid_control_slave_end_xfer;
  input            d1_timer_s1_end_xfer;
  input            d1_timer_stamp_s1_end_xfer;
  input            d1_tristate_bridge_flash_avalon_slave_end_xfer;
  input            d1_tristate_bridge_ssram_avalon_slave_end_xfer;
  input            d1_uart_s1_end_xfer;
  input            i2c_sdat_s1_readdata_from_sa;
  input   [ 15: 0] incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0;
  input   [ 31: 0] incoming_data_to_and_from_the_ssram;
  input            jtag_uart_avalon_jtag_slave_irq_from_sa;
  input   [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  input            jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  input   [  7: 0] lcd_control_slave_readdata_from_sa;
  input            lcd_control_slave_wait_counter_eq_0;
  input   [ 31: 0] onchip_mem_s1_readdata_from_sa;
  input            pio_button_s1_irq_from_sa;
  input   [  3: 0] pio_button_s1_readdata_from_sa;
  input   [ 17: 0] pio_switch_s1_readdata_from_sa;
  input            pll_c0_system;
  input            pll_c0_system_reset_n;
  input            ps2_keyboard_avalon_PS2_slave_irq_from_sa;
  input   [ 31: 0] ps2_keyboard_avalon_PS2_slave_readdata_from_sa;
  input            ps2_keyboard_avalon_PS2_slave_waitrequest_from_sa;
  input            ps2_mouse_avalon_PS2_slave_irq_from_sa;
  input   [ 31: 0] ps2_mouse_avalon_PS2_slave_readdata_from_sa;
  input            ps2_mouse_avalon_PS2_slave_waitrequest_from_sa;
  input            reset_n;
  input            sd_cmd_s1_readdata_from_sa;
  input            sd_dat3_s1_readdata_from_sa;
  input            sd_dat_s1_readdata_from_sa;
  input   [ 15: 0] sdram_u1_s1_readdata_from_sa;
  input            sdram_u1_s1_waitrequest_from_sa;
  input   [ 15: 0] sdram_u2_s1_readdata_from_sa;
  input            sdram_u2_s1_waitrequest_from_sa;
  input   [ 31: 0] sysid_control_slave_readdata_from_sa;
  input            timer_s1_irq_from_sa;
  input   [ 15: 0] timer_s1_readdata_from_sa;
  input            timer_stamp_s1_irq_from_sa;
  input   [ 15: 0] timer_stamp_s1_readdata_from_sa;
  input            uart_s1_irq_from_sa;
  input   [ 15: 0] uart_s1_readdata_from_sa;

  reg              active_and_waiting_last_time;
  reg     [ 27: 0] cpu_data_master_address_last_time;
  wire    [ 27: 0] cpu_data_master_address_to_slave;
  reg     [  1: 0] cpu_data_master_dbs_address;
  wire    [  1: 0] cpu_data_master_dbs_increment;
  reg     [  1: 0] cpu_data_master_dbs_rdv_counter;
  wire    [  1: 0] cpu_data_master_dbs_rdv_counter_inc;
  wire    [ 15: 0] cpu_data_master_dbs_write_16;
  wire    [ 31: 0] cpu_data_master_irq;
  wire             cpu_data_master_is_granted_some_slave;
  reg     [  2: 0] cpu_data_master_latency_counter;
  wire    [  1: 0] cpu_data_master_next_dbs_rdv_counter;
  reg              cpu_data_master_read_but_no_slave_selected;
  reg              cpu_data_master_read_last_time;
  wire    [ 31: 0] cpu_data_master_readdata;
  wire             cpu_data_master_readdatavalid;
  wire             cpu_data_master_run;
  wire             cpu_data_master_waitrequest;
  reg              cpu_data_master_write_last_time;
  reg     [ 31: 0] cpu_data_master_writedata_last_time;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  reg     [ 15: 0] dbs_latent_16_reg_segment_0;
  wire             dbs_rdv_count_enable;
  wire             dbs_rdv_counter_overflow;
  wire    [  2: 0] latency_load_value;
  wire    [  1: 0] next_dbs_address;
  wire    [  2: 0] p1_cpu_data_master_latency_counter;
  wire    [ 15: 0] p1_dbs_latent_16_reg_segment_0;
  wire             pll_c0_system_DM9000A_s1_irq_from_sa;
  wire             pre_dbs_count_enable;
  wire             pre_flush_cpu_data_master_readdatavalid;
  wire             r_0;
  wire             r_1;
  wire             r_2;
  wire             r_3;
  wire             r_4;
  wire             r_5;
  wire             r_6;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (cpu_data_master_qualified_request_AUDIO_s1 | ~cpu_data_master_requests_AUDIO_s1) & ((~cpu_data_master_qualified_request_AUDIO_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_AUDIO_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_ISP1362_dc | ~cpu_data_master_requests_ISP1362_dc) & ((~cpu_data_master_qualified_request_ISP1362_dc | ~cpu_data_master_read | (1 & ((ISP1362_dc_wait_counter_eq_0 & ~d1_ISP1362_dc_end_xfer)) & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_ISP1362_dc | ~cpu_data_master_write | (1 & ((ISP1362_dc_wait_counter_eq_0 & ~d1_ISP1362_dc_end_xfer)) & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_ISP1362_hc | ~cpu_data_master_requests_ISP1362_hc) & ((~cpu_data_master_qualified_request_ISP1362_hc | ~cpu_data_master_read | (1 & ((ISP1362_hc_wait_counter_eq_0 & ~d1_ISP1362_hc_end_xfer)) & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_ISP1362_hc | ~cpu_data_master_write | (1 & ((ISP1362_hc_wait_counter_eq_0 & ~d1_ISP1362_hc_end_xfer)) & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_SEG7_s1 | ~cpu_data_master_requests_SEG7_s1) & ((~cpu_data_master_qualified_request_SEG7_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_SEG7_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_VGA_s1 | ~cpu_data_master_requests_VGA_s1) & ((~cpu_data_master_qualified_request_VGA_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_VGA_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & (cpu_data_master_read | cpu_data_master_write))));

  //cascaded wait assignment, which is an e_assign
  assign cpu_data_master_run = r_0 & r_1 & r_2 & r_3 & r_4 & r_5 & r_6;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = 1 & (cpu_data_master_qualified_request_clock_0_in | ~cpu_data_master_requests_clock_0_in) & ((~cpu_data_master_qualified_request_clock_0_in | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~clock_0_in_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_clock_0_in | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~clock_0_in_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_clock_1_in | ~cpu_data_master_requests_clock_1_in) & ((~cpu_data_master_qualified_request_clock_1_in | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~clock_1_in_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_clock_1_in | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~clock_1_in_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_cpu_jtag_debug_module | ~cpu_data_master_requests_cpu_jtag_debug_module) & (cpu_data_master_granted_cpu_jtag_debug_module | ~cpu_data_master_qualified_request_cpu_jtag_debug_module) & ((~cpu_data_master_qualified_request_cpu_jtag_debug_module | ~cpu_data_master_read | (1 & ~d1_cpu_jtag_debug_module_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_cpu_jtag_debug_module | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & ((~cpu_data_master_qualified_request_i2c_sclk_s1 | ~cpu_data_master_read | (1 & ~d1_i2c_sclk_s1_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_i2c_sclk_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_i2c_sdat_s1 | ~cpu_data_master_requests_i2c_sdat_s1) & ((~cpu_data_master_qualified_request_i2c_sdat_s1 | ~cpu_data_master_read | (1 & ~d1_i2c_sdat_s1_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_i2c_sdat_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write)));

  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = 1 & (cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave | ~cpu_data_master_requests_jtag_uart_avalon_jtag_slave) & ((~cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~jtag_uart_avalon_jtag_slave_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~jtag_uart_avalon_jtag_slave_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_lcd_control_slave | ~cpu_data_master_requests_lcd_control_slave) & ((~cpu_data_master_qualified_request_lcd_control_slave | ~cpu_data_master_read | (1 & ((lcd_control_slave_wait_counter_eq_0 & ~d1_lcd_control_slave_end_xfer)) & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_lcd_control_slave | ~cpu_data_master_write | (1 & ((lcd_control_slave_wait_counter_eq_0 & ~d1_lcd_control_slave_end_xfer)) & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_onchip_mem_s1 | ~cpu_data_master_requests_onchip_mem_s1) & (cpu_data_master_granted_onchip_mem_s1 | ~cpu_data_master_qualified_request_onchip_mem_s1) & ((~cpu_data_master_qualified_request_onchip_mem_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_onchip_mem_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_pio_button_s1 | ~cpu_data_master_requests_pio_button_s1) & ((~cpu_data_master_qualified_request_pio_button_s1 | ~cpu_data_master_read | (1 & ~d1_pio_button_s1_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_pio_button_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & ((~cpu_data_master_qualified_request_pio_green_led_s1 | ~cpu_data_master_read | (1 & ~d1_pio_green_led_s1_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_pio_green_led_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write)));

  //r_3 master_run cascaded wait assignment, which is an e_assign
  assign r_3 = 1 & ((~cpu_data_master_qualified_request_pio_red_led_s1 | ~cpu_data_master_read | (1 & ~d1_pio_red_led_s1_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_pio_red_led_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_pio_switch_s1 | ~cpu_data_master_requests_pio_switch_s1) & ((~cpu_data_master_qualified_request_pio_switch_s1 | ~cpu_data_master_read | (1 & ~d1_pio_switch_s1_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_pio_switch_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_ps2_keyboard_avalon_PS2_slave | ~cpu_data_master_requests_ps2_keyboard_avalon_PS2_slave) & ((~cpu_data_master_qualified_request_ps2_keyboard_avalon_PS2_slave | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~ps2_keyboard_avalon_PS2_slave_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_ps2_keyboard_avalon_PS2_slave | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~ps2_keyboard_avalon_PS2_slave_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_ps2_mouse_avalon_PS2_slave | ~cpu_data_master_requests_ps2_mouse_avalon_PS2_slave) & ((~cpu_data_master_qualified_request_ps2_mouse_avalon_PS2_slave | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~ps2_mouse_avalon_PS2_slave_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_ps2_mouse_avalon_PS2_slave | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~ps2_mouse_avalon_PS2_slave_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & 1 & ((~cpu_data_master_qualified_request_sd_clk_s1 | ~cpu_data_master_read | (1 & ~d1_sd_clk_s1_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_sd_clk_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_sd_cmd_s1 | ~cpu_data_master_requests_sd_cmd_s1);

  //r_4 master_run cascaded wait assignment, which is an e_assign
  assign r_4 = ((~cpu_data_master_qualified_request_sd_cmd_s1 | ~cpu_data_master_read | (1 & ~d1_sd_cmd_s1_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_sd_cmd_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_sd_dat_s1 | ~cpu_data_master_requests_sd_dat_s1) & ((~cpu_data_master_qualified_request_sd_dat_s1 | ~cpu_data_master_read | (1 & ~d1_sd_dat_s1_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_sd_dat_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_sd_dat3_s1 | ~cpu_data_master_requests_sd_dat3_s1) & ((~cpu_data_master_qualified_request_sd_dat3_s1 | ~cpu_data_master_read | (1 & ~d1_sd_dat3_s1_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_sd_dat3_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_sdram_u1_s1 | (cpu_data_master_write & !cpu_data_master_byteenable_sdram_u1_s1 & cpu_data_master_dbs_address[1]) | ~cpu_data_master_requests_sdram_u1_s1) & (cpu_data_master_granted_sdram_u1_s1 | ~cpu_data_master_qualified_request_sdram_u1_s1) & ((~cpu_data_master_qualified_request_sdram_u1_s1 | ~cpu_data_master_read | (1 & ~sdram_u1_s1_waitrequest_from_sa & (cpu_data_master_dbs_address[1]) & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_sdram_u1_s1 | ~cpu_data_master_write | (1 & ~sdram_u1_s1_waitrequest_from_sa & (cpu_data_master_dbs_address[1]) & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_sdram_u2_s1 | (cpu_data_master_write & !cpu_data_master_byteenable_sdram_u2_s1 & cpu_data_master_dbs_address[1]) | ~cpu_data_master_requests_sdram_u2_s1) & (cpu_data_master_granted_sdram_u2_s1 | ~cpu_data_master_qualified_request_sdram_u2_s1) & ((~cpu_data_master_qualified_request_sdram_u2_s1 | ~cpu_data_master_read | (1 & ~sdram_u2_s1_waitrequest_from_sa & (cpu_data_master_dbs_address[1]) & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_sdram_u2_s1 | ~cpu_data_master_write | (1 & ~sdram_u2_s1_waitrequest_from_sa & (cpu_data_master_dbs_address[1]) & cpu_data_master_write)));

  //r_5 master_run cascaded wait assignment, which is an e_assign
  assign r_5 = 1 & (cpu_data_master_qualified_request_sysid_control_slave | ~cpu_data_master_requests_sysid_control_slave) & ((~cpu_data_master_qualified_request_sysid_control_slave | ~cpu_data_master_read | (1 & ~d1_sysid_control_slave_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_sysid_control_slave | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_timer_s1 | ~cpu_data_master_requests_timer_s1) & ((~cpu_data_master_qualified_request_timer_s1 | ~cpu_data_master_read | (1 & ~d1_timer_s1_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_timer_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_timer_stamp_s1 | ~cpu_data_master_requests_timer_stamp_s1) & ((~cpu_data_master_qualified_request_timer_stamp_s1 | ~cpu_data_master_read | (1 & ~d1_timer_stamp_s1_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_timer_stamp_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_cfi_flash_s1 | (cpu_data_master_write & !cpu_data_master_byteenable_cfi_flash_s1 & cpu_data_master_dbs_address[1]) | ~cpu_data_master_requests_cfi_flash_s1) & (cpu_data_master_granted_cfi_flash_s1 | ~cpu_data_master_qualified_request_cfi_flash_s1) & ((~cpu_data_master_qualified_request_cfi_flash_s1 | ~cpu_data_master_read | (1 & ((cfi_flash_s1_wait_counter_eq_0 & ~d1_tristate_bridge_flash_avalon_slave_end_xfer)) & (cpu_data_master_dbs_address[1]) & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_cfi_flash_s1 | ~cpu_data_master_write | (1 & ((cfi_flash_s1_wait_counter_eq_0 & ~d1_tristate_bridge_flash_avalon_slave_end_xfer)) & (cpu_data_master_dbs_address[1]) & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_ssram_s1 | ~cpu_data_master_requests_ssram_s1) & (cpu_data_master_granted_ssram_s1 | ~cpu_data_master_qualified_request_ssram_s1);

  //r_6 master_run cascaded wait assignment, which is an e_assign
  assign r_6 = ((~cpu_data_master_qualified_request_ssram_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_ssram_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_uart_s1 | ~cpu_data_master_requests_uart_s1) & ((~cpu_data_master_qualified_request_uart_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~d1_uart_s1_end_xfer & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_uart_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~d1_uart_s1_end_xfer & (cpu_data_master_read | cpu_data_master_write))));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_data_master_address_to_slave = cpu_data_master_address[27 : 0];

  //cpu_data_master_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_read_but_no_slave_selected <= 0;
      else if (1)
          cpu_data_master_read_but_no_slave_selected <= cpu_data_master_read & cpu_data_master_run & ~cpu_data_master_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign cpu_data_master_is_granted_some_slave = cpu_data_master_granted_AUDIO_s1 |
    cpu_data_master_granted_ISP1362_dc |
    cpu_data_master_granted_ISP1362_hc |
    cpu_data_master_granted_SEG7_s1 |
    cpu_data_master_granted_VGA_s1 |
    cpu_data_master_granted_clock_0_in |
    cpu_data_master_granted_clock_1_in |
    cpu_data_master_granted_cpu_jtag_debug_module |
    cpu_data_master_granted_i2c_sclk_s1 |
    cpu_data_master_granted_i2c_sdat_s1 |
    cpu_data_master_granted_jtag_uart_avalon_jtag_slave |
    cpu_data_master_granted_lcd_control_slave |
    cpu_data_master_granted_onchip_mem_s1 |
    cpu_data_master_granted_pio_button_s1 |
    cpu_data_master_granted_pio_green_led_s1 |
    cpu_data_master_granted_pio_red_led_s1 |
    cpu_data_master_granted_pio_switch_s1 |
    cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave |
    cpu_data_master_granted_ps2_mouse_avalon_PS2_slave |
    cpu_data_master_granted_sd_clk_s1 |
    cpu_data_master_granted_sd_cmd_s1 |
    cpu_data_master_granted_sd_dat_s1 |
    cpu_data_master_granted_sd_dat3_s1 |
    cpu_data_master_granted_sdram_u1_s1 |
    cpu_data_master_granted_sdram_u2_s1 |
    cpu_data_master_granted_sysid_control_slave |
    cpu_data_master_granted_timer_s1 |
    cpu_data_master_granted_timer_stamp_s1 |
    cpu_data_master_granted_cfi_flash_s1 |
    cpu_data_master_granted_ssram_s1 |
    cpu_data_master_granted_uart_s1;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_cpu_data_master_readdatavalid = cpu_data_master_read_data_valid_onchip_mem_s1 |
    cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave |
    cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave |
    (cpu_data_master_read_data_valid_sdram_u1_s1 & dbs_rdv_counter_overflow) |
    (cpu_data_master_read_data_valid_sdram_u2_s1 & dbs_rdv_counter_overflow) |
    (cpu_data_master_read_data_valid_cfi_flash_s1 & dbs_rdv_counter_overflow) |
    cpu_data_master_read_data_valid_ssram_s1;

  //latent slave read data valid which is not flushed, which is an e_mux
  assign cpu_data_master_readdatavalid = cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_AUDIO_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_ISP1362_dc |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_ISP1362_hc |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_SEG7_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_VGA_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_clock_0_in |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_clock_1_in |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_cpu_jtag_debug_module |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_i2c_sclk_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_i2c_sdat_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_lcd_control_slave |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_pio_button_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_pio_green_led_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_pio_red_led_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_pio_switch_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_sd_clk_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_sd_cmd_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_sd_dat_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_sd_dat3_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_sysid_control_slave |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_timer_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_timer_stamp_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_uart_s1;

  //cpu/data_master readdata mux, which is an e_mux
  assign cpu_data_master_readdata = ({32 {~(cpu_data_master_qualified_request_AUDIO_s1 & cpu_data_master_read)}} | AUDIO_s1_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_ISP1362_dc & cpu_data_master_read)}} | ISP1362_dc_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_ISP1362_hc & cpu_data_master_read)}} | ISP1362_hc_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_SEG7_s1 & cpu_data_master_read)}} | SEG7_s1_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_VGA_s1 & cpu_data_master_read)}} | VGA_s1_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_clock_0_in & cpu_data_master_read)}} | clock_0_in_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_clock_1_in & cpu_data_master_read)}} | clock_1_in_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_cpu_jtag_debug_module & cpu_data_master_read)}} | cpu_jtag_debug_module_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_i2c_sdat_s1 & cpu_data_master_read)}} | i2c_sdat_s1_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave & cpu_data_master_read)}} | jtag_uart_avalon_jtag_slave_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_lcd_control_slave & cpu_data_master_read)}} | lcd_control_slave_readdata_from_sa) &
    ({32 {~cpu_data_master_read_data_valid_onchip_mem_s1}} | onchip_mem_s1_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_pio_button_s1 & cpu_data_master_read)}} | pio_button_s1_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_pio_switch_s1 & cpu_data_master_read)}} | pio_switch_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave}} | ps2_keyboard_avalon_PS2_slave_readdata_from_sa) &
    ({32 {~cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave}} | ps2_mouse_avalon_PS2_slave_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_sd_cmd_s1 & cpu_data_master_read)}} | sd_cmd_s1_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_sd_dat_s1 & cpu_data_master_read)}} | sd_dat_s1_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_sd_dat3_s1 & cpu_data_master_read)}} | sd_dat3_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_read_data_valid_sdram_u1_s1}} | {sdram_u1_s1_readdata_from_sa[15 : 0],
    dbs_latent_16_reg_segment_0}) &
    ({32 {~cpu_data_master_read_data_valid_sdram_u2_s1}} | {sdram_u2_s1_readdata_from_sa[15 : 0],
    dbs_latent_16_reg_segment_0}) &
    ({32 {~(cpu_data_master_qualified_request_sysid_control_slave & cpu_data_master_read)}} | sysid_control_slave_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_timer_s1 & cpu_data_master_read)}} | timer_s1_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_timer_stamp_s1 & cpu_data_master_read)}} | timer_stamp_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_read_data_valid_cfi_flash_s1}} | {incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[15 : 0],
    dbs_latent_16_reg_segment_0}) &
    ({32 {~cpu_data_master_read_data_valid_ssram_s1}} | incoming_data_to_and_from_the_ssram) &
    ({32 {~(cpu_data_master_qualified_request_uart_s1 & cpu_data_master_read)}} | uart_s1_readdata_from_sa);

  //actual waitrequest port, which is an e_assign
  assign cpu_data_master_waitrequest = ~cpu_data_master_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_latency_counter <= 0;
      else if (1)
          cpu_data_master_latency_counter <= p1_cpu_data_master_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_cpu_data_master_latency_counter = ((cpu_data_master_run & cpu_data_master_read))? latency_load_value :
    (cpu_data_master_latency_counter)? cpu_data_master_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = ({3 {cpu_data_master_requests_onchip_mem_s1}} & 1) |
    ({3 {cpu_data_master_requests_ps2_keyboard_avalon_PS2_slave}} & 1) |
    ({3 {cpu_data_master_requests_ps2_mouse_avalon_PS2_slave}} & 1) |
    ({3 {cpu_data_master_requests_cfi_flash_s1}} & 2) |
    ({3 {cpu_data_master_requests_ssram_s1}} & 4);

  //DM9000A_s1_irq_from_sa from clk_25 to pll_c0_system
  DM9000A_s1_irq_from_sa_clock_crossing_cpu_data_master_module DM9000A_s1_irq_from_sa_clock_crossing_cpu_data_master
    (
      .clk      (pll_c0_system),
      .data_in  (DM9000A_s1_irq_from_sa),
      .data_out (pll_c0_system_DM9000A_s1_irq_from_sa),
      .reset_n  (pll_c0_system_reset_n)
    );

  //irq assign, which is an e_assign
  assign cpu_data_master_irq = {1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    pll_c0_system_DM9000A_s1_irq_from_sa,
    ps2_mouse_avalon_PS2_slave_irq_from_sa,
    ps2_keyboard_avalon_PS2_slave_irq_from_sa,
    ~ISP1362_dc_irq_n_from_sa,
    ~ISP1362_hc_irq_n_from_sa,
    pio_button_s1_irq_from_sa,
    uart_s1_irq_from_sa,
    jtag_uart_avalon_jtag_slave_irq_from_sa,
    timer_stamp_s1_irq_from_sa,
    timer_s1_irq_from_sa};

  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = (((~0) & cpu_data_master_requests_sdram_u1_s1 & cpu_data_master_write & !cpu_data_master_byteenable_sdram_u1_s1)) |
    (cpu_data_master_granted_sdram_u1_s1 & cpu_data_master_read & 1 & 1 & ~sdram_u1_s1_waitrequest_from_sa) |
    (cpu_data_master_granted_sdram_u1_s1 & cpu_data_master_write & 1 & 1 & ~sdram_u1_s1_waitrequest_from_sa) |
    (((~0) & cpu_data_master_requests_sdram_u2_s1 & cpu_data_master_write & !cpu_data_master_byteenable_sdram_u2_s1)) |
    (cpu_data_master_granted_sdram_u2_s1 & cpu_data_master_read & 1 & 1 & ~sdram_u2_s1_waitrequest_from_sa) |
    (cpu_data_master_granted_sdram_u2_s1 & cpu_data_master_write & 1 & 1 & ~sdram_u2_s1_waitrequest_from_sa) |
    (((~0) & cpu_data_master_requests_cfi_flash_s1 & cpu_data_master_write & !cpu_data_master_byteenable_cfi_flash_s1)) |
    ((cpu_data_master_granted_cfi_flash_s1 & cpu_data_master_read & 1 & 1 & ({cfi_flash_s1_wait_counter_eq_0 & ~d1_tristate_bridge_flash_avalon_slave_end_xfer}))) |
    ((cpu_data_master_granted_cfi_flash_s1 & cpu_data_master_write & 1 & 1 & ({cfi_flash_s1_wait_counter_eq_0 & ~d1_tristate_bridge_flash_avalon_slave_end_xfer})));

  //input to latent dbs-16 stored 0, which is an e_mux
  assign p1_dbs_latent_16_reg_segment_0 = (cpu_data_master_read_data_valid_sdram_u1_s1)? sdram_u1_s1_readdata_from_sa :
    (cpu_data_master_read_data_valid_sdram_u2_s1)? sdram_u2_s1_readdata_from_sa :
    incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0;

  //dbs register for latent dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_latent_16_reg_segment_0 <= 0;
      else if (dbs_rdv_count_enable & ((cpu_data_master_dbs_rdv_counter[1]) == 0))
          dbs_latent_16_reg_segment_0 <= p1_dbs_latent_16_reg_segment_0;
    end


  //mux write dbs 1, which is an e_mux
  assign cpu_data_master_dbs_write_16 = (cpu_data_master_dbs_address[1])? cpu_data_master_writedata[31 : 16] :
    (~(cpu_data_master_dbs_address[1]))? cpu_data_master_writedata[15 : 0] :
    (cpu_data_master_dbs_address[1])? cpu_data_master_writedata[31 : 16] :
    (~(cpu_data_master_dbs_address[1]))? cpu_data_master_writedata[15 : 0] :
    (cpu_data_master_dbs_address[1])? cpu_data_master_writedata[31 : 16] :
    cpu_data_master_writedata[15 : 0];

  //dbs count increment, which is an e_mux
  assign cpu_data_master_dbs_increment = (cpu_data_master_requests_sdram_u1_s1)? 2 :
    (cpu_data_master_requests_sdram_u2_s1)? 2 :
    (cpu_data_master_requests_cfi_flash_s1)? 2 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_data_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_data_master_dbs_address + cpu_data_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable;

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_data_master_dbs_address <= next_dbs_address;
    end


  //p1 dbs rdv counter, which is an e_assign
  assign cpu_data_master_next_dbs_rdv_counter = cpu_data_master_dbs_rdv_counter + cpu_data_master_dbs_rdv_counter_inc;

  //cpu_data_master_rdv_inc_mux, which is an e_mux
  assign cpu_data_master_dbs_rdv_counter_inc = (cpu_data_master_read_data_valid_sdram_u1_s1)? 2 :
    (cpu_data_master_read_data_valid_sdram_u2_s1)? 2 :
    2;

  //master any slave rdv, which is an e_mux
  assign dbs_rdv_count_enable = cpu_data_master_read_data_valid_sdram_u1_s1 |
    cpu_data_master_read_data_valid_sdram_u2_s1 |
    cpu_data_master_read_data_valid_cfi_flash_s1;

  //dbs rdv counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_dbs_rdv_counter <= 0;
      else if (dbs_rdv_count_enable)
          cpu_data_master_dbs_rdv_counter <= cpu_data_master_next_dbs_rdv_counter;
    end


  //dbs rdv counter overflow, which is an e_assign
  assign dbs_rdv_counter_overflow = cpu_data_master_dbs_rdv_counter[1] & ~cpu_data_master_next_dbs_rdv_counter[1];


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_data_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_address_last_time <= 0;
      else if (1)
          cpu_data_master_address_last_time <= cpu_data_master_address;
    end


  //cpu/data_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else if (1)
          active_and_waiting_last_time <= cpu_data_master_waitrequest & (cpu_data_master_read | cpu_data_master_write);
    end


  //cpu_data_master_address matches last port_name, which is an e_process
  always @(active_and_waiting_last_time or cpu_data_master_address or cpu_data_master_address_last_time)
    begin
      if (active_and_waiting_last_time & (cpu_data_master_address != cpu_data_master_address_last_time))
        begin
          $write("%0d ns: cpu_data_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_data_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_read_last_time <= 0;
      else if (1)
          cpu_data_master_read_last_time <= cpu_data_master_read;
    end


  //cpu_data_master_read matches last port_name, which is an e_process
  always @(active_and_waiting_last_time or cpu_data_master_read or cpu_data_master_read_last_time)
    begin
      if (active_and_waiting_last_time & (cpu_data_master_read != cpu_data_master_read_last_time))
        begin
          $write("%0d ns: cpu_data_master_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_data_master_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_write_last_time <= 0;
      else if (1)
          cpu_data_master_write_last_time <= cpu_data_master_write;
    end


  //cpu_data_master_write matches last port_name, which is an e_process
  always @(active_and_waiting_last_time or cpu_data_master_write or cpu_data_master_write_last_time)
    begin
      if (active_and_waiting_last_time & (cpu_data_master_write != cpu_data_master_write_last_time))
        begin
          $write("%0d ns: cpu_data_master_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_data_master_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_writedata_last_time <= 0;
      else if (1)
          cpu_data_master_writedata_last_time <= cpu_data_master_writedata;
    end


  //cpu_data_master_writedata matches last port_name, which is an e_process
  always @(active_and_waiting_last_time or cpu_data_master_write or cpu_data_master_writedata or cpu_data_master_writedata_last_time)
    begin
      if (active_and_waiting_last_time & (cpu_data_master_writedata != cpu_data_master_writedata_last_time) & cpu_data_master_write)
        begin
          $write("%0d ns: cpu_data_master_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_instruction_master_arbitrator (
                                           // inputs:
                                            cfi_flash_s1_wait_counter_eq_0,
                                            clk,
                                            cpu_instruction_master_address,
                                            cpu_instruction_master_granted_cfi_flash_s1,
                                            cpu_instruction_master_granted_cpu_jtag_debug_module,
                                            cpu_instruction_master_granted_onchip_mem_s1,
                                            cpu_instruction_master_granted_sdram_u1_s1,
                                            cpu_instruction_master_granted_sdram_u2_s1,
                                            cpu_instruction_master_granted_ssram_s1,
                                            cpu_instruction_master_qualified_request_cfi_flash_s1,
                                            cpu_instruction_master_qualified_request_cpu_jtag_debug_module,
                                            cpu_instruction_master_qualified_request_onchip_mem_s1,
                                            cpu_instruction_master_qualified_request_sdram_u1_s1,
                                            cpu_instruction_master_qualified_request_sdram_u2_s1,
                                            cpu_instruction_master_qualified_request_ssram_s1,
                                            cpu_instruction_master_read,
                                            cpu_instruction_master_read_data_valid_cfi_flash_s1,
                                            cpu_instruction_master_read_data_valid_cpu_jtag_debug_module,
                                            cpu_instruction_master_read_data_valid_onchip_mem_s1,
                                            cpu_instruction_master_read_data_valid_sdram_u1_s1,
                                            cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register,
                                            cpu_instruction_master_read_data_valid_sdram_u2_s1,
                                            cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register,
                                            cpu_instruction_master_read_data_valid_ssram_s1,
                                            cpu_instruction_master_requests_cfi_flash_s1,
                                            cpu_instruction_master_requests_cpu_jtag_debug_module,
                                            cpu_instruction_master_requests_onchip_mem_s1,
                                            cpu_instruction_master_requests_sdram_u1_s1,
                                            cpu_instruction_master_requests_sdram_u2_s1,
                                            cpu_instruction_master_requests_ssram_s1,
                                            cpu_jtag_debug_module_readdata_from_sa,
                                            d1_cpu_jtag_debug_module_end_xfer,
                                            d1_onchip_mem_s1_end_xfer,
                                            d1_sdram_u1_s1_end_xfer,
                                            d1_sdram_u2_s1_end_xfer,
                                            d1_tristate_bridge_flash_avalon_slave_end_xfer,
                                            d1_tristate_bridge_ssram_avalon_slave_end_xfer,
                                            incoming_data_to_and_from_the_cfi_flash,
                                            incoming_data_to_and_from_the_ssram,
                                            onchip_mem_s1_readdata_from_sa,
                                            reset_n,
                                            sdram_u1_s1_readdata_from_sa,
                                            sdram_u1_s1_waitrequest_from_sa,
                                            sdram_u2_s1_readdata_from_sa,
                                            sdram_u2_s1_waitrequest_from_sa,

                                           // outputs:
                                            cpu_instruction_master_address_to_slave,
                                            cpu_instruction_master_dbs_address,
                                            cpu_instruction_master_latency_counter,
                                            cpu_instruction_master_readdata,
                                            cpu_instruction_master_readdatavalid,
                                            cpu_instruction_master_waitrequest
                                         )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output  [ 27: 0] cpu_instruction_master_address_to_slave;
  output  [  1: 0] cpu_instruction_master_dbs_address;
  output  [  2: 0] cpu_instruction_master_latency_counter;
  output  [ 31: 0] cpu_instruction_master_readdata;
  output           cpu_instruction_master_readdatavalid;
  output           cpu_instruction_master_waitrequest;
  input            cfi_flash_s1_wait_counter_eq_0;
  input            clk;
  input   [ 27: 0] cpu_instruction_master_address;
  input            cpu_instruction_master_granted_cfi_flash_s1;
  input            cpu_instruction_master_granted_cpu_jtag_debug_module;
  input            cpu_instruction_master_granted_onchip_mem_s1;
  input            cpu_instruction_master_granted_sdram_u1_s1;
  input            cpu_instruction_master_granted_sdram_u2_s1;
  input            cpu_instruction_master_granted_ssram_s1;
  input            cpu_instruction_master_qualified_request_cfi_flash_s1;
  input            cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  input            cpu_instruction_master_qualified_request_onchip_mem_s1;
  input            cpu_instruction_master_qualified_request_sdram_u1_s1;
  input            cpu_instruction_master_qualified_request_sdram_u2_s1;
  input            cpu_instruction_master_qualified_request_ssram_s1;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_cfi_flash_s1;
  input            cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  input            cpu_instruction_master_read_data_valid_onchip_mem_s1;
  input            cpu_instruction_master_read_data_valid_sdram_u1_s1;
  input            cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_instruction_master_read_data_valid_sdram_u2_s1;
  input            cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_instruction_master_read_data_valid_ssram_s1;
  input            cpu_instruction_master_requests_cfi_flash_s1;
  input            cpu_instruction_master_requests_cpu_jtag_debug_module;
  input            cpu_instruction_master_requests_onchip_mem_s1;
  input            cpu_instruction_master_requests_sdram_u1_s1;
  input            cpu_instruction_master_requests_sdram_u2_s1;
  input            cpu_instruction_master_requests_ssram_s1;
  input   [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  input            d1_cpu_jtag_debug_module_end_xfer;
  input            d1_onchip_mem_s1_end_xfer;
  input            d1_sdram_u1_s1_end_xfer;
  input            d1_sdram_u2_s1_end_xfer;
  input            d1_tristate_bridge_flash_avalon_slave_end_xfer;
  input            d1_tristate_bridge_ssram_avalon_slave_end_xfer;
  input   [ 15: 0] incoming_data_to_and_from_the_cfi_flash;
  input   [ 31: 0] incoming_data_to_and_from_the_ssram;
  input   [ 31: 0] onchip_mem_s1_readdata_from_sa;
  input            reset_n;
  input   [ 15: 0] sdram_u1_s1_readdata_from_sa;
  input            sdram_u1_s1_waitrequest_from_sa;
  input   [ 15: 0] sdram_u2_s1_readdata_from_sa;
  input            sdram_u2_s1_waitrequest_from_sa;

  reg              active_and_waiting_last_time;
  reg     [ 27: 0] cpu_instruction_master_address_last_time;
  wire    [ 27: 0] cpu_instruction_master_address_to_slave;
  reg     [  1: 0] cpu_instruction_master_dbs_address;
  wire    [  1: 0] cpu_instruction_master_dbs_increment;
  reg     [  1: 0] cpu_instruction_master_dbs_rdv_counter;
  wire    [  1: 0] cpu_instruction_master_dbs_rdv_counter_inc;
  wire             cpu_instruction_master_is_granted_some_slave;
  reg     [  2: 0] cpu_instruction_master_latency_counter;
  wire    [  1: 0] cpu_instruction_master_next_dbs_rdv_counter;
  reg              cpu_instruction_master_read_but_no_slave_selected;
  reg              cpu_instruction_master_read_last_time;
  wire    [ 31: 0] cpu_instruction_master_readdata;
  wire             cpu_instruction_master_readdatavalid;
  wire             cpu_instruction_master_run;
  wire             cpu_instruction_master_waitrequest;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  reg     [ 15: 0] dbs_latent_16_reg_segment_0;
  wire             dbs_rdv_count_enable;
  wire             dbs_rdv_counter_overflow;
  wire    [  2: 0] latency_load_value;
  wire    [  1: 0] next_dbs_address;
  wire    [  2: 0] p1_cpu_instruction_master_latency_counter;
  wire    [ 15: 0] p1_dbs_latent_16_reg_segment_0;
  wire             pre_dbs_count_enable;
  wire             pre_flush_cpu_instruction_master_readdatavalid;
  wire             r_1;
  wire             r_2;
  wire             r_4;
  wire             r_5;
  wire             r_6;
  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = 1 & (cpu_instruction_master_qualified_request_cpu_jtag_debug_module | ~cpu_instruction_master_requests_cpu_jtag_debug_module) & (cpu_instruction_master_granted_cpu_jtag_debug_module | ~cpu_instruction_master_qualified_request_cpu_jtag_debug_module) & ((~cpu_instruction_master_qualified_request_cpu_jtag_debug_module | ~cpu_instruction_master_read | (1 & ~d1_cpu_jtag_debug_module_end_xfer & cpu_instruction_master_read)));

  //cascaded wait assignment, which is an e_assign
  assign cpu_instruction_master_run = r_1 & r_2 & r_4 & r_5 & r_6;

  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = 1 & (cpu_instruction_master_qualified_request_onchip_mem_s1 | ~cpu_instruction_master_requests_onchip_mem_s1) & (cpu_instruction_master_granted_onchip_mem_s1 | ~cpu_instruction_master_qualified_request_onchip_mem_s1) & ((~cpu_instruction_master_qualified_request_onchip_mem_s1 | ~(cpu_instruction_master_read) | (1 & (cpu_instruction_master_read))));

  //r_4 master_run cascaded wait assignment, which is an e_assign
  assign r_4 = 1 & (cpu_instruction_master_qualified_request_sdram_u1_s1 | ~cpu_instruction_master_requests_sdram_u1_s1) & (cpu_instruction_master_granted_sdram_u1_s1 | ~cpu_instruction_master_qualified_request_sdram_u1_s1) & ((~cpu_instruction_master_qualified_request_sdram_u1_s1 | ~cpu_instruction_master_read | (1 & ~sdram_u1_s1_waitrequest_from_sa & (cpu_instruction_master_dbs_address[1]) & cpu_instruction_master_read))) & 1 & (cpu_instruction_master_qualified_request_sdram_u2_s1 | ~cpu_instruction_master_requests_sdram_u2_s1) & (cpu_instruction_master_granted_sdram_u2_s1 | ~cpu_instruction_master_qualified_request_sdram_u2_s1) & ((~cpu_instruction_master_qualified_request_sdram_u2_s1 | ~cpu_instruction_master_read | (1 & ~sdram_u2_s1_waitrequest_from_sa & (cpu_instruction_master_dbs_address[1]) & cpu_instruction_master_read)));

  //r_5 master_run cascaded wait assignment, which is an e_assign
  assign r_5 = 1 & (cpu_instruction_master_qualified_request_cfi_flash_s1 | ~cpu_instruction_master_requests_cfi_flash_s1) & (cpu_instruction_master_granted_cfi_flash_s1 | ~cpu_instruction_master_qualified_request_cfi_flash_s1) & ((~cpu_instruction_master_qualified_request_cfi_flash_s1 | ~cpu_instruction_master_read | (1 & ((cfi_flash_s1_wait_counter_eq_0 & ~d1_tristate_bridge_flash_avalon_slave_end_xfer)) & (cpu_instruction_master_dbs_address[1]) & cpu_instruction_master_read))) & 1 & (cpu_instruction_master_qualified_request_ssram_s1 | ~cpu_instruction_master_requests_ssram_s1);

  //r_6 master_run cascaded wait assignment, which is an e_assign
  assign r_6 = (cpu_instruction_master_granted_ssram_s1 | ~cpu_instruction_master_qualified_request_ssram_s1) & ((~cpu_instruction_master_qualified_request_ssram_s1 | ~(cpu_instruction_master_read) | (1 & (cpu_instruction_master_read))));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_instruction_master_address_to_slave = cpu_instruction_master_address[27 : 0];

  //cpu_instruction_master_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_read_but_no_slave_selected <= 0;
      else if (1)
          cpu_instruction_master_read_but_no_slave_selected <= cpu_instruction_master_read & cpu_instruction_master_run & ~cpu_instruction_master_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign cpu_instruction_master_is_granted_some_slave = cpu_instruction_master_granted_cpu_jtag_debug_module |
    cpu_instruction_master_granted_onchip_mem_s1 |
    cpu_instruction_master_granted_sdram_u1_s1 |
    cpu_instruction_master_granted_sdram_u2_s1 |
    cpu_instruction_master_granted_cfi_flash_s1 |
    cpu_instruction_master_granted_ssram_s1;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_cpu_instruction_master_readdatavalid = cpu_instruction_master_read_data_valid_onchip_mem_s1 |
    (cpu_instruction_master_read_data_valid_sdram_u1_s1 & dbs_rdv_counter_overflow) |
    (cpu_instruction_master_read_data_valid_sdram_u2_s1 & dbs_rdv_counter_overflow) |
    (cpu_instruction_master_read_data_valid_cfi_flash_s1 & dbs_rdv_counter_overflow) |
    cpu_instruction_master_read_data_valid_ssram_s1;

  //latent slave read data valid which is not flushed, which is an e_mux
  assign cpu_instruction_master_readdatavalid = cpu_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_instruction_master_readdatavalid |
    cpu_instruction_master_read_data_valid_cpu_jtag_debug_module |
    cpu_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_instruction_master_readdatavalid |
    cpu_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_instruction_master_readdatavalid |
    cpu_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_instruction_master_readdatavalid |
    cpu_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_instruction_master_readdatavalid |
    cpu_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_instruction_master_readdatavalid;

  //cpu/instruction_master readdata mux, which is an e_mux
  assign cpu_instruction_master_readdata = ({32 {~(cpu_instruction_master_qualified_request_cpu_jtag_debug_module & cpu_instruction_master_read)}} | cpu_jtag_debug_module_readdata_from_sa) &
    ({32 {~cpu_instruction_master_read_data_valid_onchip_mem_s1}} | onchip_mem_s1_readdata_from_sa) &
    ({32 {~cpu_instruction_master_read_data_valid_sdram_u1_s1}} | {sdram_u1_s1_readdata_from_sa[15 : 0],
    dbs_latent_16_reg_segment_0}) &
    ({32 {~cpu_instruction_master_read_data_valid_sdram_u2_s1}} | {sdram_u2_s1_readdata_from_sa[15 : 0],
    dbs_latent_16_reg_segment_0}) &
    ({32 {~cpu_instruction_master_read_data_valid_cfi_flash_s1}} | {incoming_data_to_and_from_the_cfi_flash[15 : 0],
    dbs_latent_16_reg_segment_0}) &
    ({32 {~cpu_instruction_master_read_data_valid_ssram_s1}} | incoming_data_to_and_from_the_ssram);

  //actual waitrequest port, which is an e_assign
  assign cpu_instruction_master_waitrequest = ~cpu_instruction_master_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_latency_counter <= 0;
      else if (1)
          cpu_instruction_master_latency_counter <= p1_cpu_instruction_master_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_cpu_instruction_master_latency_counter = ((cpu_instruction_master_run & cpu_instruction_master_read))? latency_load_value :
    (cpu_instruction_master_latency_counter)? cpu_instruction_master_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = ({3 {cpu_instruction_master_requests_onchip_mem_s1}} & 1) |
    ({3 {cpu_instruction_master_requests_cfi_flash_s1}} & 2) |
    ({3 {cpu_instruction_master_requests_ssram_s1}} & 4);

  //input to latent dbs-16 stored 0, which is an e_mux
  assign p1_dbs_latent_16_reg_segment_0 = (cpu_instruction_master_read_data_valid_sdram_u1_s1)? sdram_u1_s1_readdata_from_sa :
    (cpu_instruction_master_read_data_valid_sdram_u2_s1)? sdram_u2_s1_readdata_from_sa :
    incoming_data_to_and_from_the_cfi_flash;

  //dbs register for latent dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_latent_16_reg_segment_0 <= 0;
      else if (dbs_rdv_count_enable & ((cpu_instruction_master_dbs_rdv_counter[1]) == 0))
          dbs_latent_16_reg_segment_0 <= p1_dbs_latent_16_reg_segment_0;
    end


  //dbs count increment, which is an e_mux
  assign cpu_instruction_master_dbs_increment = (cpu_instruction_master_requests_sdram_u1_s1)? 2 :
    (cpu_instruction_master_requests_sdram_u2_s1)? 2 :
    (cpu_instruction_master_requests_cfi_flash_s1)? 2 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_instruction_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_instruction_master_dbs_address + cpu_instruction_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable;

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_instruction_master_dbs_address <= next_dbs_address;
    end


  //p1 dbs rdv counter, which is an e_assign
  assign cpu_instruction_master_next_dbs_rdv_counter = cpu_instruction_master_dbs_rdv_counter + cpu_instruction_master_dbs_rdv_counter_inc;

  //cpu_instruction_master_rdv_inc_mux, which is an e_mux
  assign cpu_instruction_master_dbs_rdv_counter_inc = (cpu_instruction_master_read_data_valid_sdram_u1_s1)? 2 :
    (cpu_instruction_master_read_data_valid_sdram_u2_s1)? 2 :
    2;

  //master any slave rdv, which is an e_mux
  assign dbs_rdv_count_enable = cpu_instruction_master_read_data_valid_sdram_u1_s1 |
    cpu_instruction_master_read_data_valid_sdram_u2_s1 |
    cpu_instruction_master_read_data_valid_cfi_flash_s1;

  //dbs rdv counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_dbs_rdv_counter <= 0;
      else if (dbs_rdv_count_enable)
          cpu_instruction_master_dbs_rdv_counter <= cpu_instruction_master_next_dbs_rdv_counter;
    end


  //dbs rdv counter overflow, which is an e_assign
  assign dbs_rdv_counter_overflow = cpu_instruction_master_dbs_rdv_counter[1] & ~cpu_instruction_master_next_dbs_rdv_counter[1];

  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = (cpu_instruction_master_granted_sdram_u1_s1 & cpu_instruction_master_read & 1 & 1 & ~sdram_u1_s1_waitrequest_from_sa) |
    (cpu_instruction_master_granted_sdram_u2_s1 & cpu_instruction_master_read & 1 & 1 & ~sdram_u2_s1_waitrequest_from_sa) |
    ((cpu_instruction_master_granted_cfi_flash_s1 & cpu_instruction_master_read & 1 & 1 & ({cfi_flash_s1_wait_counter_eq_0 & ~d1_tristate_bridge_flash_avalon_slave_end_xfer})));


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_instruction_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_address_last_time <= 0;
      else if (1)
          cpu_instruction_master_address_last_time <= cpu_instruction_master_address;
    end


  //cpu/instruction_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else if (1)
          active_and_waiting_last_time <= cpu_instruction_master_waitrequest & (cpu_instruction_master_read);
    end


  //cpu_instruction_master_address matches last port_name, which is an e_process
  always @(active_and_waiting_last_time or cpu_instruction_master_address or cpu_instruction_master_address_last_time)
    begin
      if (active_and_waiting_last_time & (cpu_instruction_master_address != cpu_instruction_master_address_last_time))
        begin
          $write("%0d ns: cpu_instruction_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_instruction_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_read_last_time <= 0;
      else if (1)
          cpu_instruction_master_read_last_time <= cpu_instruction_master_read;
    end


  //cpu_instruction_master_read matches last port_name, which is an e_process
  always @(active_and_waiting_last_time or cpu_instruction_master_read or cpu_instruction_master_read_last_time)
    begin
      if (active_and_waiting_last_time & (cpu_instruction_master_read != cpu_instruction_master_read_last_time))
        begin
          $write("%0d ns: cpu_instruction_master_read did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module i2c_sclk_s1_arbitrator (
                                // inputs:
                                 clk,
                                 cpu_data_master_address_to_slave,
                                 cpu_data_master_latency_counter,
                                 cpu_data_master_read,
                                 cpu_data_master_write,
                                 cpu_data_master_writedata,
                                 reset_n,

                                // outputs:
                                 cpu_data_master_granted_i2c_sclk_s1,
                                 cpu_data_master_qualified_request_i2c_sclk_s1,
                                 cpu_data_master_read_data_valid_i2c_sclk_s1,
                                 cpu_data_master_requests_i2c_sclk_s1,
                                 d1_i2c_sclk_s1_end_xfer,
                                 i2c_sclk_s1_address,
                                 i2c_sclk_s1_chipselect,
                                 i2c_sclk_s1_reset_n,
                                 i2c_sclk_s1_write_n,
                                 i2c_sclk_s1_writedata
                              )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_i2c_sclk_s1;
  output           cpu_data_master_qualified_request_i2c_sclk_s1;
  output           cpu_data_master_read_data_valid_i2c_sclk_s1;
  output           cpu_data_master_requests_i2c_sclk_s1;
  output           d1_i2c_sclk_s1_end_xfer;
  output  [  1: 0] i2c_sclk_s1_address;
  output           i2c_sclk_s1_chipselect;
  output           i2c_sclk_s1_reset_n;
  output           i2c_sclk_s1_write_n;
  output           i2c_sclk_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_i2c_sclk_s1;
  wire             cpu_data_master_qualified_request_i2c_sclk_s1;
  wire             cpu_data_master_read_data_valid_i2c_sclk_s1;
  wire             cpu_data_master_requests_i2c_sclk_s1;
  wire             cpu_data_master_saved_grant_i2c_sclk_s1;
  reg              d1_i2c_sclk_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_i2c_sclk_s1;
  wire    [  1: 0] i2c_sclk_s1_address;
  wire             i2c_sclk_s1_allgrants;
  wire             i2c_sclk_s1_allow_new_arb_cycle;
  wire             i2c_sclk_s1_any_bursting_master_saved_grant;
  wire             i2c_sclk_s1_any_continuerequest;
  wire             i2c_sclk_s1_arb_counter_enable;
  reg     [  1: 0] i2c_sclk_s1_arb_share_counter;
  wire    [  1: 0] i2c_sclk_s1_arb_share_counter_next_value;
  wire    [  1: 0] i2c_sclk_s1_arb_share_set_values;
  wire             i2c_sclk_s1_beginbursttransfer_internal;
  wire             i2c_sclk_s1_begins_xfer;
  wire             i2c_sclk_s1_chipselect;
  wire             i2c_sclk_s1_end_xfer;
  wire             i2c_sclk_s1_firsttransfer;
  wire             i2c_sclk_s1_grant_vector;
  wire             i2c_sclk_s1_in_a_read_cycle;
  wire             i2c_sclk_s1_in_a_write_cycle;
  wire             i2c_sclk_s1_master_qreq_vector;
  wire             i2c_sclk_s1_non_bursting_master_requests;
  reg              i2c_sclk_s1_reg_firsttransfer;
  wire             i2c_sclk_s1_reset_n;
  reg              i2c_sclk_s1_slavearbiterlockenable;
  wire             i2c_sclk_s1_slavearbiterlockenable2;
  wire             i2c_sclk_s1_unreg_firsttransfer;
  wire             i2c_sclk_s1_waits_for_read;
  wire             i2c_sclk_s1_waits_for_write;
  wire             i2c_sclk_s1_write_n;
  wire             i2c_sclk_s1_writedata;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_i2c_sclk_s1_from_cpu_data_master;
  wire             wait_for_i2c_sclk_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~i2c_sclk_s1_end_xfer;
    end


  assign i2c_sclk_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_i2c_sclk_s1));
  assign cpu_data_master_requests_i2c_sclk_s1 = (({cpu_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h9641170) & (cpu_data_master_read | cpu_data_master_write)) & cpu_data_master_write;
  //i2c_sclk_s1_arb_share_counter set values, which is an e_mux
  assign i2c_sclk_s1_arb_share_set_values = 1;

  //i2c_sclk_s1_non_bursting_master_requests mux, which is an e_mux
  assign i2c_sclk_s1_non_bursting_master_requests = cpu_data_master_requests_i2c_sclk_s1;

  //i2c_sclk_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign i2c_sclk_s1_any_bursting_master_saved_grant = 0;

  //i2c_sclk_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign i2c_sclk_s1_arb_share_counter_next_value = i2c_sclk_s1_firsttransfer ? (i2c_sclk_s1_arb_share_set_values - 1) : |i2c_sclk_s1_arb_share_counter ? (i2c_sclk_s1_arb_share_counter - 1) : 0;

  //i2c_sclk_s1_allgrants all slave grants, which is an e_mux
  assign i2c_sclk_s1_allgrants = |i2c_sclk_s1_grant_vector;

  //i2c_sclk_s1_end_xfer assignment, which is an e_assign
  assign i2c_sclk_s1_end_xfer = ~(i2c_sclk_s1_waits_for_read | i2c_sclk_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_i2c_sclk_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_i2c_sclk_s1 = i2c_sclk_s1_end_xfer & (~i2c_sclk_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //i2c_sclk_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign i2c_sclk_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_i2c_sclk_s1 & i2c_sclk_s1_allgrants) | (end_xfer_arb_share_counter_term_i2c_sclk_s1 & ~i2c_sclk_s1_non_bursting_master_requests);

  //i2c_sclk_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          i2c_sclk_s1_arb_share_counter <= 0;
      else if (i2c_sclk_s1_arb_counter_enable)
          i2c_sclk_s1_arb_share_counter <= i2c_sclk_s1_arb_share_counter_next_value;
    end


  //i2c_sclk_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          i2c_sclk_s1_slavearbiterlockenable <= 0;
      else if ((|i2c_sclk_s1_master_qreq_vector & end_xfer_arb_share_counter_term_i2c_sclk_s1) | (end_xfer_arb_share_counter_term_i2c_sclk_s1 & ~i2c_sclk_s1_non_bursting_master_requests))
          i2c_sclk_s1_slavearbiterlockenable <= |i2c_sclk_s1_arb_share_counter_next_value;
    end


  //cpu/data_master i2c_sclk/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = i2c_sclk_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //i2c_sclk_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign i2c_sclk_s1_slavearbiterlockenable2 = |i2c_sclk_s1_arb_share_counter_next_value;

  //cpu/data_master i2c_sclk/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = i2c_sclk_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //i2c_sclk_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign i2c_sclk_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_i2c_sclk_s1 = cpu_data_master_requests_i2c_sclk_s1;
  //local readdatavalid cpu_data_master_read_data_valid_i2c_sclk_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_i2c_sclk_s1 = cpu_data_master_granted_i2c_sclk_s1 & cpu_data_master_read & ~i2c_sclk_s1_waits_for_read;

  //i2c_sclk_s1_writedata mux, which is an e_mux
  assign i2c_sclk_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_i2c_sclk_s1 = cpu_data_master_qualified_request_i2c_sclk_s1;

  //cpu/data_master saved-grant i2c_sclk/s1, which is an e_assign
  assign cpu_data_master_saved_grant_i2c_sclk_s1 = cpu_data_master_requests_i2c_sclk_s1;

  //allow new arb cycle for i2c_sclk/s1, which is an e_assign
  assign i2c_sclk_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign i2c_sclk_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign i2c_sclk_s1_master_qreq_vector = 1;

  //i2c_sclk_s1_reset_n assignment, which is an e_assign
  assign i2c_sclk_s1_reset_n = reset_n;

  assign i2c_sclk_s1_chipselect = cpu_data_master_granted_i2c_sclk_s1;
  //i2c_sclk_s1_firsttransfer first transaction, which is an e_assign
  assign i2c_sclk_s1_firsttransfer = i2c_sclk_s1_begins_xfer ? i2c_sclk_s1_unreg_firsttransfer : i2c_sclk_s1_reg_firsttransfer;

  //i2c_sclk_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign i2c_sclk_s1_unreg_firsttransfer = ~(i2c_sclk_s1_slavearbiterlockenable & i2c_sclk_s1_any_continuerequest);

  //i2c_sclk_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          i2c_sclk_s1_reg_firsttransfer <= 1'b1;
      else if (i2c_sclk_s1_begins_xfer)
          i2c_sclk_s1_reg_firsttransfer <= i2c_sclk_s1_unreg_firsttransfer;
    end


  //i2c_sclk_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign i2c_sclk_s1_beginbursttransfer_internal = i2c_sclk_s1_begins_xfer;

  //~i2c_sclk_s1_write_n assignment, which is an e_mux
  assign i2c_sclk_s1_write_n = ~(cpu_data_master_granted_i2c_sclk_s1 & cpu_data_master_write);

  assign shifted_address_to_i2c_sclk_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //i2c_sclk_s1_address mux, which is an e_mux
  assign i2c_sclk_s1_address = shifted_address_to_i2c_sclk_s1_from_cpu_data_master >> 2;

  //d1_i2c_sclk_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_i2c_sclk_s1_end_xfer <= 1;
      else if (1)
          d1_i2c_sclk_s1_end_xfer <= i2c_sclk_s1_end_xfer;
    end


  //i2c_sclk_s1_waits_for_read in a cycle, which is an e_mux
  assign i2c_sclk_s1_waits_for_read = i2c_sclk_s1_in_a_read_cycle & i2c_sclk_s1_begins_xfer;

  //i2c_sclk_s1_in_a_read_cycle assignment, which is an e_assign
  assign i2c_sclk_s1_in_a_read_cycle = cpu_data_master_granted_i2c_sclk_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = i2c_sclk_s1_in_a_read_cycle;

  //i2c_sclk_s1_waits_for_write in a cycle, which is an e_mux
  assign i2c_sclk_s1_waits_for_write = i2c_sclk_s1_in_a_write_cycle & 0;

  //i2c_sclk_s1_in_a_write_cycle assignment, which is an e_assign
  assign i2c_sclk_s1_in_a_write_cycle = cpu_data_master_granted_i2c_sclk_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = i2c_sclk_s1_in_a_write_cycle;

  assign wait_for_i2c_sclk_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //i2c_sclk/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module i2c_sdat_s1_arbitrator (
                                // inputs:
                                 clk,
                                 cpu_data_master_address_to_slave,
                                 cpu_data_master_latency_counter,
                                 cpu_data_master_read,
                                 cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                 cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                 cpu_data_master_write,
                                 cpu_data_master_writedata,
                                 i2c_sdat_s1_readdata,
                                 reset_n,

                                // outputs:
                                 cpu_data_master_granted_i2c_sdat_s1,
                                 cpu_data_master_qualified_request_i2c_sdat_s1,
                                 cpu_data_master_read_data_valid_i2c_sdat_s1,
                                 cpu_data_master_requests_i2c_sdat_s1,
                                 d1_i2c_sdat_s1_end_xfer,
                                 i2c_sdat_s1_address,
                                 i2c_sdat_s1_chipselect,
                                 i2c_sdat_s1_readdata_from_sa,
                                 i2c_sdat_s1_reset_n,
                                 i2c_sdat_s1_write_n,
                                 i2c_sdat_s1_writedata
                              )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_i2c_sdat_s1;
  output           cpu_data_master_qualified_request_i2c_sdat_s1;
  output           cpu_data_master_read_data_valid_i2c_sdat_s1;
  output           cpu_data_master_requests_i2c_sdat_s1;
  output           d1_i2c_sdat_s1_end_xfer;
  output  [  1: 0] i2c_sdat_s1_address;
  output           i2c_sdat_s1_chipselect;
  output           i2c_sdat_s1_readdata_from_sa;
  output           i2c_sdat_s1_reset_n;
  output           i2c_sdat_s1_write_n;
  output           i2c_sdat_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            i2c_sdat_s1_readdata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_i2c_sdat_s1;
  wire             cpu_data_master_qualified_request_i2c_sdat_s1;
  wire             cpu_data_master_read_data_valid_i2c_sdat_s1;
  wire             cpu_data_master_requests_i2c_sdat_s1;
  wire             cpu_data_master_saved_grant_i2c_sdat_s1;
  reg              d1_i2c_sdat_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_i2c_sdat_s1;
  wire    [  1: 0] i2c_sdat_s1_address;
  wire             i2c_sdat_s1_allgrants;
  wire             i2c_sdat_s1_allow_new_arb_cycle;
  wire             i2c_sdat_s1_any_bursting_master_saved_grant;
  wire             i2c_sdat_s1_any_continuerequest;
  wire             i2c_sdat_s1_arb_counter_enable;
  reg     [  1: 0] i2c_sdat_s1_arb_share_counter;
  wire    [  1: 0] i2c_sdat_s1_arb_share_counter_next_value;
  wire    [  1: 0] i2c_sdat_s1_arb_share_set_values;
  wire             i2c_sdat_s1_beginbursttransfer_internal;
  wire             i2c_sdat_s1_begins_xfer;
  wire             i2c_sdat_s1_chipselect;
  wire             i2c_sdat_s1_end_xfer;
  wire             i2c_sdat_s1_firsttransfer;
  wire             i2c_sdat_s1_grant_vector;
  wire             i2c_sdat_s1_in_a_read_cycle;
  wire             i2c_sdat_s1_in_a_write_cycle;
  wire             i2c_sdat_s1_master_qreq_vector;
  wire             i2c_sdat_s1_non_bursting_master_requests;
  wire             i2c_sdat_s1_readdata_from_sa;
  reg              i2c_sdat_s1_reg_firsttransfer;
  wire             i2c_sdat_s1_reset_n;
  reg              i2c_sdat_s1_slavearbiterlockenable;
  wire             i2c_sdat_s1_slavearbiterlockenable2;
  wire             i2c_sdat_s1_unreg_firsttransfer;
  wire             i2c_sdat_s1_waits_for_read;
  wire             i2c_sdat_s1_waits_for_write;
  wire             i2c_sdat_s1_write_n;
  wire             i2c_sdat_s1_writedata;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_i2c_sdat_s1_from_cpu_data_master;
  wire             wait_for_i2c_sdat_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~i2c_sdat_s1_end_xfer;
    end


  assign i2c_sdat_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_i2c_sdat_s1));
  //assign i2c_sdat_s1_readdata_from_sa = i2c_sdat_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign i2c_sdat_s1_readdata_from_sa = i2c_sdat_s1_readdata;

  assign cpu_data_master_requests_i2c_sdat_s1 = ({cpu_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h9641180) & (cpu_data_master_read | cpu_data_master_write);
  //i2c_sdat_s1_arb_share_counter set values, which is an e_mux
  assign i2c_sdat_s1_arb_share_set_values = 1;

  //i2c_sdat_s1_non_bursting_master_requests mux, which is an e_mux
  assign i2c_sdat_s1_non_bursting_master_requests = cpu_data_master_requests_i2c_sdat_s1;

  //i2c_sdat_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign i2c_sdat_s1_any_bursting_master_saved_grant = 0;

  //i2c_sdat_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign i2c_sdat_s1_arb_share_counter_next_value = i2c_sdat_s1_firsttransfer ? (i2c_sdat_s1_arb_share_set_values - 1) : |i2c_sdat_s1_arb_share_counter ? (i2c_sdat_s1_arb_share_counter - 1) : 0;

  //i2c_sdat_s1_allgrants all slave grants, which is an e_mux
  assign i2c_sdat_s1_allgrants = |i2c_sdat_s1_grant_vector;

  //i2c_sdat_s1_end_xfer assignment, which is an e_assign
  assign i2c_sdat_s1_end_xfer = ~(i2c_sdat_s1_waits_for_read | i2c_sdat_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_i2c_sdat_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_i2c_sdat_s1 = i2c_sdat_s1_end_xfer & (~i2c_sdat_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //i2c_sdat_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign i2c_sdat_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_i2c_sdat_s1 & i2c_sdat_s1_allgrants) | (end_xfer_arb_share_counter_term_i2c_sdat_s1 & ~i2c_sdat_s1_non_bursting_master_requests);

  //i2c_sdat_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          i2c_sdat_s1_arb_share_counter <= 0;
      else if (i2c_sdat_s1_arb_counter_enable)
          i2c_sdat_s1_arb_share_counter <= i2c_sdat_s1_arb_share_counter_next_value;
    end


  //i2c_sdat_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          i2c_sdat_s1_slavearbiterlockenable <= 0;
      else if ((|i2c_sdat_s1_master_qreq_vector & end_xfer_arb_share_counter_term_i2c_sdat_s1) | (end_xfer_arb_share_counter_term_i2c_sdat_s1 & ~i2c_sdat_s1_non_bursting_master_requests))
          i2c_sdat_s1_slavearbiterlockenable <= |i2c_sdat_s1_arb_share_counter_next_value;
    end


  //cpu/data_master i2c_sdat/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = i2c_sdat_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //i2c_sdat_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign i2c_sdat_s1_slavearbiterlockenable2 = |i2c_sdat_s1_arb_share_counter_next_value;

  //cpu/data_master i2c_sdat/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = i2c_sdat_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //i2c_sdat_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign i2c_sdat_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_i2c_sdat_s1 = cpu_data_master_requests_i2c_sdat_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_i2c_sdat_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_i2c_sdat_s1 = cpu_data_master_granted_i2c_sdat_s1 & cpu_data_master_read & ~i2c_sdat_s1_waits_for_read;

  //i2c_sdat_s1_writedata mux, which is an e_mux
  assign i2c_sdat_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_i2c_sdat_s1 = cpu_data_master_qualified_request_i2c_sdat_s1;

  //cpu/data_master saved-grant i2c_sdat/s1, which is an e_assign
  assign cpu_data_master_saved_grant_i2c_sdat_s1 = cpu_data_master_requests_i2c_sdat_s1;

  //allow new arb cycle for i2c_sdat/s1, which is an e_assign
  assign i2c_sdat_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign i2c_sdat_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign i2c_sdat_s1_master_qreq_vector = 1;

  //i2c_sdat_s1_reset_n assignment, which is an e_assign
  assign i2c_sdat_s1_reset_n = reset_n;

  assign i2c_sdat_s1_chipselect = cpu_data_master_granted_i2c_sdat_s1;
  //i2c_sdat_s1_firsttransfer first transaction, which is an e_assign
  assign i2c_sdat_s1_firsttransfer = i2c_sdat_s1_begins_xfer ? i2c_sdat_s1_unreg_firsttransfer : i2c_sdat_s1_reg_firsttransfer;

  //i2c_sdat_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign i2c_sdat_s1_unreg_firsttransfer = ~(i2c_sdat_s1_slavearbiterlockenable & i2c_sdat_s1_any_continuerequest);

  //i2c_sdat_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          i2c_sdat_s1_reg_firsttransfer <= 1'b1;
      else if (i2c_sdat_s1_begins_xfer)
          i2c_sdat_s1_reg_firsttransfer <= i2c_sdat_s1_unreg_firsttransfer;
    end


  //i2c_sdat_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign i2c_sdat_s1_beginbursttransfer_internal = i2c_sdat_s1_begins_xfer;

  //~i2c_sdat_s1_write_n assignment, which is an e_mux
  assign i2c_sdat_s1_write_n = ~(cpu_data_master_granted_i2c_sdat_s1 & cpu_data_master_write);

  assign shifted_address_to_i2c_sdat_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //i2c_sdat_s1_address mux, which is an e_mux
  assign i2c_sdat_s1_address = shifted_address_to_i2c_sdat_s1_from_cpu_data_master >> 2;

  //d1_i2c_sdat_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_i2c_sdat_s1_end_xfer <= 1;
      else if (1)
          d1_i2c_sdat_s1_end_xfer <= i2c_sdat_s1_end_xfer;
    end


  //i2c_sdat_s1_waits_for_read in a cycle, which is an e_mux
  assign i2c_sdat_s1_waits_for_read = i2c_sdat_s1_in_a_read_cycle & i2c_sdat_s1_begins_xfer;

  //i2c_sdat_s1_in_a_read_cycle assignment, which is an e_assign
  assign i2c_sdat_s1_in_a_read_cycle = cpu_data_master_granted_i2c_sdat_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = i2c_sdat_s1_in_a_read_cycle;

  //i2c_sdat_s1_waits_for_write in a cycle, which is an e_mux
  assign i2c_sdat_s1_waits_for_write = i2c_sdat_s1_in_a_write_cycle & 0;

  //i2c_sdat_s1_in_a_write_cycle assignment, which is an e_assign
  assign i2c_sdat_s1_in_a_write_cycle = cpu_data_master_granted_i2c_sdat_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = i2c_sdat_s1_in_a_write_cycle;

  assign wait_for_i2c_sdat_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //i2c_sdat/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module jtag_uart_avalon_jtag_slave_arbitrator (
                                                // inputs:
                                                 clk,
                                                 cpu_data_master_address_to_slave,
                                                 cpu_data_master_latency_counter,
                                                 cpu_data_master_read,
                                                 cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                                 cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                                 cpu_data_master_write,
                                                 cpu_data_master_writedata,
                                                 jtag_uart_avalon_jtag_slave_dataavailable,
                                                 jtag_uart_avalon_jtag_slave_irq,
                                                 jtag_uart_avalon_jtag_slave_readdata,
                                                 jtag_uart_avalon_jtag_slave_readyfordata,
                                                 jtag_uart_avalon_jtag_slave_waitrequest,
                                                 reset_n,

                                                // outputs:
                                                 cpu_data_master_granted_jtag_uart_avalon_jtag_slave,
                                                 cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave,
                                                 cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave,
                                                 cpu_data_master_requests_jtag_uart_avalon_jtag_slave,
                                                 d1_jtag_uart_avalon_jtag_slave_end_xfer,
                                                 jtag_uart_avalon_jtag_slave_address,
                                                 jtag_uart_avalon_jtag_slave_chipselect,
                                                 jtag_uart_avalon_jtag_slave_dataavailable_from_sa,
                                                 jtag_uart_avalon_jtag_slave_irq_from_sa,
                                                 jtag_uart_avalon_jtag_slave_read_n,
                                                 jtag_uart_avalon_jtag_slave_readdata_from_sa,
                                                 jtag_uart_avalon_jtag_slave_readyfordata_from_sa,
                                                 jtag_uart_avalon_jtag_slave_reset_n,
                                                 jtag_uart_avalon_jtag_slave_waitrequest_from_sa,
                                                 jtag_uart_avalon_jtag_slave_write_n,
                                                 jtag_uart_avalon_jtag_slave_writedata
                                              )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  output           cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  output           cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  output           cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  output           d1_jtag_uart_avalon_jtag_slave_end_xfer;
  output           jtag_uart_avalon_jtag_slave_address;
  output           jtag_uart_avalon_jtag_slave_chipselect;
  output           jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  output           jtag_uart_avalon_jtag_slave_irq_from_sa;
  output           jtag_uart_avalon_jtag_slave_read_n;
  output  [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  output           jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  output           jtag_uart_avalon_jtag_slave_reset_n;
  output           jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  output           jtag_uart_avalon_jtag_slave_write_n;
  output  [ 31: 0] jtag_uart_avalon_jtag_slave_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            jtag_uart_avalon_jtag_slave_dataavailable;
  input            jtag_uart_avalon_jtag_slave_irq;
  input   [ 31: 0] jtag_uart_avalon_jtag_slave_readdata;
  input            jtag_uart_avalon_jtag_slave_readyfordata;
  input            jtag_uart_avalon_jtag_slave_waitrequest;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_saved_grant_jtag_uart_avalon_jtag_slave;
  reg              d1_jtag_uart_avalon_jtag_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             jtag_uart_avalon_jtag_slave_address;
  wire             jtag_uart_avalon_jtag_slave_allgrants;
  wire             jtag_uart_avalon_jtag_slave_allow_new_arb_cycle;
  wire             jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant;
  wire             jtag_uart_avalon_jtag_slave_any_continuerequest;
  wire             jtag_uart_avalon_jtag_slave_arb_counter_enable;
  reg     [  1: 0] jtag_uart_avalon_jtag_slave_arb_share_counter;
  wire    [  1: 0] jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;
  wire    [  1: 0] jtag_uart_avalon_jtag_slave_arb_share_set_values;
  wire             jtag_uart_avalon_jtag_slave_beginbursttransfer_internal;
  wire             jtag_uart_avalon_jtag_slave_begins_xfer;
  wire             jtag_uart_avalon_jtag_slave_chipselect;
  wire             jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_avalon_jtag_slave_end_xfer;
  wire             jtag_uart_avalon_jtag_slave_firsttransfer;
  wire             jtag_uart_avalon_jtag_slave_grant_vector;
  wire             jtag_uart_avalon_jtag_slave_in_a_read_cycle;
  wire             jtag_uart_avalon_jtag_slave_in_a_write_cycle;
  wire             jtag_uart_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_avalon_jtag_slave_master_qreq_vector;
  wire             jtag_uart_avalon_jtag_slave_non_bursting_master_requests;
  wire             jtag_uart_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  reg              jtag_uart_avalon_jtag_slave_reg_firsttransfer;
  wire             jtag_uart_avalon_jtag_slave_reset_n;
  reg              jtag_uart_avalon_jtag_slave_slavearbiterlockenable;
  wire             jtag_uart_avalon_jtag_slave_slavearbiterlockenable2;
  wire             jtag_uart_avalon_jtag_slave_unreg_firsttransfer;
  wire             jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_avalon_jtag_slave_waits_for_read;
  wire             jtag_uart_avalon_jtag_slave_waits_for_write;
  wire             jtag_uart_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_writedata;
  wire    [ 27: 0] shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master;
  wire             wait_for_jtag_uart_avalon_jtag_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~jtag_uart_avalon_jtag_slave_end_xfer;
    end


  assign jtag_uart_avalon_jtag_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave));
  //assign jtag_uart_avalon_jtag_slave_readdata_from_sa = jtag_uart_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_readdata_from_sa = jtag_uart_avalon_jtag_slave_readdata;

  assign cpu_data_master_requests_jtag_uart_avalon_jtag_slave = ({cpu_data_master_address_to_slave[27 : 3] , 3'b0} == 28'h96411e8) & (cpu_data_master_read | cpu_data_master_write);
  //assign jtag_uart_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_avalon_jtag_slave_dataavailable;

  //assign jtag_uart_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_avalon_jtag_slave_readyfordata;

  //assign jtag_uart_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_avalon_jtag_slave_waitrequest;

  //jtag_uart_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_arb_share_set_values = 1;

  //jtag_uart_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_non_bursting_master_requests = cpu_data_master_requests_jtag_uart_avalon_jtag_slave;

  //jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant = 0;

  //jtag_uart_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_arb_share_counter_next_value = jtag_uart_avalon_jtag_slave_firsttransfer ? (jtag_uart_avalon_jtag_slave_arb_share_set_values - 1) : |jtag_uart_avalon_jtag_slave_arb_share_counter ? (jtag_uart_avalon_jtag_slave_arb_share_counter - 1) : 0;

  //jtag_uart_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_allgrants = |jtag_uart_avalon_jtag_slave_grant_vector;

  //jtag_uart_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_end_xfer = ~(jtag_uart_avalon_jtag_slave_waits_for_read | jtag_uart_avalon_jtag_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave = jtag_uart_avalon_jtag_slave_end_xfer & (~jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //jtag_uart_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave & jtag_uart_avalon_jtag_slave_allgrants) | (end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave & ~jtag_uart_avalon_jtag_slave_non_bursting_master_requests);

  //jtag_uart_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_avalon_jtag_slave_arb_share_counter <= 0;
      else if (jtag_uart_avalon_jtag_slave_arb_counter_enable)
          jtag_uart_avalon_jtag_slave_arb_share_counter <= jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //jtag_uart_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_avalon_jtag_slave_slavearbiterlockenable <= 0;
      else if ((|jtag_uart_avalon_jtag_slave_master_qreq_vector & end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave) | (end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave & ~jtag_uart_avalon_jtag_slave_non_bursting_master_requests))
          jtag_uart_avalon_jtag_slave_slavearbiterlockenable <= |jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //cpu/data_master jtag_uart/avalon_jtag_slave arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = jtag_uart_avalon_jtag_slave_slavearbiterlockenable & cpu_data_master_continuerequest;

  //jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 = |jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;

  //cpu/data_master jtag_uart/avalon_jtag_slave arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //jtag_uart_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave = cpu_data_master_requests_jtag_uart_avalon_jtag_slave & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave, which is an e_mux
  assign cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave = cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_read & ~jtag_uart_avalon_jtag_slave_waits_for_read;

  //jtag_uart_avalon_jtag_slave_writedata mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_jtag_uart_avalon_jtag_slave = cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;

  //cpu/data_master saved-grant jtag_uart/avalon_jtag_slave, which is an e_assign
  assign cpu_data_master_saved_grant_jtag_uart_avalon_jtag_slave = cpu_data_master_requests_jtag_uart_avalon_jtag_slave;

  //allow new arb cycle for jtag_uart/avalon_jtag_slave, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign jtag_uart_avalon_jtag_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign jtag_uart_avalon_jtag_slave_master_qreq_vector = 1;

  //jtag_uart_avalon_jtag_slave_reset_n assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_reset_n = reset_n;

  assign jtag_uart_avalon_jtag_slave_chipselect = cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  //jtag_uart_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_firsttransfer = jtag_uart_avalon_jtag_slave_begins_xfer ? jtag_uart_avalon_jtag_slave_unreg_firsttransfer : jtag_uart_avalon_jtag_slave_reg_firsttransfer;

  //jtag_uart_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_unreg_firsttransfer = ~(jtag_uart_avalon_jtag_slave_slavearbiterlockenable & jtag_uart_avalon_jtag_slave_any_continuerequest);

  //jtag_uart_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_avalon_jtag_slave_reg_firsttransfer <= 1'b1;
      else if (jtag_uart_avalon_jtag_slave_begins_xfer)
          jtag_uart_avalon_jtag_slave_reg_firsttransfer <= jtag_uart_avalon_jtag_slave_unreg_firsttransfer;
    end


  //jtag_uart_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_beginbursttransfer_internal = jtag_uart_avalon_jtag_slave_begins_xfer;

  //~jtag_uart_avalon_jtag_slave_read_n assignment, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_read_n = ~(cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_read);

  //~jtag_uart_avalon_jtag_slave_write_n assignment, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_write_n = ~(cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_write);

  assign shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master = cpu_data_master_address_to_slave;
  //jtag_uart_avalon_jtag_slave_address mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_address = shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master >> 2;

  //d1_jtag_uart_avalon_jtag_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_jtag_uart_avalon_jtag_slave_end_xfer <= 1;
      else if (1)
          d1_jtag_uart_avalon_jtag_slave_end_xfer <= jtag_uart_avalon_jtag_slave_end_xfer;
    end


  //jtag_uart_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_waits_for_read = jtag_uart_avalon_jtag_slave_in_a_read_cycle & jtag_uart_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_in_a_read_cycle = cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = jtag_uart_avalon_jtag_slave_in_a_read_cycle;

  //jtag_uart_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_waits_for_write = jtag_uart_avalon_jtag_slave_in_a_write_cycle & jtag_uart_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_in_a_write_cycle = cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = jtag_uart_avalon_jtag_slave_in_a_write_cycle;

  assign wait_for_jtag_uart_avalon_jtag_slave_counter = 0;
  //assign jtag_uart_avalon_jtag_slave_irq_from_sa = jtag_uart_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_irq_from_sa = jtag_uart_avalon_jtag_slave_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //jtag_uart/avalon_jtag_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module lcd_control_slave_arbitrator (
                                      // inputs:
                                       clk,
                                       cpu_data_master_address_to_slave,
                                       cpu_data_master_byteenable,
                                       cpu_data_master_latency_counter,
                                       cpu_data_master_read,
                                       cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                       cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                       cpu_data_master_write,
                                       cpu_data_master_writedata,
                                       lcd_control_slave_readdata,
                                       reset_n,

                                      // outputs:
                                       cpu_data_master_granted_lcd_control_slave,
                                       cpu_data_master_qualified_request_lcd_control_slave,
                                       cpu_data_master_read_data_valid_lcd_control_slave,
                                       cpu_data_master_requests_lcd_control_slave,
                                       d1_lcd_control_slave_end_xfer,
                                       lcd_control_slave_address,
                                       lcd_control_slave_begintransfer,
                                       lcd_control_slave_read,
                                       lcd_control_slave_readdata_from_sa,
                                       lcd_control_slave_wait_counter_eq_0,
                                       lcd_control_slave_write,
                                       lcd_control_slave_writedata
                                    )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_lcd_control_slave;
  output           cpu_data_master_qualified_request_lcd_control_slave;
  output           cpu_data_master_read_data_valid_lcd_control_slave;
  output           cpu_data_master_requests_lcd_control_slave;
  output           d1_lcd_control_slave_end_xfer;
  output  [  1: 0] lcd_control_slave_address;
  output           lcd_control_slave_begintransfer;
  output           lcd_control_slave_read;
  output  [  7: 0] lcd_control_slave_readdata_from_sa;
  output           lcd_control_slave_wait_counter_eq_0;
  output           lcd_control_slave_write;
  output  [  7: 0] lcd_control_slave_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [  7: 0] lcd_control_slave_readdata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_lcd_control_slave;
  wire             cpu_data_master_qualified_request_lcd_control_slave;
  wire             cpu_data_master_read_data_valid_lcd_control_slave;
  wire             cpu_data_master_requests_lcd_control_slave;
  wire             cpu_data_master_saved_grant_lcd_control_slave;
  reg              d1_lcd_control_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_lcd_control_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] lcd_control_slave_address;
  wire             lcd_control_slave_allgrants;
  wire             lcd_control_slave_allow_new_arb_cycle;
  wire             lcd_control_slave_any_bursting_master_saved_grant;
  wire             lcd_control_slave_any_continuerequest;
  wire             lcd_control_slave_arb_counter_enable;
  reg     [  1: 0] lcd_control_slave_arb_share_counter;
  wire    [  1: 0] lcd_control_slave_arb_share_counter_next_value;
  wire    [  1: 0] lcd_control_slave_arb_share_set_values;
  wire             lcd_control_slave_beginbursttransfer_internal;
  wire             lcd_control_slave_begins_xfer;
  wire             lcd_control_slave_begintransfer;
  wire    [  6: 0] lcd_control_slave_counter_load_value;
  wire             lcd_control_slave_end_xfer;
  wire             lcd_control_slave_firsttransfer;
  wire             lcd_control_slave_grant_vector;
  wire             lcd_control_slave_in_a_read_cycle;
  wire             lcd_control_slave_in_a_write_cycle;
  wire             lcd_control_slave_master_qreq_vector;
  wire             lcd_control_slave_non_bursting_master_requests;
  wire             lcd_control_slave_pretend_byte_enable;
  wire             lcd_control_slave_read;
  wire    [  7: 0] lcd_control_slave_readdata_from_sa;
  reg              lcd_control_slave_reg_firsttransfer;
  reg              lcd_control_slave_slavearbiterlockenable;
  wire             lcd_control_slave_slavearbiterlockenable2;
  wire             lcd_control_slave_unreg_firsttransfer;
  reg     [  6: 0] lcd_control_slave_wait_counter;
  wire             lcd_control_slave_wait_counter_eq_0;
  wire             lcd_control_slave_waits_for_read;
  wire             lcd_control_slave_waits_for_write;
  wire             lcd_control_slave_write;
  wire    [  7: 0] lcd_control_slave_writedata;
  wire    [ 27: 0] shifted_address_to_lcd_control_slave_from_cpu_data_master;
  wire             wait_for_lcd_control_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~lcd_control_slave_end_xfer;
    end


  assign lcd_control_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_lcd_control_slave));
  //assign lcd_control_slave_readdata_from_sa = lcd_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign lcd_control_slave_readdata_from_sa = lcd_control_slave_readdata;

  assign cpu_data_master_requests_lcd_control_slave = ({cpu_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h9641160) & (cpu_data_master_read | cpu_data_master_write);
  //lcd_control_slave_arb_share_counter set values, which is an e_mux
  assign lcd_control_slave_arb_share_set_values = 1;

  //lcd_control_slave_non_bursting_master_requests mux, which is an e_mux
  assign lcd_control_slave_non_bursting_master_requests = cpu_data_master_requests_lcd_control_slave;

  //lcd_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign lcd_control_slave_any_bursting_master_saved_grant = 0;

  //lcd_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign lcd_control_slave_arb_share_counter_next_value = lcd_control_slave_firsttransfer ? (lcd_control_slave_arb_share_set_values - 1) : |lcd_control_slave_arb_share_counter ? (lcd_control_slave_arb_share_counter - 1) : 0;

  //lcd_control_slave_allgrants all slave grants, which is an e_mux
  assign lcd_control_slave_allgrants = |lcd_control_slave_grant_vector;

  //lcd_control_slave_end_xfer assignment, which is an e_assign
  assign lcd_control_slave_end_xfer = ~(lcd_control_slave_waits_for_read | lcd_control_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_lcd_control_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_lcd_control_slave = lcd_control_slave_end_xfer & (~lcd_control_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //lcd_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign lcd_control_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_lcd_control_slave & lcd_control_slave_allgrants) | (end_xfer_arb_share_counter_term_lcd_control_slave & ~lcd_control_slave_non_bursting_master_requests);

  //lcd_control_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_control_slave_arb_share_counter <= 0;
      else if (lcd_control_slave_arb_counter_enable)
          lcd_control_slave_arb_share_counter <= lcd_control_slave_arb_share_counter_next_value;
    end


  //lcd_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_control_slave_slavearbiterlockenable <= 0;
      else if ((|lcd_control_slave_master_qreq_vector & end_xfer_arb_share_counter_term_lcd_control_slave) | (end_xfer_arb_share_counter_term_lcd_control_slave & ~lcd_control_slave_non_bursting_master_requests))
          lcd_control_slave_slavearbiterlockenable <= |lcd_control_slave_arb_share_counter_next_value;
    end


  //cpu/data_master lcd/control_slave arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = lcd_control_slave_slavearbiterlockenable & cpu_data_master_continuerequest;

  //lcd_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign lcd_control_slave_slavearbiterlockenable2 = |lcd_control_slave_arb_share_counter_next_value;

  //cpu/data_master lcd/control_slave arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = lcd_control_slave_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //lcd_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign lcd_control_slave_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_lcd_control_slave = cpu_data_master_requests_lcd_control_slave & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_lcd_control_slave, which is an e_mux
  assign cpu_data_master_read_data_valid_lcd_control_slave = cpu_data_master_granted_lcd_control_slave & cpu_data_master_read & ~lcd_control_slave_waits_for_read;

  //lcd_control_slave_writedata mux, which is an e_mux
  assign lcd_control_slave_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_lcd_control_slave = cpu_data_master_qualified_request_lcd_control_slave;

  //cpu/data_master saved-grant lcd/control_slave, which is an e_assign
  assign cpu_data_master_saved_grant_lcd_control_slave = cpu_data_master_requests_lcd_control_slave;

  //allow new arb cycle for lcd/control_slave, which is an e_assign
  assign lcd_control_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign lcd_control_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign lcd_control_slave_master_qreq_vector = 1;

  assign lcd_control_slave_begintransfer = lcd_control_slave_begins_xfer;
  //lcd_control_slave_firsttransfer first transaction, which is an e_assign
  assign lcd_control_slave_firsttransfer = lcd_control_slave_begins_xfer ? lcd_control_slave_unreg_firsttransfer : lcd_control_slave_reg_firsttransfer;

  //lcd_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign lcd_control_slave_unreg_firsttransfer = ~(lcd_control_slave_slavearbiterlockenable & lcd_control_slave_any_continuerequest);

  //lcd_control_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_control_slave_reg_firsttransfer <= 1'b1;
      else if (lcd_control_slave_begins_xfer)
          lcd_control_slave_reg_firsttransfer <= lcd_control_slave_unreg_firsttransfer;
    end


  //lcd_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign lcd_control_slave_beginbursttransfer_internal = lcd_control_slave_begins_xfer;

  //lcd_control_slave_read assignment, which is an e_mux
  assign lcd_control_slave_read = ((cpu_data_master_granted_lcd_control_slave & cpu_data_master_read))& ~lcd_control_slave_begins_xfer & (lcd_control_slave_wait_counter < 25);

  //lcd_control_slave_write assignment, which is an e_mux
  assign lcd_control_slave_write = ((cpu_data_master_granted_lcd_control_slave & cpu_data_master_write)) & ~lcd_control_slave_begins_xfer & (lcd_control_slave_wait_counter >= 25) & (lcd_control_slave_wait_counter < 50) & lcd_control_slave_pretend_byte_enable;

  assign shifted_address_to_lcd_control_slave_from_cpu_data_master = cpu_data_master_address_to_slave;
  //lcd_control_slave_address mux, which is an e_mux
  assign lcd_control_slave_address = shifted_address_to_lcd_control_slave_from_cpu_data_master >> 2;

  //d1_lcd_control_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_lcd_control_slave_end_xfer <= 1;
      else if (1)
          d1_lcd_control_slave_end_xfer <= lcd_control_slave_end_xfer;
    end


  //lcd_control_slave_waits_for_read in a cycle, which is an e_mux
  assign lcd_control_slave_waits_for_read = lcd_control_slave_in_a_read_cycle & wait_for_lcd_control_slave_counter;

  //lcd_control_slave_in_a_read_cycle assignment, which is an e_assign
  assign lcd_control_slave_in_a_read_cycle = cpu_data_master_granted_lcd_control_slave & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = lcd_control_slave_in_a_read_cycle;

  //lcd_control_slave_waits_for_write in a cycle, which is an e_mux
  assign lcd_control_slave_waits_for_write = lcd_control_slave_in_a_write_cycle & wait_for_lcd_control_slave_counter;

  //lcd_control_slave_in_a_write_cycle assignment, which is an e_assign
  assign lcd_control_slave_in_a_write_cycle = cpu_data_master_granted_lcd_control_slave & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = lcd_control_slave_in_a_write_cycle;

  assign lcd_control_slave_wait_counter_eq_0 = lcd_control_slave_wait_counter == 0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_control_slave_wait_counter <= 0;
      else if (1)
          lcd_control_slave_wait_counter <= lcd_control_slave_counter_load_value;
    end


  assign lcd_control_slave_counter_load_value = ((lcd_control_slave_in_a_read_cycle & lcd_control_slave_begins_xfer))? 48 :
    ((lcd_control_slave_in_a_write_cycle & lcd_control_slave_begins_xfer))? 73 :
    (~lcd_control_slave_wait_counter_eq_0)? lcd_control_slave_wait_counter - 1 :
    0;

  assign wait_for_lcd_control_slave_counter = lcd_control_slave_begins_xfer | ~lcd_control_slave_wait_counter_eq_0;
  //lcd_control_slave_pretend_byte_enable byte enable port mux, which is an e_mux
  assign lcd_control_slave_pretend_byte_enable = (cpu_data_master_granted_lcd_control_slave)? cpu_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //lcd/control_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module onchip_mem_s1_arbitrator (
                                  // inputs:
                                   clk,
                                   cpu_data_master_address_to_slave,
                                   cpu_data_master_byteenable,
                                   cpu_data_master_latency_counter,
                                   cpu_data_master_read,
                                   cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                   cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                   cpu_data_master_write,
                                   cpu_data_master_writedata,
                                   cpu_instruction_master_address_to_slave,
                                   cpu_instruction_master_latency_counter,
                                   cpu_instruction_master_read,
                                   cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register,
                                   cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register,
                                   onchip_mem_s1_readdata,
                                   reset_n,

                                  // outputs:
                                   cpu_data_master_granted_onchip_mem_s1,
                                   cpu_data_master_qualified_request_onchip_mem_s1,
                                   cpu_data_master_read_data_valid_onchip_mem_s1,
                                   cpu_data_master_requests_onchip_mem_s1,
                                   cpu_instruction_master_granted_onchip_mem_s1,
                                   cpu_instruction_master_qualified_request_onchip_mem_s1,
                                   cpu_instruction_master_read_data_valid_onchip_mem_s1,
                                   cpu_instruction_master_requests_onchip_mem_s1,
                                   d1_onchip_mem_s1_end_xfer,
                                   onchip_mem_s1_address,
                                   onchip_mem_s1_byteenable,
                                   onchip_mem_s1_chipselect,
                                   onchip_mem_s1_clken,
                                   onchip_mem_s1_readdata_from_sa,
                                   onchip_mem_s1_write,
                                   onchip_mem_s1_writedata
                                )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_onchip_mem_s1;
  output           cpu_data_master_qualified_request_onchip_mem_s1;
  output           cpu_data_master_read_data_valid_onchip_mem_s1;
  output           cpu_data_master_requests_onchip_mem_s1;
  output           cpu_instruction_master_granted_onchip_mem_s1;
  output           cpu_instruction_master_qualified_request_onchip_mem_s1;
  output           cpu_instruction_master_read_data_valid_onchip_mem_s1;
  output           cpu_instruction_master_requests_onchip_mem_s1;
  output           d1_onchip_mem_s1_end_xfer;
  output  [ 10: 0] onchip_mem_s1_address;
  output  [  3: 0] onchip_mem_s1_byteenable;
  output           onchip_mem_s1_chipselect;
  output           onchip_mem_s1_clken;
  output  [ 31: 0] onchip_mem_s1_readdata_from_sa;
  output           onchip_mem_s1_write;
  output  [ 31: 0] onchip_mem_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [ 27: 0] cpu_instruction_master_address_to_slave;
  input   [  2: 0] cpu_instruction_master_latency_counter;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register;
  input   [ 31: 0] onchip_mem_s1_readdata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_onchip_mem_s1;
  wire             cpu_data_master_qualified_request_onchip_mem_s1;
  wire             cpu_data_master_read_data_valid_onchip_mem_s1;
  reg              cpu_data_master_read_data_valid_onchip_mem_s1_shift_register;
  wire             cpu_data_master_read_data_valid_onchip_mem_s1_shift_register_in;
  wire             cpu_data_master_requests_onchip_mem_s1;
  wire             cpu_data_master_saved_grant_onchip_mem_s1;
  wire             cpu_instruction_master_arbiterlock;
  wire             cpu_instruction_master_arbiterlock2;
  wire             cpu_instruction_master_continuerequest;
  wire             cpu_instruction_master_granted_onchip_mem_s1;
  wire             cpu_instruction_master_qualified_request_onchip_mem_s1;
  wire             cpu_instruction_master_read_data_valid_onchip_mem_s1;
  reg              cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register;
  wire             cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register_in;
  wire             cpu_instruction_master_requests_onchip_mem_s1;
  wire             cpu_instruction_master_saved_grant_onchip_mem_s1;
  reg              d1_onchip_mem_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_onchip_mem_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_data_master_granted_slave_onchip_mem_s1;
  reg              last_cycle_cpu_instruction_master_granted_slave_onchip_mem_s1;
  wire    [ 10: 0] onchip_mem_s1_address;
  wire             onchip_mem_s1_allgrants;
  wire             onchip_mem_s1_allow_new_arb_cycle;
  wire             onchip_mem_s1_any_bursting_master_saved_grant;
  wire             onchip_mem_s1_any_continuerequest;
  reg     [  1: 0] onchip_mem_s1_arb_addend;
  wire             onchip_mem_s1_arb_counter_enable;
  reg     [  1: 0] onchip_mem_s1_arb_share_counter;
  wire    [  1: 0] onchip_mem_s1_arb_share_counter_next_value;
  wire    [  1: 0] onchip_mem_s1_arb_share_set_values;
  wire    [  1: 0] onchip_mem_s1_arb_winner;
  wire             onchip_mem_s1_arbitration_holdoff_internal;
  wire             onchip_mem_s1_beginbursttransfer_internal;
  wire             onchip_mem_s1_begins_xfer;
  wire    [  3: 0] onchip_mem_s1_byteenable;
  wire             onchip_mem_s1_chipselect;
  wire    [  3: 0] onchip_mem_s1_chosen_master_double_vector;
  wire    [  1: 0] onchip_mem_s1_chosen_master_rot_left;
  wire             onchip_mem_s1_clken;
  wire             onchip_mem_s1_end_xfer;
  wire             onchip_mem_s1_firsttransfer;
  wire    [  1: 0] onchip_mem_s1_grant_vector;
  wire             onchip_mem_s1_in_a_read_cycle;
  wire             onchip_mem_s1_in_a_write_cycle;
  wire    [  1: 0] onchip_mem_s1_master_qreq_vector;
  wire             onchip_mem_s1_non_bursting_master_requests;
  wire    [ 31: 0] onchip_mem_s1_readdata_from_sa;
  reg              onchip_mem_s1_reg_firsttransfer;
  reg     [  1: 0] onchip_mem_s1_saved_chosen_master_vector;
  reg              onchip_mem_s1_slavearbiterlockenable;
  wire             onchip_mem_s1_slavearbiterlockenable2;
  wire             onchip_mem_s1_unreg_firsttransfer;
  wire             onchip_mem_s1_waits_for_read;
  wire             onchip_mem_s1_waits_for_write;
  wire             onchip_mem_s1_write;
  wire    [ 31: 0] onchip_mem_s1_writedata;
  wire             p1_cpu_data_master_read_data_valid_onchip_mem_s1_shift_register;
  wire             p1_cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register;
  wire    [ 27: 0] shifted_address_to_onchip_mem_s1_from_cpu_data_master;
  wire    [ 27: 0] shifted_address_to_onchip_mem_s1_from_cpu_instruction_master;
  wire             wait_for_onchip_mem_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~onchip_mem_s1_end_xfer;
    end


  assign onchip_mem_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_onchip_mem_s1 | cpu_instruction_master_qualified_request_onchip_mem_s1));
  //assign onchip_mem_s1_readdata_from_sa = onchip_mem_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign onchip_mem_s1_readdata_from_sa = onchip_mem_s1_readdata;

  assign cpu_data_master_requests_onchip_mem_s1 = ({cpu_data_master_address_to_slave[27 : 13] , 13'b0} == 28'h9620000) & (cpu_data_master_read | cpu_data_master_write);
  //onchip_mem_s1_arb_share_counter set values, which is an e_mux
  assign onchip_mem_s1_arb_share_set_values = 1;

  //onchip_mem_s1_non_bursting_master_requests mux, which is an e_mux
  assign onchip_mem_s1_non_bursting_master_requests = cpu_data_master_requests_onchip_mem_s1 |
    cpu_instruction_master_requests_onchip_mem_s1 |
    cpu_data_master_requests_onchip_mem_s1 |
    cpu_instruction_master_requests_onchip_mem_s1;

  //onchip_mem_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign onchip_mem_s1_any_bursting_master_saved_grant = 0;

  //onchip_mem_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign onchip_mem_s1_arb_share_counter_next_value = onchip_mem_s1_firsttransfer ? (onchip_mem_s1_arb_share_set_values - 1) : |onchip_mem_s1_arb_share_counter ? (onchip_mem_s1_arb_share_counter - 1) : 0;

  //onchip_mem_s1_allgrants all slave grants, which is an e_mux
  assign onchip_mem_s1_allgrants = |onchip_mem_s1_grant_vector |
    |onchip_mem_s1_grant_vector |
    |onchip_mem_s1_grant_vector |
    |onchip_mem_s1_grant_vector;

  //onchip_mem_s1_end_xfer assignment, which is an e_assign
  assign onchip_mem_s1_end_xfer = ~(onchip_mem_s1_waits_for_read | onchip_mem_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_onchip_mem_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_onchip_mem_s1 = onchip_mem_s1_end_xfer & (~onchip_mem_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //onchip_mem_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign onchip_mem_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_onchip_mem_s1 & onchip_mem_s1_allgrants) | (end_xfer_arb_share_counter_term_onchip_mem_s1 & ~onchip_mem_s1_non_bursting_master_requests);

  //onchip_mem_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_mem_s1_arb_share_counter <= 0;
      else if (onchip_mem_s1_arb_counter_enable)
          onchip_mem_s1_arb_share_counter <= onchip_mem_s1_arb_share_counter_next_value;
    end


  //onchip_mem_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_mem_s1_slavearbiterlockenable <= 0;
      else if ((|onchip_mem_s1_master_qreq_vector & end_xfer_arb_share_counter_term_onchip_mem_s1) | (end_xfer_arb_share_counter_term_onchip_mem_s1 & ~onchip_mem_s1_non_bursting_master_requests))
          onchip_mem_s1_slavearbiterlockenable <= |onchip_mem_s1_arb_share_counter_next_value;
    end


  //cpu/data_master onchip_mem/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = onchip_mem_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //onchip_mem_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign onchip_mem_s1_slavearbiterlockenable2 = |onchip_mem_s1_arb_share_counter_next_value;

  //cpu/data_master onchip_mem/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = onchip_mem_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //cpu/instruction_master onchip_mem/s1 arbiterlock, which is an e_assign
  assign cpu_instruction_master_arbiterlock = onchip_mem_s1_slavearbiterlockenable & cpu_instruction_master_continuerequest;

  //cpu/instruction_master onchip_mem/s1 arbiterlock2, which is an e_assign
  assign cpu_instruction_master_arbiterlock2 = onchip_mem_s1_slavearbiterlockenable2 & cpu_instruction_master_continuerequest;

  //cpu/instruction_master granted onchip_mem/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_instruction_master_granted_slave_onchip_mem_s1 <= 0;
      else if (1)
          last_cycle_cpu_instruction_master_granted_slave_onchip_mem_s1 <= cpu_instruction_master_saved_grant_onchip_mem_s1 ? 1 : (onchip_mem_s1_arbitration_holdoff_internal | ~cpu_instruction_master_requests_onchip_mem_s1) ? 0 : last_cycle_cpu_instruction_master_granted_slave_onchip_mem_s1;
    end


  //cpu_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_instruction_master_continuerequest = last_cycle_cpu_instruction_master_granted_slave_onchip_mem_s1 & cpu_instruction_master_requests_onchip_mem_s1;

  //onchip_mem_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign onchip_mem_s1_any_continuerequest = cpu_instruction_master_continuerequest |
    cpu_data_master_continuerequest;

  assign cpu_data_master_qualified_request_onchip_mem_s1 = cpu_data_master_requests_onchip_mem_s1 & ~((cpu_data_master_read & ((1 < cpu_data_master_latency_counter) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))) | cpu_instruction_master_arbiterlock);
  //cpu_data_master_read_data_valid_onchip_mem_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_data_master_read_data_valid_onchip_mem_s1_shift_register_in = cpu_data_master_granted_onchip_mem_s1 & cpu_data_master_read & ~onchip_mem_s1_waits_for_read;

  //shift register p1 cpu_data_master_read_data_valid_onchip_mem_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_data_master_read_data_valid_onchip_mem_s1_shift_register = {cpu_data_master_read_data_valid_onchip_mem_s1_shift_register, cpu_data_master_read_data_valid_onchip_mem_s1_shift_register_in};

  //cpu_data_master_read_data_valid_onchip_mem_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_read_data_valid_onchip_mem_s1_shift_register <= 0;
      else if (1)
          cpu_data_master_read_data_valid_onchip_mem_s1_shift_register <= p1_cpu_data_master_read_data_valid_onchip_mem_s1_shift_register;
    end


  //local readdatavalid cpu_data_master_read_data_valid_onchip_mem_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_onchip_mem_s1 = cpu_data_master_read_data_valid_onchip_mem_s1_shift_register;

  //onchip_mem_s1_writedata mux, which is an e_mux
  assign onchip_mem_s1_writedata = cpu_data_master_writedata;

  //mux onchip_mem_s1_clken, which is an e_mux
  assign onchip_mem_s1_clken = 1'b1;

  assign cpu_instruction_master_requests_onchip_mem_s1 = (({cpu_instruction_master_address_to_slave[27 : 13] , 13'b0} == 28'h9620000) & (cpu_instruction_master_read)) & cpu_instruction_master_read;
  //cpu/data_master granted onchip_mem/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_data_master_granted_slave_onchip_mem_s1 <= 0;
      else if (1)
          last_cycle_cpu_data_master_granted_slave_onchip_mem_s1 <= cpu_data_master_saved_grant_onchip_mem_s1 ? 1 : (onchip_mem_s1_arbitration_holdoff_internal | ~cpu_data_master_requests_onchip_mem_s1) ? 0 : last_cycle_cpu_data_master_granted_slave_onchip_mem_s1;
    end


  //cpu_data_master_continuerequest continued request, which is an e_mux
  assign cpu_data_master_continuerequest = last_cycle_cpu_data_master_granted_slave_onchip_mem_s1 & cpu_data_master_requests_onchip_mem_s1;

  assign cpu_instruction_master_qualified_request_onchip_mem_s1 = cpu_instruction_master_requests_onchip_mem_s1 & ~((cpu_instruction_master_read & ((1 < cpu_instruction_master_latency_counter) | (|cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register))) | cpu_data_master_arbiterlock);
  //cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register_in = cpu_instruction_master_granted_onchip_mem_s1 & cpu_instruction_master_read & ~onchip_mem_s1_waits_for_read;

  //shift register p1 cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register = {cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register, cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register_in};

  //cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register <= 0;
      else if (1)
          cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register <= p1_cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register;
    end


  //local readdatavalid cpu_instruction_master_read_data_valid_onchip_mem_s1, which is an e_mux
  assign cpu_instruction_master_read_data_valid_onchip_mem_s1 = cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register;

  //allow new arb cycle for onchip_mem/s1, which is an e_assign
  assign onchip_mem_s1_allow_new_arb_cycle = ~cpu_data_master_arbiterlock & ~cpu_instruction_master_arbiterlock;

  //cpu/instruction_master assignment into master qualified-requests vector for onchip_mem/s1, which is an e_assign
  assign onchip_mem_s1_master_qreq_vector[0] = cpu_instruction_master_qualified_request_onchip_mem_s1;

  //cpu/instruction_master grant onchip_mem/s1, which is an e_assign
  assign cpu_instruction_master_granted_onchip_mem_s1 = onchip_mem_s1_grant_vector[0];

  //cpu/instruction_master saved-grant onchip_mem/s1, which is an e_assign
  assign cpu_instruction_master_saved_grant_onchip_mem_s1 = onchip_mem_s1_arb_winner[0] && cpu_instruction_master_requests_onchip_mem_s1;

  //cpu/data_master assignment into master qualified-requests vector for onchip_mem/s1, which is an e_assign
  assign onchip_mem_s1_master_qreq_vector[1] = cpu_data_master_qualified_request_onchip_mem_s1;

  //cpu/data_master grant onchip_mem/s1, which is an e_assign
  assign cpu_data_master_granted_onchip_mem_s1 = onchip_mem_s1_grant_vector[1];

  //cpu/data_master saved-grant onchip_mem/s1, which is an e_assign
  assign cpu_data_master_saved_grant_onchip_mem_s1 = onchip_mem_s1_arb_winner[1] && cpu_data_master_requests_onchip_mem_s1;

  //onchip_mem/s1 chosen-master double-vector, which is an e_assign
  assign onchip_mem_s1_chosen_master_double_vector = {onchip_mem_s1_master_qreq_vector, onchip_mem_s1_master_qreq_vector} & ({~onchip_mem_s1_master_qreq_vector, ~onchip_mem_s1_master_qreq_vector} + onchip_mem_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign onchip_mem_s1_arb_winner = (onchip_mem_s1_allow_new_arb_cycle & | onchip_mem_s1_grant_vector) ? onchip_mem_s1_grant_vector : onchip_mem_s1_saved_chosen_master_vector;

  //saved onchip_mem_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_mem_s1_saved_chosen_master_vector <= 0;
      else if (onchip_mem_s1_allow_new_arb_cycle)
          onchip_mem_s1_saved_chosen_master_vector <= |onchip_mem_s1_grant_vector ? onchip_mem_s1_grant_vector : onchip_mem_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign onchip_mem_s1_grant_vector = {(onchip_mem_s1_chosen_master_double_vector[1] | onchip_mem_s1_chosen_master_double_vector[3]),
    (onchip_mem_s1_chosen_master_double_vector[0] | onchip_mem_s1_chosen_master_double_vector[2])};

  //onchip_mem/s1 chosen master rotated left, which is an e_assign
  assign onchip_mem_s1_chosen_master_rot_left = (onchip_mem_s1_arb_winner << 1) ? (onchip_mem_s1_arb_winner << 1) : 1;

  //onchip_mem/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_mem_s1_arb_addend <= 1;
      else if (|onchip_mem_s1_grant_vector)
          onchip_mem_s1_arb_addend <= onchip_mem_s1_end_xfer? onchip_mem_s1_chosen_master_rot_left : onchip_mem_s1_grant_vector;
    end


  assign onchip_mem_s1_chipselect = cpu_data_master_granted_onchip_mem_s1 | cpu_instruction_master_granted_onchip_mem_s1;
  //onchip_mem_s1_firsttransfer first transaction, which is an e_assign
  assign onchip_mem_s1_firsttransfer = onchip_mem_s1_begins_xfer ? onchip_mem_s1_unreg_firsttransfer : onchip_mem_s1_reg_firsttransfer;

  //onchip_mem_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign onchip_mem_s1_unreg_firsttransfer = ~(onchip_mem_s1_slavearbiterlockenable & onchip_mem_s1_any_continuerequest);

  //onchip_mem_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_mem_s1_reg_firsttransfer <= 1'b1;
      else if (onchip_mem_s1_begins_xfer)
          onchip_mem_s1_reg_firsttransfer <= onchip_mem_s1_unreg_firsttransfer;
    end


  //onchip_mem_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign onchip_mem_s1_beginbursttransfer_internal = onchip_mem_s1_begins_xfer;

  //onchip_mem_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign onchip_mem_s1_arbitration_holdoff_internal = onchip_mem_s1_begins_xfer & onchip_mem_s1_firsttransfer;

  //onchip_mem_s1_write assignment, which is an e_mux
  assign onchip_mem_s1_write = cpu_data_master_granted_onchip_mem_s1 & cpu_data_master_write;

  assign shifted_address_to_onchip_mem_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //onchip_mem_s1_address mux, which is an e_mux
  assign onchip_mem_s1_address = (cpu_data_master_granted_onchip_mem_s1)? (shifted_address_to_onchip_mem_s1_from_cpu_data_master >> 2) :
    (shifted_address_to_onchip_mem_s1_from_cpu_instruction_master >> 2);

  assign shifted_address_to_onchip_mem_s1_from_cpu_instruction_master = cpu_instruction_master_address_to_slave;
  //d1_onchip_mem_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_onchip_mem_s1_end_xfer <= 1;
      else if (1)
          d1_onchip_mem_s1_end_xfer <= onchip_mem_s1_end_xfer;
    end


  //onchip_mem_s1_waits_for_read in a cycle, which is an e_mux
  assign onchip_mem_s1_waits_for_read = onchip_mem_s1_in_a_read_cycle & 0;

  //onchip_mem_s1_in_a_read_cycle assignment, which is an e_assign
  assign onchip_mem_s1_in_a_read_cycle = (cpu_data_master_granted_onchip_mem_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_onchip_mem_s1 & cpu_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = onchip_mem_s1_in_a_read_cycle;

  //onchip_mem_s1_waits_for_write in a cycle, which is an e_mux
  assign onchip_mem_s1_waits_for_write = onchip_mem_s1_in_a_write_cycle & 0;

  //onchip_mem_s1_in_a_write_cycle assignment, which is an e_assign
  assign onchip_mem_s1_in_a_write_cycle = cpu_data_master_granted_onchip_mem_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = onchip_mem_s1_in_a_write_cycle;

  assign wait_for_onchip_mem_s1_counter = 0;
  //onchip_mem_s1_byteenable byte enable port mux, which is an e_mux
  assign onchip_mem_s1_byteenable = (cpu_data_master_granted_onchip_mem_s1)? cpu_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //onchip_mem/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_granted_onchip_mem_s1 + cpu_instruction_master_granted_onchip_mem_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_saved_grant_onchip_mem_s1 + cpu_instruction_master_saved_grant_onchip_mem_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pio_button_s1_arbitrator (
                                  // inputs:
                                   clk,
                                   cpu_data_master_address_to_slave,
                                   cpu_data_master_latency_counter,
                                   cpu_data_master_read,
                                   cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                   cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                   cpu_data_master_write,
                                   cpu_data_master_writedata,
                                   pio_button_s1_irq,
                                   pio_button_s1_readdata,
                                   reset_n,

                                  // outputs:
                                   cpu_data_master_granted_pio_button_s1,
                                   cpu_data_master_qualified_request_pio_button_s1,
                                   cpu_data_master_read_data_valid_pio_button_s1,
                                   cpu_data_master_requests_pio_button_s1,
                                   d1_pio_button_s1_end_xfer,
                                   pio_button_s1_address,
                                   pio_button_s1_chipselect,
                                   pio_button_s1_irq_from_sa,
                                   pio_button_s1_readdata_from_sa,
                                   pio_button_s1_reset_n,
                                   pio_button_s1_write_n,
                                   pio_button_s1_writedata
                                )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_pio_button_s1;
  output           cpu_data_master_qualified_request_pio_button_s1;
  output           cpu_data_master_read_data_valid_pio_button_s1;
  output           cpu_data_master_requests_pio_button_s1;
  output           d1_pio_button_s1_end_xfer;
  output  [  1: 0] pio_button_s1_address;
  output           pio_button_s1_chipselect;
  output           pio_button_s1_irq_from_sa;
  output  [  3: 0] pio_button_s1_readdata_from_sa;
  output           pio_button_s1_reset_n;
  output           pio_button_s1_write_n;
  output  [  3: 0] pio_button_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            pio_button_s1_irq;
  input   [  3: 0] pio_button_s1_readdata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_pio_button_s1;
  wire             cpu_data_master_qualified_request_pio_button_s1;
  wire             cpu_data_master_read_data_valid_pio_button_s1;
  wire             cpu_data_master_requests_pio_button_s1;
  wire             cpu_data_master_saved_grant_pio_button_s1;
  reg              d1_pio_button_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pio_button_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] pio_button_s1_address;
  wire             pio_button_s1_allgrants;
  wire             pio_button_s1_allow_new_arb_cycle;
  wire             pio_button_s1_any_bursting_master_saved_grant;
  wire             pio_button_s1_any_continuerequest;
  wire             pio_button_s1_arb_counter_enable;
  reg     [  1: 0] pio_button_s1_arb_share_counter;
  wire    [  1: 0] pio_button_s1_arb_share_counter_next_value;
  wire    [  1: 0] pio_button_s1_arb_share_set_values;
  wire             pio_button_s1_beginbursttransfer_internal;
  wire             pio_button_s1_begins_xfer;
  wire             pio_button_s1_chipselect;
  wire             pio_button_s1_end_xfer;
  wire             pio_button_s1_firsttransfer;
  wire             pio_button_s1_grant_vector;
  wire             pio_button_s1_in_a_read_cycle;
  wire             pio_button_s1_in_a_write_cycle;
  wire             pio_button_s1_irq_from_sa;
  wire             pio_button_s1_master_qreq_vector;
  wire             pio_button_s1_non_bursting_master_requests;
  wire    [  3: 0] pio_button_s1_readdata_from_sa;
  reg              pio_button_s1_reg_firsttransfer;
  wire             pio_button_s1_reset_n;
  reg              pio_button_s1_slavearbiterlockenable;
  wire             pio_button_s1_slavearbiterlockenable2;
  wire             pio_button_s1_unreg_firsttransfer;
  wire             pio_button_s1_waits_for_read;
  wire             pio_button_s1_waits_for_write;
  wire             pio_button_s1_write_n;
  wire    [  3: 0] pio_button_s1_writedata;
  wire    [ 27: 0] shifted_address_to_pio_button_s1_from_cpu_data_master;
  wire             wait_for_pio_button_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~pio_button_s1_end_xfer;
    end


  assign pio_button_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_pio_button_s1));
  //assign pio_button_s1_readdata_from_sa = pio_button_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pio_button_s1_readdata_from_sa = pio_button_s1_readdata;

  assign cpu_data_master_requests_pio_button_s1 = ({cpu_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h9641150) & (cpu_data_master_read | cpu_data_master_write);
  //pio_button_s1_arb_share_counter set values, which is an e_mux
  assign pio_button_s1_arb_share_set_values = 1;

  //pio_button_s1_non_bursting_master_requests mux, which is an e_mux
  assign pio_button_s1_non_bursting_master_requests = cpu_data_master_requests_pio_button_s1;

  //pio_button_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pio_button_s1_any_bursting_master_saved_grant = 0;

  //pio_button_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pio_button_s1_arb_share_counter_next_value = pio_button_s1_firsttransfer ? (pio_button_s1_arb_share_set_values - 1) : |pio_button_s1_arb_share_counter ? (pio_button_s1_arb_share_counter - 1) : 0;

  //pio_button_s1_allgrants all slave grants, which is an e_mux
  assign pio_button_s1_allgrants = |pio_button_s1_grant_vector;

  //pio_button_s1_end_xfer assignment, which is an e_assign
  assign pio_button_s1_end_xfer = ~(pio_button_s1_waits_for_read | pio_button_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pio_button_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pio_button_s1 = pio_button_s1_end_xfer & (~pio_button_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pio_button_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pio_button_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pio_button_s1 & pio_button_s1_allgrants) | (end_xfer_arb_share_counter_term_pio_button_s1 & ~pio_button_s1_non_bursting_master_requests);

  //pio_button_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_button_s1_arb_share_counter <= 0;
      else if (pio_button_s1_arb_counter_enable)
          pio_button_s1_arb_share_counter <= pio_button_s1_arb_share_counter_next_value;
    end


  //pio_button_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_button_s1_slavearbiterlockenable <= 0;
      else if ((|pio_button_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pio_button_s1) | (end_xfer_arb_share_counter_term_pio_button_s1 & ~pio_button_s1_non_bursting_master_requests))
          pio_button_s1_slavearbiterlockenable <= |pio_button_s1_arb_share_counter_next_value;
    end


  //cpu/data_master pio_button/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = pio_button_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //pio_button_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pio_button_s1_slavearbiterlockenable2 = |pio_button_s1_arb_share_counter_next_value;

  //cpu/data_master pio_button/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = pio_button_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //pio_button_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pio_button_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_pio_button_s1 = cpu_data_master_requests_pio_button_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_pio_button_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_pio_button_s1 = cpu_data_master_granted_pio_button_s1 & cpu_data_master_read & ~pio_button_s1_waits_for_read;

  //pio_button_s1_writedata mux, which is an e_mux
  assign pio_button_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_pio_button_s1 = cpu_data_master_qualified_request_pio_button_s1;

  //cpu/data_master saved-grant pio_button/s1, which is an e_assign
  assign cpu_data_master_saved_grant_pio_button_s1 = cpu_data_master_requests_pio_button_s1;

  //allow new arb cycle for pio_button/s1, which is an e_assign
  assign pio_button_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pio_button_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pio_button_s1_master_qreq_vector = 1;

  //pio_button_s1_reset_n assignment, which is an e_assign
  assign pio_button_s1_reset_n = reset_n;

  assign pio_button_s1_chipselect = cpu_data_master_granted_pio_button_s1;
  //pio_button_s1_firsttransfer first transaction, which is an e_assign
  assign pio_button_s1_firsttransfer = pio_button_s1_begins_xfer ? pio_button_s1_unreg_firsttransfer : pio_button_s1_reg_firsttransfer;

  //pio_button_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pio_button_s1_unreg_firsttransfer = ~(pio_button_s1_slavearbiterlockenable & pio_button_s1_any_continuerequest);

  //pio_button_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_button_s1_reg_firsttransfer <= 1'b1;
      else if (pio_button_s1_begins_xfer)
          pio_button_s1_reg_firsttransfer <= pio_button_s1_unreg_firsttransfer;
    end


  //pio_button_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pio_button_s1_beginbursttransfer_internal = pio_button_s1_begins_xfer;

  //~pio_button_s1_write_n assignment, which is an e_mux
  assign pio_button_s1_write_n = ~(cpu_data_master_granted_pio_button_s1 & cpu_data_master_write);

  assign shifted_address_to_pio_button_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //pio_button_s1_address mux, which is an e_mux
  assign pio_button_s1_address = shifted_address_to_pio_button_s1_from_cpu_data_master >> 2;

  //d1_pio_button_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pio_button_s1_end_xfer <= 1;
      else if (1)
          d1_pio_button_s1_end_xfer <= pio_button_s1_end_xfer;
    end


  //pio_button_s1_waits_for_read in a cycle, which is an e_mux
  assign pio_button_s1_waits_for_read = pio_button_s1_in_a_read_cycle & pio_button_s1_begins_xfer;

  //pio_button_s1_in_a_read_cycle assignment, which is an e_assign
  assign pio_button_s1_in_a_read_cycle = cpu_data_master_granted_pio_button_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pio_button_s1_in_a_read_cycle;

  //pio_button_s1_waits_for_write in a cycle, which is an e_mux
  assign pio_button_s1_waits_for_write = pio_button_s1_in_a_write_cycle & 0;

  //pio_button_s1_in_a_write_cycle assignment, which is an e_assign
  assign pio_button_s1_in_a_write_cycle = cpu_data_master_granted_pio_button_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pio_button_s1_in_a_write_cycle;

  assign wait_for_pio_button_s1_counter = 0;
  //assign pio_button_s1_irq_from_sa = pio_button_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pio_button_s1_irq_from_sa = pio_button_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pio_button/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pio_green_led_s1_arbitrator (
                                     // inputs:
                                      clk,
                                      cpu_data_master_address_to_slave,
                                      cpu_data_master_latency_counter,
                                      cpu_data_master_read,
                                      cpu_data_master_write,
                                      cpu_data_master_writedata,
                                      reset_n,

                                     // outputs:
                                      cpu_data_master_granted_pio_green_led_s1,
                                      cpu_data_master_qualified_request_pio_green_led_s1,
                                      cpu_data_master_read_data_valid_pio_green_led_s1,
                                      cpu_data_master_requests_pio_green_led_s1,
                                      d1_pio_green_led_s1_end_xfer,
                                      pio_green_led_s1_address,
                                      pio_green_led_s1_chipselect,
                                      pio_green_led_s1_reset_n,
                                      pio_green_led_s1_write_n,
                                      pio_green_led_s1_writedata
                                   )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_pio_green_led_s1;
  output           cpu_data_master_qualified_request_pio_green_led_s1;
  output           cpu_data_master_read_data_valid_pio_green_led_s1;
  output           cpu_data_master_requests_pio_green_led_s1;
  output           d1_pio_green_led_s1_end_xfer;
  output  [  1: 0] pio_green_led_s1_address;
  output           pio_green_led_s1_chipselect;
  output           pio_green_led_s1_reset_n;
  output           pio_green_led_s1_write_n;
  output  [  8: 0] pio_green_led_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_pio_green_led_s1;
  wire             cpu_data_master_qualified_request_pio_green_led_s1;
  wire             cpu_data_master_read_data_valid_pio_green_led_s1;
  wire             cpu_data_master_requests_pio_green_led_s1;
  wire             cpu_data_master_saved_grant_pio_green_led_s1;
  reg              d1_pio_green_led_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pio_green_led_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] pio_green_led_s1_address;
  wire             pio_green_led_s1_allgrants;
  wire             pio_green_led_s1_allow_new_arb_cycle;
  wire             pio_green_led_s1_any_bursting_master_saved_grant;
  wire             pio_green_led_s1_any_continuerequest;
  wire             pio_green_led_s1_arb_counter_enable;
  reg     [  1: 0] pio_green_led_s1_arb_share_counter;
  wire    [  1: 0] pio_green_led_s1_arb_share_counter_next_value;
  wire    [  1: 0] pio_green_led_s1_arb_share_set_values;
  wire             pio_green_led_s1_beginbursttransfer_internal;
  wire             pio_green_led_s1_begins_xfer;
  wire             pio_green_led_s1_chipselect;
  wire             pio_green_led_s1_end_xfer;
  wire             pio_green_led_s1_firsttransfer;
  wire             pio_green_led_s1_grant_vector;
  wire             pio_green_led_s1_in_a_read_cycle;
  wire             pio_green_led_s1_in_a_write_cycle;
  wire             pio_green_led_s1_master_qreq_vector;
  wire             pio_green_led_s1_non_bursting_master_requests;
  reg              pio_green_led_s1_reg_firsttransfer;
  wire             pio_green_led_s1_reset_n;
  reg              pio_green_led_s1_slavearbiterlockenable;
  wire             pio_green_led_s1_slavearbiterlockenable2;
  wire             pio_green_led_s1_unreg_firsttransfer;
  wire             pio_green_led_s1_waits_for_read;
  wire             pio_green_led_s1_waits_for_write;
  wire             pio_green_led_s1_write_n;
  wire    [  8: 0] pio_green_led_s1_writedata;
  wire    [ 27: 0] shifted_address_to_pio_green_led_s1_from_cpu_data_master;
  wire             wait_for_pio_green_led_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~pio_green_led_s1_end_xfer;
    end


  assign pio_green_led_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_pio_green_led_s1));
  assign cpu_data_master_requests_pio_green_led_s1 = (({cpu_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h9641120) & (cpu_data_master_read | cpu_data_master_write)) & cpu_data_master_write;
  //pio_green_led_s1_arb_share_counter set values, which is an e_mux
  assign pio_green_led_s1_arb_share_set_values = 1;

  //pio_green_led_s1_non_bursting_master_requests mux, which is an e_mux
  assign pio_green_led_s1_non_bursting_master_requests = cpu_data_master_requests_pio_green_led_s1;

  //pio_green_led_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pio_green_led_s1_any_bursting_master_saved_grant = 0;

  //pio_green_led_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pio_green_led_s1_arb_share_counter_next_value = pio_green_led_s1_firsttransfer ? (pio_green_led_s1_arb_share_set_values - 1) : |pio_green_led_s1_arb_share_counter ? (pio_green_led_s1_arb_share_counter - 1) : 0;

  //pio_green_led_s1_allgrants all slave grants, which is an e_mux
  assign pio_green_led_s1_allgrants = |pio_green_led_s1_grant_vector;

  //pio_green_led_s1_end_xfer assignment, which is an e_assign
  assign pio_green_led_s1_end_xfer = ~(pio_green_led_s1_waits_for_read | pio_green_led_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pio_green_led_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pio_green_led_s1 = pio_green_led_s1_end_xfer & (~pio_green_led_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pio_green_led_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pio_green_led_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pio_green_led_s1 & pio_green_led_s1_allgrants) | (end_xfer_arb_share_counter_term_pio_green_led_s1 & ~pio_green_led_s1_non_bursting_master_requests);

  //pio_green_led_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_green_led_s1_arb_share_counter <= 0;
      else if (pio_green_led_s1_arb_counter_enable)
          pio_green_led_s1_arb_share_counter <= pio_green_led_s1_arb_share_counter_next_value;
    end


  //pio_green_led_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_green_led_s1_slavearbiterlockenable <= 0;
      else if ((|pio_green_led_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pio_green_led_s1) | (end_xfer_arb_share_counter_term_pio_green_led_s1 & ~pio_green_led_s1_non_bursting_master_requests))
          pio_green_led_s1_slavearbiterlockenable <= |pio_green_led_s1_arb_share_counter_next_value;
    end


  //cpu/data_master pio_green_led/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = pio_green_led_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //pio_green_led_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pio_green_led_s1_slavearbiterlockenable2 = |pio_green_led_s1_arb_share_counter_next_value;

  //cpu/data_master pio_green_led/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = pio_green_led_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //pio_green_led_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pio_green_led_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_pio_green_led_s1 = cpu_data_master_requests_pio_green_led_s1;
  //local readdatavalid cpu_data_master_read_data_valid_pio_green_led_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_pio_green_led_s1 = cpu_data_master_granted_pio_green_led_s1 & cpu_data_master_read & ~pio_green_led_s1_waits_for_read;

  //pio_green_led_s1_writedata mux, which is an e_mux
  assign pio_green_led_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_pio_green_led_s1 = cpu_data_master_qualified_request_pio_green_led_s1;

  //cpu/data_master saved-grant pio_green_led/s1, which is an e_assign
  assign cpu_data_master_saved_grant_pio_green_led_s1 = cpu_data_master_requests_pio_green_led_s1;

  //allow new arb cycle for pio_green_led/s1, which is an e_assign
  assign pio_green_led_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pio_green_led_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pio_green_led_s1_master_qreq_vector = 1;

  //pio_green_led_s1_reset_n assignment, which is an e_assign
  assign pio_green_led_s1_reset_n = reset_n;

  assign pio_green_led_s1_chipselect = cpu_data_master_granted_pio_green_led_s1;
  //pio_green_led_s1_firsttransfer first transaction, which is an e_assign
  assign pio_green_led_s1_firsttransfer = pio_green_led_s1_begins_xfer ? pio_green_led_s1_unreg_firsttransfer : pio_green_led_s1_reg_firsttransfer;

  //pio_green_led_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pio_green_led_s1_unreg_firsttransfer = ~(pio_green_led_s1_slavearbiterlockenable & pio_green_led_s1_any_continuerequest);

  //pio_green_led_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_green_led_s1_reg_firsttransfer <= 1'b1;
      else if (pio_green_led_s1_begins_xfer)
          pio_green_led_s1_reg_firsttransfer <= pio_green_led_s1_unreg_firsttransfer;
    end


  //pio_green_led_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pio_green_led_s1_beginbursttransfer_internal = pio_green_led_s1_begins_xfer;

  //~pio_green_led_s1_write_n assignment, which is an e_mux
  assign pio_green_led_s1_write_n = ~(cpu_data_master_granted_pio_green_led_s1 & cpu_data_master_write);

  assign shifted_address_to_pio_green_led_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //pio_green_led_s1_address mux, which is an e_mux
  assign pio_green_led_s1_address = shifted_address_to_pio_green_led_s1_from_cpu_data_master >> 2;

  //d1_pio_green_led_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pio_green_led_s1_end_xfer <= 1;
      else if (1)
          d1_pio_green_led_s1_end_xfer <= pio_green_led_s1_end_xfer;
    end


  //pio_green_led_s1_waits_for_read in a cycle, which is an e_mux
  assign pio_green_led_s1_waits_for_read = pio_green_led_s1_in_a_read_cycle & pio_green_led_s1_begins_xfer;

  //pio_green_led_s1_in_a_read_cycle assignment, which is an e_assign
  assign pio_green_led_s1_in_a_read_cycle = cpu_data_master_granted_pio_green_led_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pio_green_led_s1_in_a_read_cycle;

  //pio_green_led_s1_waits_for_write in a cycle, which is an e_mux
  assign pio_green_led_s1_waits_for_write = pio_green_led_s1_in_a_write_cycle & 0;

  //pio_green_led_s1_in_a_write_cycle assignment, which is an e_assign
  assign pio_green_led_s1_in_a_write_cycle = cpu_data_master_granted_pio_green_led_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pio_green_led_s1_in_a_write_cycle;

  assign wait_for_pio_green_led_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pio_green_led/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pio_red_led_s1_arbitrator (
                                   // inputs:
                                    clk,
                                    cpu_data_master_address_to_slave,
                                    cpu_data_master_latency_counter,
                                    cpu_data_master_read,
                                    cpu_data_master_write,
                                    cpu_data_master_writedata,
                                    reset_n,

                                   // outputs:
                                    cpu_data_master_granted_pio_red_led_s1,
                                    cpu_data_master_qualified_request_pio_red_led_s1,
                                    cpu_data_master_read_data_valid_pio_red_led_s1,
                                    cpu_data_master_requests_pio_red_led_s1,
                                    d1_pio_red_led_s1_end_xfer,
                                    pio_red_led_s1_address,
                                    pio_red_led_s1_chipselect,
                                    pio_red_led_s1_reset_n,
                                    pio_red_led_s1_write_n,
                                    pio_red_led_s1_writedata
                                 )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_pio_red_led_s1;
  output           cpu_data_master_qualified_request_pio_red_led_s1;
  output           cpu_data_master_read_data_valid_pio_red_led_s1;
  output           cpu_data_master_requests_pio_red_led_s1;
  output           d1_pio_red_led_s1_end_xfer;
  output  [  1: 0] pio_red_led_s1_address;
  output           pio_red_led_s1_chipselect;
  output           pio_red_led_s1_reset_n;
  output           pio_red_led_s1_write_n;
  output  [ 17: 0] pio_red_led_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_pio_red_led_s1;
  wire             cpu_data_master_qualified_request_pio_red_led_s1;
  wire             cpu_data_master_read_data_valid_pio_red_led_s1;
  wire             cpu_data_master_requests_pio_red_led_s1;
  wire             cpu_data_master_saved_grant_pio_red_led_s1;
  reg              d1_pio_red_led_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pio_red_led_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] pio_red_led_s1_address;
  wire             pio_red_led_s1_allgrants;
  wire             pio_red_led_s1_allow_new_arb_cycle;
  wire             pio_red_led_s1_any_bursting_master_saved_grant;
  wire             pio_red_led_s1_any_continuerequest;
  wire             pio_red_led_s1_arb_counter_enable;
  reg     [  1: 0] pio_red_led_s1_arb_share_counter;
  wire    [  1: 0] pio_red_led_s1_arb_share_counter_next_value;
  wire    [  1: 0] pio_red_led_s1_arb_share_set_values;
  wire             pio_red_led_s1_beginbursttransfer_internal;
  wire             pio_red_led_s1_begins_xfer;
  wire             pio_red_led_s1_chipselect;
  wire             pio_red_led_s1_end_xfer;
  wire             pio_red_led_s1_firsttransfer;
  wire             pio_red_led_s1_grant_vector;
  wire             pio_red_led_s1_in_a_read_cycle;
  wire             pio_red_led_s1_in_a_write_cycle;
  wire             pio_red_led_s1_master_qreq_vector;
  wire             pio_red_led_s1_non_bursting_master_requests;
  reg              pio_red_led_s1_reg_firsttransfer;
  wire             pio_red_led_s1_reset_n;
  reg              pio_red_led_s1_slavearbiterlockenable;
  wire             pio_red_led_s1_slavearbiterlockenable2;
  wire             pio_red_led_s1_unreg_firsttransfer;
  wire             pio_red_led_s1_waits_for_read;
  wire             pio_red_led_s1_waits_for_write;
  wire             pio_red_led_s1_write_n;
  wire    [ 17: 0] pio_red_led_s1_writedata;
  wire    [ 27: 0] shifted_address_to_pio_red_led_s1_from_cpu_data_master;
  wire             wait_for_pio_red_led_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~pio_red_led_s1_end_xfer;
    end


  assign pio_red_led_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_pio_red_led_s1));
  assign cpu_data_master_requests_pio_red_led_s1 = (({cpu_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h9641130) & (cpu_data_master_read | cpu_data_master_write)) & cpu_data_master_write;
  //pio_red_led_s1_arb_share_counter set values, which is an e_mux
  assign pio_red_led_s1_arb_share_set_values = 1;

  //pio_red_led_s1_non_bursting_master_requests mux, which is an e_mux
  assign pio_red_led_s1_non_bursting_master_requests = cpu_data_master_requests_pio_red_led_s1;

  //pio_red_led_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pio_red_led_s1_any_bursting_master_saved_grant = 0;

  //pio_red_led_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pio_red_led_s1_arb_share_counter_next_value = pio_red_led_s1_firsttransfer ? (pio_red_led_s1_arb_share_set_values - 1) : |pio_red_led_s1_arb_share_counter ? (pio_red_led_s1_arb_share_counter - 1) : 0;

  //pio_red_led_s1_allgrants all slave grants, which is an e_mux
  assign pio_red_led_s1_allgrants = |pio_red_led_s1_grant_vector;

  //pio_red_led_s1_end_xfer assignment, which is an e_assign
  assign pio_red_led_s1_end_xfer = ~(pio_red_led_s1_waits_for_read | pio_red_led_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pio_red_led_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pio_red_led_s1 = pio_red_led_s1_end_xfer & (~pio_red_led_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pio_red_led_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pio_red_led_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pio_red_led_s1 & pio_red_led_s1_allgrants) | (end_xfer_arb_share_counter_term_pio_red_led_s1 & ~pio_red_led_s1_non_bursting_master_requests);

  //pio_red_led_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_red_led_s1_arb_share_counter <= 0;
      else if (pio_red_led_s1_arb_counter_enable)
          pio_red_led_s1_arb_share_counter <= pio_red_led_s1_arb_share_counter_next_value;
    end


  //pio_red_led_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_red_led_s1_slavearbiterlockenable <= 0;
      else if ((|pio_red_led_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pio_red_led_s1) | (end_xfer_arb_share_counter_term_pio_red_led_s1 & ~pio_red_led_s1_non_bursting_master_requests))
          pio_red_led_s1_slavearbiterlockenable <= |pio_red_led_s1_arb_share_counter_next_value;
    end


  //cpu/data_master pio_red_led/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = pio_red_led_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //pio_red_led_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pio_red_led_s1_slavearbiterlockenable2 = |pio_red_led_s1_arb_share_counter_next_value;

  //cpu/data_master pio_red_led/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = pio_red_led_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //pio_red_led_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pio_red_led_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_pio_red_led_s1 = cpu_data_master_requests_pio_red_led_s1;
  //local readdatavalid cpu_data_master_read_data_valid_pio_red_led_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_pio_red_led_s1 = cpu_data_master_granted_pio_red_led_s1 & cpu_data_master_read & ~pio_red_led_s1_waits_for_read;

  //pio_red_led_s1_writedata mux, which is an e_mux
  assign pio_red_led_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_pio_red_led_s1 = cpu_data_master_qualified_request_pio_red_led_s1;

  //cpu/data_master saved-grant pio_red_led/s1, which is an e_assign
  assign cpu_data_master_saved_grant_pio_red_led_s1 = cpu_data_master_requests_pio_red_led_s1;

  //allow new arb cycle for pio_red_led/s1, which is an e_assign
  assign pio_red_led_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pio_red_led_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pio_red_led_s1_master_qreq_vector = 1;

  //pio_red_led_s1_reset_n assignment, which is an e_assign
  assign pio_red_led_s1_reset_n = reset_n;

  assign pio_red_led_s1_chipselect = cpu_data_master_granted_pio_red_led_s1;
  //pio_red_led_s1_firsttransfer first transaction, which is an e_assign
  assign pio_red_led_s1_firsttransfer = pio_red_led_s1_begins_xfer ? pio_red_led_s1_unreg_firsttransfer : pio_red_led_s1_reg_firsttransfer;

  //pio_red_led_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pio_red_led_s1_unreg_firsttransfer = ~(pio_red_led_s1_slavearbiterlockenable & pio_red_led_s1_any_continuerequest);

  //pio_red_led_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_red_led_s1_reg_firsttransfer <= 1'b1;
      else if (pio_red_led_s1_begins_xfer)
          pio_red_led_s1_reg_firsttransfer <= pio_red_led_s1_unreg_firsttransfer;
    end


  //pio_red_led_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pio_red_led_s1_beginbursttransfer_internal = pio_red_led_s1_begins_xfer;

  //~pio_red_led_s1_write_n assignment, which is an e_mux
  assign pio_red_led_s1_write_n = ~(cpu_data_master_granted_pio_red_led_s1 & cpu_data_master_write);

  assign shifted_address_to_pio_red_led_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //pio_red_led_s1_address mux, which is an e_mux
  assign pio_red_led_s1_address = shifted_address_to_pio_red_led_s1_from_cpu_data_master >> 2;

  //d1_pio_red_led_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pio_red_led_s1_end_xfer <= 1;
      else if (1)
          d1_pio_red_led_s1_end_xfer <= pio_red_led_s1_end_xfer;
    end


  //pio_red_led_s1_waits_for_read in a cycle, which is an e_mux
  assign pio_red_led_s1_waits_for_read = pio_red_led_s1_in_a_read_cycle & pio_red_led_s1_begins_xfer;

  //pio_red_led_s1_in_a_read_cycle assignment, which is an e_assign
  assign pio_red_led_s1_in_a_read_cycle = cpu_data_master_granted_pio_red_led_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pio_red_led_s1_in_a_read_cycle;

  //pio_red_led_s1_waits_for_write in a cycle, which is an e_mux
  assign pio_red_led_s1_waits_for_write = pio_red_led_s1_in_a_write_cycle & 0;

  //pio_red_led_s1_in_a_write_cycle assignment, which is an e_assign
  assign pio_red_led_s1_in_a_write_cycle = cpu_data_master_granted_pio_red_led_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pio_red_led_s1_in_a_write_cycle;

  assign wait_for_pio_red_led_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pio_red_led/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pio_switch_s1_arbitrator (
                                  // inputs:
                                   clk,
                                   cpu_data_master_address_to_slave,
                                   cpu_data_master_latency_counter,
                                   cpu_data_master_read,
                                   cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                   cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                   cpu_data_master_write,
                                   pio_switch_s1_readdata,
                                   reset_n,

                                  // outputs:
                                   cpu_data_master_granted_pio_switch_s1,
                                   cpu_data_master_qualified_request_pio_switch_s1,
                                   cpu_data_master_read_data_valid_pio_switch_s1,
                                   cpu_data_master_requests_pio_switch_s1,
                                   d1_pio_switch_s1_end_xfer,
                                   pio_switch_s1_address,
                                   pio_switch_s1_readdata_from_sa,
                                   pio_switch_s1_reset_n
                                )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_pio_switch_s1;
  output           cpu_data_master_qualified_request_pio_switch_s1;
  output           cpu_data_master_read_data_valid_pio_switch_s1;
  output           cpu_data_master_requests_pio_switch_s1;
  output           d1_pio_switch_s1_end_xfer;
  output  [  1: 0] pio_switch_s1_address;
  output  [ 17: 0] pio_switch_s1_readdata_from_sa;
  output           pio_switch_s1_reset_n;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 17: 0] pio_switch_s1_readdata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_pio_switch_s1;
  wire             cpu_data_master_qualified_request_pio_switch_s1;
  wire             cpu_data_master_read_data_valid_pio_switch_s1;
  wire             cpu_data_master_requests_pio_switch_s1;
  wire             cpu_data_master_saved_grant_pio_switch_s1;
  reg              d1_pio_switch_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pio_switch_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] pio_switch_s1_address;
  wire             pio_switch_s1_allgrants;
  wire             pio_switch_s1_allow_new_arb_cycle;
  wire             pio_switch_s1_any_bursting_master_saved_grant;
  wire             pio_switch_s1_any_continuerequest;
  wire             pio_switch_s1_arb_counter_enable;
  reg     [  1: 0] pio_switch_s1_arb_share_counter;
  wire    [  1: 0] pio_switch_s1_arb_share_counter_next_value;
  wire    [  1: 0] pio_switch_s1_arb_share_set_values;
  wire             pio_switch_s1_beginbursttransfer_internal;
  wire             pio_switch_s1_begins_xfer;
  wire             pio_switch_s1_end_xfer;
  wire             pio_switch_s1_firsttransfer;
  wire             pio_switch_s1_grant_vector;
  wire             pio_switch_s1_in_a_read_cycle;
  wire             pio_switch_s1_in_a_write_cycle;
  wire             pio_switch_s1_master_qreq_vector;
  wire             pio_switch_s1_non_bursting_master_requests;
  wire    [ 17: 0] pio_switch_s1_readdata_from_sa;
  reg              pio_switch_s1_reg_firsttransfer;
  wire             pio_switch_s1_reset_n;
  reg              pio_switch_s1_slavearbiterlockenable;
  wire             pio_switch_s1_slavearbiterlockenable2;
  wire             pio_switch_s1_unreg_firsttransfer;
  wire             pio_switch_s1_waits_for_read;
  wire             pio_switch_s1_waits_for_write;
  wire    [ 27: 0] shifted_address_to_pio_switch_s1_from_cpu_data_master;
  wire             wait_for_pio_switch_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~pio_switch_s1_end_xfer;
    end


  assign pio_switch_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_pio_switch_s1));
  //assign pio_switch_s1_readdata_from_sa = pio_switch_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pio_switch_s1_readdata_from_sa = pio_switch_s1_readdata;

  assign cpu_data_master_requests_pio_switch_s1 = (({cpu_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h9641140) & (cpu_data_master_read | cpu_data_master_write)) & cpu_data_master_read;
  //pio_switch_s1_arb_share_counter set values, which is an e_mux
  assign pio_switch_s1_arb_share_set_values = 1;

  //pio_switch_s1_non_bursting_master_requests mux, which is an e_mux
  assign pio_switch_s1_non_bursting_master_requests = cpu_data_master_requests_pio_switch_s1;

  //pio_switch_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pio_switch_s1_any_bursting_master_saved_grant = 0;

  //pio_switch_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pio_switch_s1_arb_share_counter_next_value = pio_switch_s1_firsttransfer ? (pio_switch_s1_arb_share_set_values - 1) : |pio_switch_s1_arb_share_counter ? (pio_switch_s1_arb_share_counter - 1) : 0;

  //pio_switch_s1_allgrants all slave grants, which is an e_mux
  assign pio_switch_s1_allgrants = |pio_switch_s1_grant_vector;

  //pio_switch_s1_end_xfer assignment, which is an e_assign
  assign pio_switch_s1_end_xfer = ~(pio_switch_s1_waits_for_read | pio_switch_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pio_switch_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pio_switch_s1 = pio_switch_s1_end_xfer & (~pio_switch_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pio_switch_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pio_switch_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pio_switch_s1 & pio_switch_s1_allgrants) | (end_xfer_arb_share_counter_term_pio_switch_s1 & ~pio_switch_s1_non_bursting_master_requests);

  //pio_switch_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_switch_s1_arb_share_counter <= 0;
      else if (pio_switch_s1_arb_counter_enable)
          pio_switch_s1_arb_share_counter <= pio_switch_s1_arb_share_counter_next_value;
    end


  //pio_switch_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_switch_s1_slavearbiterlockenable <= 0;
      else if ((|pio_switch_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pio_switch_s1) | (end_xfer_arb_share_counter_term_pio_switch_s1 & ~pio_switch_s1_non_bursting_master_requests))
          pio_switch_s1_slavearbiterlockenable <= |pio_switch_s1_arb_share_counter_next_value;
    end


  //cpu/data_master pio_switch/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = pio_switch_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //pio_switch_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pio_switch_s1_slavearbiterlockenable2 = |pio_switch_s1_arb_share_counter_next_value;

  //cpu/data_master pio_switch/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = pio_switch_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //pio_switch_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pio_switch_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_pio_switch_s1 = cpu_data_master_requests_pio_switch_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_pio_switch_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_pio_switch_s1 = cpu_data_master_granted_pio_switch_s1 & cpu_data_master_read & ~pio_switch_s1_waits_for_read;

  //master is always granted when requested
  assign cpu_data_master_granted_pio_switch_s1 = cpu_data_master_qualified_request_pio_switch_s1;

  //cpu/data_master saved-grant pio_switch/s1, which is an e_assign
  assign cpu_data_master_saved_grant_pio_switch_s1 = cpu_data_master_requests_pio_switch_s1;

  //allow new arb cycle for pio_switch/s1, which is an e_assign
  assign pio_switch_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pio_switch_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pio_switch_s1_master_qreq_vector = 1;

  //pio_switch_s1_reset_n assignment, which is an e_assign
  assign pio_switch_s1_reset_n = reset_n;

  //pio_switch_s1_firsttransfer first transaction, which is an e_assign
  assign pio_switch_s1_firsttransfer = pio_switch_s1_begins_xfer ? pio_switch_s1_unreg_firsttransfer : pio_switch_s1_reg_firsttransfer;

  //pio_switch_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pio_switch_s1_unreg_firsttransfer = ~(pio_switch_s1_slavearbiterlockenable & pio_switch_s1_any_continuerequest);

  //pio_switch_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_switch_s1_reg_firsttransfer <= 1'b1;
      else if (pio_switch_s1_begins_xfer)
          pio_switch_s1_reg_firsttransfer <= pio_switch_s1_unreg_firsttransfer;
    end


  //pio_switch_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pio_switch_s1_beginbursttransfer_internal = pio_switch_s1_begins_xfer;

  assign shifted_address_to_pio_switch_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //pio_switch_s1_address mux, which is an e_mux
  assign pio_switch_s1_address = shifted_address_to_pio_switch_s1_from_cpu_data_master >> 2;

  //d1_pio_switch_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pio_switch_s1_end_xfer <= 1;
      else if (1)
          d1_pio_switch_s1_end_xfer <= pio_switch_s1_end_xfer;
    end


  //pio_switch_s1_waits_for_read in a cycle, which is an e_mux
  assign pio_switch_s1_waits_for_read = pio_switch_s1_in_a_read_cycle & pio_switch_s1_begins_xfer;

  //pio_switch_s1_in_a_read_cycle assignment, which is an e_assign
  assign pio_switch_s1_in_a_read_cycle = cpu_data_master_granted_pio_switch_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pio_switch_s1_in_a_read_cycle;

  //pio_switch_s1_waits_for_write in a cycle, which is an e_mux
  assign pio_switch_s1_waits_for_write = pio_switch_s1_in_a_write_cycle & 0;

  //pio_switch_s1_in_a_write_cycle assignment, which is an e_assign
  assign pio_switch_s1_in_a_write_cycle = cpu_data_master_granted_pio_switch_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pio_switch_s1_in_a_write_cycle;

  assign wait_for_pio_switch_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pio_switch/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pll_s1_arbitrator (
                           // inputs:
                            clk,
                            clock_0_out_address_to_slave,
                            clock_0_out_nativeaddress,
                            clock_0_out_read,
                            clock_0_out_write,
                            clock_0_out_writedata,
                            pll_s1_readdata,
                            pll_s1_resetrequest,
                            reset_n,

                           // outputs:
                            clock_0_out_granted_pll_s1,
                            clock_0_out_qualified_request_pll_s1,
                            clock_0_out_read_data_valid_pll_s1,
                            clock_0_out_requests_pll_s1,
                            d1_pll_s1_end_xfer,
                            pll_s1_address,
                            pll_s1_chipselect,
                            pll_s1_read,
                            pll_s1_readdata_from_sa,
                            pll_s1_reset_n,
                            pll_s1_resetrequest_from_sa,
                            pll_s1_write,
                            pll_s1_writedata
                         )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           clock_0_out_granted_pll_s1;
  output           clock_0_out_qualified_request_pll_s1;
  output           clock_0_out_read_data_valid_pll_s1;
  output           clock_0_out_requests_pll_s1;
  output           d1_pll_s1_end_xfer;
  output  [  2: 0] pll_s1_address;
  output           pll_s1_chipselect;
  output           pll_s1_read;
  output  [ 15: 0] pll_s1_readdata_from_sa;
  output           pll_s1_reset_n;
  output           pll_s1_resetrequest_from_sa;
  output           pll_s1_write;
  output  [ 15: 0] pll_s1_writedata;
  input            clk;
  input   [  3: 0] clock_0_out_address_to_slave;
  input   [  2: 0] clock_0_out_nativeaddress;
  input            clock_0_out_read;
  input            clock_0_out_write;
  input   [ 15: 0] clock_0_out_writedata;
  input   [ 15: 0] pll_s1_readdata;
  input            pll_s1_resetrequest;
  input            reset_n;

  wire             clock_0_out_arbiterlock;
  wire             clock_0_out_arbiterlock2;
  wire             clock_0_out_continuerequest;
  wire             clock_0_out_granted_pll_s1;
  wire             clock_0_out_qualified_request_pll_s1;
  wire             clock_0_out_read_data_valid_pll_s1;
  wire             clock_0_out_requests_pll_s1;
  wire             clock_0_out_saved_grant_pll_s1;
  reg              d1_pll_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pll_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  2: 0] pll_s1_address;
  wire             pll_s1_allgrants;
  wire             pll_s1_allow_new_arb_cycle;
  wire             pll_s1_any_bursting_master_saved_grant;
  wire             pll_s1_any_continuerequest;
  wire             pll_s1_arb_counter_enable;
  reg              pll_s1_arb_share_counter;
  wire             pll_s1_arb_share_counter_next_value;
  wire             pll_s1_arb_share_set_values;
  wire             pll_s1_beginbursttransfer_internal;
  wire             pll_s1_begins_xfer;
  wire             pll_s1_chipselect;
  wire             pll_s1_end_xfer;
  wire             pll_s1_firsttransfer;
  wire             pll_s1_grant_vector;
  wire             pll_s1_in_a_read_cycle;
  wire             pll_s1_in_a_write_cycle;
  wire             pll_s1_master_qreq_vector;
  wire             pll_s1_non_bursting_master_requests;
  wire             pll_s1_read;
  wire    [ 15: 0] pll_s1_readdata_from_sa;
  reg              pll_s1_reg_firsttransfer;
  wire             pll_s1_reset_n;
  wire             pll_s1_resetrequest_from_sa;
  reg              pll_s1_slavearbiterlockenable;
  wire             pll_s1_slavearbiterlockenable2;
  wire             pll_s1_unreg_firsttransfer;
  wire             pll_s1_waits_for_read;
  wire             pll_s1_waits_for_write;
  wire             pll_s1_write;
  wire    [ 15: 0] pll_s1_writedata;
  wire             wait_for_pll_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~pll_s1_end_xfer;
    end


  assign pll_s1_begins_xfer = ~d1_reasons_to_wait & ((clock_0_out_qualified_request_pll_s1));
  //assign pll_s1_readdata_from_sa = pll_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pll_s1_readdata_from_sa = pll_s1_readdata;

  assign clock_0_out_requests_pll_s1 = (1) & (clock_0_out_read | clock_0_out_write);
  //pll_s1_arb_share_counter set values, which is an e_mux
  assign pll_s1_arb_share_set_values = 1;

  //pll_s1_non_bursting_master_requests mux, which is an e_mux
  assign pll_s1_non_bursting_master_requests = clock_0_out_requests_pll_s1;

  //pll_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pll_s1_any_bursting_master_saved_grant = 0;

  //pll_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pll_s1_arb_share_counter_next_value = pll_s1_firsttransfer ? (pll_s1_arb_share_set_values - 1) : |pll_s1_arb_share_counter ? (pll_s1_arb_share_counter - 1) : 0;

  //pll_s1_allgrants all slave grants, which is an e_mux
  assign pll_s1_allgrants = |pll_s1_grant_vector;

  //pll_s1_end_xfer assignment, which is an e_assign
  assign pll_s1_end_xfer = ~(pll_s1_waits_for_read | pll_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pll_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pll_s1 = pll_s1_end_xfer & (~pll_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pll_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pll_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pll_s1 & pll_s1_allgrants) | (end_xfer_arb_share_counter_term_pll_s1 & ~pll_s1_non_bursting_master_requests);

  //pll_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pll_s1_arb_share_counter <= 0;
      else if (pll_s1_arb_counter_enable)
          pll_s1_arb_share_counter <= pll_s1_arb_share_counter_next_value;
    end


  //pll_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pll_s1_slavearbiterlockenable <= 0;
      else if ((|pll_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pll_s1) | (end_xfer_arb_share_counter_term_pll_s1 & ~pll_s1_non_bursting_master_requests))
          pll_s1_slavearbiterlockenable <= |pll_s1_arb_share_counter_next_value;
    end


  //clock_0/out pll/s1 arbiterlock, which is an e_assign
  assign clock_0_out_arbiterlock = pll_s1_slavearbiterlockenable & clock_0_out_continuerequest;

  //pll_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pll_s1_slavearbiterlockenable2 = |pll_s1_arb_share_counter_next_value;

  //clock_0/out pll/s1 arbiterlock2, which is an e_assign
  assign clock_0_out_arbiterlock2 = pll_s1_slavearbiterlockenable2 & clock_0_out_continuerequest;

  //pll_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pll_s1_any_continuerequest = 1;

  //clock_0_out_continuerequest continued request, which is an e_assign
  assign clock_0_out_continuerequest = 1;

  assign clock_0_out_qualified_request_pll_s1 = clock_0_out_requests_pll_s1;
  //pll_s1_writedata mux, which is an e_mux
  assign pll_s1_writedata = clock_0_out_writedata;

  //master is always granted when requested
  assign clock_0_out_granted_pll_s1 = clock_0_out_qualified_request_pll_s1;

  //clock_0/out saved-grant pll/s1, which is an e_assign
  assign clock_0_out_saved_grant_pll_s1 = clock_0_out_requests_pll_s1;

  //allow new arb cycle for pll/s1, which is an e_assign
  assign pll_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pll_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pll_s1_master_qreq_vector = 1;

  //pll_s1_reset_n assignment, which is an e_assign
  assign pll_s1_reset_n = reset_n;

  //assign pll_s1_resetrequest_from_sa = pll_s1_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pll_s1_resetrequest_from_sa = pll_s1_resetrequest;

  assign pll_s1_chipselect = clock_0_out_granted_pll_s1;
  //pll_s1_firsttransfer first transaction, which is an e_assign
  assign pll_s1_firsttransfer = pll_s1_begins_xfer ? pll_s1_unreg_firsttransfer : pll_s1_reg_firsttransfer;

  //pll_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pll_s1_unreg_firsttransfer = ~(pll_s1_slavearbiterlockenable & pll_s1_any_continuerequest);

  //pll_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pll_s1_reg_firsttransfer <= 1'b1;
      else if (pll_s1_begins_xfer)
          pll_s1_reg_firsttransfer <= pll_s1_unreg_firsttransfer;
    end


  //pll_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pll_s1_beginbursttransfer_internal = pll_s1_begins_xfer;

  //pll_s1_read assignment, which is an e_mux
  assign pll_s1_read = clock_0_out_granted_pll_s1 & clock_0_out_read;

  //pll_s1_write assignment, which is an e_mux
  assign pll_s1_write = clock_0_out_granted_pll_s1 & clock_0_out_write;

  //pll_s1_address mux, which is an e_mux
  assign pll_s1_address = clock_0_out_nativeaddress;

  //d1_pll_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pll_s1_end_xfer <= 1;
      else if (1)
          d1_pll_s1_end_xfer <= pll_s1_end_xfer;
    end


  //pll_s1_waits_for_read in a cycle, which is an e_mux
  assign pll_s1_waits_for_read = pll_s1_in_a_read_cycle & pll_s1_begins_xfer;

  //pll_s1_in_a_read_cycle assignment, which is an e_assign
  assign pll_s1_in_a_read_cycle = clock_0_out_granted_pll_s1 & clock_0_out_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pll_s1_in_a_read_cycle;

  //pll_s1_waits_for_write in a cycle, which is an e_mux
  assign pll_s1_waits_for_write = pll_s1_in_a_write_cycle & 0;

  //pll_s1_in_a_write_cycle assignment, which is an e_assign
  assign pll_s1_in_a_write_cycle = clock_0_out_granted_pll_s1 & clock_0_out_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pll_s1_in_a_write_cycle;

  assign wait_for_pll_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pll/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module ps2_keyboard_avalon_PS2_slave_arbitrator (
                                                  // inputs:
                                                   clk,
                                                   cpu_data_master_address_to_slave,
                                                   cpu_data_master_byteenable,
                                                   cpu_data_master_latency_counter,
                                                   cpu_data_master_read,
                                                   cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                                   cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                                   cpu_data_master_write,
                                                   cpu_data_master_writedata,
                                                   ps2_keyboard_avalon_PS2_slave_irq,
                                                   ps2_keyboard_avalon_PS2_slave_readdata,
                                                   ps2_keyboard_avalon_PS2_slave_waitrequest,
                                                   reset_n,

                                                  // outputs:
                                                   cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave,
                                                   cpu_data_master_qualified_request_ps2_keyboard_avalon_PS2_slave,
                                                   cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave,
                                                   cpu_data_master_requests_ps2_keyboard_avalon_PS2_slave,
                                                   d1_ps2_keyboard_avalon_PS2_slave_end_xfer,
                                                   ps2_keyboard_avalon_PS2_slave_address,
                                                   ps2_keyboard_avalon_PS2_slave_byteenable,
                                                   ps2_keyboard_avalon_PS2_slave_chipselect,
                                                   ps2_keyboard_avalon_PS2_slave_irq_from_sa,
                                                   ps2_keyboard_avalon_PS2_slave_read,
                                                   ps2_keyboard_avalon_PS2_slave_readdata_from_sa,
                                                   ps2_keyboard_avalon_PS2_slave_waitrequest_from_sa,
                                                   ps2_keyboard_avalon_PS2_slave_write,
                                                   ps2_keyboard_avalon_PS2_slave_writedata
                                                )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave;
  output           cpu_data_master_qualified_request_ps2_keyboard_avalon_PS2_slave;
  output           cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave;
  output           cpu_data_master_requests_ps2_keyboard_avalon_PS2_slave;
  output           d1_ps2_keyboard_avalon_PS2_slave_end_xfer;
  output           ps2_keyboard_avalon_PS2_slave_address;
  output  [  3: 0] ps2_keyboard_avalon_PS2_slave_byteenable;
  output           ps2_keyboard_avalon_PS2_slave_chipselect;
  output           ps2_keyboard_avalon_PS2_slave_irq_from_sa;
  output           ps2_keyboard_avalon_PS2_slave_read;
  output  [ 31: 0] ps2_keyboard_avalon_PS2_slave_readdata_from_sa;
  output           ps2_keyboard_avalon_PS2_slave_waitrequest_from_sa;
  output           ps2_keyboard_avalon_PS2_slave_write;
  output  [ 31: 0] ps2_keyboard_avalon_PS2_slave_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            ps2_keyboard_avalon_PS2_slave_irq;
  input   [ 31: 0] ps2_keyboard_avalon_PS2_slave_readdata;
  input            ps2_keyboard_avalon_PS2_slave_waitrequest;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave;
  wire             cpu_data_master_qualified_request_ps2_keyboard_avalon_PS2_slave;
  wire             cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave;
  reg              cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave_shift_register;
  wire             cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave_shift_register_in;
  wire             cpu_data_master_requests_ps2_keyboard_avalon_PS2_slave;
  wire             cpu_data_master_saved_grant_ps2_keyboard_avalon_PS2_slave;
  reg              d1_ps2_keyboard_avalon_PS2_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_ps2_keyboard_avalon_PS2_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             p1_cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave_shift_register;
  wire             ps2_keyboard_avalon_PS2_slave_address;
  wire             ps2_keyboard_avalon_PS2_slave_allgrants;
  wire             ps2_keyboard_avalon_PS2_slave_allow_new_arb_cycle;
  wire             ps2_keyboard_avalon_PS2_slave_any_bursting_master_saved_grant;
  wire             ps2_keyboard_avalon_PS2_slave_any_continuerequest;
  wire             ps2_keyboard_avalon_PS2_slave_arb_counter_enable;
  reg     [  1: 0] ps2_keyboard_avalon_PS2_slave_arb_share_counter;
  wire    [  1: 0] ps2_keyboard_avalon_PS2_slave_arb_share_counter_next_value;
  wire    [  1: 0] ps2_keyboard_avalon_PS2_slave_arb_share_set_values;
  wire             ps2_keyboard_avalon_PS2_slave_beginbursttransfer_internal;
  wire             ps2_keyboard_avalon_PS2_slave_begins_xfer;
  wire    [  3: 0] ps2_keyboard_avalon_PS2_slave_byteenable;
  wire             ps2_keyboard_avalon_PS2_slave_chipselect;
  wire             ps2_keyboard_avalon_PS2_slave_end_xfer;
  wire             ps2_keyboard_avalon_PS2_slave_firsttransfer;
  wire             ps2_keyboard_avalon_PS2_slave_grant_vector;
  wire             ps2_keyboard_avalon_PS2_slave_in_a_read_cycle;
  wire             ps2_keyboard_avalon_PS2_slave_in_a_write_cycle;
  wire             ps2_keyboard_avalon_PS2_slave_irq_from_sa;
  wire             ps2_keyboard_avalon_PS2_slave_master_qreq_vector;
  wire             ps2_keyboard_avalon_PS2_slave_non_bursting_master_requests;
  wire             ps2_keyboard_avalon_PS2_slave_read;
  wire    [ 31: 0] ps2_keyboard_avalon_PS2_slave_readdata_from_sa;
  reg              ps2_keyboard_avalon_PS2_slave_reg_firsttransfer;
  reg              ps2_keyboard_avalon_PS2_slave_slavearbiterlockenable;
  wire             ps2_keyboard_avalon_PS2_slave_slavearbiterlockenable2;
  wire             ps2_keyboard_avalon_PS2_slave_unreg_firsttransfer;
  wire             ps2_keyboard_avalon_PS2_slave_waitrequest_from_sa;
  wire             ps2_keyboard_avalon_PS2_slave_waits_for_read;
  wire             ps2_keyboard_avalon_PS2_slave_waits_for_write;
  wire             ps2_keyboard_avalon_PS2_slave_write;
  wire    [ 31: 0] ps2_keyboard_avalon_PS2_slave_writedata;
  wire    [ 27: 0] shifted_address_to_ps2_keyboard_avalon_PS2_slave_from_cpu_data_master;
  wire             wait_for_ps2_keyboard_avalon_PS2_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~ps2_keyboard_avalon_PS2_slave_end_xfer;
    end


  assign ps2_keyboard_avalon_PS2_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_ps2_keyboard_avalon_PS2_slave));
  //assign ps2_keyboard_avalon_PS2_slave_readdata_from_sa = ps2_keyboard_avalon_PS2_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign ps2_keyboard_avalon_PS2_slave_readdata_from_sa = ps2_keyboard_avalon_PS2_slave_readdata;

  assign cpu_data_master_requests_ps2_keyboard_avalon_PS2_slave = ({cpu_data_master_address_to_slave[27 : 3] , 3'b0} == 28'h96411f0) & (cpu_data_master_read | cpu_data_master_write);
  //assign ps2_keyboard_avalon_PS2_slave_waitrequest_from_sa = ps2_keyboard_avalon_PS2_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign ps2_keyboard_avalon_PS2_slave_waitrequest_from_sa = ps2_keyboard_avalon_PS2_slave_waitrequest;

  //ps2_keyboard_avalon_PS2_slave_arb_share_counter set values, which is an e_mux
  assign ps2_keyboard_avalon_PS2_slave_arb_share_set_values = 1;

  //ps2_keyboard_avalon_PS2_slave_non_bursting_master_requests mux, which is an e_mux
  assign ps2_keyboard_avalon_PS2_slave_non_bursting_master_requests = cpu_data_master_requests_ps2_keyboard_avalon_PS2_slave;

  //ps2_keyboard_avalon_PS2_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign ps2_keyboard_avalon_PS2_slave_any_bursting_master_saved_grant = 0;

  //ps2_keyboard_avalon_PS2_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign ps2_keyboard_avalon_PS2_slave_arb_share_counter_next_value = ps2_keyboard_avalon_PS2_slave_firsttransfer ? (ps2_keyboard_avalon_PS2_slave_arb_share_set_values - 1) : |ps2_keyboard_avalon_PS2_slave_arb_share_counter ? (ps2_keyboard_avalon_PS2_slave_arb_share_counter - 1) : 0;

  //ps2_keyboard_avalon_PS2_slave_allgrants all slave grants, which is an e_mux
  assign ps2_keyboard_avalon_PS2_slave_allgrants = |ps2_keyboard_avalon_PS2_slave_grant_vector;

  //ps2_keyboard_avalon_PS2_slave_end_xfer assignment, which is an e_assign
  assign ps2_keyboard_avalon_PS2_slave_end_xfer = ~(ps2_keyboard_avalon_PS2_slave_waits_for_read | ps2_keyboard_avalon_PS2_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_ps2_keyboard_avalon_PS2_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_ps2_keyboard_avalon_PS2_slave = ps2_keyboard_avalon_PS2_slave_end_xfer & (~ps2_keyboard_avalon_PS2_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //ps2_keyboard_avalon_PS2_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign ps2_keyboard_avalon_PS2_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_ps2_keyboard_avalon_PS2_slave & ps2_keyboard_avalon_PS2_slave_allgrants) | (end_xfer_arb_share_counter_term_ps2_keyboard_avalon_PS2_slave & ~ps2_keyboard_avalon_PS2_slave_non_bursting_master_requests);

  //ps2_keyboard_avalon_PS2_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          ps2_keyboard_avalon_PS2_slave_arb_share_counter <= 0;
      else if (ps2_keyboard_avalon_PS2_slave_arb_counter_enable)
          ps2_keyboard_avalon_PS2_slave_arb_share_counter <= ps2_keyboard_avalon_PS2_slave_arb_share_counter_next_value;
    end


  //ps2_keyboard_avalon_PS2_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          ps2_keyboard_avalon_PS2_slave_slavearbiterlockenable <= 0;
      else if ((|ps2_keyboard_avalon_PS2_slave_master_qreq_vector & end_xfer_arb_share_counter_term_ps2_keyboard_avalon_PS2_slave) | (end_xfer_arb_share_counter_term_ps2_keyboard_avalon_PS2_slave & ~ps2_keyboard_avalon_PS2_slave_non_bursting_master_requests))
          ps2_keyboard_avalon_PS2_slave_slavearbiterlockenable <= |ps2_keyboard_avalon_PS2_slave_arb_share_counter_next_value;
    end


  //cpu/data_master ps2_keyboard/avalon_PS2_slave arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = ps2_keyboard_avalon_PS2_slave_slavearbiterlockenable & cpu_data_master_continuerequest;

  //ps2_keyboard_avalon_PS2_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign ps2_keyboard_avalon_PS2_slave_slavearbiterlockenable2 = |ps2_keyboard_avalon_PS2_slave_arb_share_counter_next_value;

  //cpu/data_master ps2_keyboard/avalon_PS2_slave arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = ps2_keyboard_avalon_PS2_slave_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //ps2_keyboard_avalon_PS2_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign ps2_keyboard_avalon_PS2_slave_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_ps2_keyboard_avalon_PS2_slave = cpu_data_master_requests_ps2_keyboard_avalon_PS2_slave & ~((cpu_data_master_read & ((1 < cpu_data_master_latency_counter) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave_shift_register_in = cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave & cpu_data_master_read & ~ps2_keyboard_avalon_PS2_slave_waits_for_read;

  //shift register p1 cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave_shift_register = {cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave_shift_register, cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave_shift_register_in};

  //cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave_shift_register <= 0;
      else if (1)
          cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave_shift_register <= p1_cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave_shift_register;
    end


  //local readdatavalid cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave, which is an e_mux
  assign cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave = cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave_shift_register;

  //ps2_keyboard_avalon_PS2_slave_writedata mux, which is an e_mux
  assign ps2_keyboard_avalon_PS2_slave_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave = cpu_data_master_qualified_request_ps2_keyboard_avalon_PS2_slave;

  //cpu/data_master saved-grant ps2_keyboard/avalon_PS2_slave, which is an e_assign
  assign cpu_data_master_saved_grant_ps2_keyboard_avalon_PS2_slave = cpu_data_master_requests_ps2_keyboard_avalon_PS2_slave;

  //allow new arb cycle for ps2_keyboard/avalon_PS2_slave, which is an e_assign
  assign ps2_keyboard_avalon_PS2_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign ps2_keyboard_avalon_PS2_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign ps2_keyboard_avalon_PS2_slave_master_qreq_vector = 1;

  assign ps2_keyboard_avalon_PS2_slave_chipselect = cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave;
  //ps2_keyboard_avalon_PS2_slave_firsttransfer first transaction, which is an e_assign
  assign ps2_keyboard_avalon_PS2_slave_firsttransfer = ps2_keyboard_avalon_PS2_slave_begins_xfer ? ps2_keyboard_avalon_PS2_slave_unreg_firsttransfer : ps2_keyboard_avalon_PS2_slave_reg_firsttransfer;

  //ps2_keyboard_avalon_PS2_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign ps2_keyboard_avalon_PS2_slave_unreg_firsttransfer = ~(ps2_keyboard_avalon_PS2_slave_slavearbiterlockenable & ps2_keyboard_avalon_PS2_slave_any_continuerequest);

  //ps2_keyboard_avalon_PS2_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          ps2_keyboard_avalon_PS2_slave_reg_firsttransfer <= 1'b1;
      else if (ps2_keyboard_avalon_PS2_slave_begins_xfer)
          ps2_keyboard_avalon_PS2_slave_reg_firsttransfer <= ps2_keyboard_avalon_PS2_slave_unreg_firsttransfer;
    end


  //ps2_keyboard_avalon_PS2_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign ps2_keyboard_avalon_PS2_slave_beginbursttransfer_internal = ps2_keyboard_avalon_PS2_slave_begins_xfer;

  //ps2_keyboard_avalon_PS2_slave_read assignment, which is an e_mux
  assign ps2_keyboard_avalon_PS2_slave_read = cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave & cpu_data_master_read;

  //ps2_keyboard_avalon_PS2_slave_write assignment, which is an e_mux
  assign ps2_keyboard_avalon_PS2_slave_write = cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave & cpu_data_master_write;

  assign shifted_address_to_ps2_keyboard_avalon_PS2_slave_from_cpu_data_master = cpu_data_master_address_to_slave;
  //ps2_keyboard_avalon_PS2_slave_address mux, which is an e_mux
  assign ps2_keyboard_avalon_PS2_slave_address = shifted_address_to_ps2_keyboard_avalon_PS2_slave_from_cpu_data_master >> 2;

  //d1_ps2_keyboard_avalon_PS2_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_ps2_keyboard_avalon_PS2_slave_end_xfer <= 1;
      else if (1)
          d1_ps2_keyboard_avalon_PS2_slave_end_xfer <= ps2_keyboard_avalon_PS2_slave_end_xfer;
    end


  //ps2_keyboard_avalon_PS2_slave_waits_for_read in a cycle, which is an e_mux
  assign ps2_keyboard_avalon_PS2_slave_waits_for_read = ps2_keyboard_avalon_PS2_slave_in_a_read_cycle & ps2_keyboard_avalon_PS2_slave_waitrequest_from_sa;

  //ps2_keyboard_avalon_PS2_slave_in_a_read_cycle assignment, which is an e_assign
  assign ps2_keyboard_avalon_PS2_slave_in_a_read_cycle = cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = ps2_keyboard_avalon_PS2_slave_in_a_read_cycle;

  //ps2_keyboard_avalon_PS2_slave_waits_for_write in a cycle, which is an e_mux
  assign ps2_keyboard_avalon_PS2_slave_waits_for_write = ps2_keyboard_avalon_PS2_slave_in_a_write_cycle & ps2_keyboard_avalon_PS2_slave_waitrequest_from_sa;

  //ps2_keyboard_avalon_PS2_slave_in_a_write_cycle assignment, which is an e_assign
  assign ps2_keyboard_avalon_PS2_slave_in_a_write_cycle = cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = ps2_keyboard_avalon_PS2_slave_in_a_write_cycle;

  assign wait_for_ps2_keyboard_avalon_PS2_slave_counter = 0;
  //ps2_keyboard_avalon_PS2_slave_byteenable byte enable port mux, which is an e_mux
  assign ps2_keyboard_avalon_PS2_slave_byteenable = (cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave)? cpu_data_master_byteenable :
    -1;

  //assign ps2_keyboard_avalon_PS2_slave_irq_from_sa = ps2_keyboard_avalon_PS2_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign ps2_keyboard_avalon_PS2_slave_irq_from_sa = ps2_keyboard_avalon_PS2_slave_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //ps2_keyboard/avalon_PS2_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module DE2_70_SOPC_reset_pll_c0_system_domain_synch_module (
                                                             // inputs:
                                                              clk,
                                                              data_in,
                                                              reset_n,

                                                             // outputs:
                                                              data_out
                                                           )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "MAX_DELAY=\"100ns\" ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else if (1)
          data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else if (1)
          data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module ps2_mouse_avalon_PS2_slave_arbitrator (
                                               // inputs:
                                                clk,
                                                cpu_data_master_address_to_slave,
                                                cpu_data_master_byteenable,
                                                cpu_data_master_latency_counter,
                                                cpu_data_master_read,
                                                cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                                cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                                cpu_data_master_write,
                                                cpu_data_master_writedata,
                                                ps2_mouse_avalon_PS2_slave_irq,
                                                ps2_mouse_avalon_PS2_slave_readdata,
                                                ps2_mouse_avalon_PS2_slave_waitrequest,
                                                reset_n,

                                               // outputs:
                                                cpu_data_master_granted_ps2_mouse_avalon_PS2_slave,
                                                cpu_data_master_qualified_request_ps2_mouse_avalon_PS2_slave,
                                                cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave,
                                                cpu_data_master_requests_ps2_mouse_avalon_PS2_slave,
                                                d1_ps2_mouse_avalon_PS2_slave_end_xfer,
                                                ps2_mouse_avalon_PS2_slave_address,
                                                ps2_mouse_avalon_PS2_slave_byteenable,
                                                ps2_mouse_avalon_PS2_slave_chipselect,
                                                ps2_mouse_avalon_PS2_slave_irq_from_sa,
                                                ps2_mouse_avalon_PS2_slave_read,
                                                ps2_mouse_avalon_PS2_slave_readdata_from_sa,
                                                ps2_mouse_avalon_PS2_slave_waitrequest_from_sa,
                                                ps2_mouse_avalon_PS2_slave_write,
                                                ps2_mouse_avalon_PS2_slave_writedata
                                             )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_ps2_mouse_avalon_PS2_slave;
  output           cpu_data_master_qualified_request_ps2_mouse_avalon_PS2_slave;
  output           cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave;
  output           cpu_data_master_requests_ps2_mouse_avalon_PS2_slave;
  output           d1_ps2_mouse_avalon_PS2_slave_end_xfer;
  output           ps2_mouse_avalon_PS2_slave_address;
  output  [  3: 0] ps2_mouse_avalon_PS2_slave_byteenable;
  output           ps2_mouse_avalon_PS2_slave_chipselect;
  output           ps2_mouse_avalon_PS2_slave_irq_from_sa;
  output           ps2_mouse_avalon_PS2_slave_read;
  output  [ 31: 0] ps2_mouse_avalon_PS2_slave_readdata_from_sa;
  output           ps2_mouse_avalon_PS2_slave_waitrequest_from_sa;
  output           ps2_mouse_avalon_PS2_slave_write;
  output  [ 31: 0] ps2_mouse_avalon_PS2_slave_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            ps2_mouse_avalon_PS2_slave_irq;
  input   [ 31: 0] ps2_mouse_avalon_PS2_slave_readdata;
  input            ps2_mouse_avalon_PS2_slave_waitrequest;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_ps2_mouse_avalon_PS2_slave;
  wire             cpu_data_master_qualified_request_ps2_mouse_avalon_PS2_slave;
  wire             cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave;
  reg              cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave_shift_register;
  wire             cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave_shift_register_in;
  wire             cpu_data_master_requests_ps2_mouse_avalon_PS2_slave;
  wire             cpu_data_master_saved_grant_ps2_mouse_avalon_PS2_slave;
  reg              d1_ps2_mouse_avalon_PS2_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_ps2_mouse_avalon_PS2_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             p1_cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave_shift_register;
  wire             ps2_mouse_avalon_PS2_slave_address;
  wire             ps2_mouse_avalon_PS2_slave_allgrants;
  wire             ps2_mouse_avalon_PS2_slave_allow_new_arb_cycle;
  wire             ps2_mouse_avalon_PS2_slave_any_bursting_master_saved_grant;
  wire             ps2_mouse_avalon_PS2_slave_any_continuerequest;
  wire             ps2_mouse_avalon_PS2_slave_arb_counter_enable;
  reg     [  1: 0] ps2_mouse_avalon_PS2_slave_arb_share_counter;
  wire    [  1: 0] ps2_mouse_avalon_PS2_slave_arb_share_counter_next_value;
  wire    [  1: 0] ps2_mouse_avalon_PS2_slave_arb_share_set_values;
  wire             ps2_mouse_avalon_PS2_slave_beginbursttransfer_internal;
  wire             ps2_mouse_avalon_PS2_slave_begins_xfer;
  wire    [  3: 0] ps2_mouse_avalon_PS2_slave_byteenable;
  wire             ps2_mouse_avalon_PS2_slave_chipselect;
  wire             ps2_mouse_avalon_PS2_slave_end_xfer;
  wire             ps2_mouse_avalon_PS2_slave_firsttransfer;
  wire             ps2_mouse_avalon_PS2_slave_grant_vector;
  wire             ps2_mouse_avalon_PS2_slave_in_a_read_cycle;
  wire             ps2_mouse_avalon_PS2_slave_in_a_write_cycle;
  wire             ps2_mouse_avalon_PS2_slave_irq_from_sa;
  wire             ps2_mouse_avalon_PS2_slave_master_qreq_vector;
  wire             ps2_mouse_avalon_PS2_slave_non_bursting_master_requests;
  wire             ps2_mouse_avalon_PS2_slave_read;
  wire    [ 31: 0] ps2_mouse_avalon_PS2_slave_readdata_from_sa;
  reg              ps2_mouse_avalon_PS2_slave_reg_firsttransfer;
  reg              ps2_mouse_avalon_PS2_slave_slavearbiterlockenable;
  wire             ps2_mouse_avalon_PS2_slave_slavearbiterlockenable2;
  wire             ps2_mouse_avalon_PS2_slave_unreg_firsttransfer;
  wire             ps2_mouse_avalon_PS2_slave_waitrequest_from_sa;
  wire             ps2_mouse_avalon_PS2_slave_waits_for_read;
  wire             ps2_mouse_avalon_PS2_slave_waits_for_write;
  wire             ps2_mouse_avalon_PS2_slave_write;
  wire    [ 31: 0] ps2_mouse_avalon_PS2_slave_writedata;
  wire    [ 27: 0] shifted_address_to_ps2_mouse_avalon_PS2_slave_from_cpu_data_master;
  wire             wait_for_ps2_mouse_avalon_PS2_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~ps2_mouse_avalon_PS2_slave_end_xfer;
    end


  assign ps2_mouse_avalon_PS2_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_ps2_mouse_avalon_PS2_slave));
  //assign ps2_mouse_avalon_PS2_slave_readdata_from_sa = ps2_mouse_avalon_PS2_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign ps2_mouse_avalon_PS2_slave_readdata_from_sa = ps2_mouse_avalon_PS2_slave_readdata;

  assign cpu_data_master_requests_ps2_mouse_avalon_PS2_slave = ({cpu_data_master_address_to_slave[27 : 3] , 3'b0} == 28'h96411f8) & (cpu_data_master_read | cpu_data_master_write);
  //assign ps2_mouse_avalon_PS2_slave_waitrequest_from_sa = ps2_mouse_avalon_PS2_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign ps2_mouse_avalon_PS2_slave_waitrequest_from_sa = ps2_mouse_avalon_PS2_slave_waitrequest;

  //ps2_mouse_avalon_PS2_slave_arb_share_counter set values, which is an e_mux
  assign ps2_mouse_avalon_PS2_slave_arb_share_set_values = 1;

  //ps2_mouse_avalon_PS2_slave_non_bursting_master_requests mux, which is an e_mux
  assign ps2_mouse_avalon_PS2_slave_non_bursting_master_requests = cpu_data_master_requests_ps2_mouse_avalon_PS2_slave;

  //ps2_mouse_avalon_PS2_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign ps2_mouse_avalon_PS2_slave_any_bursting_master_saved_grant = 0;

  //ps2_mouse_avalon_PS2_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign ps2_mouse_avalon_PS2_slave_arb_share_counter_next_value = ps2_mouse_avalon_PS2_slave_firsttransfer ? (ps2_mouse_avalon_PS2_slave_arb_share_set_values - 1) : |ps2_mouse_avalon_PS2_slave_arb_share_counter ? (ps2_mouse_avalon_PS2_slave_arb_share_counter - 1) : 0;

  //ps2_mouse_avalon_PS2_slave_allgrants all slave grants, which is an e_mux
  assign ps2_mouse_avalon_PS2_slave_allgrants = |ps2_mouse_avalon_PS2_slave_grant_vector;

  //ps2_mouse_avalon_PS2_slave_end_xfer assignment, which is an e_assign
  assign ps2_mouse_avalon_PS2_slave_end_xfer = ~(ps2_mouse_avalon_PS2_slave_waits_for_read | ps2_mouse_avalon_PS2_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_ps2_mouse_avalon_PS2_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_ps2_mouse_avalon_PS2_slave = ps2_mouse_avalon_PS2_slave_end_xfer & (~ps2_mouse_avalon_PS2_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //ps2_mouse_avalon_PS2_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign ps2_mouse_avalon_PS2_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_ps2_mouse_avalon_PS2_slave & ps2_mouse_avalon_PS2_slave_allgrants) | (end_xfer_arb_share_counter_term_ps2_mouse_avalon_PS2_slave & ~ps2_mouse_avalon_PS2_slave_non_bursting_master_requests);

  //ps2_mouse_avalon_PS2_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          ps2_mouse_avalon_PS2_slave_arb_share_counter <= 0;
      else if (ps2_mouse_avalon_PS2_slave_arb_counter_enable)
          ps2_mouse_avalon_PS2_slave_arb_share_counter <= ps2_mouse_avalon_PS2_slave_arb_share_counter_next_value;
    end


  //ps2_mouse_avalon_PS2_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          ps2_mouse_avalon_PS2_slave_slavearbiterlockenable <= 0;
      else if ((|ps2_mouse_avalon_PS2_slave_master_qreq_vector & end_xfer_arb_share_counter_term_ps2_mouse_avalon_PS2_slave) | (end_xfer_arb_share_counter_term_ps2_mouse_avalon_PS2_slave & ~ps2_mouse_avalon_PS2_slave_non_bursting_master_requests))
          ps2_mouse_avalon_PS2_slave_slavearbiterlockenable <= |ps2_mouse_avalon_PS2_slave_arb_share_counter_next_value;
    end


  //cpu/data_master ps2_mouse/avalon_PS2_slave arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = ps2_mouse_avalon_PS2_slave_slavearbiterlockenable & cpu_data_master_continuerequest;

  //ps2_mouse_avalon_PS2_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign ps2_mouse_avalon_PS2_slave_slavearbiterlockenable2 = |ps2_mouse_avalon_PS2_slave_arb_share_counter_next_value;

  //cpu/data_master ps2_mouse/avalon_PS2_slave arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = ps2_mouse_avalon_PS2_slave_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //ps2_mouse_avalon_PS2_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign ps2_mouse_avalon_PS2_slave_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_ps2_mouse_avalon_PS2_slave = cpu_data_master_requests_ps2_mouse_avalon_PS2_slave & ~((cpu_data_master_read & ((1 < cpu_data_master_latency_counter) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave_shift_register_in = cpu_data_master_granted_ps2_mouse_avalon_PS2_slave & cpu_data_master_read & ~ps2_mouse_avalon_PS2_slave_waits_for_read;

  //shift register p1 cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave_shift_register = {cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave_shift_register, cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave_shift_register_in};

  //cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave_shift_register <= 0;
      else if (1)
          cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave_shift_register <= p1_cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave_shift_register;
    end


  //local readdatavalid cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave, which is an e_mux
  assign cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave = cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave_shift_register;

  //ps2_mouse_avalon_PS2_slave_writedata mux, which is an e_mux
  assign ps2_mouse_avalon_PS2_slave_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_ps2_mouse_avalon_PS2_slave = cpu_data_master_qualified_request_ps2_mouse_avalon_PS2_slave;

  //cpu/data_master saved-grant ps2_mouse/avalon_PS2_slave, which is an e_assign
  assign cpu_data_master_saved_grant_ps2_mouse_avalon_PS2_slave = cpu_data_master_requests_ps2_mouse_avalon_PS2_slave;

  //allow new arb cycle for ps2_mouse/avalon_PS2_slave, which is an e_assign
  assign ps2_mouse_avalon_PS2_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign ps2_mouse_avalon_PS2_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign ps2_mouse_avalon_PS2_slave_master_qreq_vector = 1;

  assign ps2_mouse_avalon_PS2_slave_chipselect = cpu_data_master_granted_ps2_mouse_avalon_PS2_slave;
  //ps2_mouse_avalon_PS2_slave_firsttransfer first transaction, which is an e_assign
  assign ps2_mouse_avalon_PS2_slave_firsttransfer = ps2_mouse_avalon_PS2_slave_begins_xfer ? ps2_mouse_avalon_PS2_slave_unreg_firsttransfer : ps2_mouse_avalon_PS2_slave_reg_firsttransfer;

  //ps2_mouse_avalon_PS2_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign ps2_mouse_avalon_PS2_slave_unreg_firsttransfer = ~(ps2_mouse_avalon_PS2_slave_slavearbiterlockenable & ps2_mouse_avalon_PS2_slave_any_continuerequest);

  //ps2_mouse_avalon_PS2_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          ps2_mouse_avalon_PS2_slave_reg_firsttransfer <= 1'b1;
      else if (ps2_mouse_avalon_PS2_slave_begins_xfer)
          ps2_mouse_avalon_PS2_slave_reg_firsttransfer <= ps2_mouse_avalon_PS2_slave_unreg_firsttransfer;
    end


  //ps2_mouse_avalon_PS2_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign ps2_mouse_avalon_PS2_slave_beginbursttransfer_internal = ps2_mouse_avalon_PS2_slave_begins_xfer;

  //ps2_mouse_avalon_PS2_slave_read assignment, which is an e_mux
  assign ps2_mouse_avalon_PS2_slave_read = cpu_data_master_granted_ps2_mouse_avalon_PS2_slave & cpu_data_master_read;

  //ps2_mouse_avalon_PS2_slave_write assignment, which is an e_mux
  assign ps2_mouse_avalon_PS2_slave_write = cpu_data_master_granted_ps2_mouse_avalon_PS2_slave & cpu_data_master_write;

  assign shifted_address_to_ps2_mouse_avalon_PS2_slave_from_cpu_data_master = cpu_data_master_address_to_slave;
  //ps2_mouse_avalon_PS2_slave_address mux, which is an e_mux
  assign ps2_mouse_avalon_PS2_slave_address = shifted_address_to_ps2_mouse_avalon_PS2_slave_from_cpu_data_master >> 2;

  //d1_ps2_mouse_avalon_PS2_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_ps2_mouse_avalon_PS2_slave_end_xfer <= 1;
      else if (1)
          d1_ps2_mouse_avalon_PS2_slave_end_xfer <= ps2_mouse_avalon_PS2_slave_end_xfer;
    end


  //ps2_mouse_avalon_PS2_slave_waits_for_read in a cycle, which is an e_mux
  assign ps2_mouse_avalon_PS2_slave_waits_for_read = ps2_mouse_avalon_PS2_slave_in_a_read_cycle & ps2_mouse_avalon_PS2_slave_waitrequest_from_sa;

  //ps2_mouse_avalon_PS2_slave_in_a_read_cycle assignment, which is an e_assign
  assign ps2_mouse_avalon_PS2_slave_in_a_read_cycle = cpu_data_master_granted_ps2_mouse_avalon_PS2_slave & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = ps2_mouse_avalon_PS2_slave_in_a_read_cycle;

  //ps2_mouse_avalon_PS2_slave_waits_for_write in a cycle, which is an e_mux
  assign ps2_mouse_avalon_PS2_slave_waits_for_write = ps2_mouse_avalon_PS2_slave_in_a_write_cycle & ps2_mouse_avalon_PS2_slave_waitrequest_from_sa;

  //ps2_mouse_avalon_PS2_slave_in_a_write_cycle assignment, which is an e_assign
  assign ps2_mouse_avalon_PS2_slave_in_a_write_cycle = cpu_data_master_granted_ps2_mouse_avalon_PS2_slave & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = ps2_mouse_avalon_PS2_slave_in_a_write_cycle;

  assign wait_for_ps2_mouse_avalon_PS2_slave_counter = 0;
  //ps2_mouse_avalon_PS2_slave_byteenable byte enable port mux, which is an e_mux
  assign ps2_mouse_avalon_PS2_slave_byteenable = (cpu_data_master_granted_ps2_mouse_avalon_PS2_slave)? cpu_data_master_byteenable :
    -1;

  //assign ps2_mouse_avalon_PS2_slave_irq_from_sa = ps2_mouse_avalon_PS2_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign ps2_mouse_avalon_PS2_slave_irq_from_sa = ps2_mouse_avalon_PS2_slave_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //ps2_mouse/avalon_PS2_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sd_clk_s1_arbitrator (
                              // inputs:
                               clk,
                               cpu_data_master_address_to_slave,
                               cpu_data_master_latency_counter,
                               cpu_data_master_read,
                               cpu_data_master_write,
                               cpu_data_master_writedata,
                               reset_n,

                              // outputs:
                               cpu_data_master_granted_sd_clk_s1,
                               cpu_data_master_qualified_request_sd_clk_s1,
                               cpu_data_master_read_data_valid_sd_clk_s1,
                               cpu_data_master_requests_sd_clk_s1,
                               d1_sd_clk_s1_end_xfer,
                               sd_clk_s1_address,
                               sd_clk_s1_chipselect,
                               sd_clk_s1_reset_n,
                               sd_clk_s1_write_n,
                               sd_clk_s1_writedata
                            )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_sd_clk_s1;
  output           cpu_data_master_qualified_request_sd_clk_s1;
  output           cpu_data_master_read_data_valid_sd_clk_s1;
  output           cpu_data_master_requests_sd_clk_s1;
  output           d1_sd_clk_s1_end_xfer;
  output  [  1: 0] sd_clk_s1_address;
  output           sd_clk_s1_chipselect;
  output           sd_clk_s1_reset_n;
  output           sd_clk_s1_write_n;
  output           sd_clk_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_sd_clk_s1;
  wire             cpu_data_master_qualified_request_sd_clk_s1;
  wire             cpu_data_master_read_data_valid_sd_clk_s1;
  wire             cpu_data_master_requests_sd_clk_s1;
  wire             cpu_data_master_saved_grant_sd_clk_s1;
  reg              d1_reasons_to_wait;
  reg              d1_sd_clk_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sd_clk_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] sd_clk_s1_address;
  wire             sd_clk_s1_allgrants;
  wire             sd_clk_s1_allow_new_arb_cycle;
  wire             sd_clk_s1_any_bursting_master_saved_grant;
  wire             sd_clk_s1_any_continuerequest;
  wire             sd_clk_s1_arb_counter_enable;
  reg     [  1: 0] sd_clk_s1_arb_share_counter;
  wire    [  1: 0] sd_clk_s1_arb_share_counter_next_value;
  wire    [  1: 0] sd_clk_s1_arb_share_set_values;
  wire             sd_clk_s1_beginbursttransfer_internal;
  wire             sd_clk_s1_begins_xfer;
  wire             sd_clk_s1_chipselect;
  wire             sd_clk_s1_end_xfer;
  wire             sd_clk_s1_firsttransfer;
  wire             sd_clk_s1_grant_vector;
  wire             sd_clk_s1_in_a_read_cycle;
  wire             sd_clk_s1_in_a_write_cycle;
  wire             sd_clk_s1_master_qreq_vector;
  wire             sd_clk_s1_non_bursting_master_requests;
  reg              sd_clk_s1_reg_firsttransfer;
  wire             sd_clk_s1_reset_n;
  reg              sd_clk_s1_slavearbiterlockenable;
  wire             sd_clk_s1_slavearbiterlockenable2;
  wire             sd_clk_s1_unreg_firsttransfer;
  wire             sd_clk_s1_waits_for_read;
  wire             sd_clk_s1_waits_for_write;
  wire             sd_clk_s1_write_n;
  wire             sd_clk_s1_writedata;
  wire    [ 27: 0] shifted_address_to_sd_clk_s1_from_cpu_data_master;
  wire             wait_for_sd_clk_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~sd_clk_s1_end_xfer;
    end


  assign sd_clk_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_sd_clk_s1));
  assign cpu_data_master_requests_sd_clk_s1 = (({cpu_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h9641190) & (cpu_data_master_read | cpu_data_master_write)) & cpu_data_master_write;
  //sd_clk_s1_arb_share_counter set values, which is an e_mux
  assign sd_clk_s1_arb_share_set_values = 1;

  //sd_clk_s1_non_bursting_master_requests mux, which is an e_mux
  assign sd_clk_s1_non_bursting_master_requests = cpu_data_master_requests_sd_clk_s1;

  //sd_clk_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sd_clk_s1_any_bursting_master_saved_grant = 0;

  //sd_clk_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sd_clk_s1_arb_share_counter_next_value = sd_clk_s1_firsttransfer ? (sd_clk_s1_arb_share_set_values - 1) : |sd_clk_s1_arb_share_counter ? (sd_clk_s1_arb_share_counter - 1) : 0;

  //sd_clk_s1_allgrants all slave grants, which is an e_mux
  assign sd_clk_s1_allgrants = |sd_clk_s1_grant_vector;

  //sd_clk_s1_end_xfer assignment, which is an e_assign
  assign sd_clk_s1_end_xfer = ~(sd_clk_s1_waits_for_read | sd_clk_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sd_clk_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sd_clk_s1 = sd_clk_s1_end_xfer & (~sd_clk_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sd_clk_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sd_clk_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sd_clk_s1 & sd_clk_s1_allgrants) | (end_xfer_arb_share_counter_term_sd_clk_s1 & ~sd_clk_s1_non_bursting_master_requests);

  //sd_clk_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sd_clk_s1_arb_share_counter <= 0;
      else if (sd_clk_s1_arb_counter_enable)
          sd_clk_s1_arb_share_counter <= sd_clk_s1_arb_share_counter_next_value;
    end


  //sd_clk_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sd_clk_s1_slavearbiterlockenable <= 0;
      else if ((|sd_clk_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sd_clk_s1) | (end_xfer_arb_share_counter_term_sd_clk_s1 & ~sd_clk_s1_non_bursting_master_requests))
          sd_clk_s1_slavearbiterlockenable <= |sd_clk_s1_arb_share_counter_next_value;
    end


  //cpu/data_master sd_clk/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = sd_clk_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //sd_clk_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sd_clk_s1_slavearbiterlockenable2 = |sd_clk_s1_arb_share_counter_next_value;

  //cpu/data_master sd_clk/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = sd_clk_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //sd_clk_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign sd_clk_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_sd_clk_s1 = cpu_data_master_requests_sd_clk_s1;
  //local readdatavalid cpu_data_master_read_data_valid_sd_clk_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_sd_clk_s1 = cpu_data_master_granted_sd_clk_s1 & cpu_data_master_read & ~sd_clk_s1_waits_for_read;

  //sd_clk_s1_writedata mux, which is an e_mux
  assign sd_clk_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_sd_clk_s1 = cpu_data_master_qualified_request_sd_clk_s1;

  //cpu/data_master saved-grant sd_clk/s1, which is an e_assign
  assign cpu_data_master_saved_grant_sd_clk_s1 = cpu_data_master_requests_sd_clk_s1;

  //allow new arb cycle for sd_clk/s1, which is an e_assign
  assign sd_clk_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign sd_clk_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign sd_clk_s1_master_qreq_vector = 1;

  //sd_clk_s1_reset_n assignment, which is an e_assign
  assign sd_clk_s1_reset_n = reset_n;

  assign sd_clk_s1_chipselect = cpu_data_master_granted_sd_clk_s1;
  //sd_clk_s1_firsttransfer first transaction, which is an e_assign
  assign sd_clk_s1_firsttransfer = sd_clk_s1_begins_xfer ? sd_clk_s1_unreg_firsttransfer : sd_clk_s1_reg_firsttransfer;

  //sd_clk_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sd_clk_s1_unreg_firsttransfer = ~(sd_clk_s1_slavearbiterlockenable & sd_clk_s1_any_continuerequest);

  //sd_clk_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sd_clk_s1_reg_firsttransfer <= 1'b1;
      else if (sd_clk_s1_begins_xfer)
          sd_clk_s1_reg_firsttransfer <= sd_clk_s1_unreg_firsttransfer;
    end


  //sd_clk_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sd_clk_s1_beginbursttransfer_internal = sd_clk_s1_begins_xfer;

  //~sd_clk_s1_write_n assignment, which is an e_mux
  assign sd_clk_s1_write_n = ~(cpu_data_master_granted_sd_clk_s1 & cpu_data_master_write);

  assign shifted_address_to_sd_clk_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //sd_clk_s1_address mux, which is an e_mux
  assign sd_clk_s1_address = shifted_address_to_sd_clk_s1_from_cpu_data_master >> 2;

  //d1_sd_clk_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sd_clk_s1_end_xfer <= 1;
      else if (1)
          d1_sd_clk_s1_end_xfer <= sd_clk_s1_end_xfer;
    end


  //sd_clk_s1_waits_for_read in a cycle, which is an e_mux
  assign sd_clk_s1_waits_for_read = sd_clk_s1_in_a_read_cycle & sd_clk_s1_begins_xfer;

  //sd_clk_s1_in_a_read_cycle assignment, which is an e_assign
  assign sd_clk_s1_in_a_read_cycle = cpu_data_master_granted_sd_clk_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sd_clk_s1_in_a_read_cycle;

  //sd_clk_s1_waits_for_write in a cycle, which is an e_mux
  assign sd_clk_s1_waits_for_write = sd_clk_s1_in_a_write_cycle & 0;

  //sd_clk_s1_in_a_write_cycle assignment, which is an e_assign
  assign sd_clk_s1_in_a_write_cycle = cpu_data_master_granted_sd_clk_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sd_clk_s1_in_a_write_cycle;

  assign wait_for_sd_clk_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sd_clk/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sd_cmd_s1_arbitrator (
                              // inputs:
                               clk,
                               cpu_data_master_address_to_slave,
                               cpu_data_master_latency_counter,
                               cpu_data_master_read,
                               cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                               cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                               cpu_data_master_write,
                               cpu_data_master_writedata,
                               reset_n,
                               sd_cmd_s1_readdata,

                              // outputs:
                               cpu_data_master_granted_sd_cmd_s1,
                               cpu_data_master_qualified_request_sd_cmd_s1,
                               cpu_data_master_read_data_valid_sd_cmd_s1,
                               cpu_data_master_requests_sd_cmd_s1,
                               d1_sd_cmd_s1_end_xfer,
                               sd_cmd_s1_address,
                               sd_cmd_s1_chipselect,
                               sd_cmd_s1_readdata_from_sa,
                               sd_cmd_s1_reset_n,
                               sd_cmd_s1_write_n,
                               sd_cmd_s1_writedata
                            )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_sd_cmd_s1;
  output           cpu_data_master_qualified_request_sd_cmd_s1;
  output           cpu_data_master_read_data_valid_sd_cmd_s1;
  output           cpu_data_master_requests_sd_cmd_s1;
  output           d1_sd_cmd_s1_end_xfer;
  output  [  1: 0] sd_cmd_s1_address;
  output           sd_cmd_s1_chipselect;
  output           sd_cmd_s1_readdata_from_sa;
  output           sd_cmd_s1_reset_n;
  output           sd_cmd_s1_write_n;
  output           sd_cmd_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;
  input            sd_cmd_s1_readdata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_sd_cmd_s1;
  wire             cpu_data_master_qualified_request_sd_cmd_s1;
  wire             cpu_data_master_read_data_valid_sd_cmd_s1;
  wire             cpu_data_master_requests_sd_cmd_s1;
  wire             cpu_data_master_saved_grant_sd_cmd_s1;
  reg              d1_reasons_to_wait;
  reg              d1_sd_cmd_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sd_cmd_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] sd_cmd_s1_address;
  wire             sd_cmd_s1_allgrants;
  wire             sd_cmd_s1_allow_new_arb_cycle;
  wire             sd_cmd_s1_any_bursting_master_saved_grant;
  wire             sd_cmd_s1_any_continuerequest;
  wire             sd_cmd_s1_arb_counter_enable;
  reg     [  1: 0] sd_cmd_s1_arb_share_counter;
  wire    [  1: 0] sd_cmd_s1_arb_share_counter_next_value;
  wire    [  1: 0] sd_cmd_s1_arb_share_set_values;
  wire             sd_cmd_s1_beginbursttransfer_internal;
  wire             sd_cmd_s1_begins_xfer;
  wire             sd_cmd_s1_chipselect;
  wire             sd_cmd_s1_end_xfer;
  wire             sd_cmd_s1_firsttransfer;
  wire             sd_cmd_s1_grant_vector;
  wire             sd_cmd_s1_in_a_read_cycle;
  wire             sd_cmd_s1_in_a_write_cycle;
  wire             sd_cmd_s1_master_qreq_vector;
  wire             sd_cmd_s1_non_bursting_master_requests;
  wire             sd_cmd_s1_readdata_from_sa;
  reg              sd_cmd_s1_reg_firsttransfer;
  wire             sd_cmd_s1_reset_n;
  reg              sd_cmd_s1_slavearbiterlockenable;
  wire             sd_cmd_s1_slavearbiterlockenable2;
  wire             sd_cmd_s1_unreg_firsttransfer;
  wire             sd_cmd_s1_waits_for_read;
  wire             sd_cmd_s1_waits_for_write;
  wire             sd_cmd_s1_write_n;
  wire             sd_cmd_s1_writedata;
  wire    [ 27: 0] shifted_address_to_sd_cmd_s1_from_cpu_data_master;
  wire             wait_for_sd_cmd_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~sd_cmd_s1_end_xfer;
    end


  assign sd_cmd_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_sd_cmd_s1));
  //assign sd_cmd_s1_readdata_from_sa = sd_cmd_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sd_cmd_s1_readdata_from_sa = sd_cmd_s1_readdata;

  assign cpu_data_master_requests_sd_cmd_s1 = ({cpu_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h96411a0) & (cpu_data_master_read | cpu_data_master_write);
  //sd_cmd_s1_arb_share_counter set values, which is an e_mux
  assign sd_cmd_s1_arb_share_set_values = 1;

  //sd_cmd_s1_non_bursting_master_requests mux, which is an e_mux
  assign sd_cmd_s1_non_bursting_master_requests = cpu_data_master_requests_sd_cmd_s1;

  //sd_cmd_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sd_cmd_s1_any_bursting_master_saved_grant = 0;

  //sd_cmd_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sd_cmd_s1_arb_share_counter_next_value = sd_cmd_s1_firsttransfer ? (sd_cmd_s1_arb_share_set_values - 1) : |sd_cmd_s1_arb_share_counter ? (sd_cmd_s1_arb_share_counter - 1) : 0;

  //sd_cmd_s1_allgrants all slave grants, which is an e_mux
  assign sd_cmd_s1_allgrants = |sd_cmd_s1_grant_vector;

  //sd_cmd_s1_end_xfer assignment, which is an e_assign
  assign sd_cmd_s1_end_xfer = ~(sd_cmd_s1_waits_for_read | sd_cmd_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sd_cmd_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sd_cmd_s1 = sd_cmd_s1_end_xfer & (~sd_cmd_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sd_cmd_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sd_cmd_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sd_cmd_s1 & sd_cmd_s1_allgrants) | (end_xfer_arb_share_counter_term_sd_cmd_s1 & ~sd_cmd_s1_non_bursting_master_requests);

  //sd_cmd_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sd_cmd_s1_arb_share_counter <= 0;
      else if (sd_cmd_s1_arb_counter_enable)
          sd_cmd_s1_arb_share_counter <= sd_cmd_s1_arb_share_counter_next_value;
    end


  //sd_cmd_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sd_cmd_s1_slavearbiterlockenable <= 0;
      else if ((|sd_cmd_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sd_cmd_s1) | (end_xfer_arb_share_counter_term_sd_cmd_s1 & ~sd_cmd_s1_non_bursting_master_requests))
          sd_cmd_s1_slavearbiterlockenable <= |sd_cmd_s1_arb_share_counter_next_value;
    end


  //cpu/data_master sd_cmd/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = sd_cmd_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //sd_cmd_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sd_cmd_s1_slavearbiterlockenable2 = |sd_cmd_s1_arb_share_counter_next_value;

  //cpu/data_master sd_cmd/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = sd_cmd_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //sd_cmd_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign sd_cmd_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_sd_cmd_s1 = cpu_data_master_requests_sd_cmd_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_sd_cmd_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_sd_cmd_s1 = cpu_data_master_granted_sd_cmd_s1 & cpu_data_master_read & ~sd_cmd_s1_waits_for_read;

  //sd_cmd_s1_writedata mux, which is an e_mux
  assign sd_cmd_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_sd_cmd_s1 = cpu_data_master_qualified_request_sd_cmd_s1;

  //cpu/data_master saved-grant sd_cmd/s1, which is an e_assign
  assign cpu_data_master_saved_grant_sd_cmd_s1 = cpu_data_master_requests_sd_cmd_s1;

  //allow new arb cycle for sd_cmd/s1, which is an e_assign
  assign sd_cmd_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign sd_cmd_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign sd_cmd_s1_master_qreq_vector = 1;

  //sd_cmd_s1_reset_n assignment, which is an e_assign
  assign sd_cmd_s1_reset_n = reset_n;

  assign sd_cmd_s1_chipselect = cpu_data_master_granted_sd_cmd_s1;
  //sd_cmd_s1_firsttransfer first transaction, which is an e_assign
  assign sd_cmd_s1_firsttransfer = sd_cmd_s1_begins_xfer ? sd_cmd_s1_unreg_firsttransfer : sd_cmd_s1_reg_firsttransfer;

  //sd_cmd_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sd_cmd_s1_unreg_firsttransfer = ~(sd_cmd_s1_slavearbiterlockenable & sd_cmd_s1_any_continuerequest);

  //sd_cmd_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sd_cmd_s1_reg_firsttransfer <= 1'b1;
      else if (sd_cmd_s1_begins_xfer)
          sd_cmd_s1_reg_firsttransfer <= sd_cmd_s1_unreg_firsttransfer;
    end


  //sd_cmd_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sd_cmd_s1_beginbursttransfer_internal = sd_cmd_s1_begins_xfer;

  //~sd_cmd_s1_write_n assignment, which is an e_mux
  assign sd_cmd_s1_write_n = ~(cpu_data_master_granted_sd_cmd_s1 & cpu_data_master_write);

  assign shifted_address_to_sd_cmd_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //sd_cmd_s1_address mux, which is an e_mux
  assign sd_cmd_s1_address = shifted_address_to_sd_cmd_s1_from_cpu_data_master >> 2;

  //d1_sd_cmd_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sd_cmd_s1_end_xfer <= 1;
      else if (1)
          d1_sd_cmd_s1_end_xfer <= sd_cmd_s1_end_xfer;
    end


  //sd_cmd_s1_waits_for_read in a cycle, which is an e_mux
  assign sd_cmd_s1_waits_for_read = sd_cmd_s1_in_a_read_cycle & sd_cmd_s1_begins_xfer;

  //sd_cmd_s1_in_a_read_cycle assignment, which is an e_assign
  assign sd_cmd_s1_in_a_read_cycle = cpu_data_master_granted_sd_cmd_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sd_cmd_s1_in_a_read_cycle;

  //sd_cmd_s1_waits_for_write in a cycle, which is an e_mux
  assign sd_cmd_s1_waits_for_write = sd_cmd_s1_in_a_write_cycle & 0;

  //sd_cmd_s1_in_a_write_cycle assignment, which is an e_assign
  assign sd_cmd_s1_in_a_write_cycle = cpu_data_master_granted_sd_cmd_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sd_cmd_s1_in_a_write_cycle;

  assign wait_for_sd_cmd_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sd_cmd/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sd_dat_s1_arbitrator (
                              // inputs:
                               clk,
                               cpu_data_master_address_to_slave,
                               cpu_data_master_latency_counter,
                               cpu_data_master_read,
                               cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                               cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                               cpu_data_master_write,
                               cpu_data_master_writedata,
                               reset_n,
                               sd_dat_s1_readdata,

                              // outputs:
                               cpu_data_master_granted_sd_dat_s1,
                               cpu_data_master_qualified_request_sd_dat_s1,
                               cpu_data_master_read_data_valid_sd_dat_s1,
                               cpu_data_master_requests_sd_dat_s1,
                               d1_sd_dat_s1_end_xfer,
                               sd_dat_s1_address,
                               sd_dat_s1_chipselect,
                               sd_dat_s1_readdata_from_sa,
                               sd_dat_s1_reset_n,
                               sd_dat_s1_write_n,
                               sd_dat_s1_writedata
                            )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_sd_dat_s1;
  output           cpu_data_master_qualified_request_sd_dat_s1;
  output           cpu_data_master_read_data_valid_sd_dat_s1;
  output           cpu_data_master_requests_sd_dat_s1;
  output           d1_sd_dat_s1_end_xfer;
  output  [  1: 0] sd_dat_s1_address;
  output           sd_dat_s1_chipselect;
  output           sd_dat_s1_readdata_from_sa;
  output           sd_dat_s1_reset_n;
  output           sd_dat_s1_write_n;
  output           sd_dat_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;
  input            sd_dat_s1_readdata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_sd_dat_s1;
  wire             cpu_data_master_qualified_request_sd_dat_s1;
  wire             cpu_data_master_read_data_valid_sd_dat_s1;
  wire             cpu_data_master_requests_sd_dat_s1;
  wire             cpu_data_master_saved_grant_sd_dat_s1;
  reg              d1_reasons_to_wait;
  reg              d1_sd_dat_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sd_dat_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] sd_dat_s1_address;
  wire             sd_dat_s1_allgrants;
  wire             sd_dat_s1_allow_new_arb_cycle;
  wire             sd_dat_s1_any_bursting_master_saved_grant;
  wire             sd_dat_s1_any_continuerequest;
  wire             sd_dat_s1_arb_counter_enable;
  reg     [  1: 0] sd_dat_s1_arb_share_counter;
  wire    [  1: 0] sd_dat_s1_arb_share_counter_next_value;
  wire    [  1: 0] sd_dat_s1_arb_share_set_values;
  wire             sd_dat_s1_beginbursttransfer_internal;
  wire             sd_dat_s1_begins_xfer;
  wire             sd_dat_s1_chipselect;
  wire             sd_dat_s1_end_xfer;
  wire             sd_dat_s1_firsttransfer;
  wire             sd_dat_s1_grant_vector;
  wire             sd_dat_s1_in_a_read_cycle;
  wire             sd_dat_s1_in_a_write_cycle;
  wire             sd_dat_s1_master_qreq_vector;
  wire             sd_dat_s1_non_bursting_master_requests;
  wire             sd_dat_s1_readdata_from_sa;
  reg              sd_dat_s1_reg_firsttransfer;
  wire             sd_dat_s1_reset_n;
  reg              sd_dat_s1_slavearbiterlockenable;
  wire             sd_dat_s1_slavearbiterlockenable2;
  wire             sd_dat_s1_unreg_firsttransfer;
  wire             sd_dat_s1_waits_for_read;
  wire             sd_dat_s1_waits_for_write;
  wire             sd_dat_s1_write_n;
  wire             sd_dat_s1_writedata;
  wire    [ 27: 0] shifted_address_to_sd_dat_s1_from_cpu_data_master;
  wire             wait_for_sd_dat_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~sd_dat_s1_end_xfer;
    end


  assign sd_dat_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_sd_dat_s1));
  //assign sd_dat_s1_readdata_from_sa = sd_dat_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sd_dat_s1_readdata_from_sa = sd_dat_s1_readdata;

  assign cpu_data_master_requests_sd_dat_s1 = ({cpu_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h96411b0) & (cpu_data_master_read | cpu_data_master_write);
  //sd_dat_s1_arb_share_counter set values, which is an e_mux
  assign sd_dat_s1_arb_share_set_values = 1;

  //sd_dat_s1_non_bursting_master_requests mux, which is an e_mux
  assign sd_dat_s1_non_bursting_master_requests = cpu_data_master_requests_sd_dat_s1;

  //sd_dat_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sd_dat_s1_any_bursting_master_saved_grant = 0;

  //sd_dat_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sd_dat_s1_arb_share_counter_next_value = sd_dat_s1_firsttransfer ? (sd_dat_s1_arb_share_set_values - 1) : |sd_dat_s1_arb_share_counter ? (sd_dat_s1_arb_share_counter - 1) : 0;

  //sd_dat_s1_allgrants all slave grants, which is an e_mux
  assign sd_dat_s1_allgrants = |sd_dat_s1_grant_vector;

  //sd_dat_s1_end_xfer assignment, which is an e_assign
  assign sd_dat_s1_end_xfer = ~(sd_dat_s1_waits_for_read | sd_dat_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sd_dat_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sd_dat_s1 = sd_dat_s1_end_xfer & (~sd_dat_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sd_dat_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sd_dat_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sd_dat_s1 & sd_dat_s1_allgrants) | (end_xfer_arb_share_counter_term_sd_dat_s1 & ~sd_dat_s1_non_bursting_master_requests);

  //sd_dat_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sd_dat_s1_arb_share_counter <= 0;
      else if (sd_dat_s1_arb_counter_enable)
          sd_dat_s1_arb_share_counter <= sd_dat_s1_arb_share_counter_next_value;
    end


  //sd_dat_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sd_dat_s1_slavearbiterlockenable <= 0;
      else if ((|sd_dat_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sd_dat_s1) | (end_xfer_arb_share_counter_term_sd_dat_s1 & ~sd_dat_s1_non_bursting_master_requests))
          sd_dat_s1_slavearbiterlockenable <= |sd_dat_s1_arb_share_counter_next_value;
    end


  //cpu/data_master sd_dat/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = sd_dat_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //sd_dat_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sd_dat_s1_slavearbiterlockenable2 = |sd_dat_s1_arb_share_counter_next_value;

  //cpu/data_master sd_dat/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = sd_dat_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //sd_dat_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign sd_dat_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_sd_dat_s1 = cpu_data_master_requests_sd_dat_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_sd_dat_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_sd_dat_s1 = cpu_data_master_granted_sd_dat_s1 & cpu_data_master_read & ~sd_dat_s1_waits_for_read;

  //sd_dat_s1_writedata mux, which is an e_mux
  assign sd_dat_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_sd_dat_s1 = cpu_data_master_qualified_request_sd_dat_s1;

  //cpu/data_master saved-grant sd_dat/s1, which is an e_assign
  assign cpu_data_master_saved_grant_sd_dat_s1 = cpu_data_master_requests_sd_dat_s1;

  //allow new arb cycle for sd_dat/s1, which is an e_assign
  assign sd_dat_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign sd_dat_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign sd_dat_s1_master_qreq_vector = 1;

  //sd_dat_s1_reset_n assignment, which is an e_assign
  assign sd_dat_s1_reset_n = reset_n;

  assign sd_dat_s1_chipselect = cpu_data_master_granted_sd_dat_s1;
  //sd_dat_s1_firsttransfer first transaction, which is an e_assign
  assign sd_dat_s1_firsttransfer = sd_dat_s1_begins_xfer ? sd_dat_s1_unreg_firsttransfer : sd_dat_s1_reg_firsttransfer;

  //sd_dat_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sd_dat_s1_unreg_firsttransfer = ~(sd_dat_s1_slavearbiterlockenable & sd_dat_s1_any_continuerequest);

  //sd_dat_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sd_dat_s1_reg_firsttransfer <= 1'b1;
      else if (sd_dat_s1_begins_xfer)
          sd_dat_s1_reg_firsttransfer <= sd_dat_s1_unreg_firsttransfer;
    end


  //sd_dat_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sd_dat_s1_beginbursttransfer_internal = sd_dat_s1_begins_xfer;

  //~sd_dat_s1_write_n assignment, which is an e_mux
  assign sd_dat_s1_write_n = ~(cpu_data_master_granted_sd_dat_s1 & cpu_data_master_write);

  assign shifted_address_to_sd_dat_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //sd_dat_s1_address mux, which is an e_mux
  assign sd_dat_s1_address = shifted_address_to_sd_dat_s1_from_cpu_data_master >> 2;

  //d1_sd_dat_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sd_dat_s1_end_xfer <= 1;
      else if (1)
          d1_sd_dat_s1_end_xfer <= sd_dat_s1_end_xfer;
    end


  //sd_dat_s1_waits_for_read in a cycle, which is an e_mux
  assign sd_dat_s1_waits_for_read = sd_dat_s1_in_a_read_cycle & sd_dat_s1_begins_xfer;

  //sd_dat_s1_in_a_read_cycle assignment, which is an e_assign
  assign sd_dat_s1_in_a_read_cycle = cpu_data_master_granted_sd_dat_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sd_dat_s1_in_a_read_cycle;

  //sd_dat_s1_waits_for_write in a cycle, which is an e_mux
  assign sd_dat_s1_waits_for_write = sd_dat_s1_in_a_write_cycle & 0;

  //sd_dat_s1_in_a_write_cycle assignment, which is an e_assign
  assign sd_dat_s1_in_a_write_cycle = cpu_data_master_granted_sd_dat_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sd_dat_s1_in_a_write_cycle;

  assign wait_for_sd_dat_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sd_dat/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sd_dat3_s1_arbitrator (
                               // inputs:
                                clk,
                                cpu_data_master_address_to_slave,
                                cpu_data_master_latency_counter,
                                cpu_data_master_read,
                                cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                cpu_data_master_write,
                                cpu_data_master_writedata,
                                reset_n,
                                sd_dat3_s1_readdata,

                               // outputs:
                                cpu_data_master_granted_sd_dat3_s1,
                                cpu_data_master_qualified_request_sd_dat3_s1,
                                cpu_data_master_read_data_valid_sd_dat3_s1,
                                cpu_data_master_requests_sd_dat3_s1,
                                d1_sd_dat3_s1_end_xfer,
                                sd_dat3_s1_address,
                                sd_dat3_s1_chipselect,
                                sd_dat3_s1_readdata_from_sa,
                                sd_dat3_s1_reset_n,
                                sd_dat3_s1_write_n,
                                sd_dat3_s1_writedata
                             )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_sd_dat3_s1;
  output           cpu_data_master_qualified_request_sd_dat3_s1;
  output           cpu_data_master_read_data_valid_sd_dat3_s1;
  output           cpu_data_master_requests_sd_dat3_s1;
  output           d1_sd_dat3_s1_end_xfer;
  output  [  1: 0] sd_dat3_s1_address;
  output           sd_dat3_s1_chipselect;
  output           sd_dat3_s1_readdata_from_sa;
  output           sd_dat3_s1_reset_n;
  output           sd_dat3_s1_write_n;
  output           sd_dat3_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;
  input            sd_dat3_s1_readdata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_sd_dat3_s1;
  wire             cpu_data_master_qualified_request_sd_dat3_s1;
  wire             cpu_data_master_read_data_valid_sd_dat3_s1;
  wire             cpu_data_master_requests_sd_dat3_s1;
  wire             cpu_data_master_saved_grant_sd_dat3_s1;
  reg              d1_reasons_to_wait;
  reg              d1_sd_dat3_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sd_dat3_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] sd_dat3_s1_address;
  wire             sd_dat3_s1_allgrants;
  wire             sd_dat3_s1_allow_new_arb_cycle;
  wire             sd_dat3_s1_any_bursting_master_saved_grant;
  wire             sd_dat3_s1_any_continuerequest;
  wire             sd_dat3_s1_arb_counter_enable;
  reg     [  1: 0] sd_dat3_s1_arb_share_counter;
  wire    [  1: 0] sd_dat3_s1_arb_share_counter_next_value;
  wire    [  1: 0] sd_dat3_s1_arb_share_set_values;
  wire             sd_dat3_s1_beginbursttransfer_internal;
  wire             sd_dat3_s1_begins_xfer;
  wire             sd_dat3_s1_chipselect;
  wire             sd_dat3_s1_end_xfer;
  wire             sd_dat3_s1_firsttransfer;
  wire             sd_dat3_s1_grant_vector;
  wire             sd_dat3_s1_in_a_read_cycle;
  wire             sd_dat3_s1_in_a_write_cycle;
  wire             sd_dat3_s1_master_qreq_vector;
  wire             sd_dat3_s1_non_bursting_master_requests;
  wire             sd_dat3_s1_readdata_from_sa;
  reg              sd_dat3_s1_reg_firsttransfer;
  wire             sd_dat3_s1_reset_n;
  reg              sd_dat3_s1_slavearbiterlockenable;
  wire             sd_dat3_s1_slavearbiterlockenable2;
  wire             sd_dat3_s1_unreg_firsttransfer;
  wire             sd_dat3_s1_waits_for_read;
  wire             sd_dat3_s1_waits_for_write;
  wire             sd_dat3_s1_write_n;
  wire             sd_dat3_s1_writedata;
  wire    [ 27: 0] shifted_address_to_sd_dat3_s1_from_cpu_data_master;
  wire             wait_for_sd_dat3_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~sd_dat3_s1_end_xfer;
    end


  assign sd_dat3_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_sd_dat3_s1));
  //assign sd_dat3_s1_readdata_from_sa = sd_dat3_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sd_dat3_s1_readdata_from_sa = sd_dat3_s1_readdata;

  assign cpu_data_master_requests_sd_dat3_s1 = ({cpu_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h96411c0) & (cpu_data_master_read | cpu_data_master_write);
  //sd_dat3_s1_arb_share_counter set values, which is an e_mux
  assign sd_dat3_s1_arb_share_set_values = 1;

  //sd_dat3_s1_non_bursting_master_requests mux, which is an e_mux
  assign sd_dat3_s1_non_bursting_master_requests = cpu_data_master_requests_sd_dat3_s1;

  //sd_dat3_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sd_dat3_s1_any_bursting_master_saved_grant = 0;

  //sd_dat3_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sd_dat3_s1_arb_share_counter_next_value = sd_dat3_s1_firsttransfer ? (sd_dat3_s1_arb_share_set_values - 1) : |sd_dat3_s1_arb_share_counter ? (sd_dat3_s1_arb_share_counter - 1) : 0;

  //sd_dat3_s1_allgrants all slave grants, which is an e_mux
  assign sd_dat3_s1_allgrants = |sd_dat3_s1_grant_vector;

  //sd_dat3_s1_end_xfer assignment, which is an e_assign
  assign sd_dat3_s1_end_xfer = ~(sd_dat3_s1_waits_for_read | sd_dat3_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sd_dat3_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sd_dat3_s1 = sd_dat3_s1_end_xfer & (~sd_dat3_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sd_dat3_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sd_dat3_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sd_dat3_s1 & sd_dat3_s1_allgrants) | (end_xfer_arb_share_counter_term_sd_dat3_s1 & ~sd_dat3_s1_non_bursting_master_requests);

  //sd_dat3_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sd_dat3_s1_arb_share_counter <= 0;
      else if (sd_dat3_s1_arb_counter_enable)
          sd_dat3_s1_arb_share_counter <= sd_dat3_s1_arb_share_counter_next_value;
    end


  //sd_dat3_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sd_dat3_s1_slavearbiterlockenable <= 0;
      else if ((|sd_dat3_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sd_dat3_s1) | (end_xfer_arb_share_counter_term_sd_dat3_s1 & ~sd_dat3_s1_non_bursting_master_requests))
          sd_dat3_s1_slavearbiterlockenable <= |sd_dat3_s1_arb_share_counter_next_value;
    end


  //cpu/data_master sd_dat3/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = sd_dat3_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //sd_dat3_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sd_dat3_s1_slavearbiterlockenable2 = |sd_dat3_s1_arb_share_counter_next_value;

  //cpu/data_master sd_dat3/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = sd_dat3_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //sd_dat3_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign sd_dat3_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_sd_dat3_s1 = cpu_data_master_requests_sd_dat3_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_sd_dat3_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_sd_dat3_s1 = cpu_data_master_granted_sd_dat3_s1 & cpu_data_master_read & ~sd_dat3_s1_waits_for_read;

  //sd_dat3_s1_writedata mux, which is an e_mux
  assign sd_dat3_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_sd_dat3_s1 = cpu_data_master_qualified_request_sd_dat3_s1;

  //cpu/data_master saved-grant sd_dat3/s1, which is an e_assign
  assign cpu_data_master_saved_grant_sd_dat3_s1 = cpu_data_master_requests_sd_dat3_s1;

  //allow new arb cycle for sd_dat3/s1, which is an e_assign
  assign sd_dat3_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign sd_dat3_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign sd_dat3_s1_master_qreq_vector = 1;

  //sd_dat3_s1_reset_n assignment, which is an e_assign
  assign sd_dat3_s1_reset_n = reset_n;

  assign sd_dat3_s1_chipselect = cpu_data_master_granted_sd_dat3_s1;
  //sd_dat3_s1_firsttransfer first transaction, which is an e_assign
  assign sd_dat3_s1_firsttransfer = sd_dat3_s1_begins_xfer ? sd_dat3_s1_unreg_firsttransfer : sd_dat3_s1_reg_firsttransfer;

  //sd_dat3_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sd_dat3_s1_unreg_firsttransfer = ~(sd_dat3_s1_slavearbiterlockenable & sd_dat3_s1_any_continuerequest);

  //sd_dat3_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sd_dat3_s1_reg_firsttransfer <= 1'b1;
      else if (sd_dat3_s1_begins_xfer)
          sd_dat3_s1_reg_firsttransfer <= sd_dat3_s1_unreg_firsttransfer;
    end


  //sd_dat3_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sd_dat3_s1_beginbursttransfer_internal = sd_dat3_s1_begins_xfer;

  //~sd_dat3_s1_write_n assignment, which is an e_mux
  assign sd_dat3_s1_write_n = ~(cpu_data_master_granted_sd_dat3_s1 & cpu_data_master_write);

  assign shifted_address_to_sd_dat3_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //sd_dat3_s1_address mux, which is an e_mux
  assign sd_dat3_s1_address = shifted_address_to_sd_dat3_s1_from_cpu_data_master >> 2;

  //d1_sd_dat3_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sd_dat3_s1_end_xfer <= 1;
      else if (1)
          d1_sd_dat3_s1_end_xfer <= sd_dat3_s1_end_xfer;
    end


  //sd_dat3_s1_waits_for_read in a cycle, which is an e_mux
  assign sd_dat3_s1_waits_for_read = sd_dat3_s1_in_a_read_cycle & sd_dat3_s1_begins_xfer;

  //sd_dat3_s1_in_a_read_cycle assignment, which is an e_assign
  assign sd_dat3_s1_in_a_read_cycle = cpu_data_master_granted_sd_dat3_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sd_dat3_s1_in_a_read_cycle;

  //sd_dat3_s1_waits_for_write in a cycle, which is an e_mux
  assign sd_dat3_s1_waits_for_write = sd_dat3_s1_in_a_write_cycle & 0;

  //sd_dat3_s1_in_a_write_cycle assignment, which is an e_assign
  assign sd_dat3_s1_in_a_write_cycle = cpu_data_master_granted_sd_dat3_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sd_dat3_s1_in_a_write_cycle;

  assign wait_for_sd_dat3_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sd_dat3/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_data_master_to_sdram_u1_s1_module (
                                                            // inputs:
                                                             clear_fifo,
                                                             clk,
                                                             data_in,
                                                             read,
                                                             reset_n,
                                                             sync_reset,
                                                             write,

                                                            // outputs:
                                                             data_out,
                                                             empty,
                                                             fifo_contains_ones_n,
                                                             full
                                                          )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_instruction_master_to_sdram_u1_s1_module (
                                                                   // inputs:
                                                                    clear_fifo,
                                                                    clk,
                                                                    data_in,
                                                                    read,
                                                                    reset_n,
                                                                    sync_reset,
                                                                    write,

                                                                   // outputs:
                                                                    data_out,
                                                                    empty,
                                                                    fifo_contains_ones_n,
                                                                    full
                                                                 )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sdram_u1_s1_arbitrator (
                                // inputs:
                                 clk,
                                 cpu_data_master_address_to_slave,
                                 cpu_data_master_byteenable,
                                 cpu_data_master_dbs_address,
                                 cpu_data_master_dbs_write_16,
                                 cpu_data_master_latency_counter,
                                 cpu_data_master_read,
                                 cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                 cpu_data_master_write,
                                 cpu_instruction_master_address_to_slave,
                                 cpu_instruction_master_dbs_address,
                                 cpu_instruction_master_latency_counter,
                                 cpu_instruction_master_read,
                                 cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register,
                                 reset_n,
                                 sdram_u1_s1_readdata,
                                 sdram_u1_s1_readdatavalid,
                                 sdram_u1_s1_waitrequest,

                                // outputs:
                                 cpu_data_master_byteenable_sdram_u1_s1,
                                 cpu_data_master_granted_sdram_u1_s1,
                                 cpu_data_master_qualified_request_sdram_u1_s1,
                                 cpu_data_master_read_data_valid_sdram_u1_s1,
                                 cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                 cpu_data_master_requests_sdram_u1_s1,
                                 cpu_instruction_master_granted_sdram_u1_s1,
                                 cpu_instruction_master_qualified_request_sdram_u1_s1,
                                 cpu_instruction_master_read_data_valid_sdram_u1_s1,
                                 cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register,
                                 cpu_instruction_master_requests_sdram_u1_s1,
                                 d1_sdram_u1_s1_end_xfer,
                                 sdram_u1_s1_address,
                                 sdram_u1_s1_byteenable_n,
                                 sdram_u1_s1_chipselect,
                                 sdram_u1_s1_read_n,
                                 sdram_u1_s1_readdata_from_sa,
                                 sdram_u1_s1_reset_n,
                                 sdram_u1_s1_waitrequest_from_sa,
                                 sdram_u1_s1_write_n,
                                 sdram_u1_s1_writedata
                              )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output  [  1: 0] cpu_data_master_byteenable_sdram_u1_s1;
  output           cpu_data_master_granted_sdram_u1_s1;
  output           cpu_data_master_qualified_request_sdram_u1_s1;
  output           cpu_data_master_read_data_valid_sdram_u1_s1;
  output           cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  output           cpu_data_master_requests_sdram_u1_s1;
  output           cpu_instruction_master_granted_sdram_u1_s1;
  output           cpu_instruction_master_qualified_request_sdram_u1_s1;
  output           cpu_instruction_master_read_data_valid_sdram_u1_s1;
  output           cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register;
  output           cpu_instruction_master_requests_sdram_u1_s1;
  output           d1_sdram_u1_s1_end_xfer;
  output  [ 23: 0] sdram_u1_s1_address;
  output  [  1: 0] sdram_u1_s1_byteenable_n;
  output           sdram_u1_s1_chipselect;
  output           sdram_u1_s1_read_n;
  output  [ 15: 0] sdram_u1_s1_readdata_from_sa;
  output           sdram_u1_s1_reset_n;
  output           sdram_u1_s1_waitrequest_from_sa;
  output           sdram_u1_s1_write_n;
  output  [ 15: 0] sdram_u1_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input   [  1: 0] cpu_data_master_dbs_address;
  input   [ 15: 0] cpu_data_master_dbs_write_16;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 27: 0] cpu_instruction_master_address_to_slave;
  input   [  1: 0] cpu_instruction_master_dbs_address;
  input   [  2: 0] cpu_instruction_master_latency_counter;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register;
  input            reset_n;
  input   [ 15: 0] sdram_u1_s1_readdata;
  input            sdram_u1_s1_readdatavalid;
  input            sdram_u1_s1_waitrequest;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_u1_s1;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_u1_s1_segment_0;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_u1_s1_segment_1;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_sdram_u1_s1;
  wire             cpu_data_master_qualified_request_sdram_u1_s1;
  wire             cpu_data_master_rdv_fifo_empty_sdram_u1_s1;
  wire             cpu_data_master_rdv_fifo_output_from_sdram_u1_s1;
  wire             cpu_data_master_read_data_valid_sdram_u1_s1;
  wire             cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  wire             cpu_data_master_requests_sdram_u1_s1;
  wire             cpu_data_master_saved_grant_sdram_u1_s1;
  wire             cpu_instruction_master_arbiterlock;
  wire             cpu_instruction_master_arbiterlock2;
  wire             cpu_instruction_master_continuerequest;
  wire             cpu_instruction_master_granted_sdram_u1_s1;
  wire             cpu_instruction_master_qualified_request_sdram_u1_s1;
  wire             cpu_instruction_master_rdv_fifo_empty_sdram_u1_s1;
  wire             cpu_instruction_master_rdv_fifo_output_from_sdram_u1_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_u1_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register;
  wire             cpu_instruction_master_requests_sdram_u1_s1;
  wire             cpu_instruction_master_saved_grant_sdram_u1_s1;
  reg              d1_reasons_to_wait;
  reg              d1_sdram_u1_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sdram_u1_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_data_master_granted_slave_sdram_u1_s1;
  reg              last_cycle_cpu_instruction_master_granted_slave_sdram_u1_s1;
  wire    [ 23: 0] sdram_u1_s1_address;
  wire             sdram_u1_s1_allgrants;
  wire             sdram_u1_s1_allow_new_arb_cycle;
  wire             sdram_u1_s1_any_bursting_master_saved_grant;
  wire             sdram_u1_s1_any_continuerequest;
  reg     [  1: 0] sdram_u1_s1_arb_addend;
  wire             sdram_u1_s1_arb_counter_enable;
  reg     [  1: 0] sdram_u1_s1_arb_share_counter;
  wire    [  1: 0] sdram_u1_s1_arb_share_counter_next_value;
  wire    [  1: 0] sdram_u1_s1_arb_share_set_values;
  wire    [  1: 0] sdram_u1_s1_arb_winner;
  wire             sdram_u1_s1_arbitration_holdoff_internal;
  wire             sdram_u1_s1_beginbursttransfer_internal;
  wire             sdram_u1_s1_begins_xfer;
  wire    [  1: 0] sdram_u1_s1_byteenable_n;
  wire             sdram_u1_s1_chipselect;
  wire    [  3: 0] sdram_u1_s1_chosen_master_double_vector;
  wire    [  1: 0] sdram_u1_s1_chosen_master_rot_left;
  wire             sdram_u1_s1_end_xfer;
  wire             sdram_u1_s1_firsttransfer;
  wire    [  1: 0] sdram_u1_s1_grant_vector;
  wire             sdram_u1_s1_in_a_read_cycle;
  wire             sdram_u1_s1_in_a_write_cycle;
  wire    [  1: 0] sdram_u1_s1_master_qreq_vector;
  wire             sdram_u1_s1_move_on_to_next_transaction;
  wire             sdram_u1_s1_non_bursting_master_requests;
  wire             sdram_u1_s1_read_n;
  wire    [ 15: 0] sdram_u1_s1_readdata_from_sa;
  wire             sdram_u1_s1_readdatavalid_from_sa;
  reg              sdram_u1_s1_reg_firsttransfer;
  wire             sdram_u1_s1_reset_n;
  reg     [  1: 0] sdram_u1_s1_saved_chosen_master_vector;
  reg              sdram_u1_s1_slavearbiterlockenable;
  wire             sdram_u1_s1_slavearbiterlockenable2;
  wire             sdram_u1_s1_unreg_firsttransfer;
  wire             sdram_u1_s1_waitrequest_from_sa;
  wire             sdram_u1_s1_waits_for_read;
  wire             sdram_u1_s1_waits_for_write;
  wire             sdram_u1_s1_write_n;
  wire    [ 15: 0] sdram_u1_s1_writedata;
  wire    [ 27: 0] shifted_address_to_sdram_u1_s1_from_cpu_data_master;
  wire    [ 27: 0] shifted_address_to_sdram_u1_s1_from_cpu_instruction_master;
  wire             wait_for_sdram_u1_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~sdram_u1_s1_end_xfer;
    end


  assign sdram_u1_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_sdram_u1_s1 | cpu_instruction_master_qualified_request_sdram_u1_s1));
  //assign sdram_u1_s1_readdatavalid_from_sa = sdram_u1_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_u1_s1_readdatavalid_from_sa = sdram_u1_s1_readdatavalid;

  //assign sdram_u1_s1_readdata_from_sa = sdram_u1_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_u1_s1_readdata_from_sa = sdram_u1_s1_readdata;

  assign cpu_data_master_requests_sdram_u1_s1 = ({cpu_data_master_address_to_slave[27 : 25] , 25'b0} == 28'h4000000) & (cpu_data_master_read | cpu_data_master_write);
  //assign sdram_u1_s1_waitrequest_from_sa = sdram_u1_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_u1_s1_waitrequest_from_sa = sdram_u1_s1_waitrequest;

  //sdram_u1_s1_arb_share_counter set values, which is an e_mux
  assign sdram_u1_s1_arb_share_set_values = (cpu_data_master_granted_sdram_u1_s1)? 2 :
    (cpu_instruction_master_granted_sdram_u1_s1)? 2 :
    (cpu_data_master_granted_sdram_u1_s1)? 2 :
    (cpu_instruction_master_granted_sdram_u1_s1)? 2 :
    1;

  //sdram_u1_s1_non_bursting_master_requests mux, which is an e_mux
  assign sdram_u1_s1_non_bursting_master_requests = cpu_data_master_requests_sdram_u1_s1 |
    cpu_instruction_master_requests_sdram_u1_s1 |
    cpu_data_master_requests_sdram_u1_s1 |
    cpu_instruction_master_requests_sdram_u1_s1;

  //sdram_u1_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sdram_u1_s1_any_bursting_master_saved_grant = 0;

  //sdram_u1_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sdram_u1_s1_arb_share_counter_next_value = sdram_u1_s1_firsttransfer ? (sdram_u1_s1_arb_share_set_values - 1) : |sdram_u1_s1_arb_share_counter ? (sdram_u1_s1_arb_share_counter - 1) : 0;

  //sdram_u1_s1_allgrants all slave grants, which is an e_mux
  assign sdram_u1_s1_allgrants = |sdram_u1_s1_grant_vector |
    |sdram_u1_s1_grant_vector |
    |sdram_u1_s1_grant_vector |
    |sdram_u1_s1_grant_vector;

  //sdram_u1_s1_end_xfer assignment, which is an e_assign
  assign sdram_u1_s1_end_xfer = ~(sdram_u1_s1_waits_for_read | sdram_u1_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sdram_u1_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sdram_u1_s1 = sdram_u1_s1_end_xfer & (~sdram_u1_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sdram_u1_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sdram_u1_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sdram_u1_s1 & sdram_u1_s1_allgrants) | (end_xfer_arb_share_counter_term_sdram_u1_s1 & ~sdram_u1_s1_non_bursting_master_requests);

  //sdram_u1_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u1_s1_arb_share_counter <= 0;
      else if (sdram_u1_s1_arb_counter_enable)
          sdram_u1_s1_arb_share_counter <= sdram_u1_s1_arb_share_counter_next_value;
    end


  //sdram_u1_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u1_s1_slavearbiterlockenable <= 0;
      else if ((|sdram_u1_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sdram_u1_s1) | (end_xfer_arb_share_counter_term_sdram_u1_s1 & ~sdram_u1_s1_non_bursting_master_requests))
          sdram_u1_s1_slavearbiterlockenable <= |sdram_u1_s1_arb_share_counter_next_value;
    end


  //cpu/data_master sdram_u1/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = sdram_u1_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //sdram_u1_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sdram_u1_s1_slavearbiterlockenable2 = |sdram_u1_s1_arb_share_counter_next_value;

  //cpu/data_master sdram_u1/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = sdram_u1_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //cpu/instruction_master sdram_u1/s1 arbiterlock, which is an e_assign
  assign cpu_instruction_master_arbiterlock = sdram_u1_s1_slavearbiterlockenable & cpu_instruction_master_continuerequest;

  //cpu/instruction_master sdram_u1/s1 arbiterlock2, which is an e_assign
  assign cpu_instruction_master_arbiterlock2 = sdram_u1_s1_slavearbiterlockenable2 & cpu_instruction_master_continuerequest;

  //cpu/instruction_master granted sdram_u1/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_instruction_master_granted_slave_sdram_u1_s1 <= 0;
      else if (1)
          last_cycle_cpu_instruction_master_granted_slave_sdram_u1_s1 <= cpu_instruction_master_saved_grant_sdram_u1_s1 ? 1 : (sdram_u1_s1_arbitration_holdoff_internal | ~cpu_instruction_master_requests_sdram_u1_s1) ? 0 : last_cycle_cpu_instruction_master_granted_slave_sdram_u1_s1;
    end


  //cpu_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_instruction_master_continuerequest = last_cycle_cpu_instruction_master_granted_slave_sdram_u1_s1 & cpu_instruction_master_requests_sdram_u1_s1;

  //sdram_u1_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign sdram_u1_s1_any_continuerequest = cpu_instruction_master_continuerequest |
    cpu_data_master_continuerequest;

  assign cpu_data_master_qualified_request_sdram_u1_s1 = cpu_data_master_requests_sdram_u1_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (1 < cpu_data_master_latency_counter) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))) | ((!cpu_data_master_byteenable_sdram_u1_s1) & cpu_data_master_write) | cpu_instruction_master_arbiterlock);
  //unique name for sdram_u1_s1_move_on_to_next_transaction, which is an e_assign
  assign sdram_u1_s1_move_on_to_next_transaction = sdram_u1_s1_readdatavalid_from_sa;

  //rdv_fifo_for_cpu_data_master_to_sdram_u1_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_data_master_to_sdram_u1_s1_module rdv_fifo_for_cpu_data_master_to_sdram_u1_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_data_master_granted_sdram_u1_s1),
      .data_out             (cpu_data_master_rdv_fifo_output_from_sdram_u1_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_data_master_rdv_fifo_empty_sdram_u1_s1),
      .full                 (),
      .read                 (sdram_u1_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_u1_s1_waits_for_read)
    );

  assign cpu_data_master_read_data_valid_sdram_u1_s1_shift_register = ~cpu_data_master_rdv_fifo_empty_sdram_u1_s1;
  //local readdatavalid cpu_data_master_read_data_valid_sdram_u1_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_sdram_u1_s1 = (sdram_u1_s1_readdatavalid_from_sa & cpu_data_master_rdv_fifo_output_from_sdram_u1_s1) & ~ cpu_data_master_rdv_fifo_empty_sdram_u1_s1;

  //sdram_u1_s1_writedata mux, which is an e_mux
  assign sdram_u1_s1_writedata = cpu_data_master_dbs_write_16;

  assign cpu_instruction_master_requests_sdram_u1_s1 = (({cpu_instruction_master_address_to_slave[27 : 25] , 25'b0} == 28'h4000000) & (cpu_instruction_master_read)) & cpu_instruction_master_read;
  //cpu/data_master granted sdram_u1/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_data_master_granted_slave_sdram_u1_s1 <= 0;
      else if (1)
          last_cycle_cpu_data_master_granted_slave_sdram_u1_s1 <= cpu_data_master_saved_grant_sdram_u1_s1 ? 1 : (sdram_u1_s1_arbitration_holdoff_internal | ~cpu_data_master_requests_sdram_u1_s1) ? 0 : last_cycle_cpu_data_master_granted_slave_sdram_u1_s1;
    end


  //cpu_data_master_continuerequest continued request, which is an e_mux
  assign cpu_data_master_continuerequest = last_cycle_cpu_data_master_granted_slave_sdram_u1_s1 & cpu_data_master_requests_sdram_u1_s1;

  assign cpu_instruction_master_qualified_request_sdram_u1_s1 = cpu_instruction_master_requests_sdram_u1_s1 & ~((cpu_instruction_master_read & ((cpu_instruction_master_latency_counter != 0) | (1 < cpu_instruction_master_latency_counter) | (|cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register))) | cpu_data_master_arbiterlock);
  //rdv_fifo_for_cpu_instruction_master_to_sdram_u1_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_instruction_master_to_sdram_u1_s1_module rdv_fifo_for_cpu_instruction_master_to_sdram_u1_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_instruction_master_granted_sdram_u1_s1),
      .data_out             (cpu_instruction_master_rdv_fifo_output_from_sdram_u1_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_instruction_master_rdv_fifo_empty_sdram_u1_s1),
      .full                 (),
      .read                 (sdram_u1_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_u1_s1_waits_for_read)
    );

  assign cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register = ~cpu_instruction_master_rdv_fifo_empty_sdram_u1_s1;
  //local readdatavalid cpu_instruction_master_read_data_valid_sdram_u1_s1, which is an e_mux
  assign cpu_instruction_master_read_data_valid_sdram_u1_s1 = (sdram_u1_s1_readdatavalid_from_sa & cpu_instruction_master_rdv_fifo_output_from_sdram_u1_s1) & ~ cpu_instruction_master_rdv_fifo_empty_sdram_u1_s1;

  //allow new arb cycle for sdram_u1/s1, which is an e_assign
  assign sdram_u1_s1_allow_new_arb_cycle = ~cpu_data_master_arbiterlock & ~cpu_instruction_master_arbiterlock;

  //cpu/instruction_master assignment into master qualified-requests vector for sdram_u1/s1, which is an e_assign
  assign sdram_u1_s1_master_qreq_vector[0] = cpu_instruction_master_qualified_request_sdram_u1_s1;

  //cpu/instruction_master grant sdram_u1/s1, which is an e_assign
  assign cpu_instruction_master_granted_sdram_u1_s1 = sdram_u1_s1_grant_vector[0];

  //cpu/instruction_master saved-grant sdram_u1/s1, which is an e_assign
  assign cpu_instruction_master_saved_grant_sdram_u1_s1 = sdram_u1_s1_arb_winner[0] && cpu_instruction_master_requests_sdram_u1_s1;

  //cpu/data_master assignment into master qualified-requests vector for sdram_u1/s1, which is an e_assign
  assign sdram_u1_s1_master_qreq_vector[1] = cpu_data_master_qualified_request_sdram_u1_s1;

  //cpu/data_master grant sdram_u1/s1, which is an e_assign
  assign cpu_data_master_granted_sdram_u1_s1 = sdram_u1_s1_grant_vector[1];

  //cpu/data_master saved-grant sdram_u1/s1, which is an e_assign
  assign cpu_data_master_saved_grant_sdram_u1_s1 = sdram_u1_s1_arb_winner[1] && cpu_data_master_requests_sdram_u1_s1;

  //sdram_u1/s1 chosen-master double-vector, which is an e_assign
  assign sdram_u1_s1_chosen_master_double_vector = {sdram_u1_s1_master_qreq_vector, sdram_u1_s1_master_qreq_vector} & ({~sdram_u1_s1_master_qreq_vector, ~sdram_u1_s1_master_qreq_vector} + sdram_u1_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign sdram_u1_s1_arb_winner = (sdram_u1_s1_allow_new_arb_cycle & | sdram_u1_s1_grant_vector) ? sdram_u1_s1_grant_vector : sdram_u1_s1_saved_chosen_master_vector;

  //saved sdram_u1_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u1_s1_saved_chosen_master_vector <= 0;
      else if (sdram_u1_s1_allow_new_arb_cycle)
          sdram_u1_s1_saved_chosen_master_vector <= |sdram_u1_s1_grant_vector ? sdram_u1_s1_grant_vector : sdram_u1_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign sdram_u1_s1_grant_vector = {(sdram_u1_s1_chosen_master_double_vector[1] | sdram_u1_s1_chosen_master_double_vector[3]),
    (sdram_u1_s1_chosen_master_double_vector[0] | sdram_u1_s1_chosen_master_double_vector[2])};

  //sdram_u1/s1 chosen master rotated left, which is an e_assign
  assign sdram_u1_s1_chosen_master_rot_left = (sdram_u1_s1_arb_winner << 1) ? (sdram_u1_s1_arb_winner << 1) : 1;

  //sdram_u1/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u1_s1_arb_addend <= 1;
      else if (|sdram_u1_s1_grant_vector)
          sdram_u1_s1_arb_addend <= sdram_u1_s1_end_xfer? sdram_u1_s1_chosen_master_rot_left : sdram_u1_s1_grant_vector;
    end


  //sdram_u1_s1_reset_n assignment, which is an e_assign
  assign sdram_u1_s1_reset_n = reset_n;

  assign sdram_u1_s1_chipselect = cpu_data_master_granted_sdram_u1_s1 | cpu_instruction_master_granted_sdram_u1_s1;
  //sdram_u1_s1_firsttransfer first transaction, which is an e_assign
  assign sdram_u1_s1_firsttransfer = sdram_u1_s1_begins_xfer ? sdram_u1_s1_unreg_firsttransfer : sdram_u1_s1_reg_firsttransfer;

  //sdram_u1_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sdram_u1_s1_unreg_firsttransfer = ~(sdram_u1_s1_slavearbiterlockenable & sdram_u1_s1_any_continuerequest);

  //sdram_u1_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u1_s1_reg_firsttransfer <= 1'b1;
      else if (sdram_u1_s1_begins_xfer)
          sdram_u1_s1_reg_firsttransfer <= sdram_u1_s1_unreg_firsttransfer;
    end


  //sdram_u1_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sdram_u1_s1_beginbursttransfer_internal = sdram_u1_s1_begins_xfer;

  //sdram_u1_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign sdram_u1_s1_arbitration_holdoff_internal = sdram_u1_s1_begins_xfer & sdram_u1_s1_firsttransfer;

  //~sdram_u1_s1_read_n assignment, which is an e_mux
  assign sdram_u1_s1_read_n = ~((cpu_data_master_granted_sdram_u1_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_sdram_u1_s1 & cpu_instruction_master_read));

  //~sdram_u1_s1_write_n assignment, which is an e_mux
  assign sdram_u1_s1_write_n = ~(cpu_data_master_granted_sdram_u1_s1 & cpu_data_master_write);

  assign shifted_address_to_sdram_u1_s1_from_cpu_data_master = {cpu_data_master_address_to_slave >> 2,
    cpu_data_master_dbs_address[1],
    {1 {1'b0}}};

  //sdram_u1_s1_address mux, which is an e_mux
  assign sdram_u1_s1_address = (cpu_data_master_granted_sdram_u1_s1)? (shifted_address_to_sdram_u1_s1_from_cpu_data_master >> 1) :
    (shifted_address_to_sdram_u1_s1_from_cpu_instruction_master >> 1);

  assign shifted_address_to_sdram_u1_s1_from_cpu_instruction_master = {cpu_instruction_master_address_to_slave >> 2,
    cpu_instruction_master_dbs_address[1],
    {1 {1'b0}}};

  //d1_sdram_u1_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sdram_u1_s1_end_xfer <= 1;
      else if (1)
          d1_sdram_u1_s1_end_xfer <= sdram_u1_s1_end_xfer;
    end


  //sdram_u1_s1_waits_for_read in a cycle, which is an e_mux
  assign sdram_u1_s1_waits_for_read = sdram_u1_s1_in_a_read_cycle & sdram_u1_s1_waitrequest_from_sa;

  //sdram_u1_s1_in_a_read_cycle assignment, which is an e_assign
  assign sdram_u1_s1_in_a_read_cycle = (cpu_data_master_granted_sdram_u1_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_sdram_u1_s1 & cpu_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sdram_u1_s1_in_a_read_cycle;

  //sdram_u1_s1_waits_for_write in a cycle, which is an e_mux
  assign sdram_u1_s1_waits_for_write = sdram_u1_s1_in_a_write_cycle & sdram_u1_s1_waitrequest_from_sa;

  //sdram_u1_s1_in_a_write_cycle assignment, which is an e_assign
  assign sdram_u1_s1_in_a_write_cycle = cpu_data_master_granted_sdram_u1_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sdram_u1_s1_in_a_write_cycle;

  assign wait_for_sdram_u1_s1_counter = 0;
  //~sdram_u1_s1_byteenable_n byte enable port mux, which is an e_mux
  assign sdram_u1_s1_byteenable_n = ~((cpu_data_master_granted_sdram_u1_s1)? cpu_data_master_byteenable_sdram_u1_s1 :
    -1);

  assign {cpu_data_master_byteenable_sdram_u1_s1_segment_1,
cpu_data_master_byteenable_sdram_u1_s1_segment_0} = cpu_data_master_byteenable;
  assign cpu_data_master_byteenable_sdram_u1_s1 = ((cpu_data_master_dbs_address[1] == 0))? cpu_data_master_byteenable_sdram_u1_s1_segment_0 :
    cpu_data_master_byteenable_sdram_u1_s1_segment_1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sdram_u1/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_granted_sdram_u1_s1 + cpu_instruction_master_granted_sdram_u1_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_saved_grant_sdram_u1_s1 + cpu_instruction_master_saved_grant_sdram_u1_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_data_master_to_sdram_u2_s1_module (
                                                            // inputs:
                                                             clear_fifo,
                                                             clk,
                                                             data_in,
                                                             read,
                                                             reset_n,
                                                             sync_reset,
                                                             write,

                                                            // outputs:
                                                             data_out,
                                                             empty,
                                                             fifo_contains_ones_n,
                                                             full
                                                          )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_instruction_master_to_sdram_u2_s1_module (
                                                                   // inputs:
                                                                    clear_fifo,
                                                                    clk,
                                                                    data_in,
                                                                    read,
                                                                    reset_n,
                                                                    sync_reset,
                                                                    write,

                                                                   // outputs:
                                                                    data_out,
                                                                    empty,
                                                                    fifo_contains_ones_n,
                                                                    full
                                                                 )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sdram_u2_s1_arbitrator (
                                // inputs:
                                 clk,
                                 cpu_data_master_address_to_slave,
                                 cpu_data_master_byteenable,
                                 cpu_data_master_dbs_address,
                                 cpu_data_master_dbs_write_16,
                                 cpu_data_master_latency_counter,
                                 cpu_data_master_read,
                                 cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                 cpu_data_master_write,
                                 cpu_instruction_master_address_to_slave,
                                 cpu_instruction_master_dbs_address,
                                 cpu_instruction_master_latency_counter,
                                 cpu_instruction_master_read,
                                 cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register,
                                 reset_n,
                                 sdram_u2_s1_readdata,
                                 sdram_u2_s1_readdatavalid,
                                 sdram_u2_s1_waitrequest,

                                // outputs:
                                 cpu_data_master_byteenable_sdram_u2_s1,
                                 cpu_data_master_granted_sdram_u2_s1,
                                 cpu_data_master_qualified_request_sdram_u2_s1,
                                 cpu_data_master_read_data_valid_sdram_u2_s1,
                                 cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                 cpu_data_master_requests_sdram_u2_s1,
                                 cpu_instruction_master_granted_sdram_u2_s1,
                                 cpu_instruction_master_qualified_request_sdram_u2_s1,
                                 cpu_instruction_master_read_data_valid_sdram_u2_s1,
                                 cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register,
                                 cpu_instruction_master_requests_sdram_u2_s1,
                                 d1_sdram_u2_s1_end_xfer,
                                 sdram_u2_s1_address,
                                 sdram_u2_s1_byteenable_n,
                                 sdram_u2_s1_chipselect,
                                 sdram_u2_s1_read_n,
                                 sdram_u2_s1_readdata_from_sa,
                                 sdram_u2_s1_reset_n,
                                 sdram_u2_s1_waitrequest_from_sa,
                                 sdram_u2_s1_write_n,
                                 sdram_u2_s1_writedata
                              )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output  [  1: 0] cpu_data_master_byteenable_sdram_u2_s1;
  output           cpu_data_master_granted_sdram_u2_s1;
  output           cpu_data_master_qualified_request_sdram_u2_s1;
  output           cpu_data_master_read_data_valid_sdram_u2_s1;
  output           cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  output           cpu_data_master_requests_sdram_u2_s1;
  output           cpu_instruction_master_granted_sdram_u2_s1;
  output           cpu_instruction_master_qualified_request_sdram_u2_s1;
  output           cpu_instruction_master_read_data_valid_sdram_u2_s1;
  output           cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register;
  output           cpu_instruction_master_requests_sdram_u2_s1;
  output           d1_sdram_u2_s1_end_xfer;
  output  [ 23: 0] sdram_u2_s1_address;
  output  [  1: 0] sdram_u2_s1_byteenable_n;
  output           sdram_u2_s1_chipselect;
  output           sdram_u2_s1_read_n;
  output  [ 15: 0] sdram_u2_s1_readdata_from_sa;
  output           sdram_u2_s1_reset_n;
  output           sdram_u2_s1_waitrequest_from_sa;
  output           sdram_u2_s1_write_n;
  output  [ 15: 0] sdram_u2_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input   [  1: 0] cpu_data_master_dbs_address;
  input   [ 15: 0] cpu_data_master_dbs_write_16;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 27: 0] cpu_instruction_master_address_to_slave;
  input   [  1: 0] cpu_instruction_master_dbs_address;
  input   [  2: 0] cpu_instruction_master_latency_counter;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register;
  input            reset_n;
  input   [ 15: 0] sdram_u2_s1_readdata;
  input            sdram_u2_s1_readdatavalid;
  input            sdram_u2_s1_waitrequest;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_u2_s1;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_u2_s1_segment_0;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_u2_s1_segment_1;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_sdram_u2_s1;
  wire             cpu_data_master_qualified_request_sdram_u2_s1;
  wire             cpu_data_master_rdv_fifo_empty_sdram_u2_s1;
  wire             cpu_data_master_rdv_fifo_output_from_sdram_u2_s1;
  wire             cpu_data_master_read_data_valid_sdram_u2_s1;
  wire             cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  wire             cpu_data_master_requests_sdram_u2_s1;
  wire             cpu_data_master_saved_grant_sdram_u2_s1;
  wire             cpu_instruction_master_arbiterlock;
  wire             cpu_instruction_master_arbiterlock2;
  wire             cpu_instruction_master_continuerequest;
  wire             cpu_instruction_master_granted_sdram_u2_s1;
  wire             cpu_instruction_master_qualified_request_sdram_u2_s1;
  wire             cpu_instruction_master_rdv_fifo_empty_sdram_u2_s1;
  wire             cpu_instruction_master_rdv_fifo_output_from_sdram_u2_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_u2_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register;
  wire             cpu_instruction_master_requests_sdram_u2_s1;
  wire             cpu_instruction_master_saved_grant_sdram_u2_s1;
  reg              d1_reasons_to_wait;
  reg              d1_sdram_u2_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sdram_u2_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_data_master_granted_slave_sdram_u2_s1;
  reg              last_cycle_cpu_instruction_master_granted_slave_sdram_u2_s1;
  wire    [ 23: 0] sdram_u2_s1_address;
  wire             sdram_u2_s1_allgrants;
  wire             sdram_u2_s1_allow_new_arb_cycle;
  wire             sdram_u2_s1_any_bursting_master_saved_grant;
  wire             sdram_u2_s1_any_continuerequest;
  reg     [  1: 0] sdram_u2_s1_arb_addend;
  wire             sdram_u2_s1_arb_counter_enable;
  reg     [  1: 0] sdram_u2_s1_arb_share_counter;
  wire    [  1: 0] sdram_u2_s1_arb_share_counter_next_value;
  wire    [  1: 0] sdram_u2_s1_arb_share_set_values;
  wire    [  1: 0] sdram_u2_s1_arb_winner;
  wire             sdram_u2_s1_arbitration_holdoff_internal;
  wire             sdram_u2_s1_beginbursttransfer_internal;
  wire             sdram_u2_s1_begins_xfer;
  wire    [  1: 0] sdram_u2_s1_byteenable_n;
  wire             sdram_u2_s1_chipselect;
  wire    [  3: 0] sdram_u2_s1_chosen_master_double_vector;
  wire    [  1: 0] sdram_u2_s1_chosen_master_rot_left;
  wire             sdram_u2_s1_end_xfer;
  wire             sdram_u2_s1_firsttransfer;
  wire    [  1: 0] sdram_u2_s1_grant_vector;
  wire             sdram_u2_s1_in_a_read_cycle;
  wire             sdram_u2_s1_in_a_write_cycle;
  wire    [  1: 0] sdram_u2_s1_master_qreq_vector;
  wire             sdram_u2_s1_move_on_to_next_transaction;
  wire             sdram_u2_s1_non_bursting_master_requests;
  wire             sdram_u2_s1_read_n;
  wire    [ 15: 0] sdram_u2_s1_readdata_from_sa;
  wire             sdram_u2_s1_readdatavalid_from_sa;
  reg              sdram_u2_s1_reg_firsttransfer;
  wire             sdram_u2_s1_reset_n;
  reg     [  1: 0] sdram_u2_s1_saved_chosen_master_vector;
  reg              sdram_u2_s1_slavearbiterlockenable;
  wire             sdram_u2_s1_slavearbiterlockenable2;
  wire             sdram_u2_s1_unreg_firsttransfer;
  wire             sdram_u2_s1_waitrequest_from_sa;
  wire             sdram_u2_s1_waits_for_read;
  wire             sdram_u2_s1_waits_for_write;
  wire             sdram_u2_s1_write_n;
  wire    [ 15: 0] sdram_u2_s1_writedata;
  wire    [ 27: 0] shifted_address_to_sdram_u2_s1_from_cpu_data_master;
  wire    [ 27: 0] shifted_address_to_sdram_u2_s1_from_cpu_instruction_master;
  wire             wait_for_sdram_u2_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~sdram_u2_s1_end_xfer;
    end


  assign sdram_u2_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_sdram_u2_s1 | cpu_instruction_master_qualified_request_sdram_u2_s1));
  //assign sdram_u2_s1_readdatavalid_from_sa = sdram_u2_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_u2_s1_readdatavalid_from_sa = sdram_u2_s1_readdatavalid;

  //assign sdram_u2_s1_readdata_from_sa = sdram_u2_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_u2_s1_readdata_from_sa = sdram_u2_s1_readdata;

  assign cpu_data_master_requests_sdram_u2_s1 = ({cpu_data_master_address_to_slave[27 : 25] , 25'b0} == 28'h6000000) & (cpu_data_master_read | cpu_data_master_write);
  //assign sdram_u2_s1_waitrequest_from_sa = sdram_u2_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_u2_s1_waitrequest_from_sa = sdram_u2_s1_waitrequest;

  //sdram_u2_s1_arb_share_counter set values, which is an e_mux
  assign sdram_u2_s1_arb_share_set_values = (cpu_data_master_granted_sdram_u2_s1)? 2 :
    (cpu_instruction_master_granted_sdram_u2_s1)? 2 :
    (cpu_data_master_granted_sdram_u2_s1)? 2 :
    (cpu_instruction_master_granted_sdram_u2_s1)? 2 :
    1;

  //sdram_u2_s1_non_bursting_master_requests mux, which is an e_mux
  assign sdram_u2_s1_non_bursting_master_requests = cpu_data_master_requests_sdram_u2_s1 |
    cpu_instruction_master_requests_sdram_u2_s1 |
    cpu_data_master_requests_sdram_u2_s1 |
    cpu_instruction_master_requests_sdram_u2_s1;

  //sdram_u2_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sdram_u2_s1_any_bursting_master_saved_grant = 0;

  //sdram_u2_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sdram_u2_s1_arb_share_counter_next_value = sdram_u2_s1_firsttransfer ? (sdram_u2_s1_arb_share_set_values - 1) : |sdram_u2_s1_arb_share_counter ? (sdram_u2_s1_arb_share_counter - 1) : 0;

  //sdram_u2_s1_allgrants all slave grants, which is an e_mux
  assign sdram_u2_s1_allgrants = |sdram_u2_s1_grant_vector |
    |sdram_u2_s1_grant_vector |
    |sdram_u2_s1_grant_vector |
    |sdram_u2_s1_grant_vector;

  //sdram_u2_s1_end_xfer assignment, which is an e_assign
  assign sdram_u2_s1_end_xfer = ~(sdram_u2_s1_waits_for_read | sdram_u2_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sdram_u2_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sdram_u2_s1 = sdram_u2_s1_end_xfer & (~sdram_u2_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sdram_u2_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sdram_u2_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sdram_u2_s1 & sdram_u2_s1_allgrants) | (end_xfer_arb_share_counter_term_sdram_u2_s1 & ~sdram_u2_s1_non_bursting_master_requests);

  //sdram_u2_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u2_s1_arb_share_counter <= 0;
      else if (sdram_u2_s1_arb_counter_enable)
          sdram_u2_s1_arb_share_counter <= sdram_u2_s1_arb_share_counter_next_value;
    end


  //sdram_u2_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u2_s1_slavearbiterlockenable <= 0;
      else if ((|sdram_u2_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sdram_u2_s1) | (end_xfer_arb_share_counter_term_sdram_u2_s1 & ~sdram_u2_s1_non_bursting_master_requests))
          sdram_u2_s1_slavearbiterlockenable <= |sdram_u2_s1_arb_share_counter_next_value;
    end


  //cpu/data_master sdram_u2/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = sdram_u2_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //sdram_u2_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sdram_u2_s1_slavearbiterlockenable2 = |sdram_u2_s1_arb_share_counter_next_value;

  //cpu/data_master sdram_u2/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = sdram_u2_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //cpu/instruction_master sdram_u2/s1 arbiterlock, which is an e_assign
  assign cpu_instruction_master_arbiterlock = sdram_u2_s1_slavearbiterlockenable & cpu_instruction_master_continuerequest;

  //cpu/instruction_master sdram_u2/s1 arbiterlock2, which is an e_assign
  assign cpu_instruction_master_arbiterlock2 = sdram_u2_s1_slavearbiterlockenable2 & cpu_instruction_master_continuerequest;

  //cpu/instruction_master granted sdram_u2/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_instruction_master_granted_slave_sdram_u2_s1 <= 0;
      else if (1)
          last_cycle_cpu_instruction_master_granted_slave_sdram_u2_s1 <= cpu_instruction_master_saved_grant_sdram_u2_s1 ? 1 : (sdram_u2_s1_arbitration_holdoff_internal | ~cpu_instruction_master_requests_sdram_u2_s1) ? 0 : last_cycle_cpu_instruction_master_granted_slave_sdram_u2_s1;
    end


  //cpu_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_instruction_master_continuerequest = last_cycle_cpu_instruction_master_granted_slave_sdram_u2_s1 & cpu_instruction_master_requests_sdram_u2_s1;

  //sdram_u2_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign sdram_u2_s1_any_continuerequest = cpu_instruction_master_continuerequest |
    cpu_data_master_continuerequest;

  assign cpu_data_master_qualified_request_sdram_u2_s1 = cpu_data_master_requests_sdram_u2_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (1 < cpu_data_master_latency_counter) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register))) | ((!cpu_data_master_byteenable_sdram_u2_s1) & cpu_data_master_write) | cpu_instruction_master_arbiterlock);
  //unique name for sdram_u2_s1_move_on_to_next_transaction, which is an e_assign
  assign sdram_u2_s1_move_on_to_next_transaction = sdram_u2_s1_readdatavalid_from_sa;

  //rdv_fifo_for_cpu_data_master_to_sdram_u2_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_data_master_to_sdram_u2_s1_module rdv_fifo_for_cpu_data_master_to_sdram_u2_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_data_master_granted_sdram_u2_s1),
      .data_out             (cpu_data_master_rdv_fifo_output_from_sdram_u2_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_data_master_rdv_fifo_empty_sdram_u2_s1),
      .full                 (),
      .read                 (sdram_u2_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_u2_s1_waits_for_read)
    );

  assign cpu_data_master_read_data_valid_sdram_u2_s1_shift_register = ~cpu_data_master_rdv_fifo_empty_sdram_u2_s1;
  //local readdatavalid cpu_data_master_read_data_valid_sdram_u2_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_sdram_u2_s1 = (sdram_u2_s1_readdatavalid_from_sa & cpu_data_master_rdv_fifo_output_from_sdram_u2_s1) & ~ cpu_data_master_rdv_fifo_empty_sdram_u2_s1;

  //sdram_u2_s1_writedata mux, which is an e_mux
  assign sdram_u2_s1_writedata = cpu_data_master_dbs_write_16;

  assign cpu_instruction_master_requests_sdram_u2_s1 = (({cpu_instruction_master_address_to_slave[27 : 25] , 25'b0} == 28'h6000000) & (cpu_instruction_master_read)) & cpu_instruction_master_read;
  //cpu/data_master granted sdram_u2/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_data_master_granted_slave_sdram_u2_s1 <= 0;
      else if (1)
          last_cycle_cpu_data_master_granted_slave_sdram_u2_s1 <= cpu_data_master_saved_grant_sdram_u2_s1 ? 1 : (sdram_u2_s1_arbitration_holdoff_internal | ~cpu_data_master_requests_sdram_u2_s1) ? 0 : last_cycle_cpu_data_master_granted_slave_sdram_u2_s1;
    end


  //cpu_data_master_continuerequest continued request, which is an e_mux
  assign cpu_data_master_continuerequest = last_cycle_cpu_data_master_granted_slave_sdram_u2_s1 & cpu_data_master_requests_sdram_u2_s1;

  assign cpu_instruction_master_qualified_request_sdram_u2_s1 = cpu_instruction_master_requests_sdram_u2_s1 & ~((cpu_instruction_master_read & ((cpu_instruction_master_latency_counter != 0) | (1 < cpu_instruction_master_latency_counter) | (|cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register))) | cpu_data_master_arbiterlock);
  //rdv_fifo_for_cpu_instruction_master_to_sdram_u2_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_instruction_master_to_sdram_u2_s1_module rdv_fifo_for_cpu_instruction_master_to_sdram_u2_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_instruction_master_granted_sdram_u2_s1),
      .data_out             (cpu_instruction_master_rdv_fifo_output_from_sdram_u2_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_instruction_master_rdv_fifo_empty_sdram_u2_s1),
      .full                 (),
      .read                 (sdram_u2_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_u2_s1_waits_for_read)
    );

  assign cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register = ~cpu_instruction_master_rdv_fifo_empty_sdram_u2_s1;
  //local readdatavalid cpu_instruction_master_read_data_valid_sdram_u2_s1, which is an e_mux
  assign cpu_instruction_master_read_data_valid_sdram_u2_s1 = (sdram_u2_s1_readdatavalid_from_sa & cpu_instruction_master_rdv_fifo_output_from_sdram_u2_s1) & ~ cpu_instruction_master_rdv_fifo_empty_sdram_u2_s1;

  //allow new arb cycle for sdram_u2/s1, which is an e_assign
  assign sdram_u2_s1_allow_new_arb_cycle = ~cpu_data_master_arbiterlock & ~cpu_instruction_master_arbiterlock;

  //cpu/instruction_master assignment into master qualified-requests vector for sdram_u2/s1, which is an e_assign
  assign sdram_u2_s1_master_qreq_vector[0] = cpu_instruction_master_qualified_request_sdram_u2_s1;

  //cpu/instruction_master grant sdram_u2/s1, which is an e_assign
  assign cpu_instruction_master_granted_sdram_u2_s1 = sdram_u2_s1_grant_vector[0];

  //cpu/instruction_master saved-grant sdram_u2/s1, which is an e_assign
  assign cpu_instruction_master_saved_grant_sdram_u2_s1 = sdram_u2_s1_arb_winner[0] && cpu_instruction_master_requests_sdram_u2_s1;

  //cpu/data_master assignment into master qualified-requests vector for sdram_u2/s1, which is an e_assign
  assign sdram_u2_s1_master_qreq_vector[1] = cpu_data_master_qualified_request_sdram_u2_s1;

  //cpu/data_master grant sdram_u2/s1, which is an e_assign
  assign cpu_data_master_granted_sdram_u2_s1 = sdram_u2_s1_grant_vector[1];

  //cpu/data_master saved-grant sdram_u2/s1, which is an e_assign
  assign cpu_data_master_saved_grant_sdram_u2_s1 = sdram_u2_s1_arb_winner[1] && cpu_data_master_requests_sdram_u2_s1;

  //sdram_u2/s1 chosen-master double-vector, which is an e_assign
  assign sdram_u2_s1_chosen_master_double_vector = {sdram_u2_s1_master_qreq_vector, sdram_u2_s1_master_qreq_vector} & ({~sdram_u2_s1_master_qreq_vector, ~sdram_u2_s1_master_qreq_vector} + sdram_u2_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign sdram_u2_s1_arb_winner = (sdram_u2_s1_allow_new_arb_cycle & | sdram_u2_s1_grant_vector) ? sdram_u2_s1_grant_vector : sdram_u2_s1_saved_chosen_master_vector;

  //saved sdram_u2_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u2_s1_saved_chosen_master_vector <= 0;
      else if (sdram_u2_s1_allow_new_arb_cycle)
          sdram_u2_s1_saved_chosen_master_vector <= |sdram_u2_s1_grant_vector ? sdram_u2_s1_grant_vector : sdram_u2_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign sdram_u2_s1_grant_vector = {(sdram_u2_s1_chosen_master_double_vector[1] | sdram_u2_s1_chosen_master_double_vector[3]),
    (sdram_u2_s1_chosen_master_double_vector[0] | sdram_u2_s1_chosen_master_double_vector[2])};

  //sdram_u2/s1 chosen master rotated left, which is an e_assign
  assign sdram_u2_s1_chosen_master_rot_left = (sdram_u2_s1_arb_winner << 1) ? (sdram_u2_s1_arb_winner << 1) : 1;

  //sdram_u2/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u2_s1_arb_addend <= 1;
      else if (|sdram_u2_s1_grant_vector)
          sdram_u2_s1_arb_addend <= sdram_u2_s1_end_xfer? sdram_u2_s1_chosen_master_rot_left : sdram_u2_s1_grant_vector;
    end


  //sdram_u2_s1_reset_n assignment, which is an e_assign
  assign sdram_u2_s1_reset_n = reset_n;

  assign sdram_u2_s1_chipselect = cpu_data_master_granted_sdram_u2_s1 | cpu_instruction_master_granted_sdram_u2_s1;
  //sdram_u2_s1_firsttransfer first transaction, which is an e_assign
  assign sdram_u2_s1_firsttransfer = sdram_u2_s1_begins_xfer ? sdram_u2_s1_unreg_firsttransfer : sdram_u2_s1_reg_firsttransfer;

  //sdram_u2_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sdram_u2_s1_unreg_firsttransfer = ~(sdram_u2_s1_slavearbiterlockenable & sdram_u2_s1_any_continuerequest);

  //sdram_u2_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u2_s1_reg_firsttransfer <= 1'b1;
      else if (sdram_u2_s1_begins_xfer)
          sdram_u2_s1_reg_firsttransfer <= sdram_u2_s1_unreg_firsttransfer;
    end


  //sdram_u2_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sdram_u2_s1_beginbursttransfer_internal = sdram_u2_s1_begins_xfer;

  //sdram_u2_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign sdram_u2_s1_arbitration_holdoff_internal = sdram_u2_s1_begins_xfer & sdram_u2_s1_firsttransfer;

  //~sdram_u2_s1_read_n assignment, which is an e_mux
  assign sdram_u2_s1_read_n = ~((cpu_data_master_granted_sdram_u2_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_sdram_u2_s1 & cpu_instruction_master_read));

  //~sdram_u2_s1_write_n assignment, which is an e_mux
  assign sdram_u2_s1_write_n = ~(cpu_data_master_granted_sdram_u2_s1 & cpu_data_master_write);

  assign shifted_address_to_sdram_u2_s1_from_cpu_data_master = {cpu_data_master_address_to_slave >> 2,
    cpu_data_master_dbs_address[1],
    {1 {1'b0}}};

  //sdram_u2_s1_address mux, which is an e_mux
  assign sdram_u2_s1_address = (cpu_data_master_granted_sdram_u2_s1)? (shifted_address_to_sdram_u2_s1_from_cpu_data_master >> 1) :
    (shifted_address_to_sdram_u2_s1_from_cpu_instruction_master >> 1);

  assign shifted_address_to_sdram_u2_s1_from_cpu_instruction_master = {cpu_instruction_master_address_to_slave >> 2,
    cpu_instruction_master_dbs_address[1],
    {1 {1'b0}}};

  //d1_sdram_u2_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sdram_u2_s1_end_xfer <= 1;
      else if (1)
          d1_sdram_u2_s1_end_xfer <= sdram_u2_s1_end_xfer;
    end


  //sdram_u2_s1_waits_for_read in a cycle, which is an e_mux
  assign sdram_u2_s1_waits_for_read = sdram_u2_s1_in_a_read_cycle & sdram_u2_s1_waitrequest_from_sa;

  //sdram_u2_s1_in_a_read_cycle assignment, which is an e_assign
  assign sdram_u2_s1_in_a_read_cycle = (cpu_data_master_granted_sdram_u2_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_sdram_u2_s1 & cpu_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sdram_u2_s1_in_a_read_cycle;

  //sdram_u2_s1_waits_for_write in a cycle, which is an e_mux
  assign sdram_u2_s1_waits_for_write = sdram_u2_s1_in_a_write_cycle & sdram_u2_s1_waitrequest_from_sa;

  //sdram_u2_s1_in_a_write_cycle assignment, which is an e_assign
  assign sdram_u2_s1_in_a_write_cycle = cpu_data_master_granted_sdram_u2_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sdram_u2_s1_in_a_write_cycle;

  assign wait_for_sdram_u2_s1_counter = 0;
  //~sdram_u2_s1_byteenable_n byte enable port mux, which is an e_mux
  assign sdram_u2_s1_byteenable_n = ~((cpu_data_master_granted_sdram_u2_s1)? cpu_data_master_byteenable_sdram_u2_s1 :
    -1);

  assign {cpu_data_master_byteenable_sdram_u2_s1_segment_1,
cpu_data_master_byteenable_sdram_u2_s1_segment_0} = cpu_data_master_byteenable;
  assign cpu_data_master_byteenable_sdram_u2_s1 = ((cpu_data_master_dbs_address[1] == 0))? cpu_data_master_byteenable_sdram_u2_s1_segment_0 :
    cpu_data_master_byteenable_sdram_u2_s1_segment_1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sdram_u2/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_granted_sdram_u2_s1 + cpu_instruction_master_granted_sdram_u2_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_saved_grant_sdram_u2_s1 + cpu_instruction_master_saved_grant_sdram_u2_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sysid_control_slave_arbitrator (
                                        // inputs:
                                         clk,
                                         cpu_data_master_address_to_slave,
                                         cpu_data_master_latency_counter,
                                         cpu_data_master_read,
                                         cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                         cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                         cpu_data_master_write,
                                         reset_n,
                                         sysid_control_slave_readdata,

                                        // outputs:
                                         cpu_data_master_granted_sysid_control_slave,
                                         cpu_data_master_qualified_request_sysid_control_slave,
                                         cpu_data_master_read_data_valid_sysid_control_slave,
                                         cpu_data_master_requests_sysid_control_slave,
                                         d1_sysid_control_slave_end_xfer,
                                         sysid_control_slave_address,
                                         sysid_control_slave_readdata_from_sa
                                      )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_sysid_control_slave;
  output           cpu_data_master_qualified_request_sysid_control_slave;
  output           cpu_data_master_read_data_valid_sysid_control_slave;
  output           cpu_data_master_requests_sysid_control_slave;
  output           d1_sysid_control_slave_end_xfer;
  output           sysid_control_slave_address;
  output  [ 31: 0] sysid_control_slave_readdata_from_sa;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input            reset_n;
  input   [ 31: 0] sysid_control_slave_readdata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_sysid_control_slave;
  wire             cpu_data_master_qualified_request_sysid_control_slave;
  wire             cpu_data_master_read_data_valid_sysid_control_slave;
  wire             cpu_data_master_requests_sysid_control_slave;
  wire             cpu_data_master_saved_grant_sysid_control_slave;
  reg              d1_reasons_to_wait;
  reg              d1_sysid_control_slave_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sysid_control_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_sysid_control_slave_from_cpu_data_master;
  wire             sysid_control_slave_address;
  wire             sysid_control_slave_allgrants;
  wire             sysid_control_slave_allow_new_arb_cycle;
  wire             sysid_control_slave_any_bursting_master_saved_grant;
  wire             sysid_control_slave_any_continuerequest;
  wire             sysid_control_slave_arb_counter_enable;
  reg     [  1: 0] sysid_control_slave_arb_share_counter;
  wire    [  1: 0] sysid_control_slave_arb_share_counter_next_value;
  wire    [  1: 0] sysid_control_slave_arb_share_set_values;
  wire             sysid_control_slave_beginbursttransfer_internal;
  wire             sysid_control_slave_begins_xfer;
  wire             sysid_control_slave_end_xfer;
  wire             sysid_control_slave_firsttransfer;
  wire             sysid_control_slave_grant_vector;
  wire             sysid_control_slave_in_a_read_cycle;
  wire             sysid_control_slave_in_a_write_cycle;
  wire             sysid_control_slave_master_qreq_vector;
  wire             sysid_control_slave_non_bursting_master_requests;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  reg              sysid_control_slave_reg_firsttransfer;
  reg              sysid_control_slave_slavearbiterlockenable;
  wire             sysid_control_slave_slavearbiterlockenable2;
  wire             sysid_control_slave_unreg_firsttransfer;
  wire             sysid_control_slave_waits_for_read;
  wire             sysid_control_slave_waits_for_write;
  wire             wait_for_sysid_control_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~sysid_control_slave_end_xfer;
    end


  assign sysid_control_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_sysid_control_slave));
  //assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata;

  assign cpu_data_master_requests_sysid_control_slave = (({cpu_data_master_address_to_slave[27 : 3] , 3'b0} == 28'h96411d0) & (cpu_data_master_read | cpu_data_master_write)) & cpu_data_master_read;
  //sysid_control_slave_arb_share_counter set values, which is an e_mux
  assign sysid_control_slave_arb_share_set_values = 1;

  //sysid_control_slave_non_bursting_master_requests mux, which is an e_mux
  assign sysid_control_slave_non_bursting_master_requests = cpu_data_master_requests_sysid_control_slave;

  //sysid_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign sysid_control_slave_any_bursting_master_saved_grant = 0;

  //sysid_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign sysid_control_slave_arb_share_counter_next_value = sysid_control_slave_firsttransfer ? (sysid_control_slave_arb_share_set_values - 1) : |sysid_control_slave_arb_share_counter ? (sysid_control_slave_arb_share_counter - 1) : 0;

  //sysid_control_slave_allgrants all slave grants, which is an e_mux
  assign sysid_control_slave_allgrants = |sysid_control_slave_grant_vector;

  //sysid_control_slave_end_xfer assignment, which is an e_assign
  assign sysid_control_slave_end_xfer = ~(sysid_control_slave_waits_for_read | sysid_control_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_sysid_control_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sysid_control_slave = sysid_control_slave_end_xfer & (~sysid_control_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sysid_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign sysid_control_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_sysid_control_slave & sysid_control_slave_allgrants) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests);

  //sysid_control_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_arb_share_counter <= 0;
      else if (sysid_control_slave_arb_counter_enable)
          sysid_control_slave_arb_share_counter <= sysid_control_slave_arb_share_counter_next_value;
    end


  //sysid_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_slavearbiterlockenable <= 0;
      else if ((|sysid_control_slave_master_qreq_vector & end_xfer_arb_share_counter_term_sysid_control_slave) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests))
          sysid_control_slave_slavearbiterlockenable <= |sysid_control_slave_arb_share_counter_next_value;
    end


  //cpu/data_master sysid/control_slave arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = sysid_control_slave_slavearbiterlockenable & cpu_data_master_continuerequest;

  //sysid_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sysid_control_slave_slavearbiterlockenable2 = |sysid_control_slave_arb_share_counter_next_value;

  //cpu/data_master sysid/control_slave arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = sysid_control_slave_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //sysid_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign sysid_control_slave_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_sysid_control_slave = cpu_data_master_requests_sysid_control_slave & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_sysid_control_slave, which is an e_mux
  assign cpu_data_master_read_data_valid_sysid_control_slave = cpu_data_master_granted_sysid_control_slave & cpu_data_master_read & ~sysid_control_slave_waits_for_read;

  //master is always granted when requested
  assign cpu_data_master_granted_sysid_control_slave = cpu_data_master_qualified_request_sysid_control_slave;

  //cpu/data_master saved-grant sysid/control_slave, which is an e_assign
  assign cpu_data_master_saved_grant_sysid_control_slave = cpu_data_master_requests_sysid_control_slave;

  //allow new arb cycle for sysid/control_slave, which is an e_assign
  assign sysid_control_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign sysid_control_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign sysid_control_slave_master_qreq_vector = 1;

  //sysid_control_slave_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_firsttransfer = sysid_control_slave_begins_xfer ? sysid_control_slave_unreg_firsttransfer : sysid_control_slave_reg_firsttransfer;

  //sysid_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_unreg_firsttransfer = ~(sysid_control_slave_slavearbiterlockenable & sysid_control_slave_any_continuerequest);

  //sysid_control_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_reg_firsttransfer <= 1'b1;
      else if (sysid_control_slave_begins_xfer)
          sysid_control_slave_reg_firsttransfer <= sysid_control_slave_unreg_firsttransfer;
    end


  //sysid_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sysid_control_slave_beginbursttransfer_internal = sysid_control_slave_begins_xfer;

  assign shifted_address_to_sysid_control_slave_from_cpu_data_master = cpu_data_master_address_to_slave;
  //sysid_control_slave_address mux, which is an e_mux
  assign sysid_control_slave_address = shifted_address_to_sysid_control_slave_from_cpu_data_master >> 2;

  //d1_sysid_control_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sysid_control_slave_end_xfer <= 1;
      else if (1)
          d1_sysid_control_slave_end_xfer <= sysid_control_slave_end_xfer;
    end


  //sysid_control_slave_waits_for_read in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_read = sysid_control_slave_in_a_read_cycle & sysid_control_slave_begins_xfer;

  //sysid_control_slave_in_a_read_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_read_cycle = cpu_data_master_granted_sysid_control_slave & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sysid_control_slave_in_a_read_cycle;

  //sysid_control_slave_waits_for_write in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_write = sysid_control_slave_in_a_write_cycle & 0;

  //sysid_control_slave_in_a_write_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_write_cycle = cpu_data_master_granted_sysid_control_slave & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sysid_control_slave_in_a_write_cycle;

  assign wait_for_sysid_control_slave_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sysid/control_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module timer_s1_arbitrator (
                             // inputs:
                              clk,
                              cpu_data_master_address_to_slave,
                              cpu_data_master_latency_counter,
                              cpu_data_master_read,
                              cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                              cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                              cpu_data_master_write,
                              cpu_data_master_writedata,
                              reset_n,
                              timer_s1_irq,
                              timer_s1_readdata,

                             // outputs:
                              cpu_data_master_granted_timer_s1,
                              cpu_data_master_qualified_request_timer_s1,
                              cpu_data_master_read_data_valid_timer_s1,
                              cpu_data_master_requests_timer_s1,
                              d1_timer_s1_end_xfer,
                              timer_s1_address,
                              timer_s1_chipselect,
                              timer_s1_irq_from_sa,
                              timer_s1_readdata_from_sa,
                              timer_s1_reset_n,
                              timer_s1_write_n,
                              timer_s1_writedata
                           )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_timer_s1;
  output           cpu_data_master_qualified_request_timer_s1;
  output           cpu_data_master_read_data_valid_timer_s1;
  output           cpu_data_master_requests_timer_s1;
  output           d1_timer_s1_end_xfer;
  output  [  2: 0] timer_s1_address;
  output           timer_s1_chipselect;
  output           timer_s1_irq_from_sa;
  output  [ 15: 0] timer_s1_readdata_from_sa;
  output           timer_s1_reset_n;
  output           timer_s1_write_n;
  output  [ 15: 0] timer_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;
  input            timer_s1_irq;
  input   [ 15: 0] timer_s1_readdata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_timer_s1;
  wire             cpu_data_master_qualified_request_timer_s1;
  wire             cpu_data_master_read_data_valid_timer_s1;
  wire             cpu_data_master_requests_timer_s1;
  wire             cpu_data_master_saved_grant_timer_s1;
  reg              d1_reasons_to_wait;
  reg              d1_timer_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_timer_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_timer_s1_from_cpu_data_master;
  wire    [  2: 0] timer_s1_address;
  wire             timer_s1_allgrants;
  wire             timer_s1_allow_new_arb_cycle;
  wire             timer_s1_any_bursting_master_saved_grant;
  wire             timer_s1_any_continuerequest;
  wire             timer_s1_arb_counter_enable;
  reg     [  1: 0] timer_s1_arb_share_counter;
  wire    [  1: 0] timer_s1_arb_share_counter_next_value;
  wire    [  1: 0] timer_s1_arb_share_set_values;
  wire             timer_s1_beginbursttransfer_internal;
  wire             timer_s1_begins_xfer;
  wire             timer_s1_chipselect;
  wire             timer_s1_end_xfer;
  wire             timer_s1_firsttransfer;
  wire             timer_s1_grant_vector;
  wire             timer_s1_in_a_read_cycle;
  wire             timer_s1_in_a_write_cycle;
  wire             timer_s1_irq_from_sa;
  wire             timer_s1_master_qreq_vector;
  wire             timer_s1_non_bursting_master_requests;
  wire    [ 15: 0] timer_s1_readdata_from_sa;
  reg              timer_s1_reg_firsttransfer;
  wire             timer_s1_reset_n;
  reg              timer_s1_slavearbiterlockenable;
  wire             timer_s1_slavearbiterlockenable2;
  wire             timer_s1_unreg_firsttransfer;
  wire             timer_s1_waits_for_read;
  wire             timer_s1_waits_for_write;
  wire             timer_s1_write_n;
  wire    [ 15: 0] timer_s1_writedata;
  wire             wait_for_timer_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~timer_s1_end_xfer;
    end


  assign timer_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_timer_s1));
  //assign timer_s1_readdata_from_sa = timer_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_s1_readdata_from_sa = timer_s1_readdata;

  assign cpu_data_master_requests_timer_s1 = ({cpu_data_master_address_to_slave[27 : 5] , 5'b0} == 28'h9641080) & (cpu_data_master_read | cpu_data_master_write);
  //timer_s1_arb_share_counter set values, which is an e_mux
  assign timer_s1_arb_share_set_values = 1;

  //timer_s1_non_bursting_master_requests mux, which is an e_mux
  assign timer_s1_non_bursting_master_requests = cpu_data_master_requests_timer_s1;

  //timer_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign timer_s1_any_bursting_master_saved_grant = 0;

  //timer_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign timer_s1_arb_share_counter_next_value = timer_s1_firsttransfer ? (timer_s1_arb_share_set_values - 1) : |timer_s1_arb_share_counter ? (timer_s1_arb_share_counter - 1) : 0;

  //timer_s1_allgrants all slave grants, which is an e_mux
  assign timer_s1_allgrants = |timer_s1_grant_vector;

  //timer_s1_end_xfer assignment, which is an e_assign
  assign timer_s1_end_xfer = ~(timer_s1_waits_for_read | timer_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_timer_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_timer_s1 = timer_s1_end_xfer & (~timer_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //timer_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign timer_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_timer_s1 & timer_s1_allgrants) | (end_xfer_arb_share_counter_term_timer_s1 & ~timer_s1_non_bursting_master_requests);

  //timer_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_s1_arb_share_counter <= 0;
      else if (timer_s1_arb_counter_enable)
          timer_s1_arb_share_counter <= timer_s1_arb_share_counter_next_value;
    end


  //timer_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_s1_slavearbiterlockenable <= 0;
      else if ((|timer_s1_master_qreq_vector & end_xfer_arb_share_counter_term_timer_s1) | (end_xfer_arb_share_counter_term_timer_s1 & ~timer_s1_non_bursting_master_requests))
          timer_s1_slavearbiterlockenable <= |timer_s1_arb_share_counter_next_value;
    end


  //cpu/data_master timer/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = timer_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //timer_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign timer_s1_slavearbiterlockenable2 = |timer_s1_arb_share_counter_next_value;

  //cpu/data_master timer/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = timer_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //timer_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign timer_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_timer_s1 = cpu_data_master_requests_timer_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_timer_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_timer_s1 = cpu_data_master_granted_timer_s1 & cpu_data_master_read & ~timer_s1_waits_for_read;

  //timer_s1_writedata mux, which is an e_mux
  assign timer_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_timer_s1 = cpu_data_master_qualified_request_timer_s1;

  //cpu/data_master saved-grant timer/s1, which is an e_assign
  assign cpu_data_master_saved_grant_timer_s1 = cpu_data_master_requests_timer_s1;

  //allow new arb cycle for timer/s1, which is an e_assign
  assign timer_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign timer_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign timer_s1_master_qreq_vector = 1;

  //timer_s1_reset_n assignment, which is an e_assign
  assign timer_s1_reset_n = reset_n;

  assign timer_s1_chipselect = cpu_data_master_granted_timer_s1;
  //timer_s1_firsttransfer first transaction, which is an e_assign
  assign timer_s1_firsttransfer = timer_s1_begins_xfer ? timer_s1_unreg_firsttransfer : timer_s1_reg_firsttransfer;

  //timer_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign timer_s1_unreg_firsttransfer = ~(timer_s1_slavearbiterlockenable & timer_s1_any_continuerequest);

  //timer_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_s1_reg_firsttransfer <= 1'b1;
      else if (timer_s1_begins_xfer)
          timer_s1_reg_firsttransfer <= timer_s1_unreg_firsttransfer;
    end


  //timer_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign timer_s1_beginbursttransfer_internal = timer_s1_begins_xfer;

  //~timer_s1_write_n assignment, which is an e_mux
  assign timer_s1_write_n = ~(cpu_data_master_granted_timer_s1 & cpu_data_master_write);

  assign shifted_address_to_timer_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //timer_s1_address mux, which is an e_mux
  assign timer_s1_address = shifted_address_to_timer_s1_from_cpu_data_master >> 2;

  //d1_timer_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_timer_s1_end_xfer <= 1;
      else if (1)
          d1_timer_s1_end_xfer <= timer_s1_end_xfer;
    end


  //timer_s1_waits_for_read in a cycle, which is an e_mux
  assign timer_s1_waits_for_read = timer_s1_in_a_read_cycle & timer_s1_begins_xfer;

  //timer_s1_in_a_read_cycle assignment, which is an e_assign
  assign timer_s1_in_a_read_cycle = cpu_data_master_granted_timer_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = timer_s1_in_a_read_cycle;

  //timer_s1_waits_for_write in a cycle, which is an e_mux
  assign timer_s1_waits_for_write = timer_s1_in_a_write_cycle & 0;

  //timer_s1_in_a_write_cycle assignment, which is an e_assign
  assign timer_s1_in_a_write_cycle = cpu_data_master_granted_timer_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = timer_s1_in_a_write_cycle;

  assign wait_for_timer_s1_counter = 0;
  //assign timer_s1_irq_from_sa = timer_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_s1_irq_from_sa = timer_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //timer/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module timer_stamp_s1_arbitrator (
                                   // inputs:
                                    clk,
                                    cpu_data_master_address_to_slave,
                                    cpu_data_master_latency_counter,
                                    cpu_data_master_read,
                                    cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                    cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                    cpu_data_master_write,
                                    cpu_data_master_writedata,
                                    reset_n,
                                    timer_stamp_s1_irq,
                                    timer_stamp_s1_readdata,

                                   // outputs:
                                    cpu_data_master_granted_timer_stamp_s1,
                                    cpu_data_master_qualified_request_timer_stamp_s1,
                                    cpu_data_master_read_data_valid_timer_stamp_s1,
                                    cpu_data_master_requests_timer_stamp_s1,
                                    d1_timer_stamp_s1_end_xfer,
                                    timer_stamp_s1_address,
                                    timer_stamp_s1_chipselect,
                                    timer_stamp_s1_irq_from_sa,
                                    timer_stamp_s1_readdata_from_sa,
                                    timer_stamp_s1_reset_n,
                                    timer_stamp_s1_write_n,
                                    timer_stamp_s1_writedata
                                 )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_timer_stamp_s1;
  output           cpu_data_master_qualified_request_timer_stamp_s1;
  output           cpu_data_master_read_data_valid_timer_stamp_s1;
  output           cpu_data_master_requests_timer_stamp_s1;
  output           d1_timer_stamp_s1_end_xfer;
  output  [  2: 0] timer_stamp_s1_address;
  output           timer_stamp_s1_chipselect;
  output           timer_stamp_s1_irq_from_sa;
  output  [ 15: 0] timer_stamp_s1_readdata_from_sa;
  output           timer_stamp_s1_reset_n;
  output           timer_stamp_s1_write_n;
  output  [ 15: 0] timer_stamp_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;
  input            timer_stamp_s1_irq;
  input   [ 15: 0] timer_stamp_s1_readdata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_timer_stamp_s1;
  wire             cpu_data_master_qualified_request_timer_stamp_s1;
  wire             cpu_data_master_read_data_valid_timer_stamp_s1;
  wire             cpu_data_master_requests_timer_stamp_s1;
  wire             cpu_data_master_saved_grant_timer_stamp_s1;
  reg              d1_reasons_to_wait;
  reg              d1_timer_stamp_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_timer_stamp_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_timer_stamp_s1_from_cpu_data_master;
  wire    [  2: 0] timer_stamp_s1_address;
  wire             timer_stamp_s1_allgrants;
  wire             timer_stamp_s1_allow_new_arb_cycle;
  wire             timer_stamp_s1_any_bursting_master_saved_grant;
  wire             timer_stamp_s1_any_continuerequest;
  wire             timer_stamp_s1_arb_counter_enable;
  reg     [  1: 0] timer_stamp_s1_arb_share_counter;
  wire    [  1: 0] timer_stamp_s1_arb_share_counter_next_value;
  wire    [  1: 0] timer_stamp_s1_arb_share_set_values;
  wire             timer_stamp_s1_beginbursttransfer_internal;
  wire             timer_stamp_s1_begins_xfer;
  wire             timer_stamp_s1_chipselect;
  wire             timer_stamp_s1_end_xfer;
  wire             timer_stamp_s1_firsttransfer;
  wire             timer_stamp_s1_grant_vector;
  wire             timer_stamp_s1_in_a_read_cycle;
  wire             timer_stamp_s1_in_a_write_cycle;
  wire             timer_stamp_s1_irq_from_sa;
  wire             timer_stamp_s1_master_qreq_vector;
  wire             timer_stamp_s1_non_bursting_master_requests;
  wire    [ 15: 0] timer_stamp_s1_readdata_from_sa;
  reg              timer_stamp_s1_reg_firsttransfer;
  wire             timer_stamp_s1_reset_n;
  reg              timer_stamp_s1_slavearbiterlockenable;
  wire             timer_stamp_s1_slavearbiterlockenable2;
  wire             timer_stamp_s1_unreg_firsttransfer;
  wire             timer_stamp_s1_waits_for_read;
  wire             timer_stamp_s1_waits_for_write;
  wire             timer_stamp_s1_write_n;
  wire    [ 15: 0] timer_stamp_s1_writedata;
  wire             wait_for_timer_stamp_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~timer_stamp_s1_end_xfer;
    end


  assign timer_stamp_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_timer_stamp_s1));
  //assign timer_stamp_s1_readdata_from_sa = timer_stamp_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_stamp_s1_readdata_from_sa = timer_stamp_s1_readdata;

  assign cpu_data_master_requests_timer_stamp_s1 = ({cpu_data_master_address_to_slave[27 : 5] , 5'b0} == 28'h96410a0) & (cpu_data_master_read | cpu_data_master_write);
  //timer_stamp_s1_arb_share_counter set values, which is an e_mux
  assign timer_stamp_s1_arb_share_set_values = 1;

  //timer_stamp_s1_non_bursting_master_requests mux, which is an e_mux
  assign timer_stamp_s1_non_bursting_master_requests = cpu_data_master_requests_timer_stamp_s1;

  //timer_stamp_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign timer_stamp_s1_any_bursting_master_saved_grant = 0;

  //timer_stamp_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign timer_stamp_s1_arb_share_counter_next_value = timer_stamp_s1_firsttransfer ? (timer_stamp_s1_arb_share_set_values - 1) : |timer_stamp_s1_arb_share_counter ? (timer_stamp_s1_arb_share_counter - 1) : 0;

  //timer_stamp_s1_allgrants all slave grants, which is an e_mux
  assign timer_stamp_s1_allgrants = |timer_stamp_s1_grant_vector;

  //timer_stamp_s1_end_xfer assignment, which is an e_assign
  assign timer_stamp_s1_end_xfer = ~(timer_stamp_s1_waits_for_read | timer_stamp_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_timer_stamp_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_timer_stamp_s1 = timer_stamp_s1_end_xfer & (~timer_stamp_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //timer_stamp_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign timer_stamp_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_timer_stamp_s1 & timer_stamp_s1_allgrants) | (end_xfer_arb_share_counter_term_timer_stamp_s1 & ~timer_stamp_s1_non_bursting_master_requests);

  //timer_stamp_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_stamp_s1_arb_share_counter <= 0;
      else if (timer_stamp_s1_arb_counter_enable)
          timer_stamp_s1_arb_share_counter <= timer_stamp_s1_arb_share_counter_next_value;
    end


  //timer_stamp_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_stamp_s1_slavearbiterlockenable <= 0;
      else if ((|timer_stamp_s1_master_qreq_vector & end_xfer_arb_share_counter_term_timer_stamp_s1) | (end_xfer_arb_share_counter_term_timer_stamp_s1 & ~timer_stamp_s1_non_bursting_master_requests))
          timer_stamp_s1_slavearbiterlockenable <= |timer_stamp_s1_arb_share_counter_next_value;
    end


  //cpu/data_master timer_stamp/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = timer_stamp_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //timer_stamp_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign timer_stamp_s1_slavearbiterlockenable2 = |timer_stamp_s1_arb_share_counter_next_value;

  //cpu/data_master timer_stamp/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = timer_stamp_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //timer_stamp_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign timer_stamp_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_timer_stamp_s1 = cpu_data_master_requests_timer_stamp_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_timer_stamp_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_timer_stamp_s1 = cpu_data_master_granted_timer_stamp_s1 & cpu_data_master_read & ~timer_stamp_s1_waits_for_read;

  //timer_stamp_s1_writedata mux, which is an e_mux
  assign timer_stamp_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_timer_stamp_s1 = cpu_data_master_qualified_request_timer_stamp_s1;

  //cpu/data_master saved-grant timer_stamp/s1, which is an e_assign
  assign cpu_data_master_saved_grant_timer_stamp_s1 = cpu_data_master_requests_timer_stamp_s1;

  //allow new arb cycle for timer_stamp/s1, which is an e_assign
  assign timer_stamp_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign timer_stamp_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign timer_stamp_s1_master_qreq_vector = 1;

  //timer_stamp_s1_reset_n assignment, which is an e_assign
  assign timer_stamp_s1_reset_n = reset_n;

  assign timer_stamp_s1_chipselect = cpu_data_master_granted_timer_stamp_s1;
  //timer_stamp_s1_firsttransfer first transaction, which is an e_assign
  assign timer_stamp_s1_firsttransfer = timer_stamp_s1_begins_xfer ? timer_stamp_s1_unreg_firsttransfer : timer_stamp_s1_reg_firsttransfer;

  //timer_stamp_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign timer_stamp_s1_unreg_firsttransfer = ~(timer_stamp_s1_slavearbiterlockenable & timer_stamp_s1_any_continuerequest);

  //timer_stamp_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_stamp_s1_reg_firsttransfer <= 1'b1;
      else if (timer_stamp_s1_begins_xfer)
          timer_stamp_s1_reg_firsttransfer <= timer_stamp_s1_unreg_firsttransfer;
    end


  //timer_stamp_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign timer_stamp_s1_beginbursttransfer_internal = timer_stamp_s1_begins_xfer;

  //~timer_stamp_s1_write_n assignment, which is an e_mux
  assign timer_stamp_s1_write_n = ~(cpu_data_master_granted_timer_stamp_s1 & cpu_data_master_write);

  assign shifted_address_to_timer_stamp_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //timer_stamp_s1_address mux, which is an e_mux
  assign timer_stamp_s1_address = shifted_address_to_timer_stamp_s1_from_cpu_data_master >> 2;

  //d1_timer_stamp_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_timer_stamp_s1_end_xfer <= 1;
      else if (1)
          d1_timer_stamp_s1_end_xfer <= timer_stamp_s1_end_xfer;
    end


  //timer_stamp_s1_waits_for_read in a cycle, which is an e_mux
  assign timer_stamp_s1_waits_for_read = timer_stamp_s1_in_a_read_cycle & timer_stamp_s1_begins_xfer;

  //timer_stamp_s1_in_a_read_cycle assignment, which is an e_assign
  assign timer_stamp_s1_in_a_read_cycle = cpu_data_master_granted_timer_stamp_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = timer_stamp_s1_in_a_read_cycle;

  //timer_stamp_s1_waits_for_write in a cycle, which is an e_mux
  assign timer_stamp_s1_waits_for_write = timer_stamp_s1_in_a_write_cycle & 0;

  //timer_stamp_s1_in_a_write_cycle assignment, which is an e_assign
  assign timer_stamp_s1_in_a_write_cycle = cpu_data_master_granted_timer_stamp_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = timer_stamp_s1_in_a_write_cycle;

  assign wait_for_timer_stamp_s1_counter = 0;
  //assign timer_stamp_s1_irq_from_sa = timer_stamp_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_stamp_s1_irq_from_sa = timer_stamp_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //timer_stamp/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module tristate_bridge_flash_avalon_slave_arbitrator (
                                                       // inputs:
                                                        clk,
                                                        cpu_data_master_address_to_slave,
                                                        cpu_data_master_byteenable,
                                                        cpu_data_master_dbs_address,
                                                        cpu_data_master_dbs_write_16,
                                                        cpu_data_master_latency_counter,
                                                        cpu_data_master_read,
                                                        cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                                        cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                                        cpu_data_master_write,
                                                        cpu_instruction_master_address_to_slave,
                                                        cpu_instruction_master_dbs_address,
                                                        cpu_instruction_master_latency_counter,
                                                        cpu_instruction_master_read,
                                                        cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register,
                                                        cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register,
                                                        reset_n,

                                                       // outputs:
                                                        address_to_the_cfi_flash,
                                                        cfi_flash_s1_wait_counter_eq_0,
                                                        cpu_data_master_byteenable_cfi_flash_s1,
                                                        cpu_data_master_granted_cfi_flash_s1,
                                                        cpu_data_master_qualified_request_cfi_flash_s1,
                                                        cpu_data_master_read_data_valid_cfi_flash_s1,
                                                        cpu_data_master_requests_cfi_flash_s1,
                                                        cpu_instruction_master_granted_cfi_flash_s1,
                                                        cpu_instruction_master_qualified_request_cfi_flash_s1,
                                                        cpu_instruction_master_read_data_valid_cfi_flash_s1,
                                                        cpu_instruction_master_requests_cfi_flash_s1,
                                                        d1_tristate_bridge_flash_avalon_slave_end_xfer,
                                                        data_to_and_from_the_cfi_flash,
                                                        incoming_data_to_and_from_the_cfi_flash,
                                                        incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0,
                                                        read_n_to_the_cfi_flash,
                                                        select_n_to_the_cfi_flash,
                                                        write_n_to_the_cfi_flash
                                                     )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output  [ 22: 0] address_to_the_cfi_flash;
  output           cfi_flash_s1_wait_counter_eq_0;
  output  [  1: 0] cpu_data_master_byteenable_cfi_flash_s1;
  output           cpu_data_master_granted_cfi_flash_s1;
  output           cpu_data_master_qualified_request_cfi_flash_s1;
  output           cpu_data_master_read_data_valid_cfi_flash_s1;
  output           cpu_data_master_requests_cfi_flash_s1;
  output           cpu_instruction_master_granted_cfi_flash_s1;
  output           cpu_instruction_master_qualified_request_cfi_flash_s1;
  output           cpu_instruction_master_read_data_valid_cfi_flash_s1;
  output           cpu_instruction_master_requests_cfi_flash_s1;
  output           d1_tristate_bridge_flash_avalon_slave_end_xfer;
  inout   [ 15: 0] data_to_and_from_the_cfi_flash;
  output  [ 15: 0] incoming_data_to_and_from_the_cfi_flash;
  output  [ 15: 0] incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0;
  output           read_n_to_the_cfi_flash;
  output           select_n_to_the_cfi_flash;
  output           write_n_to_the_cfi_flash;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input   [  1: 0] cpu_data_master_dbs_address;
  input   [ 15: 0] cpu_data_master_dbs_write_16;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 27: 0] cpu_instruction_master_address_to_slave;
  input   [  1: 0] cpu_instruction_master_dbs_address;
  input   [  2: 0] cpu_instruction_master_latency_counter;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register;
  input            reset_n;

  reg     [ 22: 0] address_to_the_cfi_flash /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
  wire    [  3: 0] cfi_flash_s1_counter_load_value;
  wire             cfi_flash_s1_in_a_read_cycle;
  wire             cfi_flash_s1_in_a_write_cycle;
  reg     [  3: 0] cfi_flash_s1_wait_counter;
  wire             cfi_flash_s1_wait_counter_eq_0;
  wire             cfi_flash_s1_waits_for_read;
  wire             cfi_flash_s1_waits_for_write;
  wire             cfi_flash_s1_with_write_latency;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire    [  1: 0] cpu_data_master_byteenable_cfi_flash_s1;
  wire    [  1: 0] cpu_data_master_byteenable_cfi_flash_s1_segment_0;
  wire    [  1: 0] cpu_data_master_byteenable_cfi_flash_s1_segment_1;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_cfi_flash_s1;
  wire             cpu_data_master_qualified_request_cfi_flash_s1;
  wire             cpu_data_master_read_data_valid_cfi_flash_s1;
  reg     [  1: 0] cpu_data_master_read_data_valid_cfi_flash_s1_shift_register;
  wire             cpu_data_master_read_data_valid_cfi_flash_s1_shift_register_in;
  wire             cpu_data_master_requests_cfi_flash_s1;
  wire             cpu_data_master_saved_grant_cfi_flash_s1;
  wire             cpu_instruction_master_arbiterlock;
  wire             cpu_instruction_master_arbiterlock2;
  wire             cpu_instruction_master_continuerequest;
  wire             cpu_instruction_master_granted_cfi_flash_s1;
  wire             cpu_instruction_master_qualified_request_cfi_flash_s1;
  wire             cpu_instruction_master_read_data_valid_cfi_flash_s1;
  reg     [  1: 0] cpu_instruction_master_read_data_valid_cfi_flash_s1_shift_register;
  wire             cpu_instruction_master_read_data_valid_cfi_flash_s1_shift_register_in;
  wire             cpu_instruction_master_requests_cfi_flash_s1;
  wire             cpu_instruction_master_saved_grant_cfi_flash_s1;
  reg              d1_in_a_write_cycle /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_ENABLE_REGISTER=ON"  */;
  reg     [ 15: 0] d1_outgoing_data_to_and_from_the_cfi_flash /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
  reg              d1_reasons_to_wait;
  reg              d1_tristate_bridge_flash_avalon_slave_end_xfer;
  wire    [ 15: 0] data_to_and_from_the_cfi_flash;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_tristate_bridge_flash_avalon_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg     [ 15: 0] incoming_data_to_and_from_the_cfi_flash /* synthesis ALTERA_ATTRIBUTE = "FAST_INPUT_REGISTER=ON"  */;
  wire             incoming_data_to_and_from_the_cfi_flash_bit_0_is_x;
  wire             incoming_data_to_and_from_the_cfi_flash_bit_10_is_x;
  wire             incoming_data_to_and_from_the_cfi_flash_bit_11_is_x;
  wire             incoming_data_to_and_from_the_cfi_flash_bit_12_is_x;
  wire             incoming_data_to_and_from_the_cfi_flash_bit_13_is_x;
  wire             incoming_data_to_and_from_the_cfi_flash_bit_14_is_x;
  wire             incoming_data_to_and_from_the_cfi_flash_bit_15_is_x;
  wire             incoming_data_to_and_from_the_cfi_flash_bit_1_is_x;
  wire             incoming_data_to_and_from_the_cfi_flash_bit_2_is_x;
  wire             incoming_data_to_and_from_the_cfi_flash_bit_3_is_x;
  wire             incoming_data_to_and_from_the_cfi_flash_bit_4_is_x;
  wire             incoming_data_to_and_from_the_cfi_flash_bit_5_is_x;
  wire             incoming_data_to_and_from_the_cfi_flash_bit_6_is_x;
  wire             incoming_data_to_and_from_the_cfi_flash_bit_7_is_x;
  wire             incoming_data_to_and_from_the_cfi_flash_bit_8_is_x;
  wire             incoming_data_to_and_from_the_cfi_flash_bit_9_is_x;
  wire    [ 15: 0] incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0;
  reg              last_cycle_cpu_data_master_granted_slave_cfi_flash_s1;
  reg              last_cycle_cpu_instruction_master_granted_slave_cfi_flash_s1;
  wire    [ 15: 0] outgoing_data_to_and_from_the_cfi_flash;
  wire    [ 22: 0] p1_address_to_the_cfi_flash;
  wire    [  1: 0] p1_cpu_data_master_read_data_valid_cfi_flash_s1_shift_register;
  wire    [  1: 0] p1_cpu_instruction_master_read_data_valid_cfi_flash_s1_shift_register;
  wire             p1_read_n_to_the_cfi_flash;
  wire             p1_select_n_to_the_cfi_flash;
  wire             p1_write_n_to_the_cfi_flash;
  reg              read_n_to_the_cfi_flash /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
  reg              select_n_to_the_cfi_flash /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
  wire             time_to_write;
  wire             tristate_bridge_flash_avalon_slave_allgrants;
  wire             tristate_bridge_flash_avalon_slave_allow_new_arb_cycle;
  wire             tristate_bridge_flash_avalon_slave_any_bursting_master_saved_grant;
  wire             tristate_bridge_flash_avalon_slave_any_continuerequest;
  reg     [  1: 0] tristate_bridge_flash_avalon_slave_arb_addend;
  wire             tristate_bridge_flash_avalon_slave_arb_counter_enable;
  reg     [  1: 0] tristate_bridge_flash_avalon_slave_arb_share_counter;
  wire    [  1: 0] tristate_bridge_flash_avalon_slave_arb_share_counter_next_value;
  wire    [  1: 0] tristate_bridge_flash_avalon_slave_arb_share_set_values;
  wire    [  1: 0] tristate_bridge_flash_avalon_slave_arb_winner;
  wire             tristate_bridge_flash_avalon_slave_arbitration_holdoff_internal;
  wire             tristate_bridge_flash_avalon_slave_beginbursttransfer_internal;
  wire             tristate_bridge_flash_avalon_slave_begins_xfer;
  wire    [  3: 0] tristate_bridge_flash_avalon_slave_chosen_master_double_vector;
  wire    [  1: 0] tristate_bridge_flash_avalon_slave_chosen_master_rot_left;
  wire             tristate_bridge_flash_avalon_slave_end_xfer;
  wire             tristate_bridge_flash_avalon_slave_firsttransfer;
  wire    [  1: 0] tristate_bridge_flash_avalon_slave_grant_vector;
  wire    [  1: 0] tristate_bridge_flash_avalon_slave_master_qreq_vector;
  wire             tristate_bridge_flash_avalon_slave_non_bursting_master_requests;
  wire             tristate_bridge_flash_avalon_slave_read_pending;
  reg              tristate_bridge_flash_avalon_slave_reg_firsttransfer;
  reg     [  1: 0] tristate_bridge_flash_avalon_slave_saved_chosen_master_vector;
  reg              tristate_bridge_flash_avalon_slave_slavearbiterlockenable;
  wire             tristate_bridge_flash_avalon_slave_slavearbiterlockenable2;
  wire             tristate_bridge_flash_avalon_slave_unreg_firsttransfer;
  wire             tristate_bridge_flash_avalon_slave_write_pending;
  wire             wait_for_cfi_flash_s1_counter;
  reg              write_n_to_the_cfi_flash /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~tristate_bridge_flash_avalon_slave_end_xfer;
    end


  assign tristate_bridge_flash_avalon_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_cfi_flash_s1 | cpu_instruction_master_qualified_request_cfi_flash_s1));
  assign cpu_data_master_requests_cfi_flash_s1 = ({cpu_data_master_address_to_slave[27 : 23] , 23'b0} == 28'h8800000) & (cpu_data_master_read | cpu_data_master_write);
  //~select_n_to_the_cfi_flash of type chipselect to ~p1_select_n_to_the_cfi_flash, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          select_n_to_the_cfi_flash <= ~0;
      else if (1)
          select_n_to_the_cfi_flash <= p1_select_n_to_the_cfi_flash;
    end


  assign tristate_bridge_flash_avalon_slave_write_pending = 0;
  //tristate_bridge_flash/avalon_slave read pending calc, which is an e_assign
  assign tristate_bridge_flash_avalon_slave_read_pending = 0;

  //tristate_bridge_flash_avalon_slave_arb_share_counter set values, which is an e_mux
  assign tristate_bridge_flash_avalon_slave_arb_share_set_values = (cpu_data_master_granted_cfi_flash_s1)? 2 :
    (cpu_instruction_master_granted_cfi_flash_s1)? 2 :
    (cpu_data_master_granted_cfi_flash_s1)? 2 :
    (cpu_instruction_master_granted_cfi_flash_s1)? 2 :
    1;

  //tristate_bridge_flash_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  assign tristate_bridge_flash_avalon_slave_non_bursting_master_requests = cpu_data_master_requests_cfi_flash_s1 |
    cpu_instruction_master_requests_cfi_flash_s1 |
    cpu_data_master_requests_cfi_flash_s1 |
    cpu_instruction_master_requests_cfi_flash_s1;

  //tristate_bridge_flash_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign tristate_bridge_flash_avalon_slave_any_bursting_master_saved_grant = 0;

  //tristate_bridge_flash_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign tristate_bridge_flash_avalon_slave_arb_share_counter_next_value = tristate_bridge_flash_avalon_slave_firsttransfer ? (tristate_bridge_flash_avalon_slave_arb_share_set_values - 1) : |tristate_bridge_flash_avalon_slave_arb_share_counter ? (tristate_bridge_flash_avalon_slave_arb_share_counter - 1) : 0;

  //tristate_bridge_flash_avalon_slave_allgrants all slave grants, which is an e_mux
  assign tristate_bridge_flash_avalon_slave_allgrants = |tristate_bridge_flash_avalon_slave_grant_vector |
    |tristate_bridge_flash_avalon_slave_grant_vector |
    |tristate_bridge_flash_avalon_slave_grant_vector |
    |tristate_bridge_flash_avalon_slave_grant_vector;

  //tristate_bridge_flash_avalon_slave_end_xfer assignment, which is an e_assign
  assign tristate_bridge_flash_avalon_slave_end_xfer = ~(cfi_flash_s1_waits_for_read | cfi_flash_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_tristate_bridge_flash_avalon_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_tristate_bridge_flash_avalon_slave = tristate_bridge_flash_avalon_slave_end_xfer & (~tristate_bridge_flash_avalon_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //tristate_bridge_flash_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign tristate_bridge_flash_avalon_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_tristate_bridge_flash_avalon_slave & tristate_bridge_flash_avalon_slave_allgrants) | (end_xfer_arb_share_counter_term_tristate_bridge_flash_avalon_slave & ~tristate_bridge_flash_avalon_slave_non_bursting_master_requests);

  //tristate_bridge_flash_avalon_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tristate_bridge_flash_avalon_slave_arb_share_counter <= 0;
      else if (tristate_bridge_flash_avalon_slave_arb_counter_enable)
          tristate_bridge_flash_avalon_slave_arb_share_counter <= tristate_bridge_flash_avalon_slave_arb_share_counter_next_value;
    end


  //tristate_bridge_flash_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tristate_bridge_flash_avalon_slave_slavearbiterlockenable <= 0;
      else if ((|tristate_bridge_flash_avalon_slave_master_qreq_vector & end_xfer_arb_share_counter_term_tristate_bridge_flash_avalon_slave) | (end_xfer_arb_share_counter_term_tristate_bridge_flash_avalon_slave & ~tristate_bridge_flash_avalon_slave_non_bursting_master_requests))
          tristate_bridge_flash_avalon_slave_slavearbiterlockenable <= |tristate_bridge_flash_avalon_slave_arb_share_counter_next_value;
    end


  //cpu/data_master tristate_bridge_flash/avalon_slave arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = tristate_bridge_flash_avalon_slave_slavearbiterlockenable & cpu_data_master_continuerequest;

  //tristate_bridge_flash_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign tristate_bridge_flash_avalon_slave_slavearbiterlockenable2 = |tristate_bridge_flash_avalon_slave_arb_share_counter_next_value;

  //cpu/data_master tristate_bridge_flash/avalon_slave arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = tristate_bridge_flash_avalon_slave_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //cpu/instruction_master tristate_bridge_flash/avalon_slave arbiterlock, which is an e_assign
  assign cpu_instruction_master_arbiterlock = tristate_bridge_flash_avalon_slave_slavearbiterlockenable & cpu_instruction_master_continuerequest;

  //cpu/instruction_master tristate_bridge_flash/avalon_slave arbiterlock2, which is an e_assign
  assign cpu_instruction_master_arbiterlock2 = tristate_bridge_flash_avalon_slave_slavearbiterlockenable2 & cpu_instruction_master_continuerequest;

  //cpu/instruction_master granted cfi_flash/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_instruction_master_granted_slave_cfi_flash_s1 <= 0;
      else if (1)
          last_cycle_cpu_instruction_master_granted_slave_cfi_flash_s1 <= cpu_instruction_master_saved_grant_cfi_flash_s1 ? 1 : (tristate_bridge_flash_avalon_slave_arbitration_holdoff_internal | ~cpu_instruction_master_requests_cfi_flash_s1) ? 0 : last_cycle_cpu_instruction_master_granted_slave_cfi_flash_s1;
    end


  //cpu_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_instruction_master_continuerequest = last_cycle_cpu_instruction_master_granted_slave_cfi_flash_s1 & cpu_instruction_master_requests_cfi_flash_s1;

  //tristate_bridge_flash_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_mux
  assign tristate_bridge_flash_avalon_slave_any_continuerequest = cpu_instruction_master_continuerequest |
    cpu_data_master_continuerequest;

  assign cpu_data_master_qualified_request_cfi_flash_s1 = cpu_data_master_requests_cfi_flash_s1 & ~((cpu_data_master_read & (tristate_bridge_flash_avalon_slave_write_pending | (tristate_bridge_flash_avalon_slave_read_pending) | (2 < cpu_data_master_latency_counter) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))) | ((tristate_bridge_flash_avalon_slave_read_pending | !cpu_data_master_byteenable_cfi_flash_s1) & cpu_data_master_write) | cpu_instruction_master_arbiterlock);
  //cpu_data_master_read_data_valid_cfi_flash_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_data_master_read_data_valid_cfi_flash_s1_shift_register_in = cpu_data_master_granted_cfi_flash_s1 & cpu_data_master_read & ~cfi_flash_s1_waits_for_read;

  //shift register p1 cpu_data_master_read_data_valid_cfi_flash_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_data_master_read_data_valid_cfi_flash_s1_shift_register = {cpu_data_master_read_data_valid_cfi_flash_s1_shift_register, cpu_data_master_read_data_valid_cfi_flash_s1_shift_register_in};

  //cpu_data_master_read_data_valid_cfi_flash_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_read_data_valid_cfi_flash_s1_shift_register <= 0;
      else if (1)
          cpu_data_master_read_data_valid_cfi_flash_s1_shift_register <= p1_cpu_data_master_read_data_valid_cfi_flash_s1_shift_register;
    end


  //local readdatavalid cpu_data_master_read_data_valid_cfi_flash_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_cfi_flash_s1 = cpu_data_master_read_data_valid_cfi_flash_s1_shift_register[1];

  //data_to_and_from_the_cfi_flash register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          incoming_data_to_and_from_the_cfi_flash <= 0;
      else if (1)
          incoming_data_to_and_from_the_cfi_flash <= data_to_and_from_the_cfi_flash;
    end


  //cfi_flash_s1_with_write_latency assignment, which is an e_assign
  assign cfi_flash_s1_with_write_latency = in_a_write_cycle & (cpu_data_master_qualified_request_cfi_flash_s1 | cpu_instruction_master_qualified_request_cfi_flash_s1);

  //time to write the data, which is an e_mux
  assign time_to_write = (cfi_flash_s1_with_write_latency)? 1 :
    0;

  //d1_outgoing_data_to_and_from_the_cfi_flash register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_outgoing_data_to_and_from_the_cfi_flash <= 0;
      else if (1)
          d1_outgoing_data_to_and_from_the_cfi_flash <= outgoing_data_to_and_from_the_cfi_flash;
    end


  //write cycle delayed by 1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_in_a_write_cycle <= 0;
      else if (1)
          d1_in_a_write_cycle <= time_to_write;
    end


  //d1_outgoing_data_to_and_from_the_cfi_flash tristate driver, which is an e_assign
  assign data_to_and_from_the_cfi_flash = (d1_in_a_write_cycle)? d1_outgoing_data_to_and_from_the_cfi_flash:{16{1'bz}};

  //outgoing_data_to_and_from_the_cfi_flash mux, which is an e_mux
  assign outgoing_data_to_and_from_the_cfi_flash = cpu_data_master_dbs_write_16;

  assign cpu_instruction_master_requests_cfi_flash_s1 = (({cpu_instruction_master_address_to_slave[27 : 23] , 23'b0} == 28'h8800000) & (cpu_instruction_master_read)) & cpu_instruction_master_read;
  //cpu/data_master granted cfi_flash/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_data_master_granted_slave_cfi_flash_s1 <= 0;
      else if (1)
          last_cycle_cpu_data_master_granted_slave_cfi_flash_s1 <= cpu_data_master_saved_grant_cfi_flash_s1 ? 1 : (tristate_bridge_flash_avalon_slave_arbitration_holdoff_internal | ~cpu_data_master_requests_cfi_flash_s1) ? 0 : last_cycle_cpu_data_master_granted_slave_cfi_flash_s1;
    end


  //cpu_data_master_continuerequest continued request, which is an e_mux
  assign cpu_data_master_continuerequest = last_cycle_cpu_data_master_granted_slave_cfi_flash_s1 & cpu_data_master_requests_cfi_flash_s1;

  assign cpu_instruction_master_qualified_request_cfi_flash_s1 = cpu_instruction_master_requests_cfi_flash_s1 & ~((cpu_instruction_master_read & (tristate_bridge_flash_avalon_slave_write_pending | (tristate_bridge_flash_avalon_slave_read_pending) | (2 < cpu_instruction_master_latency_counter) | (|cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register))) | cpu_data_master_arbiterlock);
  //cpu_instruction_master_read_data_valid_cfi_flash_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_instruction_master_read_data_valid_cfi_flash_s1_shift_register_in = cpu_instruction_master_granted_cfi_flash_s1 & cpu_instruction_master_read & ~cfi_flash_s1_waits_for_read;

  //shift register p1 cpu_instruction_master_read_data_valid_cfi_flash_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_instruction_master_read_data_valid_cfi_flash_s1_shift_register = {cpu_instruction_master_read_data_valid_cfi_flash_s1_shift_register, cpu_instruction_master_read_data_valid_cfi_flash_s1_shift_register_in};

  //cpu_instruction_master_read_data_valid_cfi_flash_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_read_data_valid_cfi_flash_s1_shift_register <= 0;
      else if (1)
          cpu_instruction_master_read_data_valid_cfi_flash_s1_shift_register <= p1_cpu_instruction_master_read_data_valid_cfi_flash_s1_shift_register;
    end


  //local readdatavalid cpu_instruction_master_read_data_valid_cfi_flash_s1, which is an e_mux
  assign cpu_instruction_master_read_data_valid_cfi_flash_s1 = cpu_instruction_master_read_data_valid_cfi_flash_s1_shift_register[1];

  //allow new arb cycle for tristate_bridge_flash/avalon_slave, which is an e_assign
  assign tristate_bridge_flash_avalon_slave_allow_new_arb_cycle = ~cpu_data_master_arbiterlock & ~cpu_instruction_master_arbiterlock;

  //cpu/instruction_master assignment into master qualified-requests vector for cfi_flash/s1, which is an e_assign
  assign tristate_bridge_flash_avalon_slave_master_qreq_vector[0] = cpu_instruction_master_qualified_request_cfi_flash_s1;

  //cpu/instruction_master grant cfi_flash/s1, which is an e_assign
  assign cpu_instruction_master_granted_cfi_flash_s1 = tristate_bridge_flash_avalon_slave_grant_vector[0];

  //cpu/instruction_master saved-grant cfi_flash/s1, which is an e_assign
  assign cpu_instruction_master_saved_grant_cfi_flash_s1 = tristate_bridge_flash_avalon_slave_arb_winner[0] && cpu_instruction_master_requests_cfi_flash_s1;

  //cpu/data_master assignment into master qualified-requests vector for cfi_flash/s1, which is an e_assign
  assign tristate_bridge_flash_avalon_slave_master_qreq_vector[1] = cpu_data_master_qualified_request_cfi_flash_s1;

  //cpu/data_master grant cfi_flash/s1, which is an e_assign
  assign cpu_data_master_granted_cfi_flash_s1 = tristate_bridge_flash_avalon_slave_grant_vector[1];

  //cpu/data_master saved-grant cfi_flash/s1, which is an e_assign
  assign cpu_data_master_saved_grant_cfi_flash_s1 = tristate_bridge_flash_avalon_slave_arb_winner[1] && cpu_data_master_requests_cfi_flash_s1;

  //tristate_bridge_flash/avalon_slave chosen-master double-vector, which is an e_assign
  assign tristate_bridge_flash_avalon_slave_chosen_master_double_vector = {tristate_bridge_flash_avalon_slave_master_qreq_vector, tristate_bridge_flash_avalon_slave_master_qreq_vector} & ({~tristate_bridge_flash_avalon_slave_master_qreq_vector, ~tristate_bridge_flash_avalon_slave_master_qreq_vector} + tristate_bridge_flash_avalon_slave_arb_addend);

  //stable onehot encoding of arb winner
  assign tristate_bridge_flash_avalon_slave_arb_winner = (tristate_bridge_flash_avalon_slave_allow_new_arb_cycle & | tristate_bridge_flash_avalon_slave_grant_vector) ? tristate_bridge_flash_avalon_slave_grant_vector : tristate_bridge_flash_avalon_slave_saved_chosen_master_vector;

  //saved tristate_bridge_flash_avalon_slave_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tristate_bridge_flash_avalon_slave_saved_chosen_master_vector <= 0;
      else if (tristate_bridge_flash_avalon_slave_allow_new_arb_cycle)
          tristate_bridge_flash_avalon_slave_saved_chosen_master_vector <= |tristate_bridge_flash_avalon_slave_grant_vector ? tristate_bridge_flash_avalon_slave_grant_vector : tristate_bridge_flash_avalon_slave_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign tristate_bridge_flash_avalon_slave_grant_vector = {(tristate_bridge_flash_avalon_slave_chosen_master_double_vector[1] | tristate_bridge_flash_avalon_slave_chosen_master_double_vector[3]),
    (tristate_bridge_flash_avalon_slave_chosen_master_double_vector[0] | tristate_bridge_flash_avalon_slave_chosen_master_double_vector[2])};

  //tristate_bridge_flash/avalon_slave chosen master rotated left, which is an e_assign
  assign tristate_bridge_flash_avalon_slave_chosen_master_rot_left = (tristate_bridge_flash_avalon_slave_arb_winner << 1) ? (tristate_bridge_flash_avalon_slave_arb_winner << 1) : 1;

  //tristate_bridge_flash/avalon_slave's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tristate_bridge_flash_avalon_slave_arb_addend <= 1;
      else if (|tristate_bridge_flash_avalon_slave_grant_vector)
          tristate_bridge_flash_avalon_slave_arb_addend <= tristate_bridge_flash_avalon_slave_end_xfer? tristate_bridge_flash_avalon_slave_chosen_master_rot_left : tristate_bridge_flash_avalon_slave_grant_vector;
    end


  assign p1_select_n_to_the_cfi_flash = ~(cpu_data_master_granted_cfi_flash_s1 | cpu_instruction_master_granted_cfi_flash_s1);
  //tristate_bridge_flash_avalon_slave_firsttransfer first transaction, which is an e_assign
  assign tristate_bridge_flash_avalon_slave_firsttransfer = tristate_bridge_flash_avalon_slave_begins_xfer ? tristate_bridge_flash_avalon_slave_unreg_firsttransfer : tristate_bridge_flash_avalon_slave_reg_firsttransfer;

  //tristate_bridge_flash_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign tristate_bridge_flash_avalon_slave_unreg_firsttransfer = ~(tristate_bridge_flash_avalon_slave_slavearbiterlockenable & tristate_bridge_flash_avalon_slave_any_continuerequest);

  //tristate_bridge_flash_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tristate_bridge_flash_avalon_slave_reg_firsttransfer <= 1'b1;
      else if (tristate_bridge_flash_avalon_slave_begins_xfer)
          tristate_bridge_flash_avalon_slave_reg_firsttransfer <= tristate_bridge_flash_avalon_slave_unreg_firsttransfer;
    end


  //tristate_bridge_flash_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign tristate_bridge_flash_avalon_slave_beginbursttransfer_internal = tristate_bridge_flash_avalon_slave_begins_xfer;

  //tristate_bridge_flash_avalon_slave_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign tristate_bridge_flash_avalon_slave_arbitration_holdoff_internal = tristate_bridge_flash_avalon_slave_begins_xfer & tristate_bridge_flash_avalon_slave_firsttransfer;

  //~read_n_to_the_cfi_flash of type read to ~p1_read_n_to_the_cfi_flash, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          read_n_to_the_cfi_flash <= ~0;
      else if (1)
          read_n_to_the_cfi_flash <= p1_read_n_to_the_cfi_flash;
    end


  //~p1_read_n_to_the_cfi_flash assignment, which is an e_mux
  assign p1_read_n_to_the_cfi_flash = ~((cpu_data_master_granted_cfi_flash_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_cfi_flash_s1 & cpu_instruction_master_read));

  //~write_n_to_the_cfi_flash of type write to ~p1_write_n_to_the_cfi_flash, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          write_n_to_the_cfi_flash <= ~0;
      else if (1)
          write_n_to_the_cfi_flash <= p1_write_n_to_the_cfi_flash;
    end


  //~p1_write_n_to_the_cfi_flash assignment, which is an e_mux
  assign p1_write_n_to_the_cfi_flash = ~(cpu_data_master_granted_cfi_flash_s1 & cpu_data_master_write);

  //address_to_the_cfi_flash of type address to p1_address_to_the_cfi_flash, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          address_to_the_cfi_flash <= 0;
      else if (1)
          address_to_the_cfi_flash <= p1_address_to_the_cfi_flash;
    end


  //p1_address_to_the_cfi_flash mux, which is an e_mux
  assign p1_address_to_the_cfi_flash = (cpu_data_master_granted_cfi_flash_s1)? ({cpu_data_master_address_to_slave >> 2,
    cpu_data_master_dbs_address[1],
    {1 {1'b0}}}) :
    ({cpu_instruction_master_address_to_slave >> 2,
    cpu_instruction_master_dbs_address[1],
    {1 {1'b0}}});

  //d1_tristate_bridge_flash_avalon_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_tristate_bridge_flash_avalon_slave_end_xfer <= 1;
      else if (1)
          d1_tristate_bridge_flash_avalon_slave_end_xfer <= tristate_bridge_flash_avalon_slave_end_xfer;
    end


  //cfi_flash_s1_waits_for_read in a cycle, which is an e_mux
  assign cfi_flash_s1_waits_for_read = cfi_flash_s1_in_a_read_cycle & wait_for_cfi_flash_s1_counter;

  //cfi_flash_s1_in_a_read_cycle assignment, which is an e_assign
  assign cfi_flash_s1_in_a_read_cycle = (cpu_data_master_granted_cfi_flash_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_cfi_flash_s1 & cpu_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = cfi_flash_s1_in_a_read_cycle;

  //cfi_flash_s1_waits_for_write in a cycle, which is an e_mux
  assign cfi_flash_s1_waits_for_write = cfi_flash_s1_in_a_write_cycle & wait_for_cfi_flash_s1_counter;

  //cfi_flash_s1_in_a_write_cycle assignment, which is an e_assign
  assign cfi_flash_s1_in_a_write_cycle = cpu_data_master_granted_cfi_flash_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = cfi_flash_s1_in_a_write_cycle;

  assign cfi_flash_s1_wait_counter_eq_0 = cfi_flash_s1_wait_counter == 0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cfi_flash_s1_wait_counter <= 0;
      else if (1)
          cfi_flash_s1_wait_counter <= cfi_flash_s1_counter_load_value;
    end


  assign cfi_flash_s1_counter_load_value = ((cfi_flash_s1_in_a_read_cycle & tristate_bridge_flash_avalon_slave_begins_xfer))? 8 :
    ((cfi_flash_s1_in_a_write_cycle & tristate_bridge_flash_avalon_slave_begins_xfer))? 8 :
    (~cfi_flash_s1_wait_counter_eq_0)? cfi_flash_s1_wait_counter - 1 :
    0;

  assign wait_for_cfi_flash_s1_counter = tristate_bridge_flash_avalon_slave_begins_xfer | ~cfi_flash_s1_wait_counter_eq_0;
  assign {cpu_data_master_byteenable_cfi_flash_s1_segment_1,
cpu_data_master_byteenable_cfi_flash_s1_segment_0} = cpu_data_master_byteenable;
  assign cpu_data_master_byteenable_cfi_flash_s1 = ((cpu_data_master_dbs_address[1] == 0))? cpu_data_master_byteenable_cfi_flash_s1_segment_0 :
    cpu_data_master_byteenable_cfi_flash_s1_segment_1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //incoming_data_to_and_from_the_cfi_flash_bit_0_is_x x check, which is an e_assign_is_x
  assign incoming_data_to_and_from_the_cfi_flash_bit_0_is_x = ^(incoming_data_to_and_from_the_cfi_flash[0]) === 1'bx;

  //Crush incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[0] Xs to 0, which is an e_assign
  assign incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[0] = incoming_data_to_and_from_the_cfi_flash_bit_0_is_x ? 1'b0 : incoming_data_to_and_from_the_cfi_flash[0];

  //incoming_data_to_and_from_the_cfi_flash_bit_1_is_x x check, which is an e_assign_is_x
  assign incoming_data_to_and_from_the_cfi_flash_bit_1_is_x = ^(incoming_data_to_and_from_the_cfi_flash[1]) === 1'bx;

  //Crush incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[1] Xs to 0, which is an e_assign
  assign incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[1] = incoming_data_to_and_from_the_cfi_flash_bit_1_is_x ? 1'b0 : incoming_data_to_and_from_the_cfi_flash[1];

  //incoming_data_to_and_from_the_cfi_flash_bit_2_is_x x check, which is an e_assign_is_x
  assign incoming_data_to_and_from_the_cfi_flash_bit_2_is_x = ^(incoming_data_to_and_from_the_cfi_flash[2]) === 1'bx;

  //Crush incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[2] Xs to 0, which is an e_assign
  assign incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[2] = incoming_data_to_and_from_the_cfi_flash_bit_2_is_x ? 1'b0 : incoming_data_to_and_from_the_cfi_flash[2];

  //incoming_data_to_and_from_the_cfi_flash_bit_3_is_x x check, which is an e_assign_is_x
  assign incoming_data_to_and_from_the_cfi_flash_bit_3_is_x = ^(incoming_data_to_and_from_the_cfi_flash[3]) === 1'bx;

  //Crush incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[3] Xs to 0, which is an e_assign
  assign incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[3] = incoming_data_to_and_from_the_cfi_flash_bit_3_is_x ? 1'b0 : incoming_data_to_and_from_the_cfi_flash[3];

  //incoming_data_to_and_from_the_cfi_flash_bit_4_is_x x check, which is an e_assign_is_x
  assign incoming_data_to_and_from_the_cfi_flash_bit_4_is_x = ^(incoming_data_to_and_from_the_cfi_flash[4]) === 1'bx;

  //Crush incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[4] Xs to 0, which is an e_assign
  assign incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[4] = incoming_data_to_and_from_the_cfi_flash_bit_4_is_x ? 1'b0 : incoming_data_to_and_from_the_cfi_flash[4];

  //incoming_data_to_and_from_the_cfi_flash_bit_5_is_x x check, which is an e_assign_is_x
  assign incoming_data_to_and_from_the_cfi_flash_bit_5_is_x = ^(incoming_data_to_and_from_the_cfi_flash[5]) === 1'bx;

  //Crush incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[5] Xs to 0, which is an e_assign
  assign incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[5] = incoming_data_to_and_from_the_cfi_flash_bit_5_is_x ? 1'b0 : incoming_data_to_and_from_the_cfi_flash[5];

  //incoming_data_to_and_from_the_cfi_flash_bit_6_is_x x check, which is an e_assign_is_x
  assign incoming_data_to_and_from_the_cfi_flash_bit_6_is_x = ^(incoming_data_to_and_from_the_cfi_flash[6]) === 1'bx;

  //Crush incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[6] Xs to 0, which is an e_assign
  assign incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[6] = incoming_data_to_and_from_the_cfi_flash_bit_6_is_x ? 1'b0 : incoming_data_to_and_from_the_cfi_flash[6];

  //incoming_data_to_and_from_the_cfi_flash_bit_7_is_x x check, which is an e_assign_is_x
  assign incoming_data_to_and_from_the_cfi_flash_bit_7_is_x = ^(incoming_data_to_and_from_the_cfi_flash[7]) === 1'bx;

  //Crush incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[7] Xs to 0, which is an e_assign
  assign incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[7] = incoming_data_to_and_from_the_cfi_flash_bit_7_is_x ? 1'b0 : incoming_data_to_and_from_the_cfi_flash[7];

  //incoming_data_to_and_from_the_cfi_flash_bit_8_is_x x check, which is an e_assign_is_x
  assign incoming_data_to_and_from_the_cfi_flash_bit_8_is_x = ^(incoming_data_to_and_from_the_cfi_flash[8]) === 1'bx;

  //Crush incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[8] Xs to 0, which is an e_assign
  assign incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[8] = incoming_data_to_and_from_the_cfi_flash_bit_8_is_x ? 1'b0 : incoming_data_to_and_from_the_cfi_flash[8];

  //incoming_data_to_and_from_the_cfi_flash_bit_9_is_x x check, which is an e_assign_is_x
  assign incoming_data_to_and_from_the_cfi_flash_bit_9_is_x = ^(incoming_data_to_and_from_the_cfi_flash[9]) === 1'bx;

  //Crush incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[9] Xs to 0, which is an e_assign
  assign incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[9] = incoming_data_to_and_from_the_cfi_flash_bit_9_is_x ? 1'b0 : incoming_data_to_and_from_the_cfi_flash[9];

  //incoming_data_to_and_from_the_cfi_flash_bit_10_is_x x check, which is an e_assign_is_x
  assign incoming_data_to_and_from_the_cfi_flash_bit_10_is_x = ^(incoming_data_to_and_from_the_cfi_flash[10]) === 1'bx;

  //Crush incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[10] Xs to 0, which is an e_assign
  assign incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[10] = incoming_data_to_and_from_the_cfi_flash_bit_10_is_x ? 1'b0 : incoming_data_to_and_from_the_cfi_flash[10];

  //incoming_data_to_and_from_the_cfi_flash_bit_11_is_x x check, which is an e_assign_is_x
  assign incoming_data_to_and_from_the_cfi_flash_bit_11_is_x = ^(incoming_data_to_and_from_the_cfi_flash[11]) === 1'bx;

  //Crush incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[11] Xs to 0, which is an e_assign
  assign incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[11] = incoming_data_to_and_from_the_cfi_flash_bit_11_is_x ? 1'b0 : incoming_data_to_and_from_the_cfi_flash[11];

  //incoming_data_to_and_from_the_cfi_flash_bit_12_is_x x check, which is an e_assign_is_x
  assign incoming_data_to_and_from_the_cfi_flash_bit_12_is_x = ^(incoming_data_to_and_from_the_cfi_flash[12]) === 1'bx;

  //Crush incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[12] Xs to 0, which is an e_assign
  assign incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[12] = incoming_data_to_and_from_the_cfi_flash_bit_12_is_x ? 1'b0 : incoming_data_to_and_from_the_cfi_flash[12];

  //incoming_data_to_and_from_the_cfi_flash_bit_13_is_x x check, which is an e_assign_is_x
  assign incoming_data_to_and_from_the_cfi_flash_bit_13_is_x = ^(incoming_data_to_and_from_the_cfi_flash[13]) === 1'bx;

  //Crush incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[13] Xs to 0, which is an e_assign
  assign incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[13] = incoming_data_to_and_from_the_cfi_flash_bit_13_is_x ? 1'b0 : incoming_data_to_and_from_the_cfi_flash[13];

  //incoming_data_to_and_from_the_cfi_flash_bit_14_is_x x check, which is an e_assign_is_x
  assign incoming_data_to_and_from_the_cfi_flash_bit_14_is_x = ^(incoming_data_to_and_from_the_cfi_flash[14]) === 1'bx;

  //Crush incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[14] Xs to 0, which is an e_assign
  assign incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[14] = incoming_data_to_and_from_the_cfi_flash_bit_14_is_x ? 1'b0 : incoming_data_to_and_from_the_cfi_flash[14];

  //incoming_data_to_and_from_the_cfi_flash_bit_15_is_x x check, which is an e_assign_is_x
  assign incoming_data_to_and_from_the_cfi_flash_bit_15_is_x = ^(incoming_data_to_and_from_the_cfi_flash[15]) === 1'bx;

  //Crush incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[15] Xs to 0, which is an e_assign
  assign incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0[15] = incoming_data_to_and_from_the_cfi_flash_bit_15_is_x ? 1'b0 : incoming_data_to_and_from_the_cfi_flash[15];

  //cfi_flash/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_granted_cfi_flash_s1 + cpu_instruction_master_granted_cfi_flash_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_saved_grant_cfi_flash_s1 + cpu_instruction_master_saved_grant_cfi_flash_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on
//synthesis read_comments_as_HDL on
//  
//  assign incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0 = incoming_data_to_and_from_the_cfi_flash;
//
//synthesis read_comments_as_HDL off

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module tristate_bridge_flash_bridge_arbitrator 
;



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module tristate_bridge_ssram_avalon_slave_arbitrator (
                                                       // inputs:
                                                        clk,
                                                        cpu_data_master_address_to_slave,
                                                        cpu_data_master_byteenable,
                                                        cpu_data_master_latency_counter,
                                                        cpu_data_master_read,
                                                        cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                                        cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                                        cpu_data_master_write,
                                                        cpu_data_master_writedata,
                                                        cpu_instruction_master_address_to_slave,
                                                        cpu_instruction_master_latency_counter,
                                                        cpu_instruction_master_read,
                                                        cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register,
                                                        cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register,
                                                        reset_n,

                                                       // outputs:
                                                        address_to_the_ssram,
                                                        adsc_n_to_the_ssram,
                                                        bw_n_to_the_ssram,
                                                        bwe_n_to_the_ssram,
                                                        chipenable1_n_to_the_ssram,
                                                        cpu_data_master_granted_ssram_s1,
                                                        cpu_data_master_qualified_request_ssram_s1,
                                                        cpu_data_master_read_data_valid_ssram_s1,
                                                        cpu_data_master_requests_ssram_s1,
                                                        cpu_instruction_master_granted_ssram_s1,
                                                        cpu_instruction_master_qualified_request_ssram_s1,
                                                        cpu_instruction_master_read_data_valid_ssram_s1,
                                                        cpu_instruction_master_requests_ssram_s1,
                                                        d1_tristate_bridge_ssram_avalon_slave_end_xfer,
                                                        data_to_and_from_the_ssram,
                                                        incoming_data_to_and_from_the_ssram,
                                                        outputenable_n_to_the_ssram
                                                     )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output  [ 20: 0] address_to_the_ssram;
  output           adsc_n_to_the_ssram;
  output  [  3: 0] bw_n_to_the_ssram;
  output           bwe_n_to_the_ssram;
  output           chipenable1_n_to_the_ssram;
  output           cpu_data_master_granted_ssram_s1;
  output           cpu_data_master_qualified_request_ssram_s1;
  output           cpu_data_master_read_data_valid_ssram_s1;
  output           cpu_data_master_requests_ssram_s1;
  output           cpu_instruction_master_granted_ssram_s1;
  output           cpu_instruction_master_qualified_request_ssram_s1;
  output           cpu_instruction_master_read_data_valid_ssram_s1;
  output           cpu_instruction_master_requests_ssram_s1;
  output           d1_tristate_bridge_ssram_avalon_slave_end_xfer;
  inout   [ 31: 0] data_to_and_from_the_ssram;
  output  [ 31: 0] incoming_data_to_and_from_the_ssram;
  output           outputenable_n_to_the_ssram;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [ 27: 0] cpu_instruction_master_address_to_slave;
  input   [  2: 0] cpu_instruction_master_latency_counter;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register;
  input            reset_n;

  reg     [ 20: 0] address_to_the_ssram /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
  reg              adsc_n_to_the_ssram /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
  reg     [  3: 0] bw_n_to_the_ssram /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
  reg              bwe_n_to_the_ssram /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
  reg              chipenable1_n_to_the_ssram /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_ssram_s1;
  wire             cpu_data_master_qualified_request_ssram_s1;
  wire             cpu_data_master_read_data_valid_ssram_s1;
  reg     [  3: 0] cpu_data_master_read_data_valid_ssram_s1_shift_register;
  wire             cpu_data_master_read_data_valid_ssram_s1_shift_register_in;
  wire             cpu_data_master_requests_ssram_s1;
  wire             cpu_data_master_saved_grant_ssram_s1;
  wire             cpu_instruction_master_arbiterlock;
  wire             cpu_instruction_master_arbiterlock2;
  wire             cpu_instruction_master_continuerequest;
  wire             cpu_instruction_master_granted_ssram_s1;
  wire             cpu_instruction_master_qualified_request_ssram_s1;
  wire             cpu_instruction_master_read_data_valid_ssram_s1;
  reg     [  3: 0] cpu_instruction_master_read_data_valid_ssram_s1_shift_register;
  wire             cpu_instruction_master_read_data_valid_ssram_s1_shift_register_in;
  wire             cpu_instruction_master_requests_ssram_s1;
  wire             cpu_instruction_master_saved_grant_ssram_s1;
  reg              d1_in_a_write_cycle /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_ENABLE_REGISTER=ON"  */;
  reg     [ 31: 0] d1_outgoing_data_to_and_from_the_ssram /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
  reg              d1_reasons_to_wait;
  reg              d1_tristate_bridge_ssram_avalon_slave_end_xfer;
  wire    [ 31: 0] data_to_and_from_the_ssram;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_tristate_bridge_ssram_avalon_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg     [ 31: 0] incoming_data_to_and_from_the_ssram /* synthesis ALTERA_ATTRIBUTE = "FAST_INPUT_REGISTER=ON"  */;
  reg              last_cycle_cpu_data_master_granted_slave_ssram_s1;
  reg              last_cycle_cpu_instruction_master_granted_slave_ssram_s1;
  wire    [ 31: 0] outgoing_data_to_and_from_the_ssram;
  reg              outputenable_n_to_the_ssram /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
  wire    [ 20: 0] p1_address_to_the_ssram;
  wire             p1_adsc_n_to_the_ssram;
  wire    [  3: 0] p1_bw_n_to_the_ssram;
  wire             p1_bwe_n_to_the_ssram;
  wire             p1_chipenable1_n_to_the_ssram;
  wire    [  3: 0] p1_cpu_data_master_read_data_valid_ssram_s1_shift_register;
  wire    [  3: 0] p1_cpu_instruction_master_read_data_valid_ssram_s1_shift_register;
  wire             p1_outputenable_n_to_the_ssram;
  wire             ssram_s1_in_a_read_cycle;
  wire             ssram_s1_in_a_write_cycle;
  wire             ssram_s1_waits_for_read;
  wire             ssram_s1_waits_for_write;
  wire             ssram_s1_with_write_latency;
  wire             time_to_write;
  wire             tristate_bridge_ssram_avalon_slave_allgrants;
  wire             tristate_bridge_ssram_avalon_slave_allow_new_arb_cycle;
  wire             tristate_bridge_ssram_avalon_slave_any_bursting_master_saved_grant;
  wire             tristate_bridge_ssram_avalon_slave_any_continuerequest;
  reg     [  1: 0] tristate_bridge_ssram_avalon_slave_arb_addend;
  wire             tristate_bridge_ssram_avalon_slave_arb_counter_enable;
  reg     [  1: 0] tristate_bridge_ssram_avalon_slave_arb_share_counter;
  wire    [  1: 0] tristate_bridge_ssram_avalon_slave_arb_share_counter_next_value;
  wire    [  1: 0] tristate_bridge_ssram_avalon_slave_arb_share_set_values;
  wire    [  1: 0] tristate_bridge_ssram_avalon_slave_arb_winner;
  wire             tristate_bridge_ssram_avalon_slave_arbitration_holdoff_internal;
  wire             tristate_bridge_ssram_avalon_slave_beginbursttransfer_internal;
  wire             tristate_bridge_ssram_avalon_slave_begins_xfer;
  wire    [  3: 0] tristate_bridge_ssram_avalon_slave_chosen_master_double_vector;
  wire    [  1: 0] tristate_bridge_ssram_avalon_slave_chosen_master_rot_left;
  wire             tristate_bridge_ssram_avalon_slave_end_xfer;
  wire             tristate_bridge_ssram_avalon_slave_firsttransfer;
  wire    [  1: 0] tristate_bridge_ssram_avalon_slave_grant_vector;
  wire    [  1: 0] tristate_bridge_ssram_avalon_slave_master_qreq_vector;
  wire             tristate_bridge_ssram_avalon_slave_non_bursting_master_requests;
  wire             tristate_bridge_ssram_avalon_slave_read_pending;
  reg              tristate_bridge_ssram_avalon_slave_reg_firsttransfer;
  reg     [  1: 0] tristate_bridge_ssram_avalon_slave_saved_chosen_master_vector;
  reg              tristate_bridge_ssram_avalon_slave_slavearbiterlockenable;
  wire             tristate_bridge_ssram_avalon_slave_slavearbiterlockenable2;
  wire             tristate_bridge_ssram_avalon_slave_unreg_firsttransfer;
  wire             tristate_bridge_ssram_avalon_slave_write_pending;
  wire             wait_for_ssram_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~tristate_bridge_ssram_avalon_slave_end_xfer;
    end


  assign tristate_bridge_ssram_avalon_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_ssram_s1 | cpu_instruction_master_qualified_request_ssram_s1));
  assign cpu_data_master_requests_ssram_s1 = ({cpu_data_master_address_to_slave[27 : 21] , 21'b0} == 28'h9200000) & (cpu_data_master_read | cpu_data_master_write);
  //~chipenable1_n_to_the_ssram of type chipselect to ~p1_chipenable1_n_to_the_ssram, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          chipenable1_n_to_the_ssram <= ~0;
      else if (1)
          chipenable1_n_to_the_ssram <= p1_chipenable1_n_to_the_ssram;
    end


  assign tristate_bridge_ssram_avalon_slave_write_pending = 0;
  //tristate_bridge_ssram/avalon_slave read pending calc, which is an e_assign
  assign tristate_bridge_ssram_avalon_slave_read_pending = (|cpu_data_master_read_data_valid_ssram_s1_shift_register[1 : 0]) | (|cpu_instruction_master_read_data_valid_ssram_s1_shift_register[1 : 0]);

  //tristate_bridge_ssram_avalon_slave_arb_share_counter set values, which is an e_mux
  assign tristate_bridge_ssram_avalon_slave_arb_share_set_values = 1;

  //tristate_bridge_ssram_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  assign tristate_bridge_ssram_avalon_slave_non_bursting_master_requests = cpu_data_master_requests_ssram_s1 |
    cpu_instruction_master_requests_ssram_s1 |
    cpu_data_master_requests_ssram_s1 |
    cpu_instruction_master_requests_ssram_s1;

  //tristate_bridge_ssram_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign tristate_bridge_ssram_avalon_slave_any_bursting_master_saved_grant = 0;

  //tristate_bridge_ssram_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign tristate_bridge_ssram_avalon_slave_arb_share_counter_next_value = tristate_bridge_ssram_avalon_slave_firsttransfer ? (tristate_bridge_ssram_avalon_slave_arb_share_set_values - 1) : |tristate_bridge_ssram_avalon_slave_arb_share_counter ? (tristate_bridge_ssram_avalon_slave_arb_share_counter - 1) : 0;

  //tristate_bridge_ssram_avalon_slave_allgrants all slave grants, which is an e_mux
  assign tristate_bridge_ssram_avalon_slave_allgrants = |tristate_bridge_ssram_avalon_slave_grant_vector |
    |tristate_bridge_ssram_avalon_slave_grant_vector |
    |tristate_bridge_ssram_avalon_slave_grant_vector |
    |tristate_bridge_ssram_avalon_slave_grant_vector;

  //tristate_bridge_ssram_avalon_slave_end_xfer assignment, which is an e_assign
  assign tristate_bridge_ssram_avalon_slave_end_xfer = ~(ssram_s1_waits_for_read | ssram_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_tristate_bridge_ssram_avalon_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_tristate_bridge_ssram_avalon_slave = tristate_bridge_ssram_avalon_slave_end_xfer & (~tristate_bridge_ssram_avalon_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //tristate_bridge_ssram_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign tristate_bridge_ssram_avalon_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_tristate_bridge_ssram_avalon_slave & tristate_bridge_ssram_avalon_slave_allgrants) | (end_xfer_arb_share_counter_term_tristate_bridge_ssram_avalon_slave & ~tristate_bridge_ssram_avalon_slave_non_bursting_master_requests);

  //tristate_bridge_ssram_avalon_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tristate_bridge_ssram_avalon_slave_arb_share_counter <= 0;
      else if (tristate_bridge_ssram_avalon_slave_arb_counter_enable)
          tristate_bridge_ssram_avalon_slave_arb_share_counter <= tristate_bridge_ssram_avalon_slave_arb_share_counter_next_value;
    end


  //tristate_bridge_ssram_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tristate_bridge_ssram_avalon_slave_slavearbiterlockenable <= 0;
      else if ((|tristate_bridge_ssram_avalon_slave_master_qreq_vector & end_xfer_arb_share_counter_term_tristate_bridge_ssram_avalon_slave) | (end_xfer_arb_share_counter_term_tristate_bridge_ssram_avalon_slave & ~tristate_bridge_ssram_avalon_slave_non_bursting_master_requests))
          tristate_bridge_ssram_avalon_slave_slavearbiterlockenable <= |tristate_bridge_ssram_avalon_slave_arb_share_counter_next_value;
    end


  //cpu/data_master tristate_bridge_ssram/avalon_slave arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = tristate_bridge_ssram_avalon_slave_slavearbiterlockenable & cpu_data_master_continuerequest;

  //tristate_bridge_ssram_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign tristate_bridge_ssram_avalon_slave_slavearbiterlockenable2 = |tristate_bridge_ssram_avalon_slave_arb_share_counter_next_value;

  //cpu/data_master tristate_bridge_ssram/avalon_slave arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = tristate_bridge_ssram_avalon_slave_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //cpu/instruction_master tristate_bridge_ssram/avalon_slave arbiterlock, which is an e_assign
  assign cpu_instruction_master_arbiterlock = tristate_bridge_ssram_avalon_slave_slavearbiterlockenable & cpu_instruction_master_continuerequest;

  //cpu/instruction_master tristate_bridge_ssram/avalon_slave arbiterlock2, which is an e_assign
  assign cpu_instruction_master_arbiterlock2 = tristate_bridge_ssram_avalon_slave_slavearbiterlockenable2 & cpu_instruction_master_continuerequest;

  //cpu/instruction_master granted ssram/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_instruction_master_granted_slave_ssram_s1 <= 0;
      else if (1)
          last_cycle_cpu_instruction_master_granted_slave_ssram_s1 <= cpu_instruction_master_saved_grant_ssram_s1 ? 1 : (tristate_bridge_ssram_avalon_slave_arbitration_holdoff_internal | ~cpu_instruction_master_requests_ssram_s1) ? 0 : last_cycle_cpu_instruction_master_granted_slave_ssram_s1;
    end


  //cpu_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_instruction_master_continuerequest = last_cycle_cpu_instruction_master_granted_slave_ssram_s1 & cpu_instruction_master_requests_ssram_s1;

  //tristate_bridge_ssram_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_mux
  assign tristate_bridge_ssram_avalon_slave_any_continuerequest = cpu_instruction_master_continuerequest |
    cpu_data_master_continuerequest;

  assign cpu_data_master_qualified_request_ssram_s1 = cpu_data_master_requests_ssram_s1 & ~((cpu_data_master_read & (tristate_bridge_ssram_avalon_slave_write_pending | (tristate_bridge_ssram_avalon_slave_read_pending & !((((|cpu_data_master_read_data_valid_ssram_s1_shift_register[1 : 0]) | (|cpu_instruction_master_read_data_valid_ssram_s1_shift_register[1 : 0]))))) | (4 < cpu_data_master_latency_counter) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))) | ((tristate_bridge_ssram_avalon_slave_read_pending) & cpu_data_master_write) | cpu_instruction_master_arbiterlock);
  //cpu_data_master_read_data_valid_ssram_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_data_master_read_data_valid_ssram_s1_shift_register_in = cpu_data_master_granted_ssram_s1 & cpu_data_master_read & ~ssram_s1_waits_for_read;

  //shift register p1 cpu_data_master_read_data_valid_ssram_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_data_master_read_data_valid_ssram_s1_shift_register = {cpu_data_master_read_data_valid_ssram_s1_shift_register, cpu_data_master_read_data_valid_ssram_s1_shift_register_in};

  //cpu_data_master_read_data_valid_ssram_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_read_data_valid_ssram_s1_shift_register <= 0;
      else if (1)
          cpu_data_master_read_data_valid_ssram_s1_shift_register <= p1_cpu_data_master_read_data_valid_ssram_s1_shift_register;
    end


  //local readdatavalid cpu_data_master_read_data_valid_ssram_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_ssram_s1 = cpu_data_master_read_data_valid_ssram_s1_shift_register[3];

  //data_to_and_from_the_ssram register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          incoming_data_to_and_from_the_ssram <= 0;
      else if (1)
          incoming_data_to_and_from_the_ssram <= data_to_and_from_the_ssram;
    end


  //ssram_s1_with_write_latency assignment, which is an e_assign
  assign ssram_s1_with_write_latency = in_a_write_cycle & (cpu_data_master_qualified_request_ssram_s1 | cpu_instruction_master_qualified_request_ssram_s1);

  //time to write the data, which is an e_mux
  assign time_to_write = (ssram_s1_with_write_latency)? 1 :
    0;

  //d1_outgoing_data_to_and_from_the_ssram register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_outgoing_data_to_and_from_the_ssram <= 0;
      else if (1)
          d1_outgoing_data_to_and_from_the_ssram <= outgoing_data_to_and_from_the_ssram;
    end


  //write cycle delayed by 1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_in_a_write_cycle <= 0;
      else if (1)
          d1_in_a_write_cycle <= time_to_write;
    end


  //d1_outgoing_data_to_and_from_the_ssram tristate driver, which is an e_assign
  assign data_to_and_from_the_ssram = (d1_in_a_write_cycle)? d1_outgoing_data_to_and_from_the_ssram:{32{1'bz}};

  //outgoing_data_to_and_from_the_ssram mux, which is an e_mux
  assign outgoing_data_to_and_from_the_ssram = cpu_data_master_writedata;

  assign cpu_instruction_master_requests_ssram_s1 = (({cpu_instruction_master_address_to_slave[27 : 21] , 21'b0} == 28'h9200000) & (cpu_instruction_master_read)) & cpu_instruction_master_read;
  //cpu/data_master granted ssram/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_data_master_granted_slave_ssram_s1 <= 0;
      else if (1)
          last_cycle_cpu_data_master_granted_slave_ssram_s1 <= cpu_data_master_saved_grant_ssram_s1 ? 1 : (tristate_bridge_ssram_avalon_slave_arbitration_holdoff_internal | ~cpu_data_master_requests_ssram_s1) ? 0 : last_cycle_cpu_data_master_granted_slave_ssram_s1;
    end


  //cpu_data_master_continuerequest continued request, which is an e_mux
  assign cpu_data_master_continuerequest = last_cycle_cpu_data_master_granted_slave_ssram_s1 & cpu_data_master_requests_ssram_s1;

  assign cpu_instruction_master_qualified_request_ssram_s1 = cpu_instruction_master_requests_ssram_s1 & ~((cpu_instruction_master_read & (tristate_bridge_ssram_avalon_slave_write_pending | (tristate_bridge_ssram_avalon_slave_read_pending & !((((|cpu_data_master_read_data_valid_ssram_s1_shift_register[1 : 0]) | (|cpu_instruction_master_read_data_valid_ssram_s1_shift_register[1 : 0]))))) | (4 < cpu_instruction_master_latency_counter) | (|cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register))) | cpu_data_master_arbiterlock);
  //cpu_instruction_master_read_data_valid_ssram_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_instruction_master_read_data_valid_ssram_s1_shift_register_in = cpu_instruction_master_granted_ssram_s1 & cpu_instruction_master_read & ~ssram_s1_waits_for_read;

  //shift register p1 cpu_instruction_master_read_data_valid_ssram_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_instruction_master_read_data_valid_ssram_s1_shift_register = {cpu_instruction_master_read_data_valid_ssram_s1_shift_register, cpu_instruction_master_read_data_valid_ssram_s1_shift_register_in};

  //cpu_instruction_master_read_data_valid_ssram_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_read_data_valid_ssram_s1_shift_register <= 0;
      else if (1)
          cpu_instruction_master_read_data_valid_ssram_s1_shift_register <= p1_cpu_instruction_master_read_data_valid_ssram_s1_shift_register;
    end


  //local readdatavalid cpu_instruction_master_read_data_valid_ssram_s1, which is an e_mux
  assign cpu_instruction_master_read_data_valid_ssram_s1 = cpu_instruction_master_read_data_valid_ssram_s1_shift_register[3];

  //allow new arb cycle for tristate_bridge_ssram/avalon_slave, which is an e_assign
  assign tristate_bridge_ssram_avalon_slave_allow_new_arb_cycle = ~cpu_data_master_arbiterlock & ~cpu_instruction_master_arbiterlock;

  //cpu/instruction_master assignment into master qualified-requests vector for ssram/s1, which is an e_assign
  assign tristate_bridge_ssram_avalon_slave_master_qreq_vector[0] = cpu_instruction_master_qualified_request_ssram_s1;

  //cpu/instruction_master grant ssram/s1, which is an e_assign
  assign cpu_instruction_master_granted_ssram_s1 = tristate_bridge_ssram_avalon_slave_grant_vector[0];

  //cpu/instruction_master saved-grant ssram/s1, which is an e_assign
  assign cpu_instruction_master_saved_grant_ssram_s1 = tristate_bridge_ssram_avalon_slave_arb_winner[0] && cpu_instruction_master_requests_ssram_s1;

  //cpu/data_master assignment into master qualified-requests vector for ssram/s1, which is an e_assign
  assign tristate_bridge_ssram_avalon_slave_master_qreq_vector[1] = cpu_data_master_qualified_request_ssram_s1;

  //cpu/data_master grant ssram/s1, which is an e_assign
  assign cpu_data_master_granted_ssram_s1 = tristate_bridge_ssram_avalon_slave_grant_vector[1];

  //cpu/data_master saved-grant ssram/s1, which is an e_assign
  assign cpu_data_master_saved_grant_ssram_s1 = tristate_bridge_ssram_avalon_slave_arb_winner[1] && cpu_data_master_requests_ssram_s1;

  //tristate_bridge_ssram/avalon_slave chosen-master double-vector, which is an e_assign
  assign tristate_bridge_ssram_avalon_slave_chosen_master_double_vector = {tristate_bridge_ssram_avalon_slave_master_qreq_vector, tristate_bridge_ssram_avalon_slave_master_qreq_vector} & ({~tristate_bridge_ssram_avalon_slave_master_qreq_vector, ~tristate_bridge_ssram_avalon_slave_master_qreq_vector} + tristate_bridge_ssram_avalon_slave_arb_addend);

  //stable onehot encoding of arb winner
  assign tristate_bridge_ssram_avalon_slave_arb_winner = (tristate_bridge_ssram_avalon_slave_allow_new_arb_cycle & | tristate_bridge_ssram_avalon_slave_grant_vector) ? tristate_bridge_ssram_avalon_slave_grant_vector : tristate_bridge_ssram_avalon_slave_saved_chosen_master_vector;

  //saved tristate_bridge_ssram_avalon_slave_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tristate_bridge_ssram_avalon_slave_saved_chosen_master_vector <= 0;
      else if (tristate_bridge_ssram_avalon_slave_allow_new_arb_cycle)
          tristate_bridge_ssram_avalon_slave_saved_chosen_master_vector <= |tristate_bridge_ssram_avalon_slave_grant_vector ? tristate_bridge_ssram_avalon_slave_grant_vector : tristate_bridge_ssram_avalon_slave_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign tristate_bridge_ssram_avalon_slave_grant_vector = {(tristate_bridge_ssram_avalon_slave_chosen_master_double_vector[1] | tristate_bridge_ssram_avalon_slave_chosen_master_double_vector[3]),
    (tristate_bridge_ssram_avalon_slave_chosen_master_double_vector[0] | tristate_bridge_ssram_avalon_slave_chosen_master_double_vector[2])};

  //tristate_bridge_ssram/avalon_slave chosen master rotated left, which is an e_assign
  assign tristate_bridge_ssram_avalon_slave_chosen_master_rot_left = (tristate_bridge_ssram_avalon_slave_arb_winner << 1) ? (tristate_bridge_ssram_avalon_slave_arb_winner << 1) : 1;

  //tristate_bridge_ssram/avalon_slave's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tristate_bridge_ssram_avalon_slave_arb_addend <= 1;
      else if (|tristate_bridge_ssram_avalon_slave_grant_vector)
          tristate_bridge_ssram_avalon_slave_arb_addend <= tristate_bridge_ssram_avalon_slave_end_xfer? tristate_bridge_ssram_avalon_slave_chosen_master_rot_left : tristate_bridge_ssram_avalon_slave_grant_vector;
    end


  //~adsc_n_to_the_ssram of type begintransfer to ~p1_adsc_n_to_the_ssram, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          adsc_n_to_the_ssram <= ~0;
      else if (1)
          adsc_n_to_the_ssram <= p1_adsc_n_to_the_ssram;
    end


  assign p1_adsc_n_to_the_ssram = ~tristate_bridge_ssram_avalon_slave_begins_xfer;
  //~outputenable_n_to_the_ssram of type outputenable to ~p1_outputenable_n_to_the_ssram, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          outputenable_n_to_the_ssram <= ~0;
      else if (1)
          outputenable_n_to_the_ssram <= p1_outputenable_n_to_the_ssram;
    end


  //~p1_outputenable_n_to_the_ssram assignment, which is an e_mux
  assign p1_outputenable_n_to_the_ssram = ~((|cpu_data_master_read_data_valid_ssram_s1_shift_register[1 : 0]) | (|cpu_instruction_master_read_data_valid_ssram_s1_shift_register[1 : 0]) | ssram_s1_in_a_read_cycle);

  assign p1_chipenable1_n_to_the_ssram = ~(cpu_data_master_granted_ssram_s1 | cpu_instruction_master_granted_ssram_s1 | (|cpu_data_master_read_data_valid_ssram_s1_shift_register[1 : 0]) | (|cpu_instruction_master_read_data_valid_ssram_s1_shift_register[1 : 0]));
  //tristate_bridge_ssram_avalon_slave_firsttransfer first transaction, which is an e_assign
  assign tristate_bridge_ssram_avalon_slave_firsttransfer = tristate_bridge_ssram_avalon_slave_begins_xfer ? tristate_bridge_ssram_avalon_slave_unreg_firsttransfer : tristate_bridge_ssram_avalon_slave_reg_firsttransfer;

  //tristate_bridge_ssram_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign tristate_bridge_ssram_avalon_slave_unreg_firsttransfer = ~(tristate_bridge_ssram_avalon_slave_slavearbiterlockenable & tristate_bridge_ssram_avalon_slave_any_continuerequest);

  //tristate_bridge_ssram_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tristate_bridge_ssram_avalon_slave_reg_firsttransfer <= 1'b1;
      else if (tristate_bridge_ssram_avalon_slave_begins_xfer)
          tristate_bridge_ssram_avalon_slave_reg_firsttransfer <= tristate_bridge_ssram_avalon_slave_unreg_firsttransfer;
    end


  //tristate_bridge_ssram_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign tristate_bridge_ssram_avalon_slave_beginbursttransfer_internal = tristate_bridge_ssram_avalon_slave_begins_xfer;

  //tristate_bridge_ssram_avalon_slave_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign tristate_bridge_ssram_avalon_slave_arbitration_holdoff_internal = tristate_bridge_ssram_avalon_slave_begins_xfer & tristate_bridge_ssram_avalon_slave_firsttransfer;

  //~bwe_n_to_the_ssram of type write to ~p1_bwe_n_to_the_ssram, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          bwe_n_to_the_ssram <= ~0;
      else if (1)
          bwe_n_to_the_ssram <= p1_bwe_n_to_the_ssram;
    end


  //~bw_n_to_the_ssram of type byteenable to ~p1_bw_n_to_the_ssram, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          bw_n_to_the_ssram <= ~0;
      else if (1)
          bw_n_to_the_ssram <= p1_bw_n_to_the_ssram;
    end


  //~p1_bwe_n_to_the_ssram assignment, which is an e_mux
  assign p1_bwe_n_to_the_ssram = ~(cpu_data_master_granted_ssram_s1 & cpu_data_master_write);

  //address_to_the_ssram of type address to p1_address_to_the_ssram, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          address_to_the_ssram <= 0;
      else if (1)
          address_to_the_ssram <= p1_address_to_the_ssram;
    end


  //p1_address_to_the_ssram mux, which is an e_mux
  assign p1_address_to_the_ssram = (cpu_data_master_granted_ssram_s1)? cpu_data_master_address_to_slave :
    cpu_instruction_master_address_to_slave;

  //d1_tristate_bridge_ssram_avalon_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_tristate_bridge_ssram_avalon_slave_end_xfer <= 1;
      else if (1)
          d1_tristate_bridge_ssram_avalon_slave_end_xfer <= tristate_bridge_ssram_avalon_slave_end_xfer;
    end


  //ssram_s1_waits_for_read in a cycle, which is an e_mux
  assign ssram_s1_waits_for_read = ssram_s1_in_a_read_cycle & 0;

  //ssram_s1_in_a_read_cycle assignment, which is an e_assign
  assign ssram_s1_in_a_read_cycle = (cpu_data_master_granted_ssram_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_ssram_s1 & cpu_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = ssram_s1_in_a_read_cycle;

  //ssram_s1_waits_for_write in a cycle, which is an e_mux
  assign ssram_s1_waits_for_write = ssram_s1_in_a_write_cycle & 0;

  //ssram_s1_in_a_write_cycle assignment, which is an e_assign
  assign ssram_s1_in_a_write_cycle = cpu_data_master_granted_ssram_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = ssram_s1_in_a_write_cycle;

  assign wait_for_ssram_s1_counter = 0;
  //~p1_bw_n_to_the_ssram byte enable port mux, which is an e_mux
  assign p1_bw_n_to_the_ssram = ~((cpu_data_master_granted_ssram_s1)? cpu_data_master_byteenable :
    -1);


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //ssram/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_granted_ssram_s1 + cpu_instruction_master_granted_ssram_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_saved_grant_ssram_s1 + cpu_instruction_master_saved_grant_ssram_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module tristate_bridge_ssram_bridge_arbitrator 
;



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module uart_s1_arbitrator (
                            // inputs:
                             clk,
                             cpu_data_master_address_to_slave,
                             cpu_data_master_latency_counter,
                             cpu_data_master_read,
                             cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                             cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                             cpu_data_master_write,
                             cpu_data_master_writedata,
                             reset_n,
                             uart_s1_dataavailable,
                             uart_s1_irq,
                             uart_s1_readdata,
                             uart_s1_readyfordata,

                            // outputs:
                             cpu_data_master_granted_uart_s1,
                             cpu_data_master_qualified_request_uart_s1,
                             cpu_data_master_read_data_valid_uart_s1,
                             cpu_data_master_requests_uart_s1,
                             d1_uart_s1_end_xfer,
                             uart_s1_address,
                             uart_s1_begintransfer,
                             uart_s1_chipselect,
                             uart_s1_dataavailable_from_sa,
                             uart_s1_irq_from_sa,
                             uart_s1_read_n,
                             uart_s1_readdata_from_sa,
                             uart_s1_readyfordata_from_sa,
                             uart_s1_reset_n,
                             uart_s1_write_n,
                             uart_s1_writedata
                          )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           cpu_data_master_granted_uart_s1;
  output           cpu_data_master_qualified_request_uart_s1;
  output           cpu_data_master_read_data_valid_uart_s1;
  output           cpu_data_master_requests_uart_s1;
  output           d1_uart_s1_end_xfer;
  output  [  2: 0] uart_s1_address;
  output           uart_s1_begintransfer;
  output           uart_s1_chipselect;
  output           uart_s1_dataavailable_from_sa;
  output           uart_s1_irq_from_sa;
  output           uart_s1_read_n;
  output  [ 15: 0] uart_s1_readdata_from_sa;
  output           uart_s1_readyfordata_from_sa;
  output           uart_s1_reset_n;
  output           uart_s1_write_n;
  output  [ 15: 0] uart_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  2: 0] cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;
  input            uart_s1_dataavailable;
  input            uart_s1_irq;
  input   [ 15: 0] uart_s1_readdata;
  input            uart_s1_readyfordata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_uart_s1;
  wire             cpu_data_master_qualified_request_uart_s1;
  wire             cpu_data_master_read_data_valid_uart_s1;
  wire             cpu_data_master_requests_uart_s1;
  wire             cpu_data_master_saved_grant_uart_s1;
  reg              d1_reasons_to_wait;
  reg              d1_uart_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_uart_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_uart_s1_from_cpu_data_master;
  wire    [  2: 0] uart_s1_address;
  wire             uart_s1_allgrants;
  wire             uart_s1_allow_new_arb_cycle;
  wire             uart_s1_any_bursting_master_saved_grant;
  wire             uart_s1_any_continuerequest;
  wire             uart_s1_arb_counter_enable;
  reg     [  1: 0] uart_s1_arb_share_counter;
  wire    [  1: 0] uart_s1_arb_share_counter_next_value;
  wire    [  1: 0] uart_s1_arb_share_set_values;
  wire             uart_s1_beginbursttransfer_internal;
  wire             uart_s1_begins_xfer;
  wire             uart_s1_begintransfer;
  wire             uart_s1_chipselect;
  wire             uart_s1_dataavailable_from_sa;
  wire             uart_s1_end_xfer;
  wire             uart_s1_firsttransfer;
  wire             uart_s1_grant_vector;
  wire             uart_s1_in_a_read_cycle;
  wire             uart_s1_in_a_write_cycle;
  wire             uart_s1_irq_from_sa;
  wire             uart_s1_master_qreq_vector;
  wire             uart_s1_non_bursting_master_requests;
  wire             uart_s1_read_n;
  wire    [ 15: 0] uart_s1_readdata_from_sa;
  wire             uart_s1_readyfordata_from_sa;
  reg              uart_s1_reg_firsttransfer;
  wire             uart_s1_reset_n;
  reg              uart_s1_slavearbiterlockenable;
  wire             uart_s1_slavearbiterlockenable2;
  wire             uart_s1_unreg_firsttransfer;
  wire             uart_s1_waits_for_read;
  wire             uart_s1_waits_for_write;
  wire             uart_s1_write_n;
  wire    [ 15: 0] uart_s1_writedata;
  wire             wait_for_uart_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~uart_s1_end_xfer;
    end


  assign uart_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_uart_s1));
  //assign uart_s1_readdata_from_sa = uart_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign uart_s1_readdata_from_sa = uart_s1_readdata;

  assign cpu_data_master_requests_uart_s1 = ({cpu_data_master_address_to_slave[27 : 5] , 5'b0} == 28'h96410c0) & (cpu_data_master_read | cpu_data_master_write);
  //assign uart_s1_dataavailable_from_sa = uart_s1_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign uart_s1_dataavailable_from_sa = uart_s1_dataavailable;

  //assign uart_s1_readyfordata_from_sa = uart_s1_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign uart_s1_readyfordata_from_sa = uart_s1_readyfordata;

  //uart_s1_arb_share_counter set values, which is an e_mux
  assign uart_s1_arb_share_set_values = 1;

  //uart_s1_non_bursting_master_requests mux, which is an e_mux
  assign uart_s1_non_bursting_master_requests = cpu_data_master_requests_uart_s1;

  //uart_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign uart_s1_any_bursting_master_saved_grant = 0;

  //uart_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign uart_s1_arb_share_counter_next_value = uart_s1_firsttransfer ? (uart_s1_arb_share_set_values - 1) : |uart_s1_arb_share_counter ? (uart_s1_arb_share_counter - 1) : 0;

  //uart_s1_allgrants all slave grants, which is an e_mux
  assign uart_s1_allgrants = |uart_s1_grant_vector;

  //uart_s1_end_xfer assignment, which is an e_assign
  assign uart_s1_end_xfer = ~(uart_s1_waits_for_read | uart_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_uart_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_uart_s1 = uart_s1_end_xfer & (~uart_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //uart_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign uart_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_uart_s1 & uart_s1_allgrants) | (end_xfer_arb_share_counter_term_uart_s1 & ~uart_s1_non_bursting_master_requests);

  //uart_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          uart_s1_arb_share_counter <= 0;
      else if (uart_s1_arb_counter_enable)
          uart_s1_arb_share_counter <= uart_s1_arb_share_counter_next_value;
    end


  //uart_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          uart_s1_slavearbiterlockenable <= 0;
      else if ((|uart_s1_master_qreq_vector & end_xfer_arb_share_counter_term_uart_s1) | (end_xfer_arb_share_counter_term_uart_s1 & ~uart_s1_non_bursting_master_requests))
          uart_s1_slavearbiterlockenable <= |uart_s1_arb_share_counter_next_value;
    end


  //cpu/data_master uart/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = uart_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //uart_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign uart_s1_slavearbiterlockenable2 = |uart_s1_arb_share_counter_next_value;

  //cpu/data_master uart/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = uart_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //uart_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign uart_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_uart_s1 = cpu_data_master_requests_uart_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_uart_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_uart_s1 = cpu_data_master_granted_uart_s1 & cpu_data_master_read & ~uart_s1_waits_for_read;

  //uart_s1_writedata mux, which is an e_mux
  assign uart_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_uart_s1 = cpu_data_master_qualified_request_uart_s1;

  //cpu/data_master saved-grant uart/s1, which is an e_assign
  assign cpu_data_master_saved_grant_uart_s1 = cpu_data_master_requests_uart_s1;

  //allow new arb cycle for uart/s1, which is an e_assign
  assign uart_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign uart_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign uart_s1_master_qreq_vector = 1;

  assign uart_s1_begintransfer = uart_s1_begins_xfer;
  //uart_s1_reset_n assignment, which is an e_assign
  assign uart_s1_reset_n = reset_n;

  assign uart_s1_chipselect = cpu_data_master_granted_uart_s1;
  //uart_s1_firsttransfer first transaction, which is an e_assign
  assign uart_s1_firsttransfer = uart_s1_begins_xfer ? uart_s1_unreg_firsttransfer : uart_s1_reg_firsttransfer;

  //uart_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign uart_s1_unreg_firsttransfer = ~(uart_s1_slavearbiterlockenable & uart_s1_any_continuerequest);

  //uart_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          uart_s1_reg_firsttransfer <= 1'b1;
      else if (uart_s1_begins_xfer)
          uart_s1_reg_firsttransfer <= uart_s1_unreg_firsttransfer;
    end


  //uart_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign uart_s1_beginbursttransfer_internal = uart_s1_begins_xfer;

  //~uart_s1_read_n assignment, which is an e_mux
  assign uart_s1_read_n = ~(cpu_data_master_granted_uart_s1 & cpu_data_master_read);

  //~uart_s1_write_n assignment, which is an e_mux
  assign uart_s1_write_n = ~(cpu_data_master_granted_uart_s1 & cpu_data_master_write);

  assign shifted_address_to_uart_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //uart_s1_address mux, which is an e_mux
  assign uart_s1_address = shifted_address_to_uart_s1_from_cpu_data_master >> 2;

  //d1_uart_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_uart_s1_end_xfer <= 1;
      else if (1)
          d1_uart_s1_end_xfer <= uart_s1_end_xfer;
    end


  //uart_s1_waits_for_read in a cycle, which is an e_mux
  assign uart_s1_waits_for_read = uart_s1_in_a_read_cycle & uart_s1_begins_xfer;

  //uart_s1_in_a_read_cycle assignment, which is an e_assign
  assign uart_s1_in_a_read_cycle = cpu_data_master_granted_uart_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = uart_s1_in_a_read_cycle;

  //uart_s1_waits_for_write in a cycle, which is an e_mux
  assign uart_s1_waits_for_write = uart_s1_in_a_write_cycle & uart_s1_begins_xfer;

  //uart_s1_in_a_write_cycle assignment, which is an e_assign
  assign uart_s1_in_a_write_cycle = cpu_data_master_granted_uart_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = uart_s1_in_a_write_cycle;

  assign wait_for_uart_s1_counter = 0;
  //assign uart_s1_irq_from_sa = uart_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign uart_s1_irq_from_sa = uart_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //uart/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module DE2_70_SOPC_reset_clk_25_domain_synch_module (
                                                      // inputs:
                                                       clk,
                                                       data_in,
                                                       reset_n,

                                                      // outputs:
                                                       data_out
                                                    )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "MAX_DELAY=\"100ns\" ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else if (1)
          data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else if (1)
          data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module DE2_70_SOPC_reset_clk_50_domain_synch_module (
                                                      // inputs:
                                                       clk,
                                                       data_in,
                                                       reset_n,

                                                      // outputs:
                                                       data_out
                                                    )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "MAX_DELAY=\"100ns\" ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else if (1)
          data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else if (1)
          data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module DE2_70_SOPC (
                     // 1) global signals:
                      clk_25,
                      clk_50,
                      pll_c0_system,
                      pll_c1_memory,
                      pll_c2_audio,
                      reset_n,

                     // the_AUDIO
                      avs_s1_export_ADCDAT_to_the_AUDIO,
                      avs_s1_export_ADCLRC_to_the_AUDIO,
                      avs_s1_export_BCLK_to_the_AUDIO,
                      avs_s1_export_DACDAT_from_the_AUDIO,
                      avs_s1_export_DACLRC_to_the_AUDIO,

                     // the_DM9000A
                      avs_s1_export_ENET_CLK_from_the_DM9000A,
                      avs_s1_export_ENET_CMD_from_the_DM9000A,
                      avs_s1_export_ENET_CS_N_from_the_DM9000A,
                      avs_s1_export_ENET_DATA_to_and_from_the_DM9000A,
                      avs_s1_export_ENET_INT_to_the_DM9000A,
                      avs_s1_export_ENET_RD_N_from_the_DM9000A,
                      avs_s1_export_ENET_RST_N_from_the_DM9000A,
                      avs_s1_export_ENET_WR_N_from_the_DM9000A,

                     // the_ISP1362
                      avs_dc_export_OTG_INT1_to_the_ISP1362,
                      avs_hc_export_OTG_ADDR_from_the_ISP1362,
                      avs_hc_export_OTG_CS_N_from_the_ISP1362,
                      avs_hc_export_OTG_DATA_to_and_from_the_ISP1362,
                      avs_hc_export_OTG_INT0_to_the_ISP1362,
                      avs_hc_export_OTG_RD_N_from_the_ISP1362,
                      avs_hc_export_OTG_RST_N_from_the_ISP1362,
                      avs_hc_export_OTG_WR_N_from_the_ISP1362,

                     // the_SEG7
                      avs_s1_export_seg7_from_the_SEG7,

                     // the_VGA
                      avs_s1_export_VGA_BLANK_from_the_VGA,
                      avs_s1_export_VGA_B_from_the_VGA,
                      avs_s1_export_VGA_CLK_from_the_VGA,
                      avs_s1_export_VGA_G_from_the_VGA,
                      avs_s1_export_VGA_HS_from_the_VGA,
                      avs_s1_export_VGA_R_from_the_VGA,
                      avs_s1_export_VGA_SYNC_from_the_VGA,
                      avs_s1_export_VGA_VS_from_the_VGA,
                      avs_s1_export_iCLK_25_to_the_VGA,

                     // the_i2c_sclk
                      out_port_from_the_i2c_sclk,

                     // the_i2c_sdat
                      bidir_port_to_and_from_the_i2c_sdat,

                     // the_lcd
                      LCD_E_from_the_lcd,
                      LCD_RS_from_the_lcd,
                      LCD_RW_from_the_lcd,
                      LCD_data_to_and_from_the_lcd,

                     // the_pio_button
                      in_port_to_the_pio_button,

                     // the_pio_green_led
                      out_port_from_the_pio_green_led,

                     // the_pio_red_led
                      out_port_from_the_pio_red_led,

                     // the_pio_switch
                      in_port_to_the_pio_switch,

                     // the_ps2_keyboard
                      PS2_CLK_to_and_from_the_ps2_keyboard,
                      PS2_DAT_to_and_from_the_ps2_keyboard,

                     // the_ps2_mouse
                      PS2_CLK_to_and_from_the_ps2_mouse,
                      PS2_DAT_to_and_from_the_ps2_mouse,

                     // the_sd_clk
                      out_port_from_the_sd_clk,

                     // the_sd_cmd
                      bidir_port_to_and_from_the_sd_cmd,

                     // the_sd_dat
                      bidir_port_to_and_from_the_sd_dat,

                     // the_sd_dat3
                      bidir_port_to_and_from_the_sd_dat3,

                     // the_sdram_u1
                      zs_addr_from_the_sdram_u1,
                      zs_ba_from_the_sdram_u1,
                      zs_cas_n_from_the_sdram_u1,
                      zs_cke_from_the_sdram_u1,
                      zs_cs_n_from_the_sdram_u1,
                      zs_dq_to_and_from_the_sdram_u1,
                      zs_dqm_from_the_sdram_u1,
                      zs_ras_n_from_the_sdram_u1,
                      zs_we_n_from_the_sdram_u1,

                     // the_sdram_u2
                      zs_addr_from_the_sdram_u2,
                      zs_ba_from_the_sdram_u2,
                      zs_cas_n_from_the_sdram_u2,
                      zs_cke_from_the_sdram_u2,
                      zs_cs_n_from_the_sdram_u2,
                      zs_dq_to_and_from_the_sdram_u2,
                      zs_dqm_from_the_sdram_u2,
                      zs_ras_n_from_the_sdram_u2,
                      zs_we_n_from_the_sdram_u2,

                     // the_tristate_bridge_flash_avalon_slave
                      address_to_the_cfi_flash,
                      data_to_and_from_the_cfi_flash,
                      read_n_to_the_cfi_flash,
                      select_n_to_the_cfi_flash,
                      write_n_to_the_cfi_flash,

                     // the_tristate_bridge_ssram_avalon_slave
                      address_to_the_ssram,
                      adsc_n_to_the_ssram,
                      bw_n_to_the_ssram,
                      bwe_n_to_the_ssram,
                      chipenable1_n_to_the_ssram,
                      data_to_and_from_the_ssram,
                      outputenable_n_to_the_ssram,

                     // the_uart
                      cts_n_to_the_uart,
                      rts_n_from_the_uart,
                      rxd_to_the_uart,
                      txd_from_the_uart
                   )
;

  output           LCD_E_from_the_lcd;
  output           LCD_RS_from_the_lcd;
  output           LCD_RW_from_the_lcd;
  inout   [  7: 0] LCD_data_to_and_from_the_lcd;
  inout            PS2_CLK_to_and_from_the_ps2_keyboard;
  inout            PS2_CLK_to_and_from_the_ps2_mouse;
  inout            PS2_DAT_to_and_from_the_ps2_keyboard;
  inout            PS2_DAT_to_and_from_the_ps2_mouse;
  output  [ 22: 0] address_to_the_cfi_flash;
  output  [ 20: 0] address_to_the_ssram;
  output           adsc_n_to_the_ssram;
  output  [  1: 0] avs_hc_export_OTG_ADDR_from_the_ISP1362;
  output           avs_hc_export_OTG_CS_N_from_the_ISP1362;
  inout   [ 15: 0] avs_hc_export_OTG_DATA_to_and_from_the_ISP1362;
  output           avs_hc_export_OTG_RD_N_from_the_ISP1362;
  output           avs_hc_export_OTG_RST_N_from_the_ISP1362;
  output           avs_hc_export_OTG_WR_N_from_the_ISP1362;
  output           avs_s1_export_DACDAT_from_the_AUDIO;
  output           avs_s1_export_ENET_CLK_from_the_DM9000A;
  output           avs_s1_export_ENET_CMD_from_the_DM9000A;
  output           avs_s1_export_ENET_CS_N_from_the_DM9000A;
  inout   [ 15: 0] avs_s1_export_ENET_DATA_to_and_from_the_DM9000A;
  output           avs_s1_export_ENET_RD_N_from_the_DM9000A;
  output           avs_s1_export_ENET_RST_N_from_the_DM9000A;
  output           avs_s1_export_ENET_WR_N_from_the_DM9000A;
  output           avs_s1_export_VGA_BLANK_from_the_VGA;
  output  [  9: 0] avs_s1_export_VGA_B_from_the_VGA;
  output           avs_s1_export_VGA_CLK_from_the_VGA;
  output  [  9: 0] avs_s1_export_VGA_G_from_the_VGA;
  output           avs_s1_export_VGA_HS_from_the_VGA;
  output  [  9: 0] avs_s1_export_VGA_R_from_the_VGA;
  output           avs_s1_export_VGA_SYNC_from_the_VGA;
  output           avs_s1_export_VGA_VS_from_the_VGA;
  output  [ 63: 0] avs_s1_export_seg7_from_the_SEG7;
  inout            bidir_port_to_and_from_the_i2c_sdat;
  inout            bidir_port_to_and_from_the_sd_cmd;
  inout            bidir_port_to_and_from_the_sd_dat;
  inout            bidir_port_to_and_from_the_sd_dat3;
  output  [  3: 0] bw_n_to_the_ssram;
  output           bwe_n_to_the_ssram;
  output           chipenable1_n_to_the_ssram;
  inout   [ 15: 0] data_to_and_from_the_cfi_flash;
  inout   [ 31: 0] data_to_and_from_the_ssram;
  output           out_port_from_the_i2c_sclk;
  output  [  8: 0] out_port_from_the_pio_green_led;
  output  [ 17: 0] out_port_from_the_pio_red_led;
  output           out_port_from_the_sd_clk;
  output           outputenable_n_to_the_ssram;
  output           pll_c0_system;
  output           pll_c1_memory;
  output           pll_c2_audio;
  output           read_n_to_the_cfi_flash;
  output           rts_n_from_the_uart;
  output           select_n_to_the_cfi_flash;
  output           txd_from_the_uart;
  output           write_n_to_the_cfi_flash;
  output  [ 12: 0] zs_addr_from_the_sdram_u1;
  output  [ 12: 0] zs_addr_from_the_sdram_u2;
  output  [  1: 0] zs_ba_from_the_sdram_u1;
  output  [  1: 0] zs_ba_from_the_sdram_u2;
  output           zs_cas_n_from_the_sdram_u1;
  output           zs_cas_n_from_the_sdram_u2;
  output           zs_cke_from_the_sdram_u1;
  output           zs_cke_from_the_sdram_u2;
  output           zs_cs_n_from_the_sdram_u1;
  output           zs_cs_n_from_the_sdram_u2;
  inout   [ 15: 0] zs_dq_to_and_from_the_sdram_u1;
  inout   [ 15: 0] zs_dq_to_and_from_the_sdram_u2;
  output  [  1: 0] zs_dqm_from_the_sdram_u1;
  output  [  1: 0] zs_dqm_from_the_sdram_u2;
  output           zs_ras_n_from_the_sdram_u1;
  output           zs_ras_n_from_the_sdram_u2;
  output           zs_we_n_from_the_sdram_u1;
  output           zs_we_n_from_the_sdram_u2;
  input            avs_dc_export_OTG_INT1_to_the_ISP1362;
  input            avs_hc_export_OTG_INT0_to_the_ISP1362;
  input            avs_s1_export_ADCDAT_to_the_AUDIO;
  input            avs_s1_export_ADCLRC_to_the_AUDIO;
  input            avs_s1_export_BCLK_to_the_AUDIO;
  input            avs_s1_export_DACLRC_to_the_AUDIO;
  input            avs_s1_export_ENET_INT_to_the_DM9000A;
  input            avs_s1_export_iCLK_25_to_the_VGA;
  input            clk_25;
  input            clk_50;
  input            cts_n_to_the_uart;
  input   [  3: 0] in_port_to_the_pio_button;
  input   [ 17: 0] in_port_to_the_pio_switch;
  input            reset_n;
  input            rxd_to_the_uart;

  wire    [  4: 0] AUDIO_s1_address;
  wire             AUDIO_s1_read;
  wire    [ 32: 0] AUDIO_s1_readdata;
  wire    [ 32: 0] AUDIO_s1_readdata_from_sa;
  wire             AUDIO_s1_reset;
  wire             AUDIO_s1_write;
  wire    [ 32: 0] AUDIO_s1_writedata;
  wire             DM9000A_s1_address;
  wire             DM9000A_s1_chipselect_n;
  wire             DM9000A_s1_irq;
  wire             DM9000A_s1_irq_from_sa;
  wire             DM9000A_s1_read_n;
  wire    [ 15: 0] DM9000A_s1_readdata;
  wire    [ 15: 0] DM9000A_s1_readdata_from_sa;
  wire             DM9000A_s1_reset_n;
  wire             DM9000A_s1_wait_counter_eq_0;
  wire             DM9000A_s1_write_n;
  wire    [ 15: 0] DM9000A_s1_writedata;
  wire             ISP1362_dc_address;
  wire             ISP1362_dc_chipselect_n;
  wire             ISP1362_dc_irq_n;
  wire             ISP1362_dc_irq_n_from_sa;
  wire             ISP1362_dc_read_n;
  wire    [ 15: 0] ISP1362_dc_readdata;
  wire    [ 15: 0] ISP1362_dc_readdata_from_sa;
  wire             ISP1362_dc_reset_n;
  wire             ISP1362_dc_wait_counter_eq_0;
  wire             ISP1362_dc_write_n;
  wire    [ 15: 0] ISP1362_dc_writedata;
  wire             ISP1362_hc_address;
  wire             ISP1362_hc_chipselect_n;
  wire             ISP1362_hc_irq_n;
  wire             ISP1362_hc_irq_n_from_sa;
  wire             ISP1362_hc_read_n;
  wire    [ 15: 0] ISP1362_hc_readdata;
  wire    [ 15: 0] ISP1362_hc_readdata_from_sa;
  wire             ISP1362_hc_reset_n;
  wire             ISP1362_hc_wait_counter_eq_0;
  wire             ISP1362_hc_write_n;
  wire    [ 15: 0] ISP1362_hc_writedata;
  wire             LCD_E_from_the_lcd;
  wire             LCD_RS_from_the_lcd;
  wire             LCD_RW_from_the_lcd;
  wire    [  7: 0] LCD_data_to_and_from_the_lcd;
  wire             PS2_CLK_to_and_from_the_ps2_keyboard;
  wire             PS2_CLK_to_and_from_the_ps2_mouse;
  wire             PS2_DAT_to_and_from_the_ps2_keyboard;
  wire             PS2_DAT_to_and_from_the_ps2_mouse;
  wire    [  2: 0] SEG7_s1_address;
  wire             SEG7_s1_read;
  wire    [  7: 0] SEG7_s1_readdata;
  wire    [  7: 0] SEG7_s1_readdata_from_sa;
  wire             SEG7_s1_reset;
  wire             SEG7_s1_write;
  wire    [  7: 0] SEG7_s1_writedata;
  wire    [ 18: 0] VGA_s1_address;
  wire             VGA_s1_chipselect;
  wire             VGA_s1_read;
  wire    [ 15: 0] VGA_s1_readdata;
  wire    [ 15: 0] VGA_s1_readdata_from_sa;
  wire             VGA_s1_reset_n;
  wire             VGA_s1_write;
  wire    [ 15: 0] VGA_s1_writedata;
  wire    [ 22: 0] address_to_the_cfi_flash;
  wire    [ 20: 0] address_to_the_ssram;
  wire             adsc_n_to_the_ssram;
  wire    [  1: 0] avs_hc_export_OTG_ADDR_from_the_ISP1362;
  wire             avs_hc_export_OTG_CS_N_from_the_ISP1362;
  wire    [ 15: 0] avs_hc_export_OTG_DATA_to_and_from_the_ISP1362;
  wire             avs_hc_export_OTG_RD_N_from_the_ISP1362;
  wire             avs_hc_export_OTG_RST_N_from_the_ISP1362;
  wire             avs_hc_export_OTG_WR_N_from_the_ISP1362;
  wire             avs_s1_export_DACDAT_from_the_AUDIO;
  wire             avs_s1_export_ENET_CLK_from_the_DM9000A;
  wire             avs_s1_export_ENET_CMD_from_the_DM9000A;
  wire             avs_s1_export_ENET_CS_N_from_the_DM9000A;
  wire    [ 15: 0] avs_s1_export_ENET_DATA_to_and_from_the_DM9000A;
  wire             avs_s1_export_ENET_RD_N_from_the_DM9000A;
  wire             avs_s1_export_ENET_RST_N_from_the_DM9000A;
  wire             avs_s1_export_ENET_WR_N_from_the_DM9000A;
  wire             avs_s1_export_VGA_BLANK_from_the_VGA;
  wire    [  9: 0] avs_s1_export_VGA_B_from_the_VGA;
  wire             avs_s1_export_VGA_CLK_from_the_VGA;
  wire    [  9: 0] avs_s1_export_VGA_G_from_the_VGA;
  wire             avs_s1_export_VGA_HS_from_the_VGA;
  wire    [  9: 0] avs_s1_export_VGA_R_from_the_VGA;
  wire             avs_s1_export_VGA_SYNC_from_the_VGA;
  wire             avs_s1_export_VGA_VS_from_the_VGA;
  wire    [ 63: 0] avs_s1_export_seg7_from_the_SEG7;
  wire             bidir_port_to_and_from_the_i2c_sdat;
  wire             bidir_port_to_and_from_the_sd_cmd;
  wire             bidir_port_to_and_from_the_sd_dat;
  wire             bidir_port_to_and_from_the_sd_dat3;
  wire    [  3: 0] bw_n_to_the_ssram;
  wire             bwe_n_to_the_ssram;
  wire             cfi_flash_s1_wait_counter_eq_0;
  wire             chipenable1_n_to_the_ssram;
  wire             clk_25_reset_n;
  wire             clk_50_reset_n;
  wire    [  3: 0] clock_0_in_address;
  wire    [  1: 0] clock_0_in_byteenable;
  wire             clock_0_in_endofpacket;
  wire             clock_0_in_endofpacket_from_sa;
  wire    [  2: 0] clock_0_in_nativeaddress;
  wire             clock_0_in_read;
  wire    [ 15: 0] clock_0_in_readdata;
  wire    [ 15: 0] clock_0_in_readdata_from_sa;
  wire             clock_0_in_reset_n;
  wire             clock_0_in_waitrequest;
  wire             clock_0_in_waitrequest_from_sa;
  wire             clock_0_in_write;
  wire    [ 15: 0] clock_0_in_writedata;
  wire    [  3: 0] clock_0_out_address;
  wire    [  3: 0] clock_0_out_address_to_slave;
  wire    [  1: 0] clock_0_out_byteenable;
  wire             clock_0_out_endofpacket;
  wire             clock_0_out_granted_pll_s1;
  wire    [  2: 0] clock_0_out_nativeaddress;
  wire             clock_0_out_qualified_request_pll_s1;
  wire             clock_0_out_read;
  wire             clock_0_out_read_data_valid_pll_s1;
  wire    [ 15: 0] clock_0_out_readdata;
  wire             clock_0_out_requests_pll_s1;
  wire             clock_0_out_reset_n;
  wire             clock_0_out_waitrequest;
  wire             clock_0_out_write;
  wire    [ 15: 0] clock_0_out_writedata;
  wire    [  1: 0] clock_1_in_address;
  wire    [  1: 0] clock_1_in_byteenable;
  wire             clock_1_in_endofpacket;
  wire             clock_1_in_endofpacket_from_sa;
  wire             clock_1_in_nativeaddress;
  wire             clock_1_in_read;
  wire    [ 15: 0] clock_1_in_readdata;
  wire    [ 15: 0] clock_1_in_readdata_from_sa;
  wire             clock_1_in_reset_n;
  wire             clock_1_in_waitrequest;
  wire             clock_1_in_waitrequest_from_sa;
  wire             clock_1_in_write;
  wire    [ 15: 0] clock_1_in_writedata;
  wire    [  1: 0] clock_1_out_address;
  wire    [  1: 0] clock_1_out_address_to_slave;
  wire    [  1: 0] clock_1_out_byteenable;
  wire             clock_1_out_endofpacket;
  wire             clock_1_out_granted_DM9000A_s1;
  wire             clock_1_out_nativeaddress;
  wire             clock_1_out_qualified_request_DM9000A_s1;
  wire             clock_1_out_read;
  wire             clock_1_out_read_data_valid_DM9000A_s1;
  wire    [ 15: 0] clock_1_out_readdata;
  wire             clock_1_out_requests_DM9000A_s1;
  wire             clock_1_out_reset_n;
  wire             clock_1_out_waitrequest;
  wire             clock_1_out_write;
  wire    [ 15: 0] clock_1_out_writedata;
  wire    [ 27: 0] cpu_data_master_address;
  wire    [ 27: 0] cpu_data_master_address_to_slave;
  wire    [  3: 0] cpu_data_master_byteenable;
  wire    [  1: 0] cpu_data_master_byteenable_cfi_flash_s1;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_u1_s1;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_u2_s1;
  wire    [  1: 0] cpu_data_master_dbs_address;
  wire    [ 15: 0] cpu_data_master_dbs_write_16;
  wire             cpu_data_master_debugaccess;
  wire             cpu_data_master_granted_AUDIO_s1;
  wire             cpu_data_master_granted_ISP1362_dc;
  wire             cpu_data_master_granted_ISP1362_hc;
  wire             cpu_data_master_granted_SEG7_s1;
  wire             cpu_data_master_granted_VGA_s1;
  wire             cpu_data_master_granted_cfi_flash_s1;
  wire             cpu_data_master_granted_clock_0_in;
  wire             cpu_data_master_granted_clock_1_in;
  wire             cpu_data_master_granted_cpu_jtag_debug_module;
  wire             cpu_data_master_granted_i2c_sclk_s1;
  wire             cpu_data_master_granted_i2c_sdat_s1;
  wire             cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_granted_lcd_control_slave;
  wire             cpu_data_master_granted_onchip_mem_s1;
  wire             cpu_data_master_granted_pio_button_s1;
  wire             cpu_data_master_granted_pio_green_led_s1;
  wire             cpu_data_master_granted_pio_red_led_s1;
  wire             cpu_data_master_granted_pio_switch_s1;
  wire             cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave;
  wire             cpu_data_master_granted_ps2_mouse_avalon_PS2_slave;
  wire             cpu_data_master_granted_sd_clk_s1;
  wire             cpu_data_master_granted_sd_cmd_s1;
  wire             cpu_data_master_granted_sd_dat3_s1;
  wire             cpu_data_master_granted_sd_dat_s1;
  wire             cpu_data_master_granted_sdram_u1_s1;
  wire             cpu_data_master_granted_sdram_u2_s1;
  wire             cpu_data_master_granted_ssram_s1;
  wire             cpu_data_master_granted_sysid_control_slave;
  wire             cpu_data_master_granted_timer_s1;
  wire             cpu_data_master_granted_timer_stamp_s1;
  wire             cpu_data_master_granted_uart_s1;
  wire    [ 31: 0] cpu_data_master_irq;
  wire    [  2: 0] cpu_data_master_latency_counter;
  wire             cpu_data_master_qualified_request_AUDIO_s1;
  wire             cpu_data_master_qualified_request_ISP1362_dc;
  wire             cpu_data_master_qualified_request_ISP1362_hc;
  wire             cpu_data_master_qualified_request_SEG7_s1;
  wire             cpu_data_master_qualified_request_VGA_s1;
  wire             cpu_data_master_qualified_request_cfi_flash_s1;
  wire             cpu_data_master_qualified_request_clock_0_in;
  wire             cpu_data_master_qualified_request_clock_1_in;
  wire             cpu_data_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_data_master_qualified_request_i2c_sclk_s1;
  wire             cpu_data_master_qualified_request_i2c_sdat_s1;
  wire             cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_qualified_request_lcd_control_slave;
  wire             cpu_data_master_qualified_request_onchip_mem_s1;
  wire             cpu_data_master_qualified_request_pio_button_s1;
  wire             cpu_data_master_qualified_request_pio_green_led_s1;
  wire             cpu_data_master_qualified_request_pio_red_led_s1;
  wire             cpu_data_master_qualified_request_pio_switch_s1;
  wire             cpu_data_master_qualified_request_ps2_keyboard_avalon_PS2_slave;
  wire             cpu_data_master_qualified_request_ps2_mouse_avalon_PS2_slave;
  wire             cpu_data_master_qualified_request_sd_clk_s1;
  wire             cpu_data_master_qualified_request_sd_cmd_s1;
  wire             cpu_data_master_qualified_request_sd_dat3_s1;
  wire             cpu_data_master_qualified_request_sd_dat_s1;
  wire             cpu_data_master_qualified_request_sdram_u1_s1;
  wire             cpu_data_master_qualified_request_sdram_u2_s1;
  wire             cpu_data_master_qualified_request_ssram_s1;
  wire             cpu_data_master_qualified_request_sysid_control_slave;
  wire             cpu_data_master_qualified_request_timer_s1;
  wire             cpu_data_master_qualified_request_timer_stamp_s1;
  wire             cpu_data_master_qualified_request_uart_s1;
  wire             cpu_data_master_read;
  wire             cpu_data_master_read_data_valid_AUDIO_s1;
  wire             cpu_data_master_read_data_valid_ISP1362_dc;
  wire             cpu_data_master_read_data_valid_ISP1362_hc;
  wire             cpu_data_master_read_data_valid_SEG7_s1;
  wire             cpu_data_master_read_data_valid_VGA_s1;
  wire             cpu_data_master_read_data_valid_cfi_flash_s1;
  wire             cpu_data_master_read_data_valid_clock_0_in;
  wire             cpu_data_master_read_data_valid_clock_1_in;
  wire             cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_data_master_read_data_valid_i2c_sclk_s1;
  wire             cpu_data_master_read_data_valid_i2c_sdat_s1;
  wire             cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_read_data_valid_lcd_control_slave;
  wire             cpu_data_master_read_data_valid_onchip_mem_s1;
  wire             cpu_data_master_read_data_valid_pio_button_s1;
  wire             cpu_data_master_read_data_valid_pio_green_led_s1;
  wire             cpu_data_master_read_data_valid_pio_red_led_s1;
  wire             cpu_data_master_read_data_valid_pio_switch_s1;
  wire             cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave;
  wire             cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave;
  wire             cpu_data_master_read_data_valid_sd_clk_s1;
  wire             cpu_data_master_read_data_valid_sd_cmd_s1;
  wire             cpu_data_master_read_data_valid_sd_dat3_s1;
  wire             cpu_data_master_read_data_valid_sd_dat_s1;
  wire             cpu_data_master_read_data_valid_sdram_u1_s1;
  wire             cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  wire             cpu_data_master_read_data_valid_sdram_u2_s1;
  wire             cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  wire             cpu_data_master_read_data_valid_ssram_s1;
  wire             cpu_data_master_read_data_valid_sysid_control_slave;
  wire             cpu_data_master_read_data_valid_timer_s1;
  wire             cpu_data_master_read_data_valid_timer_stamp_s1;
  wire             cpu_data_master_read_data_valid_uart_s1;
  wire    [ 31: 0] cpu_data_master_readdata;
  wire             cpu_data_master_readdatavalid;
  wire             cpu_data_master_requests_AUDIO_s1;
  wire             cpu_data_master_requests_ISP1362_dc;
  wire             cpu_data_master_requests_ISP1362_hc;
  wire             cpu_data_master_requests_SEG7_s1;
  wire             cpu_data_master_requests_VGA_s1;
  wire             cpu_data_master_requests_cfi_flash_s1;
  wire             cpu_data_master_requests_clock_0_in;
  wire             cpu_data_master_requests_clock_1_in;
  wire             cpu_data_master_requests_cpu_jtag_debug_module;
  wire             cpu_data_master_requests_i2c_sclk_s1;
  wire             cpu_data_master_requests_i2c_sdat_s1;
  wire             cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_requests_lcd_control_slave;
  wire             cpu_data_master_requests_onchip_mem_s1;
  wire             cpu_data_master_requests_pio_button_s1;
  wire             cpu_data_master_requests_pio_green_led_s1;
  wire             cpu_data_master_requests_pio_red_led_s1;
  wire             cpu_data_master_requests_pio_switch_s1;
  wire             cpu_data_master_requests_ps2_keyboard_avalon_PS2_slave;
  wire             cpu_data_master_requests_ps2_mouse_avalon_PS2_slave;
  wire             cpu_data_master_requests_sd_clk_s1;
  wire             cpu_data_master_requests_sd_cmd_s1;
  wire             cpu_data_master_requests_sd_dat3_s1;
  wire             cpu_data_master_requests_sd_dat_s1;
  wire             cpu_data_master_requests_sdram_u1_s1;
  wire             cpu_data_master_requests_sdram_u2_s1;
  wire             cpu_data_master_requests_ssram_s1;
  wire             cpu_data_master_requests_sysid_control_slave;
  wire             cpu_data_master_requests_timer_s1;
  wire             cpu_data_master_requests_timer_stamp_s1;
  wire             cpu_data_master_requests_uart_s1;
  wire             cpu_data_master_waitrequest;
  wire             cpu_data_master_write;
  wire    [ 31: 0] cpu_data_master_writedata;
  wire    [ 27: 0] cpu_instruction_master_address;
  wire    [ 27: 0] cpu_instruction_master_address_to_slave;
  wire    [  1: 0] cpu_instruction_master_dbs_address;
  wire             cpu_instruction_master_granted_cfi_flash_s1;
  wire             cpu_instruction_master_granted_cpu_jtag_debug_module;
  wire             cpu_instruction_master_granted_onchip_mem_s1;
  wire             cpu_instruction_master_granted_sdram_u1_s1;
  wire             cpu_instruction_master_granted_sdram_u2_s1;
  wire             cpu_instruction_master_granted_ssram_s1;
  wire    [  2: 0] cpu_instruction_master_latency_counter;
  wire             cpu_instruction_master_qualified_request_cfi_flash_s1;
  wire             cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_instruction_master_qualified_request_onchip_mem_s1;
  wire             cpu_instruction_master_qualified_request_sdram_u1_s1;
  wire             cpu_instruction_master_qualified_request_sdram_u2_s1;
  wire             cpu_instruction_master_qualified_request_ssram_s1;
  wire             cpu_instruction_master_read;
  wire             cpu_instruction_master_read_data_valid_cfi_flash_s1;
  wire             cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_instruction_master_read_data_valid_onchip_mem_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_u1_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register;
  wire             cpu_instruction_master_read_data_valid_sdram_u2_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register;
  wire             cpu_instruction_master_read_data_valid_ssram_s1;
  wire    [ 31: 0] cpu_instruction_master_readdata;
  wire             cpu_instruction_master_readdatavalid;
  wire             cpu_instruction_master_requests_cfi_flash_s1;
  wire             cpu_instruction_master_requests_cpu_jtag_debug_module;
  wire             cpu_instruction_master_requests_onchip_mem_s1;
  wire             cpu_instruction_master_requests_sdram_u1_s1;
  wire             cpu_instruction_master_requests_sdram_u2_s1;
  wire             cpu_instruction_master_requests_ssram_s1;
  wire             cpu_instruction_master_waitrequest;
  wire    [  8: 0] cpu_jtag_debug_module_address;
  wire             cpu_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_jtag_debug_module_byteenable;
  wire             cpu_jtag_debug_module_chipselect;
  wire             cpu_jtag_debug_module_debugaccess;
  wire    [ 31: 0] cpu_jtag_debug_module_readdata;
  wire    [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  wire             cpu_jtag_debug_module_reset;
  wire             cpu_jtag_debug_module_reset_n;
  wire             cpu_jtag_debug_module_resetrequest;
  wire             cpu_jtag_debug_module_resetrequest_from_sa;
  wire             cpu_jtag_debug_module_write;
  wire    [ 31: 0] cpu_jtag_debug_module_writedata;
  wire             d1_AUDIO_s1_end_xfer;
  wire             d1_DM9000A_s1_end_xfer;
  wire             d1_ISP1362_dc_end_xfer;
  wire             d1_ISP1362_hc_end_xfer;
  wire             d1_SEG7_s1_end_xfer;
  wire             d1_VGA_s1_end_xfer;
  wire             d1_clock_0_in_end_xfer;
  wire             d1_clock_1_in_end_xfer;
  wire             d1_cpu_jtag_debug_module_end_xfer;
  wire             d1_i2c_sclk_s1_end_xfer;
  wire             d1_i2c_sdat_s1_end_xfer;
  wire             d1_jtag_uart_avalon_jtag_slave_end_xfer;
  wire             d1_lcd_control_slave_end_xfer;
  wire             d1_onchip_mem_s1_end_xfer;
  wire             d1_pio_button_s1_end_xfer;
  wire             d1_pio_green_led_s1_end_xfer;
  wire             d1_pio_red_led_s1_end_xfer;
  wire             d1_pio_switch_s1_end_xfer;
  wire             d1_pll_s1_end_xfer;
  wire             d1_ps2_keyboard_avalon_PS2_slave_end_xfer;
  wire             d1_ps2_mouse_avalon_PS2_slave_end_xfer;
  wire             d1_sd_clk_s1_end_xfer;
  wire             d1_sd_cmd_s1_end_xfer;
  wire             d1_sd_dat3_s1_end_xfer;
  wire             d1_sd_dat_s1_end_xfer;
  wire             d1_sdram_u1_s1_end_xfer;
  wire             d1_sdram_u2_s1_end_xfer;
  wire             d1_sysid_control_slave_end_xfer;
  wire             d1_timer_s1_end_xfer;
  wire             d1_timer_stamp_s1_end_xfer;
  wire             d1_tristate_bridge_flash_avalon_slave_end_xfer;
  wire             d1_tristate_bridge_ssram_avalon_slave_end_xfer;
  wire             d1_uart_s1_end_xfer;
  wire    [ 15: 0] data_to_and_from_the_cfi_flash;
  wire    [ 31: 0] data_to_and_from_the_ssram;
  wire    [  1: 0] i2c_sclk_s1_address;
  wire             i2c_sclk_s1_chipselect;
  wire             i2c_sclk_s1_reset_n;
  wire             i2c_sclk_s1_write_n;
  wire             i2c_sclk_s1_writedata;
  wire    [  1: 0] i2c_sdat_s1_address;
  wire             i2c_sdat_s1_chipselect;
  wire             i2c_sdat_s1_readdata;
  wire             i2c_sdat_s1_readdata_from_sa;
  wire             i2c_sdat_s1_reset_n;
  wire             i2c_sdat_s1_write_n;
  wire             i2c_sdat_s1_writedata;
  wire    [ 15: 0] incoming_data_to_and_from_the_cfi_flash;
  wire    [ 15: 0] incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0;
  wire    [ 31: 0] incoming_data_to_and_from_the_ssram;
  wire             jtag_uart_avalon_jtag_slave_address;
  wire             jtag_uart_avalon_jtag_slave_chipselect;
  wire             jtag_uart_avalon_jtag_slave_dataavailable;
  wire             jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_avalon_jtag_slave_irq;
  wire             jtag_uart_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_readdata;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_avalon_jtag_slave_readyfordata;
  wire             jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  wire             jtag_uart_avalon_jtag_slave_reset_n;
  wire             jtag_uart_avalon_jtag_slave_waitrequest;
  wire             jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_writedata;
  wire    [  1: 0] lcd_control_slave_address;
  wire             lcd_control_slave_begintransfer;
  wire             lcd_control_slave_read;
  wire    [  7: 0] lcd_control_slave_readdata;
  wire    [  7: 0] lcd_control_slave_readdata_from_sa;
  wire             lcd_control_slave_wait_counter_eq_0;
  wire             lcd_control_slave_write;
  wire    [  7: 0] lcd_control_slave_writedata;
  wire    [ 10: 0] onchip_mem_s1_address;
  wire    [  3: 0] onchip_mem_s1_byteenable;
  wire             onchip_mem_s1_chipselect;
  wire             onchip_mem_s1_clken;
  wire    [ 31: 0] onchip_mem_s1_readdata;
  wire    [ 31: 0] onchip_mem_s1_readdata_from_sa;
  wire             onchip_mem_s1_write;
  wire    [ 31: 0] onchip_mem_s1_writedata;
  wire             out_clk_pll_c0;
  wire             out_clk_pll_c1;
  wire             out_clk_pll_c2;
  wire             out_port_from_the_i2c_sclk;
  wire    [  8: 0] out_port_from_the_pio_green_led;
  wire    [ 17: 0] out_port_from_the_pio_red_led;
  wire             out_port_from_the_sd_clk;
  wire             outputenable_n_to_the_ssram;
  wire    [  1: 0] pio_button_s1_address;
  wire             pio_button_s1_chipselect;
  wire             pio_button_s1_irq;
  wire             pio_button_s1_irq_from_sa;
  wire    [  3: 0] pio_button_s1_readdata;
  wire    [  3: 0] pio_button_s1_readdata_from_sa;
  wire             pio_button_s1_reset_n;
  wire             pio_button_s1_write_n;
  wire    [  3: 0] pio_button_s1_writedata;
  wire    [  1: 0] pio_green_led_s1_address;
  wire             pio_green_led_s1_chipselect;
  wire             pio_green_led_s1_reset_n;
  wire             pio_green_led_s1_write_n;
  wire    [  8: 0] pio_green_led_s1_writedata;
  wire    [  1: 0] pio_red_led_s1_address;
  wire             pio_red_led_s1_chipselect;
  wire             pio_red_led_s1_reset_n;
  wire             pio_red_led_s1_write_n;
  wire    [ 17: 0] pio_red_led_s1_writedata;
  wire    [  1: 0] pio_switch_s1_address;
  wire    [ 17: 0] pio_switch_s1_readdata;
  wire    [ 17: 0] pio_switch_s1_readdata_from_sa;
  wire             pio_switch_s1_reset_n;
  wire             pll_c0_system;
  wire             pll_c0_system_reset;
  wire             pll_c0_system_reset_n;
  wire             pll_c1_memory;
  wire             pll_c2_audio;
  wire    [  2: 0] pll_s1_address;
  wire             pll_s1_chipselect;
  wire             pll_s1_read;
  wire    [ 15: 0] pll_s1_readdata;
  wire    [ 15: 0] pll_s1_readdata_from_sa;
  wire             pll_s1_reset_n;
  wire             pll_s1_resetrequest;
  wire             pll_s1_resetrequest_from_sa;
  wire             pll_s1_write;
  wire    [ 15: 0] pll_s1_writedata;
  wire             ps2_keyboard_avalon_PS2_slave_address;
  wire    [  3: 0] ps2_keyboard_avalon_PS2_slave_byteenable;
  wire             ps2_keyboard_avalon_PS2_slave_chipselect;
  wire             ps2_keyboard_avalon_PS2_slave_irq;
  wire             ps2_keyboard_avalon_PS2_slave_irq_from_sa;
  wire             ps2_keyboard_avalon_PS2_slave_read;
  wire    [ 31: 0] ps2_keyboard_avalon_PS2_slave_readdata;
  wire    [ 31: 0] ps2_keyboard_avalon_PS2_slave_readdata_from_sa;
  wire             ps2_keyboard_avalon_PS2_slave_waitrequest;
  wire             ps2_keyboard_avalon_PS2_slave_waitrequest_from_sa;
  wire             ps2_keyboard_avalon_PS2_slave_write;
  wire    [ 31: 0] ps2_keyboard_avalon_PS2_slave_writedata;
  wire             ps2_mouse_avalon_PS2_slave_address;
  wire    [  3: 0] ps2_mouse_avalon_PS2_slave_byteenable;
  wire             ps2_mouse_avalon_PS2_slave_chipselect;
  wire             ps2_mouse_avalon_PS2_slave_irq;
  wire             ps2_mouse_avalon_PS2_slave_irq_from_sa;
  wire             ps2_mouse_avalon_PS2_slave_read;
  wire    [ 31: 0] ps2_mouse_avalon_PS2_slave_readdata;
  wire    [ 31: 0] ps2_mouse_avalon_PS2_slave_readdata_from_sa;
  wire             ps2_mouse_avalon_PS2_slave_waitrequest;
  wire             ps2_mouse_avalon_PS2_slave_waitrequest_from_sa;
  wire             ps2_mouse_avalon_PS2_slave_write;
  wire    [ 31: 0] ps2_mouse_avalon_PS2_slave_writedata;
  wire             read_n_to_the_cfi_flash;
  wire             reset_n_sources;
  wire             rts_n_from_the_uart;
  wire    [  1: 0] sd_clk_s1_address;
  wire             sd_clk_s1_chipselect;
  wire             sd_clk_s1_reset_n;
  wire             sd_clk_s1_write_n;
  wire             sd_clk_s1_writedata;
  wire    [  1: 0] sd_cmd_s1_address;
  wire             sd_cmd_s1_chipselect;
  wire             sd_cmd_s1_readdata;
  wire             sd_cmd_s1_readdata_from_sa;
  wire             sd_cmd_s1_reset_n;
  wire             sd_cmd_s1_write_n;
  wire             sd_cmd_s1_writedata;
  wire    [  1: 0] sd_dat3_s1_address;
  wire             sd_dat3_s1_chipselect;
  wire             sd_dat3_s1_readdata;
  wire             sd_dat3_s1_readdata_from_sa;
  wire             sd_dat3_s1_reset_n;
  wire             sd_dat3_s1_write_n;
  wire             sd_dat3_s1_writedata;
  wire    [  1: 0] sd_dat_s1_address;
  wire             sd_dat_s1_chipselect;
  wire             sd_dat_s1_readdata;
  wire             sd_dat_s1_readdata_from_sa;
  wire             sd_dat_s1_reset_n;
  wire             sd_dat_s1_write_n;
  wire             sd_dat_s1_writedata;
  wire    [ 23: 0] sdram_u1_s1_address;
  wire    [  1: 0] sdram_u1_s1_byteenable_n;
  wire             sdram_u1_s1_chipselect;
  wire             sdram_u1_s1_read_n;
  wire    [ 15: 0] sdram_u1_s1_readdata;
  wire    [ 15: 0] sdram_u1_s1_readdata_from_sa;
  wire             sdram_u1_s1_readdatavalid;
  wire             sdram_u1_s1_reset_n;
  wire             sdram_u1_s1_waitrequest;
  wire             sdram_u1_s1_waitrequest_from_sa;
  wire             sdram_u1_s1_write_n;
  wire    [ 15: 0] sdram_u1_s1_writedata;
  wire    [ 23: 0] sdram_u2_s1_address;
  wire    [  1: 0] sdram_u2_s1_byteenable_n;
  wire             sdram_u2_s1_chipselect;
  wire             sdram_u2_s1_read_n;
  wire    [ 15: 0] sdram_u2_s1_readdata;
  wire    [ 15: 0] sdram_u2_s1_readdata_from_sa;
  wire             sdram_u2_s1_readdatavalid;
  wire             sdram_u2_s1_reset_n;
  wire             sdram_u2_s1_waitrequest;
  wire             sdram_u2_s1_waitrequest_from_sa;
  wire             sdram_u2_s1_write_n;
  wire    [ 15: 0] sdram_u2_s1_writedata;
  wire             select_n_to_the_cfi_flash;
  wire             sysid_control_slave_address;
  wire    [ 31: 0] sysid_control_slave_readdata;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  wire    [  2: 0] timer_s1_address;
  wire             timer_s1_chipselect;
  wire             timer_s1_irq;
  wire             timer_s1_irq_from_sa;
  wire    [ 15: 0] timer_s1_readdata;
  wire    [ 15: 0] timer_s1_readdata_from_sa;
  wire             timer_s1_reset_n;
  wire             timer_s1_write_n;
  wire    [ 15: 0] timer_s1_writedata;
  wire    [  2: 0] timer_stamp_s1_address;
  wire             timer_stamp_s1_chipselect;
  wire             timer_stamp_s1_irq;
  wire             timer_stamp_s1_irq_from_sa;
  wire    [ 15: 0] timer_stamp_s1_readdata;
  wire    [ 15: 0] timer_stamp_s1_readdata_from_sa;
  wire             timer_stamp_s1_reset_n;
  wire             timer_stamp_s1_write_n;
  wire    [ 15: 0] timer_stamp_s1_writedata;
  wire             txd_from_the_uart;
  wire    [  2: 0] uart_s1_address;
  wire             uart_s1_begintransfer;
  wire             uart_s1_chipselect;
  wire             uart_s1_dataavailable;
  wire             uart_s1_dataavailable_from_sa;
  wire             uart_s1_irq;
  wire             uart_s1_irq_from_sa;
  wire             uart_s1_read_n;
  wire    [ 15: 0] uart_s1_readdata;
  wire    [ 15: 0] uart_s1_readdata_from_sa;
  wire             uart_s1_readyfordata;
  wire             uart_s1_readyfordata_from_sa;
  wire             uart_s1_reset_n;
  wire             uart_s1_write_n;
  wire    [ 15: 0] uart_s1_writedata;
  wire             write_n_to_the_cfi_flash;
  wire    [ 12: 0] zs_addr_from_the_sdram_u1;
  wire    [ 12: 0] zs_addr_from_the_sdram_u2;
  wire    [  1: 0] zs_ba_from_the_sdram_u1;
  wire    [  1: 0] zs_ba_from_the_sdram_u2;
  wire             zs_cas_n_from_the_sdram_u1;
  wire             zs_cas_n_from_the_sdram_u2;
  wire             zs_cke_from_the_sdram_u1;
  wire             zs_cke_from_the_sdram_u2;
  wire             zs_cs_n_from_the_sdram_u1;
  wire             zs_cs_n_from_the_sdram_u2;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram_u1;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram_u2;
  wire    [  1: 0] zs_dqm_from_the_sdram_u1;
  wire    [  1: 0] zs_dqm_from_the_sdram_u2;
  wire             zs_ras_n_from_the_sdram_u1;
  wire             zs_ras_n_from_the_sdram_u2;
  wire             zs_we_n_from_the_sdram_u1;
  wire             zs_we_n_from_the_sdram_u2;
  AUDIO_s1_arbitrator the_AUDIO_s1
    (
      .AUDIO_s1_address                                           (AUDIO_s1_address),
      .AUDIO_s1_read                                              (AUDIO_s1_read),
      .AUDIO_s1_readdata                                          (AUDIO_s1_readdata),
      .AUDIO_s1_readdata_from_sa                                  (AUDIO_s1_readdata_from_sa),
      .AUDIO_s1_reset                                             (AUDIO_s1_reset),
      .AUDIO_s1_write                                             (AUDIO_s1_write),
      .AUDIO_s1_writedata                                         (AUDIO_s1_writedata),
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_AUDIO_s1                           (cpu_data_master_granted_AUDIO_s1),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_AUDIO_s1                 (cpu_data_master_qualified_request_AUDIO_s1),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_AUDIO_s1                   (cpu_data_master_read_data_valid_AUDIO_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_AUDIO_s1                          (cpu_data_master_requests_AUDIO_s1),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_AUDIO_s1_end_xfer                                       (d1_AUDIO_s1_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n)
    );

  AUDIO the_AUDIO
    (
      .avs_s1_address       (AUDIO_s1_address),
      .avs_s1_clk           (pll_c0_system),
      .avs_s1_export_ADCDAT (avs_s1_export_ADCDAT_to_the_AUDIO),
      .avs_s1_export_ADCLRC (avs_s1_export_ADCLRC_to_the_AUDIO),
      .avs_s1_export_BCLK   (avs_s1_export_BCLK_to_the_AUDIO),
      .avs_s1_export_DACDAT (avs_s1_export_DACDAT_from_the_AUDIO),
      .avs_s1_export_DACLRC (avs_s1_export_DACLRC_to_the_AUDIO),
      .avs_s1_read          (AUDIO_s1_read),
      .avs_s1_readdata      (AUDIO_s1_readdata),
      .avs_s1_reset         (AUDIO_s1_reset),
      .avs_s1_write         (AUDIO_s1_write),
      .avs_s1_writedata     (AUDIO_s1_writedata)
    );

  DM9000A_s1_arbitrator the_DM9000A_s1
    (
      .DM9000A_s1_address                       (DM9000A_s1_address),
      .DM9000A_s1_chipselect_n                  (DM9000A_s1_chipselect_n),
      .DM9000A_s1_irq                           (DM9000A_s1_irq),
      .DM9000A_s1_irq_from_sa                   (DM9000A_s1_irq_from_sa),
      .DM9000A_s1_read_n                        (DM9000A_s1_read_n),
      .DM9000A_s1_readdata                      (DM9000A_s1_readdata),
      .DM9000A_s1_readdata_from_sa              (DM9000A_s1_readdata_from_sa),
      .DM9000A_s1_reset_n                       (DM9000A_s1_reset_n),
      .DM9000A_s1_wait_counter_eq_0             (DM9000A_s1_wait_counter_eq_0),
      .DM9000A_s1_write_n                       (DM9000A_s1_write_n),
      .DM9000A_s1_writedata                     (DM9000A_s1_writedata),
      .clk                                      (clk_25),
      .clock_1_out_address_to_slave             (clock_1_out_address_to_slave),
      .clock_1_out_granted_DM9000A_s1           (clock_1_out_granted_DM9000A_s1),
      .clock_1_out_nativeaddress                (clock_1_out_nativeaddress),
      .clock_1_out_qualified_request_DM9000A_s1 (clock_1_out_qualified_request_DM9000A_s1),
      .clock_1_out_read                         (clock_1_out_read),
      .clock_1_out_read_data_valid_DM9000A_s1   (clock_1_out_read_data_valid_DM9000A_s1),
      .clock_1_out_requests_DM9000A_s1          (clock_1_out_requests_DM9000A_s1),
      .clock_1_out_write                        (clock_1_out_write),
      .clock_1_out_writedata                    (clock_1_out_writedata),
      .d1_DM9000A_s1_end_xfer                   (d1_DM9000A_s1_end_xfer),
      .reset_n                                  (clk_25_reset_n)
    );

  DM9000A the_DM9000A
    (
      .avs_s1_address_iCMD       (DM9000A_s1_address),
      .avs_s1_chipselect_n_iCS_N (DM9000A_s1_chipselect_n),
      .avs_s1_clk_iCLK           (clk_25),
      .avs_s1_export_ENET_CLK    (avs_s1_export_ENET_CLK_from_the_DM9000A),
      .avs_s1_export_ENET_CMD    (avs_s1_export_ENET_CMD_from_the_DM9000A),
      .avs_s1_export_ENET_CS_N   (avs_s1_export_ENET_CS_N_from_the_DM9000A),
      .avs_s1_export_ENET_DATA   (avs_s1_export_ENET_DATA_to_and_from_the_DM9000A),
      .avs_s1_export_ENET_INT    (avs_s1_export_ENET_INT_to_the_DM9000A),
      .avs_s1_export_ENET_RD_N   (avs_s1_export_ENET_RD_N_from_the_DM9000A),
      .avs_s1_export_ENET_RST_N  (avs_s1_export_ENET_RST_N_from_the_DM9000A),
      .avs_s1_export_ENET_WR_N   (avs_s1_export_ENET_WR_N_from_the_DM9000A),
      .avs_s1_irq_oINT           (DM9000A_s1_irq),
      .avs_s1_read_n_iRD_N       (DM9000A_s1_read_n),
      .avs_s1_readdata_oDATA     (DM9000A_s1_readdata),
      .avs_s1_reset_n_iRST_N     (DM9000A_s1_reset_n),
      .avs_s1_write_n_iWR_N      (DM9000A_s1_write_n),
      .avs_s1_writedata_iDATA    (DM9000A_s1_writedata)
    );

  ISP1362_dc_arbitrator the_ISP1362_dc
    (
      .ISP1362_dc_address                                         (ISP1362_dc_address),
      .ISP1362_dc_chipselect_n                                    (ISP1362_dc_chipselect_n),
      .ISP1362_dc_irq_n                                           (ISP1362_dc_irq_n),
      .ISP1362_dc_irq_n_from_sa                                   (ISP1362_dc_irq_n_from_sa),
      .ISP1362_dc_read_n                                          (ISP1362_dc_read_n),
      .ISP1362_dc_readdata                                        (ISP1362_dc_readdata),
      .ISP1362_dc_readdata_from_sa                                (ISP1362_dc_readdata_from_sa),
      .ISP1362_dc_reset_n                                         (ISP1362_dc_reset_n),
      .ISP1362_dc_wait_counter_eq_0                               (ISP1362_dc_wait_counter_eq_0),
      .ISP1362_dc_write_n                                         (ISP1362_dc_write_n),
      .ISP1362_dc_writedata                                       (ISP1362_dc_writedata),
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_ISP1362_dc                         (cpu_data_master_granted_ISP1362_dc),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_ISP1362_dc               (cpu_data_master_qualified_request_ISP1362_dc),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_ISP1362_dc                 (cpu_data_master_read_data_valid_ISP1362_dc),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_ISP1362_dc                        (cpu_data_master_requests_ISP1362_dc),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_ISP1362_dc_end_xfer                                     (d1_ISP1362_dc_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n)
    );

  ISP1362_hc_arbitrator the_ISP1362_hc
    (
      .ISP1362_hc_address                                         (ISP1362_hc_address),
      .ISP1362_hc_chipselect_n                                    (ISP1362_hc_chipselect_n),
      .ISP1362_hc_irq_n                                           (ISP1362_hc_irq_n),
      .ISP1362_hc_irq_n_from_sa                                   (ISP1362_hc_irq_n_from_sa),
      .ISP1362_hc_read_n                                          (ISP1362_hc_read_n),
      .ISP1362_hc_readdata                                        (ISP1362_hc_readdata),
      .ISP1362_hc_readdata_from_sa                                (ISP1362_hc_readdata_from_sa),
      .ISP1362_hc_reset_n                                         (ISP1362_hc_reset_n),
      .ISP1362_hc_wait_counter_eq_0                               (ISP1362_hc_wait_counter_eq_0),
      .ISP1362_hc_write_n                                         (ISP1362_hc_write_n),
      .ISP1362_hc_writedata                                       (ISP1362_hc_writedata),
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_ISP1362_hc                         (cpu_data_master_granted_ISP1362_hc),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_ISP1362_hc               (cpu_data_master_qualified_request_ISP1362_hc),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_ISP1362_hc                 (cpu_data_master_read_data_valid_ISP1362_hc),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_ISP1362_hc                        (cpu_data_master_requests_ISP1362_hc),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_ISP1362_hc_end_xfer                                     (d1_ISP1362_hc_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n)
    );

  ISP1362 the_ISP1362
    (
      .avs_dc_address_iADDR      (ISP1362_dc_address),
      .avs_dc_chipselect_n_iCS_N (ISP1362_dc_chipselect_n),
      .avs_dc_clk_iCLK           (pll_c0_system),
      .avs_dc_export_OTG_INT1    (avs_dc_export_OTG_INT1_to_the_ISP1362),
      .avs_dc_irq_n_oINT0_N      (ISP1362_dc_irq_n),
      .avs_dc_read_n_iRD_N       (ISP1362_dc_read_n),
      .avs_dc_readdata_oDATA     (ISP1362_dc_readdata),
      .avs_dc_reset_n_iRST_N     (ISP1362_dc_reset_n),
      .avs_dc_write_n_iWR_N      (ISP1362_dc_write_n),
      .avs_dc_writedata_iDATA    (ISP1362_dc_writedata),
      .avs_hc_address_iADDR      (ISP1362_hc_address),
      .avs_hc_chipselect_n_iCS_N (ISP1362_hc_chipselect_n),
      .avs_hc_clk_iCLK           (pll_c0_system),
      .avs_hc_export_OTG_ADDR    (avs_hc_export_OTG_ADDR_from_the_ISP1362),
      .avs_hc_export_OTG_CS_N    (avs_hc_export_OTG_CS_N_from_the_ISP1362),
      .avs_hc_export_OTG_DATA    (avs_hc_export_OTG_DATA_to_and_from_the_ISP1362),
      .avs_hc_export_OTG_INT0    (avs_hc_export_OTG_INT0_to_the_ISP1362),
      .avs_hc_export_OTG_RD_N    (avs_hc_export_OTG_RD_N_from_the_ISP1362),
      .avs_hc_export_OTG_RST_N   (avs_hc_export_OTG_RST_N_from_the_ISP1362),
      .avs_hc_export_OTG_WR_N    (avs_hc_export_OTG_WR_N_from_the_ISP1362),
      .avs_hc_irq_n_oINT0_N      (ISP1362_hc_irq_n),
      .avs_hc_read_n_iRD_N       (ISP1362_hc_read_n),
      .avs_hc_readdata_oDATA     (ISP1362_hc_readdata),
      .avs_hc_reset_n_iRST_N     (ISP1362_hc_reset_n),
      .avs_hc_write_n_iWR_N      (ISP1362_hc_write_n),
      .avs_hc_writedata_iDATA    (ISP1362_hc_writedata)
    );

  SEG7_s1_arbitrator the_SEG7_s1
    (
      .SEG7_s1_address                                            (SEG7_s1_address),
      .SEG7_s1_read                                               (SEG7_s1_read),
      .SEG7_s1_readdata                                           (SEG7_s1_readdata),
      .SEG7_s1_readdata_from_sa                                   (SEG7_s1_readdata_from_sa),
      .SEG7_s1_reset                                              (SEG7_s1_reset),
      .SEG7_s1_write                                              (SEG7_s1_write),
      .SEG7_s1_writedata                                          (SEG7_s1_writedata),
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                 (cpu_data_master_byteenable),
      .cpu_data_master_granted_SEG7_s1                            (cpu_data_master_granted_SEG7_s1),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_SEG7_s1                  (cpu_data_master_qualified_request_SEG7_s1),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_SEG7_s1                    (cpu_data_master_read_data_valid_SEG7_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_SEG7_s1                           (cpu_data_master_requests_SEG7_s1),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_SEG7_s1_end_xfer                                        (d1_SEG7_s1_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n)
    );

  SEG7 the_SEG7
    (
      .avs_s1_address     (SEG7_s1_address),
      .avs_s1_clk         (pll_c0_system),
      .avs_s1_export_seg7 (avs_s1_export_seg7_from_the_SEG7),
      .avs_s1_read        (SEG7_s1_read),
      .avs_s1_readdata    (SEG7_s1_readdata),
      .avs_s1_reset       (SEG7_s1_reset),
      .avs_s1_write       (SEG7_s1_write),
      .avs_s1_writedata   (SEG7_s1_writedata)
    );

  VGA_s1_arbitrator the_VGA_s1
    (
      .VGA_s1_address                                             (VGA_s1_address),
      .VGA_s1_chipselect                                          (VGA_s1_chipselect),
      .VGA_s1_read                                                (VGA_s1_read),
      .VGA_s1_readdata                                            (VGA_s1_readdata),
      .VGA_s1_readdata_from_sa                                    (VGA_s1_readdata_from_sa),
      .VGA_s1_reset_n                                             (VGA_s1_reset_n),
      .VGA_s1_write                                               (VGA_s1_write),
      .VGA_s1_writedata                                           (VGA_s1_writedata),
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_VGA_s1                             (cpu_data_master_granted_VGA_s1),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_VGA_s1                   (cpu_data_master_qualified_request_VGA_s1),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_VGA_s1                     (cpu_data_master_read_data_valid_VGA_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_VGA_s1                            (cpu_data_master_requests_VGA_s1),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_VGA_s1_end_xfer                                         (d1_VGA_s1_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n)
    );

  VGA the_VGA
    (
      .avs_s1_address_iADDR    (VGA_s1_address),
      .avs_s1_chipselect_iCS   (VGA_s1_chipselect),
      .avs_s1_clk_iCLK         (pll_c0_system),
      .avs_s1_export_VGA_B     (avs_s1_export_VGA_B_from_the_VGA),
      .avs_s1_export_VGA_BLANK (avs_s1_export_VGA_BLANK_from_the_VGA),
      .avs_s1_export_VGA_CLK   (avs_s1_export_VGA_CLK_from_the_VGA),
      .avs_s1_export_VGA_G     (avs_s1_export_VGA_G_from_the_VGA),
      .avs_s1_export_VGA_HS    (avs_s1_export_VGA_HS_from_the_VGA),
      .avs_s1_export_VGA_R     (avs_s1_export_VGA_R_from_the_VGA),
      .avs_s1_export_VGA_SYNC  (avs_s1_export_VGA_SYNC_from_the_VGA),
      .avs_s1_export_VGA_VS    (avs_s1_export_VGA_VS_from_the_VGA),
      .avs_s1_export_iCLK_25   (avs_s1_export_iCLK_25_to_the_VGA),
      .avs_s1_read_iRD         (VGA_s1_read),
      .avs_s1_readdata_oDATA   (VGA_s1_readdata),
      .avs_s1_reset_n_iRST_N   (VGA_s1_reset_n),
      .avs_s1_write_iWR        (VGA_s1_write),
      .avs_s1_writedata_iDATA  (VGA_s1_writedata)
    );

  clock_0_in_arbitrator the_clock_0_in
    (
      .clk                                                        (pll_c0_system),
      .clock_0_in_address                                         (clock_0_in_address),
      .clock_0_in_byteenable                                      (clock_0_in_byteenable),
      .clock_0_in_endofpacket                                     (clock_0_in_endofpacket),
      .clock_0_in_endofpacket_from_sa                             (clock_0_in_endofpacket_from_sa),
      .clock_0_in_nativeaddress                                   (clock_0_in_nativeaddress),
      .clock_0_in_read                                            (clock_0_in_read),
      .clock_0_in_readdata                                        (clock_0_in_readdata),
      .clock_0_in_readdata_from_sa                                (clock_0_in_readdata_from_sa),
      .clock_0_in_reset_n                                         (clock_0_in_reset_n),
      .clock_0_in_waitrequest                                     (clock_0_in_waitrequest),
      .clock_0_in_waitrequest_from_sa                             (clock_0_in_waitrequest_from_sa),
      .clock_0_in_write                                           (clock_0_in_write),
      .clock_0_in_writedata                                       (clock_0_in_writedata),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                 (cpu_data_master_byteenable),
      .cpu_data_master_granted_clock_0_in                         (cpu_data_master_granted_clock_0_in),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_clock_0_in               (cpu_data_master_qualified_request_clock_0_in),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_clock_0_in                 (cpu_data_master_read_data_valid_clock_0_in),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_clock_0_in                        (cpu_data_master_requests_clock_0_in),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_clock_0_in_end_xfer                                     (d1_clock_0_in_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n)
    );

  clock_0_out_arbitrator the_clock_0_out
    (
      .clk                                  (clk_50),
      .clock_0_out_address                  (clock_0_out_address),
      .clock_0_out_address_to_slave         (clock_0_out_address_to_slave),
      .clock_0_out_granted_pll_s1           (clock_0_out_granted_pll_s1),
      .clock_0_out_qualified_request_pll_s1 (clock_0_out_qualified_request_pll_s1),
      .clock_0_out_read                     (clock_0_out_read),
      .clock_0_out_read_data_valid_pll_s1   (clock_0_out_read_data_valid_pll_s1),
      .clock_0_out_readdata                 (clock_0_out_readdata),
      .clock_0_out_requests_pll_s1          (clock_0_out_requests_pll_s1),
      .clock_0_out_reset_n                  (clock_0_out_reset_n),
      .clock_0_out_waitrequest              (clock_0_out_waitrequest),
      .clock_0_out_write                    (clock_0_out_write),
      .clock_0_out_writedata                (clock_0_out_writedata),
      .d1_pll_s1_end_xfer                   (d1_pll_s1_end_xfer),
      .pll_s1_readdata_from_sa              (pll_s1_readdata_from_sa),
      .reset_n                              (clk_50_reset_n)
    );

  clock_0 the_clock_0
    (
      .master_address       (clock_0_out_address),
      .master_byteenable    (clock_0_out_byteenable),
      .master_clk           (clk_50),
      .master_endofpacket   (clock_0_out_endofpacket),
      .master_nativeaddress (clock_0_out_nativeaddress),
      .master_read          (clock_0_out_read),
      .master_readdata      (clock_0_out_readdata),
      .master_reset_n       (clock_0_out_reset_n),
      .master_waitrequest   (clock_0_out_waitrequest),
      .master_write         (clock_0_out_write),
      .master_writedata     (clock_0_out_writedata),
      .slave_address        (clock_0_in_address),
      .slave_byteenable     (clock_0_in_byteenable),
      .slave_clk            (pll_c0_system),
      .slave_endofpacket    (clock_0_in_endofpacket),
      .slave_nativeaddress  (clock_0_in_nativeaddress),
      .slave_read           (clock_0_in_read),
      .slave_readdata       (clock_0_in_readdata),
      .slave_reset_n        (clock_0_in_reset_n),
      .slave_waitrequest    (clock_0_in_waitrequest),
      .slave_write          (clock_0_in_write),
      .slave_writedata      (clock_0_in_writedata)
    );

  clock_1_in_arbitrator the_clock_1_in
    (
      .clk                                                        (pll_c0_system),
      .clock_1_in_address                                         (clock_1_in_address),
      .clock_1_in_byteenable                                      (clock_1_in_byteenable),
      .clock_1_in_endofpacket                                     (clock_1_in_endofpacket),
      .clock_1_in_endofpacket_from_sa                             (clock_1_in_endofpacket_from_sa),
      .clock_1_in_nativeaddress                                   (clock_1_in_nativeaddress),
      .clock_1_in_read                                            (clock_1_in_read),
      .clock_1_in_readdata                                        (clock_1_in_readdata),
      .clock_1_in_readdata_from_sa                                (clock_1_in_readdata_from_sa),
      .clock_1_in_reset_n                                         (clock_1_in_reset_n),
      .clock_1_in_waitrequest                                     (clock_1_in_waitrequest),
      .clock_1_in_waitrequest_from_sa                             (clock_1_in_waitrequest_from_sa),
      .clock_1_in_write                                           (clock_1_in_write),
      .clock_1_in_writedata                                       (clock_1_in_writedata),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                 (cpu_data_master_byteenable),
      .cpu_data_master_granted_clock_1_in                         (cpu_data_master_granted_clock_1_in),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_clock_1_in               (cpu_data_master_qualified_request_clock_1_in),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_clock_1_in                 (cpu_data_master_read_data_valid_clock_1_in),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_clock_1_in                        (cpu_data_master_requests_clock_1_in),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_clock_1_in_end_xfer                                     (d1_clock_1_in_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n)
    );

  clock_1_out_arbitrator the_clock_1_out
    (
      .DM9000A_s1_readdata_from_sa              (DM9000A_s1_readdata_from_sa),
      .DM9000A_s1_wait_counter_eq_0             (DM9000A_s1_wait_counter_eq_0),
      .clk                                      (clk_25),
      .clock_1_out_address                      (clock_1_out_address),
      .clock_1_out_address_to_slave             (clock_1_out_address_to_slave),
      .clock_1_out_granted_DM9000A_s1           (clock_1_out_granted_DM9000A_s1),
      .clock_1_out_qualified_request_DM9000A_s1 (clock_1_out_qualified_request_DM9000A_s1),
      .clock_1_out_read                         (clock_1_out_read),
      .clock_1_out_read_data_valid_DM9000A_s1   (clock_1_out_read_data_valid_DM9000A_s1),
      .clock_1_out_readdata                     (clock_1_out_readdata),
      .clock_1_out_requests_DM9000A_s1          (clock_1_out_requests_DM9000A_s1),
      .clock_1_out_reset_n                      (clock_1_out_reset_n),
      .clock_1_out_waitrequest                  (clock_1_out_waitrequest),
      .clock_1_out_write                        (clock_1_out_write),
      .clock_1_out_writedata                    (clock_1_out_writedata),
      .d1_DM9000A_s1_end_xfer                   (d1_DM9000A_s1_end_xfer),
      .reset_n                                  (clk_25_reset_n)
    );

  clock_1 the_clock_1
    (
      .master_address       (clock_1_out_address),
      .master_byteenable    (clock_1_out_byteenable),
      .master_clk           (clk_25),
      .master_endofpacket   (clock_1_out_endofpacket),
      .master_nativeaddress (clock_1_out_nativeaddress),
      .master_read          (clock_1_out_read),
      .master_readdata      (clock_1_out_readdata),
      .master_reset_n       (clock_1_out_reset_n),
      .master_waitrequest   (clock_1_out_waitrequest),
      .master_write         (clock_1_out_write),
      .master_writedata     (clock_1_out_writedata),
      .slave_address        (clock_1_in_address),
      .slave_byteenable     (clock_1_in_byteenable),
      .slave_clk            (pll_c0_system),
      .slave_endofpacket    (clock_1_in_endofpacket),
      .slave_nativeaddress  (clock_1_in_nativeaddress),
      .slave_read           (clock_1_in_read),
      .slave_readdata       (clock_1_in_readdata),
      .slave_reset_n        (clock_1_in_reset_n),
      .slave_waitrequest    (clock_1_in_waitrequest),
      .slave_write          (clock_1_in_write),
      .slave_writedata      (clock_1_in_writedata)
    );

  cpu_jtag_debug_module_arbitrator the_cpu_jtag_debug_module
    (
      .clk                                                               (pll_c0_system),
      .cpu_data_master_address_to_slave                                  (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                        (cpu_data_master_byteenable),
      .cpu_data_master_debugaccess                                       (cpu_data_master_debugaccess),
      .cpu_data_master_granted_cpu_jtag_debug_module                     (cpu_data_master_granted_cpu_jtag_debug_module),
      .cpu_data_master_latency_counter                                   (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_cpu_jtag_debug_module           (cpu_data_master_qualified_request_cpu_jtag_debug_module),
      .cpu_data_master_read                                              (cpu_data_master_read),
      .cpu_data_master_read_data_valid_cpu_jtag_debug_module             (cpu_data_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_cpu_jtag_debug_module                    (cpu_data_master_requests_cpu_jtag_debug_module),
      .cpu_data_master_write                                             (cpu_data_master_write),
      .cpu_data_master_writedata                                         (cpu_data_master_writedata),
      .cpu_instruction_master_address_to_slave                           (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_granted_cpu_jtag_debug_module              (cpu_instruction_master_granted_cpu_jtag_debug_module),
      .cpu_instruction_master_latency_counter                            (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_cpu_jtag_debug_module    (cpu_instruction_master_qualified_request_cpu_jtag_debug_module),
      .cpu_instruction_master_read                                       (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_cpu_jtag_debug_module      (cpu_instruction_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_instruction_master_requests_cpu_jtag_debug_module             (cpu_instruction_master_requests_cpu_jtag_debug_module),
      .cpu_jtag_debug_module_address                                     (cpu_jtag_debug_module_address),
      .cpu_jtag_debug_module_begintransfer                               (cpu_jtag_debug_module_begintransfer),
      .cpu_jtag_debug_module_byteenable                                  (cpu_jtag_debug_module_byteenable),
      .cpu_jtag_debug_module_chipselect                                  (cpu_jtag_debug_module_chipselect),
      .cpu_jtag_debug_module_debugaccess                                 (cpu_jtag_debug_module_debugaccess),
      .cpu_jtag_debug_module_readdata                                    (cpu_jtag_debug_module_readdata),
      .cpu_jtag_debug_module_readdata_from_sa                            (cpu_jtag_debug_module_readdata_from_sa),
      .cpu_jtag_debug_module_reset                                       (cpu_jtag_debug_module_reset),
      .cpu_jtag_debug_module_reset_n                                     (cpu_jtag_debug_module_reset_n),
      .cpu_jtag_debug_module_resetrequest                                (cpu_jtag_debug_module_resetrequest),
      .cpu_jtag_debug_module_resetrequest_from_sa                        (cpu_jtag_debug_module_resetrequest_from_sa),
      .cpu_jtag_debug_module_write                                       (cpu_jtag_debug_module_write),
      .cpu_jtag_debug_module_writedata                                   (cpu_jtag_debug_module_writedata),
      .d1_cpu_jtag_debug_module_end_xfer                                 (d1_cpu_jtag_debug_module_end_xfer),
      .reset_n                                                           (pll_c0_system_reset_n)
    );

  cpu_data_master_arbitrator the_cpu_data_master
    (
      .AUDIO_s1_readdata_from_sa                                       (AUDIO_s1_readdata_from_sa),
      .DM9000A_s1_irq_from_sa                                          (DM9000A_s1_irq_from_sa),
      .ISP1362_dc_irq_n_from_sa                                        (ISP1362_dc_irq_n_from_sa),
      .ISP1362_dc_readdata_from_sa                                     (ISP1362_dc_readdata_from_sa),
      .ISP1362_dc_wait_counter_eq_0                                    (ISP1362_dc_wait_counter_eq_0),
      .ISP1362_hc_irq_n_from_sa                                        (ISP1362_hc_irq_n_from_sa),
      .ISP1362_hc_readdata_from_sa                                     (ISP1362_hc_readdata_from_sa),
      .ISP1362_hc_wait_counter_eq_0                                    (ISP1362_hc_wait_counter_eq_0),
      .SEG7_s1_readdata_from_sa                                        (SEG7_s1_readdata_from_sa),
      .VGA_s1_readdata_from_sa                                         (VGA_s1_readdata_from_sa),
      .cfi_flash_s1_wait_counter_eq_0                                  (cfi_flash_s1_wait_counter_eq_0),
      .clk                                                             (pll_c0_system),
      .clock_0_in_readdata_from_sa                                     (clock_0_in_readdata_from_sa),
      .clock_0_in_waitrequest_from_sa                                  (clock_0_in_waitrequest_from_sa),
      .clock_1_in_readdata_from_sa                                     (clock_1_in_readdata_from_sa),
      .clock_1_in_waitrequest_from_sa                                  (clock_1_in_waitrequest_from_sa),
      .cpu_data_master_address                                         (cpu_data_master_address),
      .cpu_data_master_address_to_slave                                (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable_cfi_flash_s1                         (cpu_data_master_byteenable_cfi_flash_s1),
      .cpu_data_master_byteenable_sdram_u1_s1                          (cpu_data_master_byteenable_sdram_u1_s1),
      .cpu_data_master_byteenable_sdram_u2_s1                          (cpu_data_master_byteenable_sdram_u2_s1),
      .cpu_data_master_dbs_address                                     (cpu_data_master_dbs_address),
      .cpu_data_master_dbs_write_16                                    (cpu_data_master_dbs_write_16),
      .cpu_data_master_debugaccess                                     (cpu_data_master_debugaccess),
      .cpu_data_master_granted_AUDIO_s1                                (cpu_data_master_granted_AUDIO_s1),
      .cpu_data_master_granted_ISP1362_dc                              (cpu_data_master_granted_ISP1362_dc),
      .cpu_data_master_granted_ISP1362_hc                              (cpu_data_master_granted_ISP1362_hc),
      .cpu_data_master_granted_SEG7_s1                                 (cpu_data_master_granted_SEG7_s1),
      .cpu_data_master_granted_VGA_s1                                  (cpu_data_master_granted_VGA_s1),
      .cpu_data_master_granted_cfi_flash_s1                            (cpu_data_master_granted_cfi_flash_s1),
      .cpu_data_master_granted_clock_0_in                              (cpu_data_master_granted_clock_0_in),
      .cpu_data_master_granted_clock_1_in                              (cpu_data_master_granted_clock_1_in),
      .cpu_data_master_granted_cpu_jtag_debug_module                   (cpu_data_master_granted_cpu_jtag_debug_module),
      .cpu_data_master_granted_i2c_sclk_s1                             (cpu_data_master_granted_i2c_sclk_s1),
      .cpu_data_master_granted_i2c_sdat_s1                             (cpu_data_master_granted_i2c_sdat_s1),
      .cpu_data_master_granted_jtag_uart_avalon_jtag_slave             (cpu_data_master_granted_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_granted_lcd_control_slave                       (cpu_data_master_granted_lcd_control_slave),
      .cpu_data_master_granted_onchip_mem_s1                           (cpu_data_master_granted_onchip_mem_s1),
      .cpu_data_master_granted_pio_button_s1                           (cpu_data_master_granted_pio_button_s1),
      .cpu_data_master_granted_pio_green_led_s1                        (cpu_data_master_granted_pio_green_led_s1),
      .cpu_data_master_granted_pio_red_led_s1                          (cpu_data_master_granted_pio_red_led_s1),
      .cpu_data_master_granted_pio_switch_s1                           (cpu_data_master_granted_pio_switch_s1),
      .cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave           (cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave),
      .cpu_data_master_granted_ps2_mouse_avalon_PS2_slave              (cpu_data_master_granted_ps2_mouse_avalon_PS2_slave),
      .cpu_data_master_granted_sd_clk_s1                               (cpu_data_master_granted_sd_clk_s1),
      .cpu_data_master_granted_sd_cmd_s1                               (cpu_data_master_granted_sd_cmd_s1),
      .cpu_data_master_granted_sd_dat3_s1                              (cpu_data_master_granted_sd_dat3_s1),
      .cpu_data_master_granted_sd_dat_s1                               (cpu_data_master_granted_sd_dat_s1),
      .cpu_data_master_granted_sdram_u1_s1                             (cpu_data_master_granted_sdram_u1_s1),
      .cpu_data_master_granted_sdram_u2_s1                             (cpu_data_master_granted_sdram_u2_s1),
      .cpu_data_master_granted_ssram_s1                                (cpu_data_master_granted_ssram_s1),
      .cpu_data_master_granted_sysid_control_slave                     (cpu_data_master_granted_sysid_control_slave),
      .cpu_data_master_granted_timer_s1                                (cpu_data_master_granted_timer_s1),
      .cpu_data_master_granted_timer_stamp_s1                          (cpu_data_master_granted_timer_stamp_s1),
      .cpu_data_master_granted_uart_s1                                 (cpu_data_master_granted_uart_s1),
      .cpu_data_master_irq                                             (cpu_data_master_irq),
      .cpu_data_master_latency_counter                                 (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_AUDIO_s1                      (cpu_data_master_qualified_request_AUDIO_s1),
      .cpu_data_master_qualified_request_ISP1362_dc                    (cpu_data_master_qualified_request_ISP1362_dc),
      .cpu_data_master_qualified_request_ISP1362_hc                    (cpu_data_master_qualified_request_ISP1362_hc),
      .cpu_data_master_qualified_request_SEG7_s1                       (cpu_data_master_qualified_request_SEG7_s1),
      .cpu_data_master_qualified_request_VGA_s1                        (cpu_data_master_qualified_request_VGA_s1),
      .cpu_data_master_qualified_request_cfi_flash_s1                  (cpu_data_master_qualified_request_cfi_flash_s1),
      .cpu_data_master_qualified_request_clock_0_in                    (cpu_data_master_qualified_request_clock_0_in),
      .cpu_data_master_qualified_request_clock_1_in                    (cpu_data_master_qualified_request_clock_1_in),
      .cpu_data_master_qualified_request_cpu_jtag_debug_module         (cpu_data_master_qualified_request_cpu_jtag_debug_module),
      .cpu_data_master_qualified_request_i2c_sclk_s1                   (cpu_data_master_qualified_request_i2c_sclk_s1),
      .cpu_data_master_qualified_request_i2c_sdat_s1                   (cpu_data_master_qualified_request_i2c_sdat_s1),
      .cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave   (cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_qualified_request_lcd_control_slave             (cpu_data_master_qualified_request_lcd_control_slave),
      .cpu_data_master_qualified_request_onchip_mem_s1                 (cpu_data_master_qualified_request_onchip_mem_s1),
      .cpu_data_master_qualified_request_pio_button_s1                 (cpu_data_master_qualified_request_pio_button_s1),
      .cpu_data_master_qualified_request_pio_green_led_s1              (cpu_data_master_qualified_request_pio_green_led_s1),
      .cpu_data_master_qualified_request_pio_red_led_s1                (cpu_data_master_qualified_request_pio_red_led_s1),
      .cpu_data_master_qualified_request_pio_switch_s1                 (cpu_data_master_qualified_request_pio_switch_s1),
      .cpu_data_master_qualified_request_ps2_keyboard_avalon_PS2_slave (cpu_data_master_qualified_request_ps2_keyboard_avalon_PS2_slave),
      .cpu_data_master_qualified_request_ps2_mouse_avalon_PS2_slave    (cpu_data_master_qualified_request_ps2_mouse_avalon_PS2_slave),
      .cpu_data_master_qualified_request_sd_clk_s1                     (cpu_data_master_qualified_request_sd_clk_s1),
      .cpu_data_master_qualified_request_sd_cmd_s1                     (cpu_data_master_qualified_request_sd_cmd_s1),
      .cpu_data_master_qualified_request_sd_dat3_s1                    (cpu_data_master_qualified_request_sd_dat3_s1),
      .cpu_data_master_qualified_request_sd_dat_s1                     (cpu_data_master_qualified_request_sd_dat_s1),
      .cpu_data_master_qualified_request_sdram_u1_s1                   (cpu_data_master_qualified_request_sdram_u1_s1),
      .cpu_data_master_qualified_request_sdram_u2_s1                   (cpu_data_master_qualified_request_sdram_u2_s1),
      .cpu_data_master_qualified_request_ssram_s1                      (cpu_data_master_qualified_request_ssram_s1),
      .cpu_data_master_qualified_request_sysid_control_slave           (cpu_data_master_qualified_request_sysid_control_slave),
      .cpu_data_master_qualified_request_timer_s1                      (cpu_data_master_qualified_request_timer_s1),
      .cpu_data_master_qualified_request_timer_stamp_s1                (cpu_data_master_qualified_request_timer_stamp_s1),
      .cpu_data_master_qualified_request_uart_s1                       (cpu_data_master_qualified_request_uart_s1),
      .cpu_data_master_read                                            (cpu_data_master_read),
      .cpu_data_master_read_data_valid_AUDIO_s1                        (cpu_data_master_read_data_valid_AUDIO_s1),
      .cpu_data_master_read_data_valid_ISP1362_dc                      (cpu_data_master_read_data_valid_ISP1362_dc),
      .cpu_data_master_read_data_valid_ISP1362_hc                      (cpu_data_master_read_data_valid_ISP1362_hc),
      .cpu_data_master_read_data_valid_SEG7_s1                         (cpu_data_master_read_data_valid_SEG7_s1),
      .cpu_data_master_read_data_valid_VGA_s1                          (cpu_data_master_read_data_valid_VGA_s1),
      .cpu_data_master_read_data_valid_cfi_flash_s1                    (cpu_data_master_read_data_valid_cfi_flash_s1),
      .cpu_data_master_read_data_valid_clock_0_in                      (cpu_data_master_read_data_valid_clock_0_in),
      .cpu_data_master_read_data_valid_clock_1_in                      (cpu_data_master_read_data_valid_clock_1_in),
      .cpu_data_master_read_data_valid_cpu_jtag_debug_module           (cpu_data_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_data_master_read_data_valid_i2c_sclk_s1                     (cpu_data_master_read_data_valid_i2c_sclk_s1),
      .cpu_data_master_read_data_valid_i2c_sdat_s1                     (cpu_data_master_read_data_valid_i2c_sdat_s1),
      .cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave     (cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_read_data_valid_lcd_control_slave               (cpu_data_master_read_data_valid_lcd_control_slave),
      .cpu_data_master_read_data_valid_onchip_mem_s1                   (cpu_data_master_read_data_valid_onchip_mem_s1),
      .cpu_data_master_read_data_valid_pio_button_s1                   (cpu_data_master_read_data_valid_pio_button_s1),
      .cpu_data_master_read_data_valid_pio_green_led_s1                (cpu_data_master_read_data_valid_pio_green_led_s1),
      .cpu_data_master_read_data_valid_pio_red_led_s1                  (cpu_data_master_read_data_valid_pio_red_led_s1),
      .cpu_data_master_read_data_valid_pio_switch_s1                   (cpu_data_master_read_data_valid_pio_switch_s1),
      .cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave   (cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave),
      .cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave      (cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave),
      .cpu_data_master_read_data_valid_sd_clk_s1                       (cpu_data_master_read_data_valid_sd_clk_s1),
      .cpu_data_master_read_data_valid_sd_cmd_s1                       (cpu_data_master_read_data_valid_sd_cmd_s1),
      .cpu_data_master_read_data_valid_sd_dat3_s1                      (cpu_data_master_read_data_valid_sd_dat3_s1),
      .cpu_data_master_read_data_valid_sd_dat_s1                       (cpu_data_master_read_data_valid_sd_dat_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1                     (cpu_data_master_read_data_valid_sdram_u1_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register      (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1                     (cpu_data_master_read_data_valid_sdram_u2_s1),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register      (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_read_data_valid_ssram_s1                        (cpu_data_master_read_data_valid_ssram_s1),
      .cpu_data_master_read_data_valid_sysid_control_slave             (cpu_data_master_read_data_valid_sysid_control_slave),
      .cpu_data_master_read_data_valid_timer_s1                        (cpu_data_master_read_data_valid_timer_s1),
      .cpu_data_master_read_data_valid_timer_stamp_s1                  (cpu_data_master_read_data_valid_timer_stamp_s1),
      .cpu_data_master_read_data_valid_uart_s1                         (cpu_data_master_read_data_valid_uart_s1),
      .cpu_data_master_readdata                                        (cpu_data_master_readdata),
      .cpu_data_master_readdatavalid                                   (cpu_data_master_readdatavalid),
      .cpu_data_master_requests_AUDIO_s1                               (cpu_data_master_requests_AUDIO_s1),
      .cpu_data_master_requests_ISP1362_dc                             (cpu_data_master_requests_ISP1362_dc),
      .cpu_data_master_requests_ISP1362_hc                             (cpu_data_master_requests_ISP1362_hc),
      .cpu_data_master_requests_SEG7_s1                                (cpu_data_master_requests_SEG7_s1),
      .cpu_data_master_requests_VGA_s1                                 (cpu_data_master_requests_VGA_s1),
      .cpu_data_master_requests_cfi_flash_s1                           (cpu_data_master_requests_cfi_flash_s1),
      .cpu_data_master_requests_clock_0_in                             (cpu_data_master_requests_clock_0_in),
      .cpu_data_master_requests_clock_1_in                             (cpu_data_master_requests_clock_1_in),
      .cpu_data_master_requests_cpu_jtag_debug_module                  (cpu_data_master_requests_cpu_jtag_debug_module),
      .cpu_data_master_requests_i2c_sclk_s1                            (cpu_data_master_requests_i2c_sclk_s1),
      .cpu_data_master_requests_i2c_sdat_s1                            (cpu_data_master_requests_i2c_sdat_s1),
      .cpu_data_master_requests_jtag_uart_avalon_jtag_slave            (cpu_data_master_requests_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_requests_lcd_control_slave                      (cpu_data_master_requests_lcd_control_slave),
      .cpu_data_master_requests_onchip_mem_s1                          (cpu_data_master_requests_onchip_mem_s1),
      .cpu_data_master_requests_pio_button_s1                          (cpu_data_master_requests_pio_button_s1),
      .cpu_data_master_requests_pio_green_led_s1                       (cpu_data_master_requests_pio_green_led_s1),
      .cpu_data_master_requests_pio_red_led_s1                         (cpu_data_master_requests_pio_red_led_s1),
      .cpu_data_master_requests_pio_switch_s1                          (cpu_data_master_requests_pio_switch_s1),
      .cpu_data_master_requests_ps2_keyboard_avalon_PS2_slave          (cpu_data_master_requests_ps2_keyboard_avalon_PS2_slave),
      .cpu_data_master_requests_ps2_mouse_avalon_PS2_slave             (cpu_data_master_requests_ps2_mouse_avalon_PS2_slave),
      .cpu_data_master_requests_sd_clk_s1                              (cpu_data_master_requests_sd_clk_s1),
      .cpu_data_master_requests_sd_cmd_s1                              (cpu_data_master_requests_sd_cmd_s1),
      .cpu_data_master_requests_sd_dat3_s1                             (cpu_data_master_requests_sd_dat3_s1),
      .cpu_data_master_requests_sd_dat_s1                              (cpu_data_master_requests_sd_dat_s1),
      .cpu_data_master_requests_sdram_u1_s1                            (cpu_data_master_requests_sdram_u1_s1),
      .cpu_data_master_requests_sdram_u2_s1                            (cpu_data_master_requests_sdram_u2_s1),
      .cpu_data_master_requests_ssram_s1                               (cpu_data_master_requests_ssram_s1),
      .cpu_data_master_requests_sysid_control_slave                    (cpu_data_master_requests_sysid_control_slave),
      .cpu_data_master_requests_timer_s1                               (cpu_data_master_requests_timer_s1),
      .cpu_data_master_requests_timer_stamp_s1                         (cpu_data_master_requests_timer_stamp_s1),
      .cpu_data_master_requests_uart_s1                                (cpu_data_master_requests_uart_s1),
      .cpu_data_master_waitrequest                                     (cpu_data_master_waitrequest),
      .cpu_data_master_write                                           (cpu_data_master_write),
      .cpu_data_master_writedata                                       (cpu_data_master_writedata),
      .cpu_jtag_debug_module_readdata_from_sa                          (cpu_jtag_debug_module_readdata_from_sa),
      .d1_AUDIO_s1_end_xfer                                            (d1_AUDIO_s1_end_xfer),
      .d1_ISP1362_dc_end_xfer                                          (d1_ISP1362_dc_end_xfer),
      .d1_ISP1362_hc_end_xfer                                          (d1_ISP1362_hc_end_xfer),
      .d1_SEG7_s1_end_xfer                                             (d1_SEG7_s1_end_xfer),
      .d1_VGA_s1_end_xfer                                              (d1_VGA_s1_end_xfer),
      .d1_clock_0_in_end_xfer                                          (d1_clock_0_in_end_xfer),
      .d1_clock_1_in_end_xfer                                          (d1_clock_1_in_end_xfer),
      .d1_cpu_jtag_debug_module_end_xfer                               (d1_cpu_jtag_debug_module_end_xfer),
      .d1_i2c_sclk_s1_end_xfer                                         (d1_i2c_sclk_s1_end_xfer),
      .d1_i2c_sdat_s1_end_xfer                                         (d1_i2c_sdat_s1_end_xfer),
      .d1_jtag_uart_avalon_jtag_slave_end_xfer                         (d1_jtag_uart_avalon_jtag_slave_end_xfer),
      .d1_lcd_control_slave_end_xfer                                   (d1_lcd_control_slave_end_xfer),
      .d1_onchip_mem_s1_end_xfer                                       (d1_onchip_mem_s1_end_xfer),
      .d1_pio_button_s1_end_xfer                                       (d1_pio_button_s1_end_xfer),
      .d1_pio_green_led_s1_end_xfer                                    (d1_pio_green_led_s1_end_xfer),
      .d1_pio_red_led_s1_end_xfer                                      (d1_pio_red_led_s1_end_xfer),
      .d1_pio_switch_s1_end_xfer                                       (d1_pio_switch_s1_end_xfer),
      .d1_ps2_keyboard_avalon_PS2_slave_end_xfer                       (d1_ps2_keyboard_avalon_PS2_slave_end_xfer),
      .d1_ps2_mouse_avalon_PS2_slave_end_xfer                          (d1_ps2_mouse_avalon_PS2_slave_end_xfer),
      .d1_sd_clk_s1_end_xfer                                           (d1_sd_clk_s1_end_xfer),
      .d1_sd_cmd_s1_end_xfer                                           (d1_sd_cmd_s1_end_xfer),
      .d1_sd_dat3_s1_end_xfer                                          (d1_sd_dat3_s1_end_xfer),
      .d1_sd_dat_s1_end_xfer                                           (d1_sd_dat_s1_end_xfer),
      .d1_sdram_u1_s1_end_xfer                                         (d1_sdram_u1_s1_end_xfer),
      .d1_sdram_u2_s1_end_xfer                                         (d1_sdram_u2_s1_end_xfer),
      .d1_sysid_control_slave_end_xfer                                 (d1_sysid_control_slave_end_xfer),
      .d1_timer_s1_end_xfer                                            (d1_timer_s1_end_xfer),
      .d1_timer_stamp_s1_end_xfer                                      (d1_timer_stamp_s1_end_xfer),
      .d1_tristate_bridge_flash_avalon_slave_end_xfer                  (d1_tristate_bridge_flash_avalon_slave_end_xfer),
      .d1_tristate_bridge_ssram_avalon_slave_end_xfer                  (d1_tristate_bridge_ssram_avalon_slave_end_xfer),
      .d1_uart_s1_end_xfer                                             (d1_uart_s1_end_xfer),
      .i2c_sdat_s1_readdata_from_sa                                    (i2c_sdat_s1_readdata_from_sa),
      .incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0  (incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0),
      .incoming_data_to_and_from_the_ssram                             (incoming_data_to_and_from_the_ssram),
      .jtag_uart_avalon_jtag_slave_irq_from_sa                         (jtag_uart_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_avalon_jtag_slave_readdata_from_sa                    (jtag_uart_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_avalon_jtag_slave_waitrequest_from_sa                 (jtag_uart_avalon_jtag_slave_waitrequest_from_sa),
      .lcd_control_slave_readdata_from_sa                              (lcd_control_slave_readdata_from_sa),
      .lcd_control_slave_wait_counter_eq_0                             (lcd_control_slave_wait_counter_eq_0),
      .onchip_mem_s1_readdata_from_sa                                  (onchip_mem_s1_readdata_from_sa),
      .pio_button_s1_irq_from_sa                                       (pio_button_s1_irq_from_sa),
      .pio_button_s1_readdata_from_sa                                  (pio_button_s1_readdata_from_sa),
      .pio_switch_s1_readdata_from_sa                                  (pio_switch_s1_readdata_from_sa),
      .pll_c0_system                                                   (pll_c0_system),
      .pll_c0_system_reset_n                                           (pll_c0_system_reset_n),
      .ps2_keyboard_avalon_PS2_slave_irq_from_sa                       (ps2_keyboard_avalon_PS2_slave_irq_from_sa),
      .ps2_keyboard_avalon_PS2_slave_readdata_from_sa                  (ps2_keyboard_avalon_PS2_slave_readdata_from_sa),
      .ps2_keyboard_avalon_PS2_slave_waitrequest_from_sa               (ps2_keyboard_avalon_PS2_slave_waitrequest_from_sa),
      .ps2_mouse_avalon_PS2_slave_irq_from_sa                          (ps2_mouse_avalon_PS2_slave_irq_from_sa),
      .ps2_mouse_avalon_PS2_slave_readdata_from_sa                     (ps2_mouse_avalon_PS2_slave_readdata_from_sa),
      .ps2_mouse_avalon_PS2_slave_waitrequest_from_sa                  (ps2_mouse_avalon_PS2_slave_waitrequest_from_sa),
      .reset_n                                                         (pll_c0_system_reset_n),
      .sd_cmd_s1_readdata_from_sa                                      (sd_cmd_s1_readdata_from_sa),
      .sd_dat3_s1_readdata_from_sa                                     (sd_dat3_s1_readdata_from_sa),
      .sd_dat_s1_readdata_from_sa                                      (sd_dat_s1_readdata_from_sa),
      .sdram_u1_s1_readdata_from_sa                                    (sdram_u1_s1_readdata_from_sa),
      .sdram_u1_s1_waitrequest_from_sa                                 (sdram_u1_s1_waitrequest_from_sa),
      .sdram_u2_s1_readdata_from_sa                                    (sdram_u2_s1_readdata_from_sa),
      .sdram_u2_s1_waitrequest_from_sa                                 (sdram_u2_s1_waitrequest_from_sa),
      .sysid_control_slave_readdata_from_sa                            (sysid_control_slave_readdata_from_sa),
      .timer_s1_irq_from_sa                                            (timer_s1_irq_from_sa),
      .timer_s1_readdata_from_sa                                       (timer_s1_readdata_from_sa),
      .timer_stamp_s1_irq_from_sa                                      (timer_stamp_s1_irq_from_sa),
      .timer_stamp_s1_readdata_from_sa                                 (timer_stamp_s1_readdata_from_sa),
      .uart_s1_irq_from_sa                                             (uart_s1_irq_from_sa),
      .uart_s1_readdata_from_sa                                        (uart_s1_readdata_from_sa)
    );

  cpu_instruction_master_arbitrator the_cpu_instruction_master
    (
      .cfi_flash_s1_wait_counter_eq_0                                    (cfi_flash_s1_wait_counter_eq_0),
      .clk                                                               (pll_c0_system),
      .cpu_instruction_master_address                                    (cpu_instruction_master_address),
      .cpu_instruction_master_address_to_slave                           (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_dbs_address                                (cpu_instruction_master_dbs_address),
      .cpu_instruction_master_granted_cfi_flash_s1                       (cpu_instruction_master_granted_cfi_flash_s1),
      .cpu_instruction_master_granted_cpu_jtag_debug_module              (cpu_instruction_master_granted_cpu_jtag_debug_module),
      .cpu_instruction_master_granted_onchip_mem_s1                      (cpu_instruction_master_granted_onchip_mem_s1),
      .cpu_instruction_master_granted_sdram_u1_s1                        (cpu_instruction_master_granted_sdram_u1_s1),
      .cpu_instruction_master_granted_sdram_u2_s1                        (cpu_instruction_master_granted_sdram_u2_s1),
      .cpu_instruction_master_granted_ssram_s1                           (cpu_instruction_master_granted_ssram_s1),
      .cpu_instruction_master_latency_counter                            (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_cfi_flash_s1             (cpu_instruction_master_qualified_request_cfi_flash_s1),
      .cpu_instruction_master_qualified_request_cpu_jtag_debug_module    (cpu_instruction_master_qualified_request_cpu_jtag_debug_module),
      .cpu_instruction_master_qualified_request_onchip_mem_s1            (cpu_instruction_master_qualified_request_onchip_mem_s1),
      .cpu_instruction_master_qualified_request_sdram_u1_s1              (cpu_instruction_master_qualified_request_sdram_u1_s1),
      .cpu_instruction_master_qualified_request_sdram_u2_s1              (cpu_instruction_master_qualified_request_sdram_u2_s1),
      .cpu_instruction_master_qualified_request_ssram_s1                 (cpu_instruction_master_qualified_request_ssram_s1),
      .cpu_instruction_master_read                                       (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_cfi_flash_s1               (cpu_instruction_master_read_data_valid_cfi_flash_s1),
      .cpu_instruction_master_read_data_valid_cpu_jtag_debug_module      (cpu_instruction_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_instruction_master_read_data_valid_onchip_mem_s1              (cpu_instruction_master_read_data_valid_onchip_mem_s1),
      .cpu_instruction_master_read_data_valid_sdram_u1_s1                (cpu_instruction_master_read_data_valid_sdram_u1_s1),
      .cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_instruction_master_read_data_valid_sdram_u2_s1                (cpu_instruction_master_read_data_valid_sdram_u2_s1),
      .cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_instruction_master_read_data_valid_ssram_s1                   (cpu_instruction_master_read_data_valid_ssram_s1),
      .cpu_instruction_master_readdata                                   (cpu_instruction_master_readdata),
      .cpu_instruction_master_readdatavalid                              (cpu_instruction_master_readdatavalid),
      .cpu_instruction_master_requests_cfi_flash_s1                      (cpu_instruction_master_requests_cfi_flash_s1),
      .cpu_instruction_master_requests_cpu_jtag_debug_module             (cpu_instruction_master_requests_cpu_jtag_debug_module),
      .cpu_instruction_master_requests_onchip_mem_s1                     (cpu_instruction_master_requests_onchip_mem_s1),
      .cpu_instruction_master_requests_sdram_u1_s1                       (cpu_instruction_master_requests_sdram_u1_s1),
      .cpu_instruction_master_requests_sdram_u2_s1                       (cpu_instruction_master_requests_sdram_u2_s1),
      .cpu_instruction_master_requests_ssram_s1                          (cpu_instruction_master_requests_ssram_s1),
      .cpu_instruction_master_waitrequest                                (cpu_instruction_master_waitrequest),
      .cpu_jtag_debug_module_readdata_from_sa                            (cpu_jtag_debug_module_readdata_from_sa),
      .d1_cpu_jtag_debug_module_end_xfer                                 (d1_cpu_jtag_debug_module_end_xfer),
      .d1_onchip_mem_s1_end_xfer                                         (d1_onchip_mem_s1_end_xfer),
      .d1_sdram_u1_s1_end_xfer                                           (d1_sdram_u1_s1_end_xfer),
      .d1_sdram_u2_s1_end_xfer                                           (d1_sdram_u2_s1_end_xfer),
      .d1_tristate_bridge_flash_avalon_slave_end_xfer                    (d1_tristate_bridge_flash_avalon_slave_end_xfer),
      .d1_tristate_bridge_ssram_avalon_slave_end_xfer                    (d1_tristate_bridge_ssram_avalon_slave_end_xfer),
      .incoming_data_to_and_from_the_cfi_flash                           (incoming_data_to_and_from_the_cfi_flash),
      .incoming_data_to_and_from_the_ssram                               (incoming_data_to_and_from_the_ssram),
      .onchip_mem_s1_readdata_from_sa                                    (onchip_mem_s1_readdata_from_sa),
      .reset_n                                                           (pll_c0_system_reset_n),
      .sdram_u1_s1_readdata_from_sa                                      (sdram_u1_s1_readdata_from_sa),
      .sdram_u1_s1_waitrequest_from_sa                                   (sdram_u1_s1_waitrequest_from_sa),
      .sdram_u2_s1_readdata_from_sa                                      (sdram_u2_s1_readdata_from_sa),
      .sdram_u2_s1_waitrequest_from_sa                                   (sdram_u2_s1_waitrequest_from_sa)
    );

  cpu the_cpu
    (
      .clk                                   (pll_c0_system),
      .d_address                             (cpu_data_master_address),
      .d_byteenable                          (cpu_data_master_byteenable),
      .d_irq                                 (cpu_data_master_irq),
      .d_read                                (cpu_data_master_read),
      .d_readdata                            (cpu_data_master_readdata),
      .d_readdatavalid                       (cpu_data_master_readdatavalid),
      .d_waitrequest                         (cpu_data_master_waitrequest),
      .d_write                               (cpu_data_master_write),
      .d_writedata                           (cpu_data_master_writedata),
      .i_address                             (cpu_instruction_master_address),
      .i_read                                (cpu_instruction_master_read),
      .i_readdata                            (cpu_instruction_master_readdata),
      .i_readdatavalid                       (cpu_instruction_master_readdatavalid),
      .i_waitrequest                         (cpu_instruction_master_waitrequest),
      .jtag_debug_module_address             (cpu_jtag_debug_module_address),
      .jtag_debug_module_begintransfer       (cpu_jtag_debug_module_begintransfer),
      .jtag_debug_module_byteenable          (cpu_jtag_debug_module_byteenable),
      .jtag_debug_module_clk                 (pll_c0_system),
      .jtag_debug_module_debugaccess         (cpu_jtag_debug_module_debugaccess),
      .jtag_debug_module_debugaccess_to_roms (cpu_data_master_debugaccess),
      .jtag_debug_module_readdata            (cpu_jtag_debug_module_readdata),
      .jtag_debug_module_reset               (cpu_jtag_debug_module_reset),
      .jtag_debug_module_resetrequest        (cpu_jtag_debug_module_resetrequest),
      .jtag_debug_module_select              (cpu_jtag_debug_module_chipselect),
      .jtag_debug_module_write               (cpu_jtag_debug_module_write),
      .jtag_debug_module_writedata           (cpu_jtag_debug_module_writedata),
      .reset_n                               (cpu_jtag_debug_module_reset_n)
    );

  i2c_sclk_s1_arbitrator the_i2c_sclk_s1
    (
      .clk                                           (pll_c0_system),
      .cpu_data_master_address_to_slave              (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_i2c_sclk_s1           (cpu_data_master_granted_i2c_sclk_s1),
      .cpu_data_master_latency_counter               (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_i2c_sclk_s1 (cpu_data_master_qualified_request_i2c_sclk_s1),
      .cpu_data_master_read                          (cpu_data_master_read),
      .cpu_data_master_read_data_valid_i2c_sclk_s1   (cpu_data_master_read_data_valid_i2c_sclk_s1),
      .cpu_data_master_requests_i2c_sclk_s1          (cpu_data_master_requests_i2c_sclk_s1),
      .cpu_data_master_write                         (cpu_data_master_write),
      .cpu_data_master_writedata                     (cpu_data_master_writedata),
      .d1_i2c_sclk_s1_end_xfer                       (d1_i2c_sclk_s1_end_xfer),
      .i2c_sclk_s1_address                           (i2c_sclk_s1_address),
      .i2c_sclk_s1_chipselect                        (i2c_sclk_s1_chipselect),
      .i2c_sclk_s1_reset_n                           (i2c_sclk_s1_reset_n),
      .i2c_sclk_s1_write_n                           (i2c_sclk_s1_write_n),
      .i2c_sclk_s1_writedata                         (i2c_sclk_s1_writedata),
      .reset_n                                       (pll_c0_system_reset_n)
    );

  i2c_sclk the_i2c_sclk
    (
      .address    (i2c_sclk_s1_address),
      .chipselect (i2c_sclk_s1_chipselect),
      .clk        (pll_c0_system),
      .out_port   (out_port_from_the_i2c_sclk),
      .reset_n    (i2c_sclk_s1_reset_n),
      .write_n    (i2c_sclk_s1_write_n),
      .writedata  (i2c_sclk_s1_writedata)
    );

  i2c_sdat_s1_arbitrator the_i2c_sdat_s1
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_i2c_sdat_s1                        (cpu_data_master_granted_i2c_sdat_s1),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_i2c_sdat_s1              (cpu_data_master_qualified_request_i2c_sdat_s1),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_i2c_sdat_s1                (cpu_data_master_read_data_valid_i2c_sdat_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_i2c_sdat_s1                       (cpu_data_master_requests_i2c_sdat_s1),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_i2c_sdat_s1_end_xfer                                    (d1_i2c_sdat_s1_end_xfer),
      .i2c_sdat_s1_address                                        (i2c_sdat_s1_address),
      .i2c_sdat_s1_chipselect                                     (i2c_sdat_s1_chipselect),
      .i2c_sdat_s1_readdata                                       (i2c_sdat_s1_readdata),
      .i2c_sdat_s1_readdata_from_sa                               (i2c_sdat_s1_readdata_from_sa),
      .i2c_sdat_s1_reset_n                                        (i2c_sdat_s1_reset_n),
      .i2c_sdat_s1_write_n                                        (i2c_sdat_s1_write_n),
      .i2c_sdat_s1_writedata                                      (i2c_sdat_s1_writedata),
      .reset_n                                                    (pll_c0_system_reset_n)
    );

  i2c_sdat the_i2c_sdat
    (
      .address    (i2c_sdat_s1_address),
      .bidir_port (bidir_port_to_and_from_the_i2c_sdat),
      .chipselect (i2c_sdat_s1_chipselect),
      .clk        (pll_c0_system),
      .readdata   (i2c_sdat_s1_readdata),
      .reset_n    (i2c_sdat_s1_reset_n),
      .write_n    (i2c_sdat_s1_write_n),
      .writedata  (i2c_sdat_s1_writedata)
    );

  jtag_uart_avalon_jtag_slave_arbitrator the_jtag_uart_avalon_jtag_slave
    (
      .clk                                                           (pll_c0_system),
      .cpu_data_master_address_to_slave                              (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_jtag_uart_avalon_jtag_slave           (cpu_data_master_granted_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_latency_counter                               (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave (cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_read                                          (cpu_data_master_read),
      .cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave   (cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register    (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register    (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_jtag_uart_avalon_jtag_slave          (cpu_data_master_requests_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_write                                         (cpu_data_master_write),
      .cpu_data_master_writedata                                     (cpu_data_master_writedata),
      .d1_jtag_uart_avalon_jtag_slave_end_xfer                       (d1_jtag_uart_avalon_jtag_slave_end_xfer),
      .jtag_uart_avalon_jtag_slave_address                           (jtag_uart_avalon_jtag_slave_address),
      .jtag_uart_avalon_jtag_slave_chipselect                        (jtag_uart_avalon_jtag_slave_chipselect),
      .jtag_uart_avalon_jtag_slave_dataavailable                     (jtag_uart_avalon_jtag_slave_dataavailable),
      .jtag_uart_avalon_jtag_slave_dataavailable_from_sa             (jtag_uart_avalon_jtag_slave_dataavailable_from_sa),
      .jtag_uart_avalon_jtag_slave_irq                               (jtag_uart_avalon_jtag_slave_irq),
      .jtag_uart_avalon_jtag_slave_irq_from_sa                       (jtag_uart_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_avalon_jtag_slave_read_n                            (jtag_uart_avalon_jtag_slave_read_n),
      .jtag_uart_avalon_jtag_slave_readdata                          (jtag_uart_avalon_jtag_slave_readdata),
      .jtag_uart_avalon_jtag_slave_readdata_from_sa                  (jtag_uart_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_avalon_jtag_slave_readyfordata                      (jtag_uart_avalon_jtag_slave_readyfordata),
      .jtag_uart_avalon_jtag_slave_readyfordata_from_sa              (jtag_uart_avalon_jtag_slave_readyfordata_from_sa),
      .jtag_uart_avalon_jtag_slave_reset_n                           (jtag_uart_avalon_jtag_slave_reset_n),
      .jtag_uart_avalon_jtag_slave_waitrequest                       (jtag_uart_avalon_jtag_slave_waitrequest),
      .jtag_uart_avalon_jtag_slave_waitrequest_from_sa               (jtag_uart_avalon_jtag_slave_waitrequest_from_sa),
      .jtag_uart_avalon_jtag_slave_write_n                           (jtag_uart_avalon_jtag_slave_write_n),
      .jtag_uart_avalon_jtag_slave_writedata                         (jtag_uart_avalon_jtag_slave_writedata),
      .reset_n                                                       (pll_c0_system_reset_n)
    );

  jtag_uart the_jtag_uart
    (
      .av_address     (jtag_uart_avalon_jtag_slave_address),
      .av_chipselect  (jtag_uart_avalon_jtag_slave_chipselect),
      .av_irq         (jtag_uart_avalon_jtag_slave_irq),
      .av_read_n      (jtag_uart_avalon_jtag_slave_read_n),
      .av_readdata    (jtag_uart_avalon_jtag_slave_readdata),
      .av_waitrequest (jtag_uart_avalon_jtag_slave_waitrequest),
      .av_write_n     (jtag_uart_avalon_jtag_slave_write_n),
      .av_writedata   (jtag_uart_avalon_jtag_slave_writedata),
      .clk            (pll_c0_system),
      .dataavailable  (jtag_uart_avalon_jtag_slave_dataavailable),
      .readyfordata   (jtag_uart_avalon_jtag_slave_readyfordata),
      .rst_n          (jtag_uart_avalon_jtag_slave_reset_n)
    );

  lcd_control_slave_arbitrator the_lcd_control_slave
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                 (cpu_data_master_byteenable),
      .cpu_data_master_granted_lcd_control_slave                  (cpu_data_master_granted_lcd_control_slave),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_lcd_control_slave        (cpu_data_master_qualified_request_lcd_control_slave),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_lcd_control_slave          (cpu_data_master_read_data_valid_lcd_control_slave),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_lcd_control_slave                 (cpu_data_master_requests_lcd_control_slave),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_lcd_control_slave_end_xfer                              (d1_lcd_control_slave_end_xfer),
      .lcd_control_slave_address                                  (lcd_control_slave_address),
      .lcd_control_slave_begintransfer                            (lcd_control_slave_begintransfer),
      .lcd_control_slave_read                                     (lcd_control_slave_read),
      .lcd_control_slave_readdata                                 (lcd_control_slave_readdata),
      .lcd_control_slave_readdata_from_sa                         (lcd_control_slave_readdata_from_sa),
      .lcd_control_slave_wait_counter_eq_0                        (lcd_control_slave_wait_counter_eq_0),
      .lcd_control_slave_write                                    (lcd_control_slave_write),
      .lcd_control_slave_writedata                                (lcd_control_slave_writedata),
      .reset_n                                                    (pll_c0_system_reset_n)
    );

  lcd the_lcd
    (
      .LCD_E         (LCD_E_from_the_lcd),
      .LCD_RS        (LCD_RS_from_the_lcd),
      .LCD_RW        (LCD_RW_from_the_lcd),
      .LCD_data      (LCD_data_to_and_from_the_lcd),
      .address       (lcd_control_slave_address),
      .begintransfer (lcd_control_slave_begintransfer),
      .read          (lcd_control_slave_read),
      .readdata      (lcd_control_slave_readdata),
      .write         (lcd_control_slave_write),
      .writedata     (lcd_control_slave_writedata)
    );

  onchip_mem_s1_arbitrator the_onchip_mem_s1
    (
      .clk                                                               (pll_c0_system),
      .cpu_data_master_address_to_slave                                  (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                        (cpu_data_master_byteenable),
      .cpu_data_master_granted_onchip_mem_s1                             (cpu_data_master_granted_onchip_mem_s1),
      .cpu_data_master_latency_counter                                   (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_onchip_mem_s1                   (cpu_data_master_qualified_request_onchip_mem_s1),
      .cpu_data_master_read                                              (cpu_data_master_read),
      .cpu_data_master_read_data_valid_onchip_mem_s1                     (cpu_data_master_read_data_valid_onchip_mem_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_onchip_mem_s1                            (cpu_data_master_requests_onchip_mem_s1),
      .cpu_data_master_write                                             (cpu_data_master_write),
      .cpu_data_master_writedata                                         (cpu_data_master_writedata),
      .cpu_instruction_master_address_to_slave                           (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_granted_onchip_mem_s1                      (cpu_instruction_master_granted_onchip_mem_s1),
      .cpu_instruction_master_latency_counter                            (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_onchip_mem_s1            (cpu_instruction_master_qualified_request_onchip_mem_s1),
      .cpu_instruction_master_read                                       (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_onchip_mem_s1              (cpu_instruction_master_read_data_valid_onchip_mem_s1),
      .cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_instruction_master_requests_onchip_mem_s1                     (cpu_instruction_master_requests_onchip_mem_s1),
      .d1_onchip_mem_s1_end_xfer                                         (d1_onchip_mem_s1_end_xfer),
      .onchip_mem_s1_address                                             (onchip_mem_s1_address),
      .onchip_mem_s1_byteenable                                          (onchip_mem_s1_byteenable),
      .onchip_mem_s1_chipselect                                          (onchip_mem_s1_chipselect),
      .onchip_mem_s1_clken                                               (onchip_mem_s1_clken),
      .onchip_mem_s1_readdata                                            (onchip_mem_s1_readdata),
      .onchip_mem_s1_readdata_from_sa                                    (onchip_mem_s1_readdata_from_sa),
      .onchip_mem_s1_write                                               (onchip_mem_s1_write),
      .onchip_mem_s1_writedata                                           (onchip_mem_s1_writedata),
      .reset_n                                                           (pll_c0_system_reset_n)
    );

  onchip_mem the_onchip_mem
    (
      .address    (onchip_mem_s1_address),
      .byteenable (onchip_mem_s1_byteenable),
      .chipselect (onchip_mem_s1_chipselect),
      .clk        (pll_c0_system),
      .clken      (onchip_mem_s1_clken),
      .readdata   (onchip_mem_s1_readdata),
      .write      (onchip_mem_s1_write),
      .writedata  (onchip_mem_s1_writedata)
    );

  pio_button_s1_arbitrator the_pio_button_s1
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_pio_button_s1                      (cpu_data_master_granted_pio_button_s1),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_pio_button_s1            (cpu_data_master_qualified_request_pio_button_s1),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_pio_button_s1              (cpu_data_master_read_data_valid_pio_button_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_pio_button_s1                     (cpu_data_master_requests_pio_button_s1),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_pio_button_s1_end_xfer                                  (d1_pio_button_s1_end_xfer),
      .pio_button_s1_address                                      (pio_button_s1_address),
      .pio_button_s1_chipselect                                   (pio_button_s1_chipselect),
      .pio_button_s1_irq                                          (pio_button_s1_irq),
      .pio_button_s1_irq_from_sa                                  (pio_button_s1_irq_from_sa),
      .pio_button_s1_readdata                                     (pio_button_s1_readdata),
      .pio_button_s1_readdata_from_sa                             (pio_button_s1_readdata_from_sa),
      .pio_button_s1_reset_n                                      (pio_button_s1_reset_n),
      .pio_button_s1_write_n                                      (pio_button_s1_write_n),
      .pio_button_s1_writedata                                    (pio_button_s1_writedata),
      .reset_n                                                    (pll_c0_system_reset_n)
    );

  pio_button the_pio_button
    (
      .address    (pio_button_s1_address),
      .chipselect (pio_button_s1_chipselect),
      .clk        (pll_c0_system),
      .in_port    (in_port_to_the_pio_button),
      .irq        (pio_button_s1_irq),
      .readdata   (pio_button_s1_readdata),
      .reset_n    (pio_button_s1_reset_n),
      .write_n    (pio_button_s1_write_n),
      .writedata  (pio_button_s1_writedata)
    );

  pio_green_led_s1_arbitrator the_pio_green_led_s1
    (
      .clk                                                (pll_c0_system),
      .cpu_data_master_address_to_slave                   (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_pio_green_led_s1           (cpu_data_master_granted_pio_green_led_s1),
      .cpu_data_master_latency_counter                    (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_pio_green_led_s1 (cpu_data_master_qualified_request_pio_green_led_s1),
      .cpu_data_master_read                               (cpu_data_master_read),
      .cpu_data_master_read_data_valid_pio_green_led_s1   (cpu_data_master_read_data_valid_pio_green_led_s1),
      .cpu_data_master_requests_pio_green_led_s1          (cpu_data_master_requests_pio_green_led_s1),
      .cpu_data_master_write                              (cpu_data_master_write),
      .cpu_data_master_writedata                          (cpu_data_master_writedata),
      .d1_pio_green_led_s1_end_xfer                       (d1_pio_green_led_s1_end_xfer),
      .pio_green_led_s1_address                           (pio_green_led_s1_address),
      .pio_green_led_s1_chipselect                        (pio_green_led_s1_chipselect),
      .pio_green_led_s1_reset_n                           (pio_green_led_s1_reset_n),
      .pio_green_led_s1_write_n                           (pio_green_led_s1_write_n),
      .pio_green_led_s1_writedata                         (pio_green_led_s1_writedata),
      .reset_n                                            (pll_c0_system_reset_n)
    );

  pio_green_led the_pio_green_led
    (
      .address    (pio_green_led_s1_address),
      .chipselect (pio_green_led_s1_chipselect),
      .clk        (pll_c0_system),
      .out_port   (out_port_from_the_pio_green_led),
      .reset_n    (pio_green_led_s1_reset_n),
      .write_n    (pio_green_led_s1_write_n),
      .writedata  (pio_green_led_s1_writedata)
    );

  pio_red_led_s1_arbitrator the_pio_red_led_s1
    (
      .clk                                              (pll_c0_system),
      .cpu_data_master_address_to_slave                 (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_pio_red_led_s1           (cpu_data_master_granted_pio_red_led_s1),
      .cpu_data_master_latency_counter                  (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_pio_red_led_s1 (cpu_data_master_qualified_request_pio_red_led_s1),
      .cpu_data_master_read                             (cpu_data_master_read),
      .cpu_data_master_read_data_valid_pio_red_led_s1   (cpu_data_master_read_data_valid_pio_red_led_s1),
      .cpu_data_master_requests_pio_red_led_s1          (cpu_data_master_requests_pio_red_led_s1),
      .cpu_data_master_write                            (cpu_data_master_write),
      .cpu_data_master_writedata                        (cpu_data_master_writedata),
      .d1_pio_red_led_s1_end_xfer                       (d1_pio_red_led_s1_end_xfer),
      .pio_red_led_s1_address                           (pio_red_led_s1_address),
      .pio_red_led_s1_chipselect                        (pio_red_led_s1_chipselect),
      .pio_red_led_s1_reset_n                           (pio_red_led_s1_reset_n),
      .pio_red_led_s1_write_n                           (pio_red_led_s1_write_n),
      .pio_red_led_s1_writedata                         (pio_red_led_s1_writedata),
      .reset_n                                          (pll_c0_system_reset_n)
    );

  pio_red_led the_pio_red_led
    (
      .address    (pio_red_led_s1_address),
      .chipselect (pio_red_led_s1_chipselect),
      .clk        (pll_c0_system),
      .out_port   (out_port_from_the_pio_red_led),
      .reset_n    (pio_red_led_s1_reset_n),
      .write_n    (pio_red_led_s1_write_n),
      .writedata  (pio_red_led_s1_writedata)
    );

  pio_switch_s1_arbitrator the_pio_switch_s1
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_pio_switch_s1                      (cpu_data_master_granted_pio_switch_s1),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_pio_switch_s1            (cpu_data_master_qualified_request_pio_switch_s1),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_pio_switch_s1              (cpu_data_master_read_data_valid_pio_switch_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_pio_switch_s1                     (cpu_data_master_requests_pio_switch_s1),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .d1_pio_switch_s1_end_xfer                                  (d1_pio_switch_s1_end_xfer),
      .pio_switch_s1_address                                      (pio_switch_s1_address),
      .pio_switch_s1_readdata                                     (pio_switch_s1_readdata),
      .pio_switch_s1_readdata_from_sa                             (pio_switch_s1_readdata_from_sa),
      .pio_switch_s1_reset_n                                      (pio_switch_s1_reset_n),
      .reset_n                                                    (pll_c0_system_reset_n)
    );

  pio_switch the_pio_switch
    (
      .address  (pio_switch_s1_address),
      .clk      (pll_c0_system),
      .in_port  (in_port_to_the_pio_switch),
      .readdata (pio_switch_s1_readdata),
      .reset_n  (pio_switch_s1_reset_n)
    );

  pll_s1_arbitrator the_pll_s1
    (
      .clk                                  (clk_50),
      .clock_0_out_address_to_slave         (clock_0_out_address_to_slave),
      .clock_0_out_granted_pll_s1           (clock_0_out_granted_pll_s1),
      .clock_0_out_nativeaddress            (clock_0_out_nativeaddress),
      .clock_0_out_qualified_request_pll_s1 (clock_0_out_qualified_request_pll_s1),
      .clock_0_out_read                     (clock_0_out_read),
      .clock_0_out_read_data_valid_pll_s1   (clock_0_out_read_data_valid_pll_s1),
      .clock_0_out_requests_pll_s1          (clock_0_out_requests_pll_s1),
      .clock_0_out_write                    (clock_0_out_write),
      .clock_0_out_writedata                (clock_0_out_writedata),
      .d1_pll_s1_end_xfer                   (d1_pll_s1_end_xfer),
      .pll_s1_address                       (pll_s1_address),
      .pll_s1_chipselect                    (pll_s1_chipselect),
      .pll_s1_read                          (pll_s1_read),
      .pll_s1_readdata                      (pll_s1_readdata),
      .pll_s1_readdata_from_sa              (pll_s1_readdata_from_sa),
      .pll_s1_reset_n                       (pll_s1_reset_n),
      .pll_s1_resetrequest                  (pll_s1_resetrequest),
      .pll_s1_resetrequest_from_sa          (pll_s1_resetrequest_from_sa),
      .pll_s1_write                         (pll_s1_write),
      .pll_s1_writedata                     (pll_s1_writedata),
      .reset_n                              (clk_50_reset_n)
    );

  //pll_c0_system out_clk assignment, which is an e_assign
  assign pll_c0_system = out_clk_pll_c0;

  //pll_c1_memory out_clk assignment, which is an e_assign
  assign pll_c1_memory = out_clk_pll_c1;

  //pll_c2_audio out_clk assignment, which is an e_assign
  assign pll_c2_audio = out_clk_pll_c2;

  pll the_pll
    (
      .address      (pll_s1_address),
      .c0           (out_clk_pll_c0),
      .c1           (out_clk_pll_c1),
      .c2           (out_clk_pll_c2),
      .chipselect   (pll_s1_chipselect),
      .clk          (clk_50),
      .read         (pll_s1_read),
      .readdata     (pll_s1_readdata),
      .reset_n      (pll_s1_reset_n),
      .resetrequest (pll_s1_resetrequest),
      .write        (pll_s1_write),
      .writedata    (pll_s1_writedata)
    );

  ps2_keyboard_avalon_PS2_slave_arbitrator the_ps2_keyboard_avalon_PS2_slave
    (
      .clk                                                             (pll_c0_system),
      .cpu_data_master_address_to_slave                                (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                      (cpu_data_master_byteenable),
      .cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave           (cpu_data_master_granted_ps2_keyboard_avalon_PS2_slave),
      .cpu_data_master_latency_counter                                 (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_ps2_keyboard_avalon_PS2_slave (cpu_data_master_qualified_request_ps2_keyboard_avalon_PS2_slave),
      .cpu_data_master_read                                            (cpu_data_master_read),
      .cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave   (cpu_data_master_read_data_valid_ps2_keyboard_avalon_PS2_slave),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register      (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register      (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_ps2_keyboard_avalon_PS2_slave          (cpu_data_master_requests_ps2_keyboard_avalon_PS2_slave),
      .cpu_data_master_write                                           (cpu_data_master_write),
      .cpu_data_master_writedata                                       (cpu_data_master_writedata),
      .d1_ps2_keyboard_avalon_PS2_slave_end_xfer                       (d1_ps2_keyboard_avalon_PS2_slave_end_xfer),
      .ps2_keyboard_avalon_PS2_slave_address                           (ps2_keyboard_avalon_PS2_slave_address),
      .ps2_keyboard_avalon_PS2_slave_byteenable                        (ps2_keyboard_avalon_PS2_slave_byteenable),
      .ps2_keyboard_avalon_PS2_slave_chipselect                        (ps2_keyboard_avalon_PS2_slave_chipselect),
      .ps2_keyboard_avalon_PS2_slave_irq                               (ps2_keyboard_avalon_PS2_slave_irq),
      .ps2_keyboard_avalon_PS2_slave_irq_from_sa                       (ps2_keyboard_avalon_PS2_slave_irq_from_sa),
      .ps2_keyboard_avalon_PS2_slave_read                              (ps2_keyboard_avalon_PS2_slave_read),
      .ps2_keyboard_avalon_PS2_slave_readdata                          (ps2_keyboard_avalon_PS2_slave_readdata),
      .ps2_keyboard_avalon_PS2_slave_readdata_from_sa                  (ps2_keyboard_avalon_PS2_slave_readdata_from_sa),
      .ps2_keyboard_avalon_PS2_slave_waitrequest                       (ps2_keyboard_avalon_PS2_slave_waitrequest),
      .ps2_keyboard_avalon_PS2_slave_waitrequest_from_sa               (ps2_keyboard_avalon_PS2_slave_waitrequest_from_sa),
      .ps2_keyboard_avalon_PS2_slave_write                             (ps2_keyboard_avalon_PS2_slave_write),
      .ps2_keyboard_avalon_PS2_slave_writedata                         (ps2_keyboard_avalon_PS2_slave_writedata),
      .reset_n                                                         (pll_c0_system_reset_n)
    );

  //complemented pll_c0_system_reset_n, which is an e_assign
  assign pll_c0_system_reset = ~pll_c0_system_reset_n;

  //reset is asserted asynchronously and deasserted synchronously
  DE2_70_SOPC_reset_pll_c0_system_domain_synch_module DE2_70_SOPC_reset_pll_c0_system_domain_synch
    (
      .clk      (pll_c0_system),
      .data_in  (1'b1),
      .data_out (pll_c0_system_reset_n),
      .reset_n  (reset_n_sources)
    );

  //reset sources mux, which is an e_mux
  assign reset_n_sources = ~(~reset_n |
    0 |
    0 |
    cpu_jtag_debug_module_resetrequest_from_sa |
    cpu_jtag_debug_module_resetrequest_from_sa |
    0 |
    pll_s1_resetrequest_from_sa |
    pll_s1_resetrequest_from_sa);

  ps2_keyboard the_ps2_keyboard
    (
      .PS2_CLK     (PS2_CLK_to_and_from_the_ps2_keyboard),
      .PS2_DAT     (PS2_DAT_to_and_from_the_ps2_keyboard),
      .address     (ps2_keyboard_avalon_PS2_slave_address),
      .byteenable  (ps2_keyboard_avalon_PS2_slave_byteenable),
      .chipselect  (ps2_keyboard_avalon_PS2_slave_chipselect),
      .clk         (pll_c0_system),
      .irq         (ps2_keyboard_avalon_PS2_slave_irq),
      .read        (ps2_keyboard_avalon_PS2_slave_read),
      .readdata    (ps2_keyboard_avalon_PS2_slave_readdata),
      .reset       (pll_c0_system_reset),
      .waitrequest (ps2_keyboard_avalon_PS2_slave_waitrequest),
      .write       (ps2_keyboard_avalon_PS2_slave_write),
      .writedata   (ps2_keyboard_avalon_PS2_slave_writedata)
    );

  ps2_mouse_avalon_PS2_slave_arbitrator the_ps2_mouse_avalon_PS2_slave
    (
      .clk                                                          (pll_c0_system),
      .cpu_data_master_address_to_slave                             (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                   (cpu_data_master_byteenable),
      .cpu_data_master_granted_ps2_mouse_avalon_PS2_slave           (cpu_data_master_granted_ps2_mouse_avalon_PS2_slave),
      .cpu_data_master_latency_counter                              (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_ps2_mouse_avalon_PS2_slave (cpu_data_master_qualified_request_ps2_mouse_avalon_PS2_slave),
      .cpu_data_master_read                                         (cpu_data_master_read),
      .cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave   (cpu_data_master_read_data_valid_ps2_mouse_avalon_PS2_slave),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register   (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register   (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_ps2_mouse_avalon_PS2_slave          (cpu_data_master_requests_ps2_mouse_avalon_PS2_slave),
      .cpu_data_master_write                                        (cpu_data_master_write),
      .cpu_data_master_writedata                                    (cpu_data_master_writedata),
      .d1_ps2_mouse_avalon_PS2_slave_end_xfer                       (d1_ps2_mouse_avalon_PS2_slave_end_xfer),
      .ps2_mouse_avalon_PS2_slave_address                           (ps2_mouse_avalon_PS2_slave_address),
      .ps2_mouse_avalon_PS2_slave_byteenable                        (ps2_mouse_avalon_PS2_slave_byteenable),
      .ps2_mouse_avalon_PS2_slave_chipselect                        (ps2_mouse_avalon_PS2_slave_chipselect),
      .ps2_mouse_avalon_PS2_slave_irq                               (ps2_mouse_avalon_PS2_slave_irq),
      .ps2_mouse_avalon_PS2_slave_irq_from_sa                       (ps2_mouse_avalon_PS2_slave_irq_from_sa),
      .ps2_mouse_avalon_PS2_slave_read                              (ps2_mouse_avalon_PS2_slave_read),
      .ps2_mouse_avalon_PS2_slave_readdata                          (ps2_mouse_avalon_PS2_slave_readdata),
      .ps2_mouse_avalon_PS2_slave_readdata_from_sa                  (ps2_mouse_avalon_PS2_slave_readdata_from_sa),
      .ps2_mouse_avalon_PS2_slave_waitrequest                       (ps2_mouse_avalon_PS2_slave_waitrequest),
      .ps2_mouse_avalon_PS2_slave_waitrequest_from_sa               (ps2_mouse_avalon_PS2_slave_waitrequest_from_sa),
      .ps2_mouse_avalon_PS2_slave_write                             (ps2_mouse_avalon_PS2_slave_write),
      .ps2_mouse_avalon_PS2_slave_writedata                         (ps2_mouse_avalon_PS2_slave_writedata),
      .reset_n                                                      (pll_c0_system_reset_n)
    );

  ps2_mouse the_ps2_mouse
    (
      .PS2_CLK     (PS2_CLK_to_and_from_the_ps2_mouse),
      .PS2_DAT     (PS2_DAT_to_and_from_the_ps2_mouse),
      .address     (ps2_mouse_avalon_PS2_slave_address),
      .byteenable  (ps2_mouse_avalon_PS2_slave_byteenable),
      .chipselect  (ps2_mouse_avalon_PS2_slave_chipselect),
      .clk         (pll_c0_system),
      .irq         (ps2_mouse_avalon_PS2_slave_irq),
      .read        (ps2_mouse_avalon_PS2_slave_read),
      .readdata    (ps2_mouse_avalon_PS2_slave_readdata),
      .reset       (pll_c0_system_reset),
      .waitrequest (ps2_mouse_avalon_PS2_slave_waitrequest),
      .write       (ps2_mouse_avalon_PS2_slave_write),
      .writedata   (ps2_mouse_avalon_PS2_slave_writedata)
    );

  sd_clk_s1_arbitrator the_sd_clk_s1
    (
      .clk                                         (pll_c0_system),
      .cpu_data_master_address_to_slave            (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_sd_clk_s1           (cpu_data_master_granted_sd_clk_s1),
      .cpu_data_master_latency_counter             (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_sd_clk_s1 (cpu_data_master_qualified_request_sd_clk_s1),
      .cpu_data_master_read                        (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sd_clk_s1   (cpu_data_master_read_data_valid_sd_clk_s1),
      .cpu_data_master_requests_sd_clk_s1          (cpu_data_master_requests_sd_clk_s1),
      .cpu_data_master_write                       (cpu_data_master_write),
      .cpu_data_master_writedata                   (cpu_data_master_writedata),
      .d1_sd_clk_s1_end_xfer                       (d1_sd_clk_s1_end_xfer),
      .reset_n                                     (pll_c0_system_reset_n),
      .sd_clk_s1_address                           (sd_clk_s1_address),
      .sd_clk_s1_chipselect                        (sd_clk_s1_chipselect),
      .sd_clk_s1_reset_n                           (sd_clk_s1_reset_n),
      .sd_clk_s1_write_n                           (sd_clk_s1_write_n),
      .sd_clk_s1_writedata                         (sd_clk_s1_writedata)
    );

  sd_clk the_sd_clk
    (
      .address    (sd_clk_s1_address),
      .chipselect (sd_clk_s1_chipselect),
      .clk        (pll_c0_system),
      .out_port   (out_port_from_the_sd_clk),
      .reset_n    (sd_clk_s1_reset_n),
      .write_n    (sd_clk_s1_write_n),
      .writedata  (sd_clk_s1_writedata)
    );

  sd_cmd_s1_arbitrator the_sd_cmd_s1
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_sd_cmd_s1                          (cpu_data_master_granted_sd_cmd_s1),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_sd_cmd_s1                (cpu_data_master_qualified_request_sd_cmd_s1),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sd_cmd_s1                  (cpu_data_master_read_data_valid_sd_cmd_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_sd_cmd_s1                         (cpu_data_master_requests_sd_cmd_s1),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_sd_cmd_s1_end_xfer                                      (d1_sd_cmd_s1_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n),
      .sd_cmd_s1_address                                          (sd_cmd_s1_address),
      .sd_cmd_s1_chipselect                                       (sd_cmd_s1_chipselect),
      .sd_cmd_s1_readdata                                         (sd_cmd_s1_readdata),
      .sd_cmd_s1_readdata_from_sa                                 (sd_cmd_s1_readdata_from_sa),
      .sd_cmd_s1_reset_n                                          (sd_cmd_s1_reset_n),
      .sd_cmd_s1_write_n                                          (sd_cmd_s1_write_n),
      .sd_cmd_s1_writedata                                        (sd_cmd_s1_writedata)
    );

  sd_cmd the_sd_cmd
    (
      .address    (sd_cmd_s1_address),
      .bidir_port (bidir_port_to_and_from_the_sd_cmd),
      .chipselect (sd_cmd_s1_chipselect),
      .clk        (pll_c0_system),
      .readdata   (sd_cmd_s1_readdata),
      .reset_n    (sd_cmd_s1_reset_n),
      .write_n    (sd_cmd_s1_write_n),
      .writedata  (sd_cmd_s1_writedata)
    );

  sd_dat_s1_arbitrator the_sd_dat_s1
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_sd_dat_s1                          (cpu_data_master_granted_sd_dat_s1),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_sd_dat_s1                (cpu_data_master_qualified_request_sd_dat_s1),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sd_dat_s1                  (cpu_data_master_read_data_valid_sd_dat_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_sd_dat_s1                         (cpu_data_master_requests_sd_dat_s1),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_sd_dat_s1_end_xfer                                      (d1_sd_dat_s1_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n),
      .sd_dat_s1_address                                          (sd_dat_s1_address),
      .sd_dat_s1_chipselect                                       (sd_dat_s1_chipselect),
      .sd_dat_s1_readdata                                         (sd_dat_s1_readdata),
      .sd_dat_s1_readdata_from_sa                                 (sd_dat_s1_readdata_from_sa),
      .sd_dat_s1_reset_n                                          (sd_dat_s1_reset_n),
      .sd_dat_s1_write_n                                          (sd_dat_s1_write_n),
      .sd_dat_s1_writedata                                        (sd_dat_s1_writedata)
    );

  sd_dat the_sd_dat
    (
      .address    (sd_dat_s1_address),
      .bidir_port (bidir_port_to_and_from_the_sd_dat),
      .chipselect (sd_dat_s1_chipselect),
      .clk        (pll_c0_system),
      .readdata   (sd_dat_s1_readdata),
      .reset_n    (sd_dat_s1_reset_n),
      .write_n    (sd_dat_s1_write_n),
      .writedata  (sd_dat_s1_writedata)
    );

  sd_dat3_s1_arbitrator the_sd_dat3_s1
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_sd_dat3_s1                         (cpu_data_master_granted_sd_dat3_s1),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_sd_dat3_s1               (cpu_data_master_qualified_request_sd_dat3_s1),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sd_dat3_s1                 (cpu_data_master_read_data_valid_sd_dat3_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_sd_dat3_s1                        (cpu_data_master_requests_sd_dat3_s1),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_sd_dat3_s1_end_xfer                                     (d1_sd_dat3_s1_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n),
      .sd_dat3_s1_address                                         (sd_dat3_s1_address),
      .sd_dat3_s1_chipselect                                      (sd_dat3_s1_chipselect),
      .sd_dat3_s1_readdata                                        (sd_dat3_s1_readdata),
      .sd_dat3_s1_readdata_from_sa                                (sd_dat3_s1_readdata_from_sa),
      .sd_dat3_s1_reset_n                                         (sd_dat3_s1_reset_n),
      .sd_dat3_s1_write_n                                         (sd_dat3_s1_write_n),
      .sd_dat3_s1_writedata                                       (sd_dat3_s1_writedata)
    );

  sd_dat3 the_sd_dat3
    (
      .address    (sd_dat3_s1_address),
      .bidir_port (bidir_port_to_and_from_the_sd_dat3),
      .chipselect (sd_dat3_s1_chipselect),
      .clk        (pll_c0_system),
      .readdata   (sd_dat3_s1_readdata),
      .reset_n    (sd_dat3_s1_reset_n),
      .write_n    (sd_dat3_s1_write_n),
      .writedata  (sd_dat3_s1_writedata)
    );

  sdram_u1_s1_arbitrator the_sdram_u1_s1
    (
      .clk                                                               (pll_c0_system),
      .cpu_data_master_address_to_slave                                  (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                        (cpu_data_master_byteenable),
      .cpu_data_master_byteenable_sdram_u1_s1                            (cpu_data_master_byteenable_sdram_u1_s1),
      .cpu_data_master_dbs_address                                       (cpu_data_master_dbs_address),
      .cpu_data_master_dbs_write_16                                      (cpu_data_master_dbs_write_16),
      .cpu_data_master_granted_sdram_u1_s1                               (cpu_data_master_granted_sdram_u1_s1),
      .cpu_data_master_latency_counter                                   (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_sdram_u1_s1                     (cpu_data_master_qualified_request_sdram_u1_s1),
      .cpu_data_master_read                                              (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sdram_u1_s1                       (cpu_data_master_read_data_valid_sdram_u1_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_sdram_u1_s1                              (cpu_data_master_requests_sdram_u1_s1),
      .cpu_data_master_write                                             (cpu_data_master_write),
      .cpu_instruction_master_address_to_slave                           (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_dbs_address                                (cpu_instruction_master_dbs_address),
      .cpu_instruction_master_granted_sdram_u1_s1                        (cpu_instruction_master_granted_sdram_u1_s1),
      .cpu_instruction_master_latency_counter                            (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_sdram_u1_s1              (cpu_instruction_master_qualified_request_sdram_u1_s1),
      .cpu_instruction_master_read                                       (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_sdram_u1_s1                (cpu_instruction_master_read_data_valid_sdram_u1_s1),
      .cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_instruction_master_requests_sdram_u1_s1                       (cpu_instruction_master_requests_sdram_u1_s1),
      .d1_sdram_u1_s1_end_xfer                                           (d1_sdram_u1_s1_end_xfer),
      .reset_n                                                           (pll_c0_system_reset_n),
      .sdram_u1_s1_address                                               (sdram_u1_s1_address),
      .sdram_u1_s1_byteenable_n                                          (sdram_u1_s1_byteenable_n),
      .sdram_u1_s1_chipselect                                            (sdram_u1_s1_chipselect),
      .sdram_u1_s1_read_n                                                (sdram_u1_s1_read_n),
      .sdram_u1_s1_readdata                                              (sdram_u1_s1_readdata),
      .sdram_u1_s1_readdata_from_sa                                      (sdram_u1_s1_readdata_from_sa),
      .sdram_u1_s1_readdatavalid                                         (sdram_u1_s1_readdatavalid),
      .sdram_u1_s1_reset_n                                               (sdram_u1_s1_reset_n),
      .sdram_u1_s1_waitrequest                                           (sdram_u1_s1_waitrequest),
      .sdram_u1_s1_waitrequest_from_sa                                   (sdram_u1_s1_waitrequest_from_sa),
      .sdram_u1_s1_write_n                                               (sdram_u1_s1_write_n),
      .sdram_u1_s1_writedata                                             (sdram_u1_s1_writedata)
    );

  sdram_u1 the_sdram_u1
    (
      .az_addr        (sdram_u1_s1_address),
      .az_be_n        (sdram_u1_s1_byteenable_n),
      .az_cs          (sdram_u1_s1_chipselect),
      .az_data        (sdram_u1_s1_writedata),
      .az_rd_n        (sdram_u1_s1_read_n),
      .az_wr_n        (sdram_u1_s1_write_n),
      .clk            (pll_c0_system),
      .reset_n        (sdram_u1_s1_reset_n),
      .za_data        (sdram_u1_s1_readdata),
      .za_valid       (sdram_u1_s1_readdatavalid),
      .za_waitrequest (sdram_u1_s1_waitrequest),
      .zs_addr        (zs_addr_from_the_sdram_u1),
      .zs_ba          (zs_ba_from_the_sdram_u1),
      .zs_cas_n       (zs_cas_n_from_the_sdram_u1),
      .zs_cke         (zs_cke_from_the_sdram_u1),
      .zs_cs_n        (zs_cs_n_from_the_sdram_u1),
      .zs_dq          (zs_dq_to_and_from_the_sdram_u1),
      .zs_dqm         (zs_dqm_from_the_sdram_u1),
      .zs_ras_n       (zs_ras_n_from_the_sdram_u1),
      .zs_we_n        (zs_we_n_from_the_sdram_u1)
    );

  sdram_u2_s1_arbitrator the_sdram_u2_s1
    (
      .clk                                                               (pll_c0_system),
      .cpu_data_master_address_to_slave                                  (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                        (cpu_data_master_byteenable),
      .cpu_data_master_byteenable_sdram_u2_s1                            (cpu_data_master_byteenable_sdram_u2_s1),
      .cpu_data_master_dbs_address                                       (cpu_data_master_dbs_address),
      .cpu_data_master_dbs_write_16                                      (cpu_data_master_dbs_write_16),
      .cpu_data_master_granted_sdram_u2_s1                               (cpu_data_master_granted_sdram_u2_s1),
      .cpu_data_master_latency_counter                                   (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_sdram_u2_s1                     (cpu_data_master_qualified_request_sdram_u2_s1),
      .cpu_data_master_read                                              (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1                       (cpu_data_master_read_data_valid_sdram_u2_s1),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_sdram_u2_s1                              (cpu_data_master_requests_sdram_u2_s1),
      .cpu_data_master_write                                             (cpu_data_master_write),
      .cpu_instruction_master_address_to_slave                           (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_dbs_address                                (cpu_instruction_master_dbs_address),
      .cpu_instruction_master_granted_sdram_u2_s1                        (cpu_instruction_master_granted_sdram_u2_s1),
      .cpu_instruction_master_latency_counter                            (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_sdram_u2_s1              (cpu_instruction_master_qualified_request_sdram_u2_s1),
      .cpu_instruction_master_read                                       (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_instruction_master_read_data_valid_sdram_u2_s1                (cpu_instruction_master_read_data_valid_sdram_u2_s1),
      .cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_instruction_master_requests_sdram_u2_s1                       (cpu_instruction_master_requests_sdram_u2_s1),
      .d1_sdram_u2_s1_end_xfer                                           (d1_sdram_u2_s1_end_xfer),
      .reset_n                                                           (pll_c0_system_reset_n),
      .sdram_u2_s1_address                                               (sdram_u2_s1_address),
      .sdram_u2_s1_byteenable_n                                          (sdram_u2_s1_byteenable_n),
      .sdram_u2_s1_chipselect                                            (sdram_u2_s1_chipselect),
      .sdram_u2_s1_read_n                                                (sdram_u2_s1_read_n),
      .sdram_u2_s1_readdata                                              (sdram_u2_s1_readdata),
      .sdram_u2_s1_readdata_from_sa                                      (sdram_u2_s1_readdata_from_sa),
      .sdram_u2_s1_readdatavalid                                         (sdram_u2_s1_readdatavalid),
      .sdram_u2_s1_reset_n                                               (sdram_u2_s1_reset_n),
      .sdram_u2_s1_waitrequest                                           (sdram_u2_s1_waitrequest),
      .sdram_u2_s1_waitrequest_from_sa                                   (sdram_u2_s1_waitrequest_from_sa),
      .sdram_u2_s1_write_n                                               (sdram_u2_s1_write_n),
      .sdram_u2_s1_writedata                                             (sdram_u2_s1_writedata)
    );

  sdram_u2 the_sdram_u2
    (
      .az_addr        (sdram_u2_s1_address),
      .az_be_n        (sdram_u2_s1_byteenable_n),
      .az_cs          (sdram_u2_s1_chipselect),
      .az_data        (sdram_u2_s1_writedata),
      .az_rd_n        (sdram_u2_s1_read_n),
      .az_wr_n        (sdram_u2_s1_write_n),
      .clk            (pll_c0_system),
      .reset_n        (sdram_u2_s1_reset_n),
      .za_data        (sdram_u2_s1_readdata),
      .za_valid       (sdram_u2_s1_readdatavalid),
      .za_waitrequest (sdram_u2_s1_waitrequest),
      .zs_addr        (zs_addr_from_the_sdram_u2),
      .zs_ba          (zs_ba_from_the_sdram_u2),
      .zs_cas_n       (zs_cas_n_from_the_sdram_u2),
      .zs_cke         (zs_cke_from_the_sdram_u2),
      .zs_cs_n        (zs_cs_n_from_the_sdram_u2),
      .zs_dq          (zs_dq_to_and_from_the_sdram_u2),
      .zs_dqm         (zs_dqm_from_the_sdram_u2),
      .zs_ras_n       (zs_ras_n_from_the_sdram_u2),
      .zs_we_n        (zs_we_n_from_the_sdram_u2)
    );

  sysid_control_slave_arbitrator the_sysid_control_slave
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_sysid_control_slave                (cpu_data_master_granted_sysid_control_slave),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_sysid_control_slave      (cpu_data_master_qualified_request_sysid_control_slave),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_read_data_valid_sysid_control_slave        (cpu_data_master_read_data_valid_sysid_control_slave),
      .cpu_data_master_requests_sysid_control_slave               (cpu_data_master_requests_sysid_control_slave),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .d1_sysid_control_slave_end_xfer                            (d1_sysid_control_slave_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n),
      .sysid_control_slave_address                                (sysid_control_slave_address),
      .sysid_control_slave_readdata                               (sysid_control_slave_readdata),
      .sysid_control_slave_readdata_from_sa                       (sysid_control_slave_readdata_from_sa)
    );

  sysid the_sysid
    (
      .address  (sysid_control_slave_address),
      .readdata (sysid_control_slave_readdata)
    );

  timer_s1_arbitrator the_timer_s1
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_timer_s1                           (cpu_data_master_granted_timer_s1),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_timer_s1                 (cpu_data_master_qualified_request_timer_s1),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_read_data_valid_timer_s1                   (cpu_data_master_read_data_valid_timer_s1),
      .cpu_data_master_requests_timer_s1                          (cpu_data_master_requests_timer_s1),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_timer_s1_end_xfer                                       (d1_timer_s1_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n),
      .timer_s1_address                                           (timer_s1_address),
      .timer_s1_chipselect                                        (timer_s1_chipselect),
      .timer_s1_irq                                               (timer_s1_irq),
      .timer_s1_irq_from_sa                                       (timer_s1_irq_from_sa),
      .timer_s1_readdata                                          (timer_s1_readdata),
      .timer_s1_readdata_from_sa                                  (timer_s1_readdata_from_sa),
      .timer_s1_reset_n                                           (timer_s1_reset_n),
      .timer_s1_write_n                                           (timer_s1_write_n),
      .timer_s1_writedata                                         (timer_s1_writedata)
    );

  timer the_timer
    (
      .address    (timer_s1_address),
      .chipselect (timer_s1_chipselect),
      .clk        (pll_c0_system),
      .irq        (timer_s1_irq),
      .readdata   (timer_s1_readdata),
      .reset_n    (timer_s1_reset_n),
      .write_n    (timer_s1_write_n),
      .writedata  (timer_s1_writedata)
    );

  timer_stamp_s1_arbitrator the_timer_stamp_s1
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_timer_stamp_s1                     (cpu_data_master_granted_timer_stamp_s1),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_timer_stamp_s1           (cpu_data_master_qualified_request_timer_stamp_s1),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_read_data_valid_timer_stamp_s1             (cpu_data_master_read_data_valid_timer_stamp_s1),
      .cpu_data_master_requests_timer_stamp_s1                    (cpu_data_master_requests_timer_stamp_s1),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_timer_stamp_s1_end_xfer                                 (d1_timer_stamp_s1_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n),
      .timer_stamp_s1_address                                     (timer_stamp_s1_address),
      .timer_stamp_s1_chipselect                                  (timer_stamp_s1_chipselect),
      .timer_stamp_s1_irq                                         (timer_stamp_s1_irq),
      .timer_stamp_s1_irq_from_sa                                 (timer_stamp_s1_irq_from_sa),
      .timer_stamp_s1_readdata                                    (timer_stamp_s1_readdata),
      .timer_stamp_s1_readdata_from_sa                            (timer_stamp_s1_readdata_from_sa),
      .timer_stamp_s1_reset_n                                     (timer_stamp_s1_reset_n),
      .timer_stamp_s1_write_n                                     (timer_stamp_s1_write_n),
      .timer_stamp_s1_writedata                                   (timer_stamp_s1_writedata)
    );

  timer_stamp the_timer_stamp
    (
      .address    (timer_stamp_s1_address),
      .chipselect (timer_stamp_s1_chipselect),
      .clk        (pll_c0_system),
      .irq        (timer_stamp_s1_irq),
      .readdata   (timer_stamp_s1_readdata),
      .reset_n    (timer_stamp_s1_reset_n),
      .write_n    (timer_stamp_s1_write_n),
      .writedata  (timer_stamp_s1_writedata)
    );

  tristate_bridge_flash_avalon_slave_arbitrator the_tristate_bridge_flash_avalon_slave
    (
      .address_to_the_cfi_flash                                          (address_to_the_cfi_flash),
      .cfi_flash_s1_wait_counter_eq_0                                    (cfi_flash_s1_wait_counter_eq_0),
      .clk                                                               (pll_c0_system),
      .cpu_data_master_address_to_slave                                  (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                        (cpu_data_master_byteenable),
      .cpu_data_master_byteenable_cfi_flash_s1                           (cpu_data_master_byteenable_cfi_flash_s1),
      .cpu_data_master_dbs_address                                       (cpu_data_master_dbs_address),
      .cpu_data_master_dbs_write_16                                      (cpu_data_master_dbs_write_16),
      .cpu_data_master_granted_cfi_flash_s1                              (cpu_data_master_granted_cfi_flash_s1),
      .cpu_data_master_latency_counter                                   (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_cfi_flash_s1                    (cpu_data_master_qualified_request_cfi_flash_s1),
      .cpu_data_master_read                                              (cpu_data_master_read),
      .cpu_data_master_read_data_valid_cfi_flash_s1                      (cpu_data_master_read_data_valid_cfi_flash_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_cfi_flash_s1                             (cpu_data_master_requests_cfi_flash_s1),
      .cpu_data_master_write                                             (cpu_data_master_write),
      .cpu_instruction_master_address_to_slave                           (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_dbs_address                                (cpu_instruction_master_dbs_address),
      .cpu_instruction_master_granted_cfi_flash_s1                       (cpu_instruction_master_granted_cfi_flash_s1),
      .cpu_instruction_master_latency_counter                            (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_cfi_flash_s1             (cpu_instruction_master_qualified_request_cfi_flash_s1),
      .cpu_instruction_master_read                                       (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_cfi_flash_s1               (cpu_instruction_master_read_data_valid_cfi_flash_s1),
      .cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_instruction_master_requests_cfi_flash_s1                      (cpu_instruction_master_requests_cfi_flash_s1),
      .d1_tristate_bridge_flash_avalon_slave_end_xfer                    (d1_tristate_bridge_flash_avalon_slave_end_xfer),
      .data_to_and_from_the_cfi_flash                                    (data_to_and_from_the_cfi_flash),
      .incoming_data_to_and_from_the_cfi_flash                           (incoming_data_to_and_from_the_cfi_flash),
      .incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0    (incoming_data_to_and_from_the_cfi_flash_with_Xs_converted_to_0),
      .read_n_to_the_cfi_flash                                           (read_n_to_the_cfi_flash),
      .reset_n                                                           (pll_c0_system_reset_n),
      .select_n_to_the_cfi_flash                                         (select_n_to_the_cfi_flash),
      .write_n_to_the_cfi_flash                                          (write_n_to_the_cfi_flash)
    );

  tristate_bridge_ssram_avalon_slave_arbitrator the_tristate_bridge_ssram_avalon_slave
    (
      .address_to_the_ssram                                              (address_to_the_ssram),
      .adsc_n_to_the_ssram                                               (adsc_n_to_the_ssram),
      .bw_n_to_the_ssram                                                 (bw_n_to_the_ssram),
      .bwe_n_to_the_ssram                                                (bwe_n_to_the_ssram),
      .chipenable1_n_to_the_ssram                                        (chipenable1_n_to_the_ssram),
      .clk                                                               (pll_c0_system),
      .cpu_data_master_address_to_slave                                  (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                        (cpu_data_master_byteenable),
      .cpu_data_master_granted_ssram_s1                                  (cpu_data_master_granted_ssram_s1),
      .cpu_data_master_latency_counter                                   (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_ssram_s1                        (cpu_data_master_qualified_request_ssram_s1),
      .cpu_data_master_read                                              (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_read_data_valid_ssram_s1                          (cpu_data_master_read_data_valid_ssram_s1),
      .cpu_data_master_requests_ssram_s1                                 (cpu_data_master_requests_ssram_s1),
      .cpu_data_master_write                                             (cpu_data_master_write),
      .cpu_data_master_writedata                                         (cpu_data_master_writedata),
      .cpu_instruction_master_address_to_slave                           (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_granted_ssram_s1                           (cpu_instruction_master_granted_ssram_s1),
      .cpu_instruction_master_latency_counter                            (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_ssram_s1                 (cpu_instruction_master_qualified_request_ssram_s1),
      .cpu_instruction_master_read                                       (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_instruction_master_read_data_valid_ssram_s1                   (cpu_instruction_master_read_data_valid_ssram_s1),
      .cpu_instruction_master_requests_ssram_s1                          (cpu_instruction_master_requests_ssram_s1),
      .d1_tristate_bridge_ssram_avalon_slave_end_xfer                    (d1_tristate_bridge_ssram_avalon_slave_end_xfer),
      .data_to_and_from_the_ssram                                        (data_to_and_from_the_ssram),
      .incoming_data_to_and_from_the_ssram                               (incoming_data_to_and_from_the_ssram),
      .outputenable_n_to_the_ssram                                       (outputenable_n_to_the_ssram),
      .reset_n                                                           (pll_c0_system_reset_n)
    );

  uart_s1_arbitrator the_uart_s1
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_uart_s1                            (cpu_data_master_granted_uart_s1),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_uart_s1                  (cpu_data_master_qualified_request_uart_s1),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_read_data_valid_uart_s1                    (cpu_data_master_read_data_valid_uart_s1),
      .cpu_data_master_requests_uart_s1                           (cpu_data_master_requests_uart_s1),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_uart_s1_end_xfer                                        (d1_uart_s1_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n),
      .uart_s1_address                                            (uart_s1_address),
      .uart_s1_begintransfer                                      (uart_s1_begintransfer),
      .uart_s1_chipselect                                         (uart_s1_chipselect),
      .uart_s1_dataavailable                                      (uart_s1_dataavailable),
      .uart_s1_dataavailable_from_sa                              (uart_s1_dataavailable_from_sa),
      .uart_s1_irq                                                (uart_s1_irq),
      .uart_s1_irq_from_sa                                        (uart_s1_irq_from_sa),
      .uart_s1_read_n                                             (uart_s1_read_n),
      .uart_s1_readdata                                           (uart_s1_readdata),
      .uart_s1_readdata_from_sa                                   (uart_s1_readdata_from_sa),
      .uart_s1_readyfordata                                       (uart_s1_readyfordata),
      .uart_s1_readyfordata_from_sa                               (uart_s1_readyfordata_from_sa),
      .uart_s1_reset_n                                            (uart_s1_reset_n),
      .uart_s1_write_n                                            (uart_s1_write_n),
      .uart_s1_writedata                                          (uart_s1_writedata)
    );

  uart the_uart
    (
      .address       (uart_s1_address),
      .begintransfer (uart_s1_begintransfer),
      .chipselect    (uart_s1_chipselect),
      .clk           (pll_c0_system),
      .cts_n         (cts_n_to_the_uart),
      .dataavailable (uart_s1_dataavailable),
      .irq           (uart_s1_irq),
      .read_n        (uart_s1_read_n),
      .readdata      (uart_s1_readdata),
      .readyfordata  (uart_s1_readyfordata),
      .reset_n       (uart_s1_reset_n),
      .rts_n         (rts_n_from_the_uart),
      .rxd           (rxd_to_the_uart),
      .txd           (txd_from_the_uart),
      .write_n       (uart_s1_write_n),
      .writedata     (uart_s1_writedata)
    );

  //reset is asserted asynchronously and deasserted synchronously
  DE2_70_SOPC_reset_clk_25_domain_synch_module DE2_70_SOPC_reset_clk_25_domain_synch
    (
      .clk      (clk_25),
      .data_in  (1'b1),
      .data_out (clk_25_reset_n),
      .reset_n  (reset_n_sources)
    );

  //reset is asserted asynchronously and deasserted synchronously
  DE2_70_SOPC_reset_clk_50_domain_synch_module DE2_70_SOPC_reset_clk_50_domain_synch
    (
      .clk      (clk_50),
      .data_in  (1'b1),
      .data_out (clk_50_reset_n),
      .reset_n  (reset_n_sources)
    );

  //clock_0_out_endofpacket of type endofpacket does not connect to anything so wire it to default (0)
  assign clock_0_out_endofpacket = 0;

  //clock_1_out_endofpacket of type endofpacket does not connect to anything so wire it to default (0)
  assign clock_1_out_endofpacket = 0;


endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cfi_flash_lane0_module (
                                // inputs:
                                 data,
                                 rdaddress,
                                 rdclken,
                                 wraddress,
                                 wrclock,
                                 wren,

                                // outputs:
                                 q
                              )
;

  output  [  7: 0] q;
  input   [  7: 0] data;
  input   [ 21: 0] rdaddress;
  input            rdclken;
  input   [ 21: 0] wraddress;
  input            wrclock;
  input            wren;

  reg     [  7: 0] mem_array [4194303: 0];
  wire    [  7: 0] q;
  reg     [ 21: 0] read_address;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  always @(rdaddress)
    begin
      if (1)
          read_address <= rdaddress;
    end


  // Data read is asynchronous.
  assign q = mem_array[read_address];

initial
    $readmemh("cfi_flash_lane0.dat", mem_array);
  always @(posedge wrclock)
    begin
      // Write data
      if (wren)
          mem_array[wraddress] <= data;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on
//synthesis read_comments_as_HDL on
//  always @(rdaddress)
//    begin
//      if (1)
//          read_address <= rdaddress;
//    end
//
//
//  lpm_ram_dp lpm_ram_dp_component
//    (
//      .data (data),
//      .q (q),
//      .rdaddress (read_address),
//      .rdclken (rdclken),
//      .wraddress (wraddress),
//      .wrclock (wrclock),
//      .wren (wren)
//    );
//
//  defparam lpm_ram_dp_component.lpm_file = "cfi_flash_lane0.mif",
//           lpm_ram_dp_component.lpm_hint = "USE_EAB=ON",
//           lpm_ram_dp_component.lpm_indata = "REGISTERED",
//           lpm_ram_dp_component.lpm_outdata = "UNREGISTERED",
//           lpm_ram_dp_component.lpm_rdaddress_control = "UNREGISTERED",
//           lpm_ram_dp_component.lpm_width = 8,
//           lpm_ram_dp_component.lpm_widthad = 22,
//           lpm_ram_dp_component.lpm_wraddress_control = "REGISTERED",
//           lpm_ram_dp_component.suppress_memory_conversion_warnings = "ON";
//
//synthesis read_comments_as_HDL off

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cfi_flash_lane1_module (
                                // inputs:
                                 data,
                                 rdaddress,
                                 rdclken,
                                 wraddress,
                                 wrclock,
                                 wren,

                                // outputs:
                                 q
                              )
;

  output  [  7: 0] q;
  input   [  7: 0] data;
  input   [ 21: 0] rdaddress;
  input            rdclken;
  input   [ 21: 0] wraddress;
  input            wrclock;
  input            wren;

  reg     [  7: 0] mem_array [4194303: 0];
  wire    [  7: 0] q;
  reg     [ 21: 0] read_address;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  always @(rdaddress)
    begin
      if (1)
          read_address <= rdaddress;
    end


  // Data read is asynchronous.
  assign q = mem_array[read_address];

initial
    $readmemh("cfi_flash_lane1.dat", mem_array);
  always @(posedge wrclock)
    begin
      // Write data
      if (wren)
          mem_array[wraddress] <= data;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on
//synthesis read_comments_as_HDL on
//  always @(rdaddress)
//    begin
//      if (1)
//          read_address <= rdaddress;
//    end
//
//
//  lpm_ram_dp lpm_ram_dp_component
//    (
//      .data (data),
//      .q (q),
//      .rdaddress (read_address),
//      .rdclken (rdclken),
//      .wraddress (wraddress),
//      .wrclock (wrclock),
//      .wren (wren)
//    );
//
//  defparam lpm_ram_dp_component.lpm_file = "cfi_flash_lane1.mif",
//           lpm_ram_dp_component.lpm_hint = "USE_EAB=ON",
//           lpm_ram_dp_component.lpm_indata = "REGISTERED",
//           lpm_ram_dp_component.lpm_outdata = "UNREGISTERED",
//           lpm_ram_dp_component.lpm_rdaddress_control = "UNREGISTERED",
//           lpm_ram_dp_component.lpm_width = 8,
//           lpm_ram_dp_component.lpm_widthad = 22,
//           lpm_ram_dp_component.lpm_wraddress_control = "REGISTERED",
//           lpm_ram_dp_component.suppress_memory_conversion_warnings = "ON";
//
//synthesis read_comments_as_HDL off

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cfi_flash (
                   // inputs:
                    address,
                    read_n,
                    select_n,
                    write_n,

                   // outputs:
                    data
                 )
;

  inout   [ 15: 0] data;
  input   [ 21: 0] address;
  input            read_n;
  input            select_n;
  input            write_n;

  wire    [ 15: 0] data;
  wire    [  7: 0] data_0;
  wire    [  7: 0] data_1;
  wire    [ 15: 0] logic_vector_gasket;
  wire    [  7: 0] q_0;
  wire    [  7: 0] q_1;
  //s1, which is an e_ptf_slave

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  assign logic_vector_gasket = data;
  assign data_0 = logic_vector_gasket[7 : 0];
  //cfi_flash_lane0, which is an e_ram
  cfi_flash_lane0_module cfi_flash_lane0
    (
      .data      (data_0),
      .q         (q_0),
      .rdaddress (address),
      .rdclken   (1'b1),
      .wraddress (address),
      .wrclock   (write_n),
      .wren      (~select_n)
    );

  assign data_1 = logic_vector_gasket[15 : 8];
  //cfi_flash_lane1, which is an e_ram
  cfi_flash_lane1_module cfi_flash_lane1
    (
      .data      (data_1),
      .q         (q_1),
      .rdaddress (address),
      .rdclken   (1'b1),
      .wraddress (address),
      .wrclock   (write_n),
      .wren      (~select_n)
    );

  assign data = (~select_n & ~read_n)? {q_1,
    q_0}: {16{1'bz}};


//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module ssram_lane0_module (
                            // inputs:
                             clk,
                             data,
                             rdaddress,
                             rdclken,
                             reset_n,
                             wraddress,
                             wrclock,
                             wren,

                            // outputs:
                             q
                          )
;

  output  [  7: 0] q;
  input            clk;
  input   [  7: 0] data;
  input   [ 18: 0] rdaddress;
  input            rdclken;
  input            reset_n;
  input   [ 18: 0] wraddress;
  input            wrclock;
  input            wren;

  reg     [ 18: 0] d1_rdaddress;
  reg     [  7: 0] mem_array [524287: 0];
  wire    [  7: 0] q;
  reg     [ 18: 0] read_address;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
        begin
          d1_rdaddress <= 0;
          read_address <= 0;
        end
      else if (rdclken)
        begin
          d1_rdaddress <= rdaddress;
          read_address <= d1_rdaddress;
        end
    end


  // Data read is synchronized through latent_rdaddress.
  assign q = mem_array[read_address];

initial
    $readmemh("ssram_lane0.dat", mem_array);
  always @(posedge wrclock)
    begin
      // Write data
      if (wren)
          mem_array[wraddress] <= data;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on
//synthesis read_comments_as_HDL on
//  always @(rdaddress)
//    begin
//      if (1)
//          read_address <= rdaddress;
//    end
//
//
//  lpm_ram_dp lpm_ram_dp_component
//    (
//      .data (data),
//      .q (q),
//      .rdaddress (read_address),
//      .rdclken (rdclken),
//      .rdclock (clk),
//      .wraddress (wraddress),
//      .wrclock (wrclock),
//      .wren (wren)
//    );
//
//  defparam lpm_ram_dp_component.lpm_file = "ssram_lane0.mif",
//           lpm_ram_dp_component.lpm_hint = "USE_EAB=ON",
//           lpm_ram_dp_component.lpm_indata = "REGISTERED",
//           lpm_ram_dp_component.lpm_outdata = "REGISTERED",
//           lpm_ram_dp_component.lpm_rdaddress_control = "REGISTERED",
//           lpm_ram_dp_component.lpm_width = 8,
//           lpm_ram_dp_component.lpm_widthad = 19,
//           lpm_ram_dp_component.lpm_wraddress_control = "REGISTERED",
//           lpm_ram_dp_component.suppress_memory_conversion_warnings = "ON";
//
//synthesis read_comments_as_HDL off

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module ssram_lane1_module (
                            // inputs:
                             clk,
                             data,
                             rdaddress,
                             rdclken,
                             reset_n,
                             wraddress,
                             wrclock,
                             wren,

                            // outputs:
                             q
                          )
;

  output  [  7: 0] q;
  input            clk;
  input   [  7: 0] data;
  input   [ 18: 0] rdaddress;
  input            rdclken;
  input            reset_n;
  input   [ 18: 0] wraddress;
  input            wrclock;
  input            wren;

  reg     [ 18: 0] d1_rdaddress;
  reg     [  7: 0] mem_array [524287: 0];
  wire    [  7: 0] q;
  reg     [ 18: 0] read_address;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
        begin
          d1_rdaddress <= 0;
          read_address <= 0;
        end
      else if (rdclken)
        begin
          d1_rdaddress <= rdaddress;
          read_address <= d1_rdaddress;
        end
    end


  // Data read is synchronized through latent_rdaddress.
  assign q = mem_array[read_address];

initial
    $readmemh("ssram_lane1.dat", mem_array);
  always @(posedge wrclock)
    begin
      // Write data
      if (wren)
          mem_array[wraddress] <= data;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on
//synthesis read_comments_as_HDL on
//  always @(rdaddress)
//    begin
//      if (1)
//          read_address <= rdaddress;
//    end
//
//
//  lpm_ram_dp lpm_ram_dp_component
//    (
//      .data (data),
//      .q (q),
//      .rdaddress (read_address),
//      .rdclken (rdclken),
//      .rdclock (clk),
//      .wraddress (wraddress),
//      .wrclock (wrclock),
//      .wren (wren)
//    );
//
//  defparam lpm_ram_dp_component.lpm_file = "ssram_lane1.mif",
//           lpm_ram_dp_component.lpm_hint = "USE_EAB=ON",
//           lpm_ram_dp_component.lpm_indata = "REGISTERED",
//           lpm_ram_dp_component.lpm_outdata = "REGISTERED",
//           lpm_ram_dp_component.lpm_rdaddress_control = "REGISTERED",
//           lpm_ram_dp_component.lpm_width = 8,
//           lpm_ram_dp_component.lpm_widthad = 19,
//           lpm_ram_dp_component.lpm_wraddress_control = "REGISTERED",
//           lpm_ram_dp_component.suppress_memory_conversion_warnings = "ON";
//
//synthesis read_comments_as_HDL off

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module ssram_lane2_module (
                            // inputs:
                             clk,
                             data,
                             rdaddress,
                             rdclken,
                             reset_n,
                             wraddress,
                             wrclock,
                             wren,

                            // outputs:
                             q
                          )
;

  output  [  7: 0] q;
  input            clk;
  input   [  7: 0] data;
  input   [ 18: 0] rdaddress;
  input            rdclken;
  input            reset_n;
  input   [ 18: 0] wraddress;
  input            wrclock;
  input            wren;

  reg     [ 18: 0] d1_rdaddress;
  reg     [  7: 0] mem_array [524287: 0];
  wire    [  7: 0] q;
  reg     [ 18: 0] read_address;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
        begin
          d1_rdaddress <= 0;
          read_address <= 0;
        end
      else if (rdclken)
        begin
          d1_rdaddress <= rdaddress;
          read_address <= d1_rdaddress;
        end
    end


  // Data read is synchronized through latent_rdaddress.
  assign q = mem_array[read_address];

initial
    $readmemh("ssram_lane2.dat", mem_array);
  always @(posedge wrclock)
    begin
      // Write data
      if (wren)
          mem_array[wraddress] <= data;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on
//synthesis read_comments_as_HDL on
//  always @(rdaddress)
//    begin
//      if (1)
//          read_address <= rdaddress;
//    end
//
//
//  lpm_ram_dp lpm_ram_dp_component
//    (
//      .data (data),
//      .q (q),
//      .rdaddress (read_address),
//      .rdclken (rdclken),
//      .rdclock (clk),
//      .wraddress (wraddress),
//      .wrclock (wrclock),
//      .wren (wren)
//    );
//
//  defparam lpm_ram_dp_component.lpm_file = "ssram_lane2.mif",
//           lpm_ram_dp_component.lpm_hint = "USE_EAB=ON",
//           lpm_ram_dp_component.lpm_indata = "REGISTERED",
//           lpm_ram_dp_component.lpm_outdata = "REGISTERED",
//           lpm_ram_dp_component.lpm_rdaddress_control = "REGISTERED",
//           lpm_ram_dp_component.lpm_width = 8,
//           lpm_ram_dp_component.lpm_widthad = 19,
//           lpm_ram_dp_component.lpm_wraddress_control = "REGISTERED",
//           lpm_ram_dp_component.suppress_memory_conversion_warnings = "ON";
//
//synthesis read_comments_as_HDL off

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module ssram_lane3_module (
                            // inputs:
                             clk,
                             data,
                             rdaddress,
                             rdclken,
                             reset_n,
                             wraddress,
                             wrclock,
                             wren,

                            // outputs:
                             q
                          )
;

  output  [  7: 0] q;
  input            clk;
  input   [  7: 0] data;
  input   [ 18: 0] rdaddress;
  input            rdclken;
  input            reset_n;
  input   [ 18: 0] wraddress;
  input            wrclock;
  input            wren;

  reg     [ 18: 0] d1_rdaddress;
  reg     [  7: 0] mem_array [524287: 0];
  wire    [  7: 0] q;
  reg     [ 18: 0] read_address;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
        begin
          d1_rdaddress <= 0;
          read_address <= 0;
        end
      else if (rdclken)
        begin
          d1_rdaddress <= rdaddress;
          read_address <= d1_rdaddress;
        end
    end


  // Data read is synchronized through latent_rdaddress.
  assign q = mem_array[read_address];

initial
    $readmemh("ssram_lane3.dat", mem_array);
  always @(posedge wrclock)
    begin
      // Write data
      if (wren)
          mem_array[wraddress] <= data;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on
//synthesis read_comments_as_HDL on
//  always @(rdaddress)
//    begin
//      if (1)
//          read_address <= rdaddress;
//    end
//
//
//  lpm_ram_dp lpm_ram_dp_component
//    (
//      .data (data),
//      .q (q),
//      .rdaddress (read_address),
//      .rdclken (rdclken),
//      .rdclock (clk),
//      .wraddress (wraddress),
//      .wrclock (wrclock),
//      .wren (wren)
//    );
//
//  defparam lpm_ram_dp_component.lpm_file = "ssram_lane3.mif",
//           lpm_ram_dp_component.lpm_hint = "USE_EAB=ON",
//           lpm_ram_dp_component.lpm_indata = "REGISTERED",
//           lpm_ram_dp_component.lpm_outdata = "REGISTERED",
//           lpm_ram_dp_component.lpm_rdaddress_control = "REGISTERED",
//           lpm_ram_dp_component.lpm_width = 8,
//           lpm_ram_dp_component.lpm_widthad = 19,
//           lpm_ram_dp_component.lpm_wraddress_control = "REGISTERED",
//           lpm_ram_dp_component.suppress_memory_conversion_warnings = "ON";
//
//synthesis read_comments_as_HDL off

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module ssram (
               // inputs:
                address,
                adsc_n,
                bw_n,
                bwe_n,
                chipenable1_n,
                clk,
                outputenable_n,
                reset_n,

               // outputs:
                data
             )
;

  inout   [ 31: 0] data;
  input   [ 18: 0] address;
  input            adsc_n;
  input   [  3: 0] bw_n;
  input            bwe_n;
  input            chipenable1_n;
  input            clk;
  input            outputenable_n;
  input            reset_n;

  wire    [ 31: 0] data;
  wire    [  7: 0] data_0;
  wire    [  7: 0] data_1;
  wire    [  7: 0] data_2;
  wire    [  7: 0] data_3;
  wire    [ 31: 0] logic_vector_gasket;
  wire    [  7: 0] q_0;
  wire    [  7: 0] q_1;
  wire    [  7: 0] q_2;
  wire    [  7: 0] q_3;
  //s1, which is an e_ptf_slave

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  assign logic_vector_gasket = data;
  assign data_0 = logic_vector_gasket[7 : 0];
  //ssram_lane0, which is an e_ram
  ssram_lane0_module ssram_lane0
    (
      .clk       (clk),
      .data      (data_0),
      .q         (q_0),
      .rdaddress (address),
      .rdclken   (1'b1),
      .reset_n   (reset_n),
      .wraddress (address),
      .wrclock   (clk),
      .wren      (~chipenable1_n & ~bwe_n & ~bw_n[0])
    );

  assign data_1 = logic_vector_gasket[15 : 8];
  //ssram_lane1, which is an e_ram
  ssram_lane1_module ssram_lane1
    (
      .clk       (clk),
      .data      (data_1),
      .q         (q_1),
      .rdaddress (address),
      .rdclken   (1'b1),
      .reset_n   (reset_n),
      .wraddress (address),
      .wrclock   (clk),
      .wren      (~chipenable1_n & ~bwe_n & ~bw_n[1])
    );

  assign data_2 = logic_vector_gasket[23 : 16];
  //ssram_lane2, which is an e_ram
  ssram_lane2_module ssram_lane2
    (
      .clk       (clk),
      .data      (data_2),
      .q         (q_2),
      .rdaddress (address),
      .rdclken   (1'b1),
      .reset_n   (reset_n),
      .wraddress (address),
      .wrclock   (clk),
      .wren      (~chipenable1_n & ~bwe_n & ~bw_n[2])
    );

  assign data_3 = logic_vector_gasket[31 : 24];
  //ssram_lane3, which is an e_ram
  ssram_lane3_module ssram_lane3
    (
      .clk       (clk),
      .data      (data_3),
      .q         (q_3),
      .rdaddress (address),
      .rdclken   (1'b1),
      .reset_n   (reset_n),
      .wraddress (address),
      .wrclock   (clk),
      .wren      (~chipenable1_n & ~bwe_n & ~bw_n[3])
    );

  assign data = (~chipenable1_n & ~outputenable_n)? {q_3,
    q_2,
    q_1,
    q_0}: {32{1'bz}};


//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


//synthesis translate_off



// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE

// AND HERE WILL BE PRESERVED </ALTERA_NOTE>


// If user logic components use Altsync_Ram with convert_hex2ver.dll,
// set USE_convert_hex2ver in the user comments section above

// `ifdef USE_convert_hex2ver
// `else
// `define NO_PLI 1
// `endif

`include "c:/altera/72/quartus/eda/sim_lib/altera_mf.v"
`include "c:/altera/72/quartus/eda/sim_lib/220model.v"
`include "c:/altera/72/quartus/eda/sim_lib/sgate.v"
`include "AUDIO.v"
`include "VGA.v"
`include "SEG7.v"
`include "DM9000A.v"
`include "ISP1362.v"
`include "uart.v"
`include "pio_red_led.v"
`include "clock_0.v"
`include "sysid.v"
`include "Altera_UP_Avalon_PS2.v"
`include "Altera_UP_PS2.v"
`include "Altera_UP_PS2_Command_Out.v"
`include "Altera_UP_PS2_Data_In.v"
`include "ps2_mouse.v"
`include "timer.v"
`include "jtag_uart.v"
`include "sdram_u1.v"
`include "sdram_u1_test_component.v"
`include "cpu_test_bench.v"
`include "cpu_mult_cell.v"
`include "cpu_jtag_debug_module.v"
`include "cpu_jtag_debug_module_wrapper.v"
`include "cpu.v"
`include "i2c_sclk.v"
`include "clock_1.v"
`include "pio_button.v"
`include "sdram_u2.v"
`include "sdram_u2_test_component.v"
`include "pll.v"
`include "altpllpll.v"
`include "i2c_sdat.v"
`include "sd_cmd.v"
`include "sd_dat3.v"
`include "pio_switch.v"
`include "lcd.v"
`include "pio_green_led.v"
`include "sd_dat.v"
`include "sd_clk.v"
`include "ps2_keyboard.v"
`include "onchip_mem.v"
`include "timer_stamp.v"

`timescale 1ns / 1ps

module test_bench 
;


  wire             LCD_E_from_the_lcd;
  wire             LCD_RS_from_the_lcd;
  wire             LCD_RW_from_the_lcd;
  wire    [  7: 0] LCD_data_to_and_from_the_lcd;
  wire             PS2_CLK_to_and_from_the_ps2_keyboard;
  wire             PS2_CLK_to_and_from_the_ps2_mouse;
  wire             PS2_DAT_to_and_from_the_ps2_keyboard;
  wire             PS2_DAT_to_and_from_the_ps2_mouse;
  wire    [ 22: 0] address_to_the_cfi_flash;
  wire    [ 20: 0] address_to_the_ssram;
  wire             adsc_n_to_the_ssram;
  wire             avs_dc_export_OTG_INT1_to_the_ISP1362;
  wire    [  1: 0] avs_hc_export_OTG_ADDR_from_the_ISP1362;
  wire             avs_hc_export_OTG_CS_N_from_the_ISP1362;
  wire    [ 15: 0] avs_hc_export_OTG_DATA_to_and_from_the_ISP1362;
  wire             avs_hc_export_OTG_INT0_to_the_ISP1362;
  wire             avs_hc_export_OTG_RD_N_from_the_ISP1362;
  wire             avs_hc_export_OTG_RST_N_from_the_ISP1362;
  wire             avs_hc_export_OTG_WR_N_from_the_ISP1362;
  wire             avs_s1_export_ADCDAT_to_the_AUDIO;
  wire             avs_s1_export_ADCLRC_to_the_AUDIO;
  wire             avs_s1_export_BCLK_to_the_AUDIO;
  wire             avs_s1_export_DACDAT_from_the_AUDIO;
  wire             avs_s1_export_DACLRC_to_the_AUDIO;
  wire             avs_s1_export_ENET_CLK_from_the_DM9000A;
  wire             avs_s1_export_ENET_CMD_from_the_DM9000A;
  wire             avs_s1_export_ENET_CS_N_from_the_DM9000A;
  wire    [ 15: 0] avs_s1_export_ENET_DATA_to_and_from_the_DM9000A;
  wire             avs_s1_export_ENET_INT_to_the_DM9000A;
  wire             avs_s1_export_ENET_RD_N_from_the_DM9000A;
  wire             avs_s1_export_ENET_RST_N_from_the_DM9000A;
  wire             avs_s1_export_ENET_WR_N_from_the_DM9000A;
  wire             avs_s1_export_VGA_BLANK_from_the_VGA;
  wire    [  9: 0] avs_s1_export_VGA_B_from_the_VGA;
  wire             avs_s1_export_VGA_CLK_from_the_VGA;
  wire    [  9: 0] avs_s1_export_VGA_G_from_the_VGA;
  wire             avs_s1_export_VGA_HS_from_the_VGA;
  wire    [  9: 0] avs_s1_export_VGA_R_from_the_VGA;
  wire             avs_s1_export_VGA_SYNC_from_the_VGA;
  wire             avs_s1_export_VGA_VS_from_the_VGA;
  wire             avs_s1_export_iCLK_25_to_the_VGA;
  wire    [ 63: 0] avs_s1_export_seg7_from_the_SEG7;
  wire             bidir_port_to_and_from_the_i2c_sdat;
  wire             bidir_port_to_and_from_the_sd_cmd;
  wire             bidir_port_to_and_from_the_sd_dat;
  wire             bidir_port_to_and_from_the_sd_dat3;
  wire    [  3: 0] bw_n_to_the_ssram;
  wire             bwe_n_to_the_ssram;
  wire             chipenable1_n_to_the_ssram;
  wire             clk;
  reg              clk_25;
  reg              clk_50;
  wire             clock_0_in_endofpacket_from_sa;
  wire    [  1: 0] clock_0_out_byteenable;
  wire             clock_0_out_endofpacket;
  wire             clock_1_in_endofpacket_from_sa;
  wire    [  1: 0] clock_1_out_byteenable;
  wire             clock_1_out_endofpacket;
  wire             cts_n_to_the_uart;
  wire    [ 15: 0] data_to_and_from_the_cfi_flash;
  wire    [ 31: 0] data_to_and_from_the_ssram;
  wire    [  3: 0] in_port_to_the_pio_button;
  wire    [ 17: 0] in_port_to_the_pio_switch;
  wire             jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  wire             out_port_from_the_i2c_sclk;
  wire    [  8: 0] out_port_from_the_pio_green_led;
  wire    [ 17: 0] out_port_from_the_pio_red_led;
  wire             out_port_from_the_sd_clk;
  wire             outputenable_n_to_the_ssram;
  wire             pll_c0_system;
  wire             pll_c1_memory;
  wire             pll_c2_audio;
  wire             read_n_to_the_cfi_flash;
  reg              reset_n;
  wire             rts_n_from_the_uart;
  wire             rxd_to_the_uart;
  wire             select_n_to_the_cfi_flash;
  wire             txd_from_the_uart;
  wire             uart_s1_dataavailable_from_sa;
  wire             uart_s1_readyfordata_from_sa;
  wire             write_n_to_the_cfi_flash;
  wire    [ 12: 0] zs_addr_from_the_sdram_u1;
  wire    [ 12: 0] zs_addr_from_the_sdram_u2;
  wire    [  1: 0] zs_ba_from_the_sdram_u1;
  wire    [  1: 0] zs_ba_from_the_sdram_u2;
  wire             zs_cas_n_from_the_sdram_u1;
  wire             zs_cas_n_from_the_sdram_u2;
  wire             zs_cke_from_the_sdram_u1;
  wire             zs_cke_from_the_sdram_u2;
  wire             zs_cs_n_from_the_sdram_u1;
  wire             zs_cs_n_from_the_sdram_u2;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram_u1;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram_u2;
  wire    [  1: 0] zs_dqm_from_the_sdram_u1;
  wire    [  1: 0] zs_dqm_from_the_sdram_u2;
  wire             zs_ras_n_from_the_sdram_u1;
  wire             zs_ras_n_from_the_sdram_u2;
  wire             zs_we_n_from_the_sdram_u1;
  wire             zs_we_n_from_the_sdram_u2;


// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
//  add your signals and additional architecture here
// AND HERE WILL BE PRESERVED </ALTERA_NOTE>

  //Set us up the Dut
  DE2_70_SOPC DUT
    (
      .LCD_E_from_the_lcd                              (LCD_E_from_the_lcd),
      .LCD_RS_from_the_lcd                             (LCD_RS_from_the_lcd),
      .LCD_RW_from_the_lcd                             (LCD_RW_from_the_lcd),
      .LCD_data_to_and_from_the_lcd                    (LCD_data_to_and_from_the_lcd),
      .PS2_CLK_to_and_from_the_ps2_keyboard            (PS2_CLK_to_and_from_the_ps2_keyboard),
      .PS2_CLK_to_and_from_the_ps2_mouse               (PS2_CLK_to_and_from_the_ps2_mouse),
      .PS2_DAT_to_and_from_the_ps2_keyboard            (PS2_DAT_to_and_from_the_ps2_keyboard),
      .PS2_DAT_to_and_from_the_ps2_mouse               (PS2_DAT_to_and_from_the_ps2_mouse),
      .address_to_the_cfi_flash                        (address_to_the_cfi_flash),
      .address_to_the_ssram                            (address_to_the_ssram),
      .adsc_n_to_the_ssram                             (adsc_n_to_the_ssram),
      .avs_dc_export_OTG_INT1_to_the_ISP1362           (avs_dc_export_OTG_INT1_to_the_ISP1362),
      .avs_hc_export_OTG_ADDR_from_the_ISP1362         (avs_hc_export_OTG_ADDR_from_the_ISP1362),
      .avs_hc_export_OTG_CS_N_from_the_ISP1362         (avs_hc_export_OTG_CS_N_from_the_ISP1362),
      .avs_hc_export_OTG_DATA_to_and_from_the_ISP1362  (avs_hc_export_OTG_DATA_to_and_from_the_ISP1362),
      .avs_hc_export_OTG_INT0_to_the_ISP1362           (avs_hc_export_OTG_INT0_to_the_ISP1362),
      .avs_hc_export_OTG_RD_N_from_the_ISP1362         (avs_hc_export_OTG_RD_N_from_the_ISP1362),
      .avs_hc_export_OTG_RST_N_from_the_ISP1362        (avs_hc_export_OTG_RST_N_from_the_ISP1362),
      .avs_hc_export_OTG_WR_N_from_the_ISP1362         (avs_hc_export_OTG_WR_N_from_the_ISP1362),
      .avs_s1_export_ADCDAT_to_the_AUDIO               (avs_s1_export_ADCDAT_to_the_AUDIO),
      .avs_s1_export_ADCLRC_to_the_AUDIO               (avs_s1_export_ADCLRC_to_the_AUDIO),
      .avs_s1_export_BCLK_to_the_AUDIO                 (avs_s1_export_BCLK_to_the_AUDIO),
      .avs_s1_export_DACDAT_from_the_AUDIO             (avs_s1_export_DACDAT_from_the_AUDIO),
      .avs_s1_export_DACLRC_to_the_AUDIO               (avs_s1_export_DACLRC_to_the_AUDIO),
      .avs_s1_export_ENET_CLK_from_the_DM9000A         (avs_s1_export_ENET_CLK_from_the_DM9000A),
      .avs_s1_export_ENET_CMD_from_the_DM9000A         (avs_s1_export_ENET_CMD_from_the_DM9000A),
      .avs_s1_export_ENET_CS_N_from_the_DM9000A        (avs_s1_export_ENET_CS_N_from_the_DM9000A),
      .avs_s1_export_ENET_DATA_to_and_from_the_DM9000A (avs_s1_export_ENET_DATA_to_and_from_the_DM9000A),
      .avs_s1_export_ENET_INT_to_the_DM9000A           (avs_s1_export_ENET_INT_to_the_DM9000A),
      .avs_s1_export_ENET_RD_N_from_the_DM9000A        (avs_s1_export_ENET_RD_N_from_the_DM9000A),
      .avs_s1_export_ENET_RST_N_from_the_DM9000A       (avs_s1_export_ENET_RST_N_from_the_DM9000A),
      .avs_s1_export_ENET_WR_N_from_the_DM9000A        (avs_s1_export_ENET_WR_N_from_the_DM9000A),
      .avs_s1_export_VGA_BLANK_from_the_VGA            (avs_s1_export_VGA_BLANK_from_the_VGA),
      .avs_s1_export_VGA_B_from_the_VGA                (avs_s1_export_VGA_B_from_the_VGA),
      .avs_s1_export_VGA_CLK_from_the_VGA              (avs_s1_export_VGA_CLK_from_the_VGA),
      .avs_s1_export_VGA_G_from_the_VGA                (avs_s1_export_VGA_G_from_the_VGA),
      .avs_s1_export_VGA_HS_from_the_VGA               (avs_s1_export_VGA_HS_from_the_VGA),
      .avs_s1_export_VGA_R_from_the_VGA                (avs_s1_export_VGA_R_from_the_VGA),
      .avs_s1_export_VGA_SYNC_from_the_VGA             (avs_s1_export_VGA_SYNC_from_the_VGA),
      .avs_s1_export_VGA_VS_from_the_VGA               (avs_s1_export_VGA_VS_from_the_VGA),
      .avs_s1_export_iCLK_25_to_the_VGA                (avs_s1_export_iCLK_25_to_the_VGA),
      .avs_s1_export_seg7_from_the_SEG7                (avs_s1_export_seg7_from_the_SEG7),
      .bidir_port_to_and_from_the_i2c_sdat             (bidir_port_to_and_from_the_i2c_sdat),
      .bidir_port_to_and_from_the_sd_cmd               (bidir_port_to_and_from_the_sd_cmd),
      .bidir_port_to_and_from_the_sd_dat               (bidir_port_to_and_from_the_sd_dat),
      .bidir_port_to_and_from_the_sd_dat3              (bidir_port_to_and_from_the_sd_dat3),
      .bw_n_to_the_ssram                               (bw_n_to_the_ssram),
      .bwe_n_to_the_ssram                              (bwe_n_to_the_ssram),
      .chipenable1_n_to_the_ssram                      (chipenable1_n_to_the_ssram),
      .clk_25                                          (clk_25),
      .clk_50                                          (clk_50),
      .cts_n_to_the_uart                               (cts_n_to_the_uart),
      .data_to_and_from_the_cfi_flash                  (data_to_and_from_the_cfi_flash),
      .data_to_and_from_the_ssram                      (data_to_and_from_the_ssram),
      .in_port_to_the_pio_button                       (in_port_to_the_pio_button),
      .in_port_to_the_pio_switch                       (in_port_to_the_pio_switch),
      .out_port_from_the_i2c_sclk                      (out_port_from_the_i2c_sclk),
      .out_port_from_the_pio_green_led                 (out_port_from_the_pio_green_led),
      .out_port_from_the_pio_red_led                   (out_port_from_the_pio_red_led),
      .out_port_from_the_sd_clk                        (out_port_from_the_sd_clk),
      .outputenable_n_to_the_ssram                     (outputenable_n_to_the_ssram),
      .pll_c0_system                                   (pll_c0_system),
      .pll_c1_memory                                   (pll_c1_memory),
      .pll_c2_audio                                    (pll_c2_audio),
      .read_n_to_the_cfi_flash                         (read_n_to_the_cfi_flash),
      .reset_n                                         (reset_n),
      .rts_n_from_the_uart                             (rts_n_from_the_uart),
      .rxd_to_the_uart                                 (rxd_to_the_uart),
      .select_n_to_the_cfi_flash                       (select_n_to_the_cfi_flash),
      .txd_from_the_uart                               (txd_from_the_uart),
      .write_n_to_the_cfi_flash                        (write_n_to_the_cfi_flash),
      .zs_addr_from_the_sdram_u1                       (zs_addr_from_the_sdram_u1),
      .zs_addr_from_the_sdram_u2                       (zs_addr_from_the_sdram_u2),
      .zs_ba_from_the_sdram_u1                         (zs_ba_from_the_sdram_u1),
      .zs_ba_from_the_sdram_u2                         (zs_ba_from_the_sdram_u2),
      .zs_cas_n_from_the_sdram_u1                      (zs_cas_n_from_the_sdram_u1),
      .zs_cas_n_from_the_sdram_u2                      (zs_cas_n_from_the_sdram_u2),
      .zs_cke_from_the_sdram_u1                        (zs_cke_from_the_sdram_u1),
      .zs_cke_from_the_sdram_u2                        (zs_cke_from_the_sdram_u2),
      .zs_cs_n_from_the_sdram_u1                       (zs_cs_n_from_the_sdram_u1),
      .zs_cs_n_from_the_sdram_u2                       (zs_cs_n_from_the_sdram_u2),
      .zs_dq_to_and_from_the_sdram_u1                  (zs_dq_to_and_from_the_sdram_u1),
      .zs_dq_to_and_from_the_sdram_u2                  (zs_dq_to_and_from_the_sdram_u2),
      .zs_dqm_from_the_sdram_u1                        (zs_dqm_from_the_sdram_u1),
      .zs_dqm_from_the_sdram_u2                        (zs_dqm_from_the_sdram_u2),
      .zs_ras_n_from_the_sdram_u1                      (zs_ras_n_from_the_sdram_u1),
      .zs_ras_n_from_the_sdram_u2                      (zs_ras_n_from_the_sdram_u2),
      .zs_we_n_from_the_sdram_u1                       (zs_we_n_from_the_sdram_u1),
      .zs_we_n_from_the_sdram_u2                       (zs_we_n_from_the_sdram_u2)
    );

  cfi_flash the_cfi_flash
    (
      .address  (address_to_the_cfi_flash[22 : 1]),
      .data     (data_to_and_from_the_cfi_flash),
      .read_n   (read_n_to_the_cfi_flash),
      .select_n (select_n_to_the_cfi_flash),
      .write_n  (write_n_to_the_cfi_flash)
    );

  ssram the_ssram
    (
      .address        (address_to_the_ssram[20 : 2]),
      .adsc_n         (adsc_n_to_the_ssram),
      .bw_n           (bw_n_to_the_ssram),
      .bwe_n          (bwe_n_to_the_ssram),
      .chipenable1_n  (chipenable1_n_to_the_ssram),
      .clk            (pll_c0_system),
      .data           (data_to_and_from_the_ssram),
      .outputenable_n (outputenable_n_to_the_ssram),
      .reset_n        (reset_n)
    );

  sdram_u1_test_component the_sdram_u1_test_component
    (
      .clk      (pll_c0_system),
      .zs_addr  (zs_addr_from_the_sdram_u1),
      .zs_ba    (zs_ba_from_the_sdram_u1),
      .zs_cas_n (zs_cas_n_from_the_sdram_u1),
      .zs_cke   (zs_cke_from_the_sdram_u1),
      .zs_cs_n  (zs_cs_n_from_the_sdram_u1),
      .zs_dq    (zs_dq_to_and_from_the_sdram_u1),
      .zs_dqm   (zs_dqm_from_the_sdram_u1),
      .zs_ras_n (zs_ras_n_from_the_sdram_u1),
      .zs_we_n  (zs_we_n_from_the_sdram_u1)
    );

  sdram_u2_test_component the_sdram_u2_test_component
    (
      .clk      (pll_c0_system),
      .zs_addr  (zs_addr_from_the_sdram_u2),
      .zs_ba    (zs_ba_from_the_sdram_u2),
      .zs_cas_n (zs_cas_n_from_the_sdram_u2),
      .zs_cke   (zs_cke_from_the_sdram_u2),
      .zs_cs_n  (zs_cs_n_from_the_sdram_u2),
      .zs_dq    (zs_dq_to_and_from_the_sdram_u2),
      .zs_dqm   (zs_dqm_from_the_sdram_u2),
      .zs_ras_n (zs_ras_n_from_the_sdram_u2),
      .zs_we_n  (zs_we_n_from_the_sdram_u2)
    );

  initial
    clk_25 = 1'b0;
  always
    #20 clk_25 <= ~clk_25;
  
  initial
    clk_50 = 1'b0;
  always
    #10 clk_50 <= ~clk_50;
  
  initial 
    begin
      reset_n <= 0;
      #200 reset_n <= 1;
    end

endmodule


//synthesis translate_on