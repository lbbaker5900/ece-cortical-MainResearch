/*********************************************************************************************

    File name   : wu_fetch.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : This module reads the WU memory
                  The initial wu_addr is from the system

*********************************************************************************************/
    
`timescale 1ns/10ps

`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "manager_array.vh"
`include "manager.vh"
`include "stack_interface.vh"
`include "stack_interface_typedef.vh"
`include "pe_cntl.vh"
`include "noc_cntl.vh"
`include "mem_acc_cont.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "wu_fetch.vh"


module wu_fetch (

            //-------------------------------
            // WU Memory
            //
            wuf__wum__read                    ,
            wuf__wum__addr                    ,
            
            //-------------------------------
            // Configuration
            mcntl__wuf__enable                ,
            mcntl__wuf__start_addr            ,
            
            //-------------------------------
            //
            wum__wuf__stall                   ,
            xxx__wuf__stall                   ,

            //-------------------------------
            // General
            //
            clk                               ,
            reset_poweron    
 
    );

  //----------------------------------------------------------------------------------------------------
  // General

  input                                     clk                          ;
  input                                     reset_poweron                ;

  //----------------------------------------------------------------------------------------------------
  // Control

  input                                     mcntl__wuf__enable             ;  // start fetching
  input  [`MGR_WU_ADDRESS_RANGE    ]        mcntl__wuf__start_addr         ;  // first WU address
  input                                     xxx__wuf__stall                ;

  //----------------------------------------------------------------------------------------------------
  // WU Memory

  output [`MGR_WU_ADDRESS_RANGE    ]        wuf__wum__addr                 ;
  output                                    wuf__wum__read                 ;
  input                                     wum__wuf__stall                ;


  //----------------------------------------------------------------------------------------------------
  // Registers/Wires

  reg                                       mcntl__wuf__enable_d1          ;  // first WU address
  reg  [`MGR_WU_ADDRESS_RANGE    ]          mcntl__wuf__start_addr_d1      ;  // first WU address

  reg  [`MGR_WU_ADDRESS_RANGE    ]          wuf__wum__addr                 ;
  reg                                       wuf__wum__read                 ;

  wire [`MGR_WU_ADDRESS_RANGE    ]          wuf__wum__addr_e1              ;
  wire                                      wuf__wum__read_e1              ;

  reg                                       xxx__wuf__stall_d1             ;
  reg                                       wum__wuf__stall_d1             ;

  reg  [`MGR_WU_ADDRESS_RANGE    ]          pc                             ;
  wire                                      increment_pc                   ;
  wire                                      stall                          ;

  //----------------------------------------------------------------------------------------------------
  // Registered Inputs and Outputs

  always @(posedge clk)
    begin
      xxx__wuf__stall_d1        <= ( reset_poweron   ) ? 'd0  :  xxx__wuf__stall         ;
      wum__wuf__stall_d1        <= ( reset_poweron   ) ? 'd0  :  wum__wuf__stall         ;
      mcntl__wuf__enable_d1     <= ( reset_poweron   ) ? 'd0  :  mcntl__wuf__enable      ;
      mcntl__wuf__start_addr_d1 <= ( reset_poweron   ) ? 'd0  :  mcntl__wuf__start_addr  ;
      wuf__wum__addr            <= ( reset_poweron   ) ? 'd0  :  wuf__wum__addr_e1       ;
      wuf__wum__read            <= ( reset_poweron   ) ? 'd0  :  wuf__wum__read_e1       ;

    end


  //----------------------------------------------------------------------------------------------------
  // Fetch FSM
  //

  reg [`WUF_CNTL_STATE_RANGE ] wuf_cntl_state      ; // state flop
  reg [`WUF_CNTL_STATE_RANGE ] wuf_cntl_state_next ;
  
  

  // State register 
  always @(posedge clk)
    begin
      wuf_cntl_state <= ( reset_poweron ) ? `WUF_CNTL_WAIT       :
                                            wuf_cntl_state_next  ;
    end
  
 
  always @(*)
    begin
      case (wuf_cntl_state)
        
        `WUF_CNTL_WAIT: 
          wuf_cntl_state_next =  (~stall ) ? `WUF_CNTL_START        :  // start WU read
                                             `WUF_CNTL_WAIT         ;

        `WUF_CNTL_START: 
          wuf_cntl_state_next =  (~stall ) ? `WUF_CNTL_INC_PC       :  
                                             `WUF_CNTL_START        ;

        `WUF_CNTL_INC_PC: 
          wuf_cntl_state_next =  ( stall ) ? `WUF_CNTL_STALL        :  
                                             `WUF_CNTL_INC_PC       ;

        `WUF_CNTL_STALL: 
          wuf_cntl_state_next =  (~stall ) ? `WUF_CNTL_INC_PC       :  
                                             `WUF_CNTL_STALL        ;

        // Latch state on error
        `WUF_CNTL_ERR:
          wuf_cntl_state_next = `WUF_CNTL_ERR ;
  
        default:
          wuf_cntl_state_next = `WUF_CNTL_WAIT ;
    
      endcase // case(so_cntl_state)
    end // always @ (*)
  

  //----------------------------------------------------------------------------------------------------
  // Assignments
  //

  assign stall                     = xxx__wuf__stall_d1 | wum__wuf__stall ;
  assign wuf__wum__addr_e1         = pc                   ;
  assign wuf__wum__read_e1         = increment_pc         ;

  assign increment_pc              = (wuf_cntl_state == `WUF_CNTL_INC_PC) ;

  always @(posedge clk)
    begin
      pc  <= ( reset_poweron       )  ? 'd0                       :
             (~mcntl__wuf__enable  )  ? mcntl__wuf__start_addr_d1 :
             ( increment_pc        )  ? pc + 1                    :
                                        pc                        ;
    end




endmodule



