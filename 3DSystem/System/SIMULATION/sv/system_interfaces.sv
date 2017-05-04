/*********************************************************************************************
    File name   : system_interfaces.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : May 2017
    Email       : lbbaker@ncsu.edu
    
    Description : This file contains:
                    - NoC interface to local manager
*********************************************************************************************/

`timescale 1ns/10ps

`include "common.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"
`include "pe.vh"
`include "pe_array.vh"
`include "stack_interface.vh"
`include "stack_interface_typedef.vh"
`include "noc_interpe_port_Bitmasks.vh"

`include "mgr_noc_cntl.vh"
`include "manager.vh"
`include "manager_array.vh"

///////////////////////////////////////////////////////////////////////////////
// Downstream
///////////////////////////////////////////////////////////////////////////////

// NoC block local interface to local
interface locl_from_noc_ifc(
                           input bit clk   );

    logic                                            noc__locl__dp_valid      ; 
    logic [`COMMON_STD_INTF_CNTL_RANGE             ] noc__locl__dp_cntl       ; 
    logic                                            locl__noc__dp_ready      ; 
    logic [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ] noc__locl__dp_type       ; 
    logic [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ] noc__locl__dp_ptype      ; 
    logic [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ] noc__locl__dp_data       ; 
    logic                                            noc__locl__dp_pvalid     ; 
    logic [`MGR_MGR_ID_RANGE                       ] noc__locl__dp_mgrId      ; 

    clocking cb_p @(posedge clk);
      input  noc__locl__dp_valid      ; 
      input  noc__locl__dp_cntl       ; 
      input  locl__noc__dp_ready      ; 
      input  noc__locl__dp_type       ; 
      input  noc__locl__dp_ptype      ; 
      input  noc__locl__dp_data       ; 
      input  noc__locl__dp_pvalid     ; 
      input  noc__locl__dp_mgrId      ; 
    endclocking : cb_p

endinterface : locl_from_noc_ifc

typedef virtual locl_from_noc_ifc vLocalFromNoC_T  ;


// NoC block local interface from local
interface locl_to_noc_ifc(
                           input bit clk   );

    logic                                            locl__noc__dp_valid      ; 
    logic [`COMMON_STD_INTF_CNTL_RANGE             ] locl__noc__dp_cntl       ; 
    logic                                            noc__locl__dp_ready      ; 
    logic [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ] locl__noc__dp_type       ; 
    logic [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ] locl__noc__dp_ptype      ; 
    logic [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE       ] locl__noc__dp_desttype   ; 
    logic                                            locl__noc__dp_pvalid     ; 
    logic [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ] locl__noc__dp_data       ; 

    clocking cb_p @(posedge clk);
      input  locl__noc__dp_valid      ; 
      input  locl__noc__dp_cntl       ; 
      input  noc__locl__dp_ready      ; 
      input  locl__noc__dp_type       ; 
      input  locl__noc__dp_ptype      ; 
      input  locl__noc__dp_desttype   ; 
      input  locl__noc__dp_pvalid     ; 
      input  locl__noc__dp_data       ; 
    endclocking : cb_p
endinterface : locl_to_noc_ifc

typedef virtual locl_to_noc_ifc vLocalToNoC_T  ;


// WU Decoder to MR interface(s)
interface wud_to_mrc_ifc(
                           input bit clk   );

    logic                                      wud__mrc__valid                                  ;  // send MR descriptors
    logic                                      mrc__wud__ready                                  ;
    logic [`COMMON_STD_INTF_CNTL_RANGE    ]    wud__mrc__cntl                                   ;  // descriptor delineator
    logic [`MGR_WU_OPT_TYPE_RANGE         ]    wud__mrc__option_type    [`MGR_WU_OPT_PER_INST ] ;  // WU Instruction option fields
    logic [`MGR_WU_OPT_VALUE_RANGE        ]    wud__mrc__option_value   [`MGR_WU_OPT_PER_INST ] ;  
            
    clocking cb_p @(posedge clk);

      input   wud__mrc__valid           ;  // send MR descriptors
      input   mrc__wud__ready           ;
      input   wud__mrc__cntl            ;  // descriptor delineator
      input   wud__mrc__option_type     ;  // WU Instruction option fields
      input   wud__mrc__option_value    ;  
            
    endclocking : cb_p
endinterface : wud_to_mrc_ifc

typedef virtual wud_to_mrc_ifc vWudToMrc_T  ;


