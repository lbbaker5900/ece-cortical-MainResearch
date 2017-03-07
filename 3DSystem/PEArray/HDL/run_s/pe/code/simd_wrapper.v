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

  // store in reg before transferring to simd
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  allLanes_results  [`PE_NUM_OF_EXEC_LANES ] ;
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  allLanes_valid                             ;

  //----------------------------------------------------------------------------------------------------
  // Assignments
  //
  //----------------------------------------------------------------------
  // Update each lanes regFile with result from streaming operation module 

  genvar gvi;
  generate
    for (gvi=0; gvi<`PE_NUM_OF_EXEC_LANES ; gvi=gvi+1) 
      begin: regFile_load

        wire                               lane_result_valid  ;
        wire  [`PE_EXEC_LANE_WIDTH_RANGE]  lane_result        ;
        
        always @(posedge clk)
          begin
            allLanes_valid  [gvi]  <=  ( reset_poweron     ) ? 1'd0                    :
                                       ( lane_result_valid ) ? 1'b1                    :
                                                               allLanes_valid[gvi]     ;

            allLanes_results[gvi]  <=  ( reset_poweron     ) ? `PE_EXEC_LANE_WIDTH 'd0 :
                                       ( lane_result_valid ) ? lane_result             :
                                                               allLanes_results[gvi]   ;

          end

      end
  endgenerate

  `include "simd_wrapper_scntl_to_simd_regfile_assignments.vh"

  //----------------------------------------------------------------------------------------------------
  
endmodule

