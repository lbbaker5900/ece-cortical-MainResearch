/*********************************************************************************************

    File name   : simd_wrapper.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : This module takes instantiates the SIMD core and provides conenctions to/from the other PE functions

                  stOp
                    - provides a regFile interface to communicate with the streamingOps
                  Local memory
                    - provides a means to arbittrate for the local memory 

*********************************************************************************************/
    
`timescale 1ns/10ps
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "simd_wrapper.vh"
`include "stack_interface.vh"
`include "noc_cntl.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"




module simd_wrapper (

                          //-------------------------------
                          // PE control configuration to stOp via simd
                          //
                          `include "pe_cntl_simd_ports.vh"

                          //-------------------------------
                          // Configuration output to stOp
                          //
                          `include "pe_simd_ports.vh"

                          //-------------------------------
                          // Result from stOp to regFile (via scntl)
                          `include "simd_wrapper_scntl_to_simd_regfile_ports.vh"

                          //--------------------------------------------------------
                          // System
                          peId              ,
                          clk               ,
                          reset_poweron     
    );

  input                       clk            ;
  input                       reset_poweron  ;
  input [`PE_PE_ID_RANGE   ]  peId           ; 


  //----------------------------------------------------------------------------------------------------
  // RegFile Outputs to stOp controller

  `include "pe_simd_wrapper_output_port_declarations.vh"

  //----------------------------------------------------------------------------------------------------
  // PE control to stOp via SIMD

  `include "pe_simd_wrapper_input_port_declarations.vh"

  //----------------------------------------------------------------------------------------------------
  // Result from stOp to regFile

  `include "simd_wrapper_scntl_to_simd_regfile_ports_declaration.vh"


  //----------------------------------------------------------------------------------------------------
  // Registers/Wires
  //
  `include "pe_simd_wrapper_assignments.vh"
  `include "simd_wrapper_scntl_to_simd_regfile_wires.vh"

  //----------------------------------------------------------------------------------------------------
  // Assignments
  //
  `include "simd_wrapper_scntl_to_simd_regfile_assignments.vh"
  
endmodule

