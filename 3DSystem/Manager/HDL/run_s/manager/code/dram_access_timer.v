/*********************************************************************************************

    File name            : dram_access_timer.v
    Author               : Lee Baker
    Original Designer(s) : Hari Hara, Sharath Meneni, Akhil Ranga, Navya Talluri
    Affiliation          : North Carolina State University, Raleigh, NC
    Date                 : June 2017
    email                : lbbaker@ncsu.edu

    Description : This file maintains the timing constraints within a bank
                  
      Note: leveraged from https://github.ncsu.edu/ECE-Memory-Controller-IS/ece-diram4-memory-controller/blob/master/HDL/run_s/scheduler/code/global-timer.v

    Structure of timer with all values initated

    Rule: Check the column for issuing can_go, set row when granted
                 PO    PC    CR    CW    PR
            PO   19    9     9(3)  3     N/A
            PC   10    N/A   N/A   N/A   10 
            CR   13    3     2     2     N/A 
            CW   15    5     2     2     N/A
            PR   19    N/A   N/A   N/A   19 
                                        
            BB   19    19                19   // extra row for page open and page close and page refresh commands to check for Bank Busy counter
                                              // BB --> BANK BUSY COUNTER  

*********************************************************************************************/
    
`timescale 1ns/10ps

`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "manager_array.vh"
`include "manager.vh"
`include "main_mem_cntl.vh"
`include "dram_access_timer.vh"


module dram_access_timer(

            //clk,row_number, col_number,set, reset, upd__cam__conflict_timer_set, grant, can_go);
            
            //-------------------------------
            // Outputs
            output reg                           can_go             ,
            output reg                           can_go_valid       ,  // We need to pipeline to meet timing, so stall can_go if another command is in process
            output reg                           ready              ,  // immediately deassert ready if we are getting a request while one is still being processed

            //-------------------------------
            // Inputs
            input  wire                                  request_valid         ,
            input  wire  [`DRAM_ACC_NUM_OF_CMDS_RANGE ]  request_cmd           ,

            input  wire                                  adjacent_bank_request ,

            //-------------------------------
            // General
            //
            input  wire  [`MGR_MGR_ID_RANGE    ]  sys__mgr__mgrId ,

            input  wire                           clk             ,
            input  wire                           reset_poweron  
            );   
 

  reg [`DRAM_ACC_TIMER_RANGE        ]  page_open    [`DRAM_ACC_NUM_OF_PAGE_DEPENDENCIES_RANGE  ] ;        //column for page open, first row - page open, second row - page close, third - cr, 4 - cw
  reg [`DRAM_ACC_TIMER_RANGE        ]  page_close   [`DRAM_ACC_NUM_OF_PAGE_DEPENDENCIES_RANGE  ] ;        // for pc
  reg [`DRAM_ACC_TIMER_RANGE        ]  cache_read   [`DRAM_ACC_NUM_OF_CACHE_DEPENDENCIES_RANGE ] ;        // for cr      //each row is 5 bit number to hold the timings
  reg [`DRAM_ACC_TIMER_RANGE        ]  cache_write  [`DRAM_ACC_NUM_OF_CACHE_DEPENDENCIES_RANGE ] ;        // for cw
  reg [`DRAM_ACC_TIMER_RANGE        ]  page_refresh [`DRAM_ACC_NUM_OF_PAGE_DEPENDENCIES_RANGE  ] ;
  
  reg [`DRAM_ACC_NUM_OF_CMDS_VECTOR ]  cmd_can_go                                                ; // vector in order of DRAM_ACC_CMD_IS_*
                                                                                                 
  reg                                  request_page_open                                         ; 
  reg                                  request_page_close                                        ; 
  reg                                  request_cache_read                                        ; 
  reg                                  request_cache_write                                       ; 
  reg                                  request_page_refresh                                      ; 
  
  reg [1:0]  int_request_valid ;
  genvar gvi;
  generate
    for (gvi=0; gvi<2; gvi++)
      begin
        always @(posedge clk)
          begin
            if (gvi == 0)
              int_request_valid[gvi] = request_valid            ;
            else
              int_request_valid[gvi] = int_request_valid[gvi-1] ;
          end
      end
  endgenerate

  always @(*) 
    begin
      ready = |int_request_valid ;
    end

  always @(*)
    begin
      request_page_open     = request_valid && (request_cmd == `DRAM_ACC_CMD_IS_PO); 
      request_page_close    = request_valid && (request_cmd == `DRAM_ACC_CMD_IS_PC); 
      request_cache_read    = request_valid && (request_cmd == `DRAM_ACC_CMD_IS_CR); 
      request_cache_write   = request_valid && (request_cmd == `DRAM_ACC_CMD_IS_CW); 
      request_page_refresh  = request_valid && (request_cmd == `DRAM_ACC_CMD_IS_PR); 
    end
  
  always @(posedge clk)
  begin
    if(reset_poweron)
      begin
        for (int i=0; i<`DRAM_ACC_NUM_OF_PAGE_DEPENDENCIES ; i++)
          begin
            page_close   [i]   <= 'd0  ;
            page_open    [i]   <= 'd0  ;
            page_refresh [i]   <= 'd0  ;
          end
        for (int i=0; i<`DRAM_ACC_NUM_OF_CACHE_DEPENDENCIES ; i++)
          begin
            cache_read   [i]   <= 'd0  ;
            cache_write  [i]   <= 'd0  ;
          end
      end
    else 
      begin
        //------------------------------------------------------------------------------------------------------------------------
        // PO
        page_open    [`DRAM_ACC_CMD_IS_PO ] <= (request_page_open && can_go     ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_PO2PO  : ((|page_open    [`DRAM_ACC_CMD_IS_PO ] ) ? (page_open    [`DRAM_ACC_CMD_IS_PO ] - 1 ) : (page_open    [`DRAM_ACC_CMD_IS_PO ] ));
        page_close   [`DRAM_ACC_CMD_IS_PO ] <= (request_page_open && can_go     ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_PO2PC  : ((|page_close   [`DRAM_ACC_CMD_IS_PO ] ) ? (page_close   [`DRAM_ACC_CMD_IS_PO ] - 1 ) : (page_close   [`DRAM_ACC_CMD_IS_PO ] ));
        cache_read   [`DRAM_ACC_CMD_IS_PO ] <= (request_page_open && can_go     ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_PO2CR  : ((|cache_read   [`DRAM_ACC_CMD_IS_PO ] ) ? (cache_read   [`DRAM_ACC_CMD_IS_PO ] - 1 ) : (cache_read   [`DRAM_ACC_CMD_IS_PO ] ));
        cache_write  [`DRAM_ACC_CMD_IS_PO ] <= (request_page_open && can_go     ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_PO2CW  : ((|cache_write  [`DRAM_ACC_CMD_IS_PO ] ) ? (cache_write  [`DRAM_ACC_CMD_IS_PO ] - 1 ) : (cache_write  [`DRAM_ACC_CMD_IS_PO ] ));
        page_refresh [`DRAM_ACC_CMD_IS_PO ] <= (request_page_open && can_go     ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_PO2PR  : ((|page_refresh [`DRAM_ACC_CMD_IS_PO ] ) ? (page_refresh [`DRAM_ACC_CMD_IS_PO ] - 1 ) : (page_refresh [`DRAM_ACC_CMD_IS_PO ] ));
        //------------------------------------------------------------------------------------------------------------------------
        // PC
        page_open    [`DRAM_ACC_CMD_IS_PC ] <= (request_page_close && can_go    ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_PC2PO  : ((|page_open    [`DRAM_ACC_CMD_IS_PC ] ) ? (page_open    [`DRAM_ACC_CMD_IS_PC ] - 1 ) : (page_open    [`DRAM_ACC_CMD_IS_PC ] ));
        page_close   [`DRAM_ACC_CMD_IS_PC ] <= (request_page_close && can_go    ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_PC2PC  : ((|page_close   [`DRAM_ACC_CMD_IS_PC ] ) ? (page_close   [`DRAM_ACC_CMD_IS_PC ] - 1 ) : (page_close   [`DRAM_ACC_CMD_IS_PC ] ));
        cache_read   [`DRAM_ACC_CMD_IS_PC ] <= (request_page_close && can_go    ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_PC2CR  : ((|cache_read   [`DRAM_ACC_CMD_IS_PC ] ) ? (cache_read   [`DRAM_ACC_CMD_IS_PC ] - 1 ) : (cache_read   [`DRAM_ACC_CMD_IS_PC ] ));
        cache_write  [`DRAM_ACC_CMD_IS_PC ] <= (request_page_close && can_go    ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_PC2CW  : ((|cache_write  [`DRAM_ACC_CMD_IS_PC ] ) ? (cache_write  [`DRAM_ACC_CMD_IS_PC ] - 1 ) : (cache_write  [`DRAM_ACC_CMD_IS_PC ] ));
        page_refresh [`DRAM_ACC_CMD_IS_PC ] <= (request_page_close && can_go    ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_PC2PR  : ((|page_refresh [`DRAM_ACC_CMD_IS_PC ] ) ? (page_refresh [`DRAM_ACC_CMD_IS_PC ] - 1 ) : (page_refresh [`DRAM_ACC_CMD_IS_PC ] ));
        //------------------------------------------------------------------------------------------------------------------------
        // CR                                                                           
        page_open    [`DRAM_ACC_CMD_IS_CR ] <= (request_cache_read && can_go    ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_CR2PO  : ((|page_open    [`DRAM_ACC_CMD_IS_CR ] ) ? (page_open    [`DRAM_ACC_CMD_IS_CR ] - 1 ) : (page_open    [`DRAM_ACC_CMD_IS_CR ] ));
        page_close   [`DRAM_ACC_CMD_IS_CR ] <= (request_cache_read && can_go    ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_CR2PC  : ((|page_close   [`DRAM_ACC_CMD_IS_CR ] ) ? (page_close   [`DRAM_ACC_CMD_IS_CR ] - 1 ) : (page_close   [`DRAM_ACC_CMD_IS_CR ] ));
        cache_read   [`DRAM_ACC_CMD_IS_CR ] <= (request_cache_read && can_go    ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_CR2CR  : ((|cache_read   [`DRAM_ACC_CMD_IS_CR ] ) ? (cache_read   [`DRAM_ACC_CMD_IS_CR ] - 1 ) : (cache_read   [`DRAM_ACC_CMD_IS_CR ] ));
        cache_write  [`DRAM_ACC_CMD_IS_CR ] <= (request_cache_read && can_go    ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_CR2CW  : ((|cache_write  [`DRAM_ACC_CMD_IS_CR ] ) ? (cache_write  [`DRAM_ACC_CMD_IS_CR ] - 1 ) : (cache_write  [`DRAM_ACC_CMD_IS_CR ] ));
        page_refresh [`DRAM_ACC_CMD_IS_CR ] <= (request_cache_read && can_go    ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_CR2PR  : ((|page_refresh [`DRAM_ACC_CMD_IS_CR ] ) ? (page_refresh [`DRAM_ACC_CMD_IS_CR ] - 1 ) : (page_refresh [`DRAM_ACC_CMD_IS_CR ] ));
        //------------------------------------------------------------------------------------------------------------------------
        // CW                                                                                
        page_open    [`DRAM_ACC_CMD_IS_CW ] <= (request_cache_write && can_go   ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_CW2PO  : ((|page_open    [`DRAM_ACC_CMD_IS_CW ] ) ? (page_open    [`DRAM_ACC_CMD_IS_CW ] - 1 ) : (page_open    [`DRAM_ACC_CMD_IS_CW ] ));
        page_close   [`DRAM_ACC_CMD_IS_CW ] <= (request_cache_write && can_go   ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_CW2PC  : ((|page_close   [`DRAM_ACC_CMD_IS_CW ] ) ? (page_close   [`DRAM_ACC_CMD_IS_CW ] - 1 ) : (page_close   [`DRAM_ACC_CMD_IS_CW ] ));
        cache_read   [`DRAM_ACC_CMD_IS_CW ] <= (request_cache_write && can_go   ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_CW2CR  : ((|cache_read   [`DRAM_ACC_CMD_IS_CW ] ) ? (cache_read   [`DRAM_ACC_CMD_IS_CW ] - 1 ) : (cache_read   [`DRAM_ACC_CMD_IS_CW ] ));
        cache_write  [`DRAM_ACC_CMD_IS_CW ] <= (request_cache_write && can_go   ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_CW2CW  : ((|cache_write  [`DRAM_ACC_CMD_IS_CW ] ) ? (cache_write  [`DRAM_ACC_CMD_IS_CW ] - 1 ) : (cache_write  [`DRAM_ACC_CMD_IS_CW ] ));
        page_refresh [`DRAM_ACC_CMD_IS_CW ] <= (request_cache_write && can_go   ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_CW2PR  : ((|page_refresh [`DRAM_ACC_CMD_IS_CW ] ) ? (page_refresh [`DRAM_ACC_CMD_IS_CW ] - 1 ) : (page_refresh [`DRAM_ACC_CMD_IS_CW ] ));
        //------------------------------------------------------------------------------------------------------------------------
        // PR
        page_open    [`DRAM_ACC_CMD_IS_PR ] <= (request_page_refresh && can_go  ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_PR2PO : ((|page_open    [`DRAM_ACC_CMD_IS_PR ] ) ? (page_open    [`DRAM_ACC_CMD_IS_PR ] - 1 ) : (page_open    [`DRAM_ACC_CMD_IS_PR ] ));
        page_close   [`DRAM_ACC_CMD_IS_PR ] <= (request_page_refresh && can_go  ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_PR2PC : ((|page_close   [`DRAM_ACC_CMD_IS_PR ] ) ? (page_close   [`DRAM_ACC_CMD_IS_PR ] - 1 ) : (page_close   [`DRAM_ACC_CMD_IS_PR ] ));
        cache_read   [`DRAM_ACC_CMD_IS_PR ] <= (request_page_refresh && can_go  ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_PR2CR : ((|cache_read   [`DRAM_ACC_CMD_IS_PR ] ) ? (cache_read   [`DRAM_ACC_CMD_IS_PR ] - 1 ) : (cache_read   [`DRAM_ACC_CMD_IS_PR ] ));
        cache_write  [`DRAM_ACC_CMD_IS_PR ] <= (request_page_refresh && can_go  ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_PR2CW : ((|cache_write  [`DRAM_ACC_CMD_IS_PR ] ) ? (cache_write  [`DRAM_ACC_CMD_IS_PR ] - 1 ) : (cache_write  [`DRAM_ACC_CMD_IS_PR ] ));
        page_refresh [`DRAM_ACC_CMD_IS_PR ] <= (request_page_refresh && can_go  ) ? `DRAM_ACC_DIRAM4_REQMTS_TIMER_PR2PR : ((|page_refresh [`DRAM_ACC_CMD_IS_PR ] ) ? (page_refresh [`DRAM_ACC_CMD_IS_PR ] - 1 ) : (page_refresh [`DRAM_ACC_CMD_IS_PR ] ));
        //------------------------------------------------------------------------------------------------------------------------
        // Adjacent Bank
        page_open    [`DRAM_ACC_CMD_IS_ADJ ] <= ((adjacent_bank_request ) ? (`DRAM_ACC_DIRAM4_REQMTS_TIMER_INTER_BANK ) : ((|page_open    [`DRAM_ACC_CMD_IS_ADJ ] ) ? (page_open    [`DRAM_ACC_CMD_IS_ADJ ] - 1 ) : (page_open    [`DRAM_ACC_CMD_IS_ADJ ] )));
        page_close   [`DRAM_ACC_CMD_IS_ADJ ] <= ((adjacent_bank_request ) ? (`DRAM_ACC_DIRAM4_REQMTS_TIMER_INTER_BANK ) : ((|page_close   [`DRAM_ACC_CMD_IS_ADJ ] ) ? (page_close   [`DRAM_ACC_CMD_IS_ADJ ] - 1 ) : (page_close   [`DRAM_ACC_CMD_IS_ADJ ] )));
        page_refresh [`DRAM_ACC_CMD_IS_ADJ ] <= ((adjacent_bank_request ) ? (`DRAM_ACC_DIRAM4_REQMTS_TIMER_INTER_BANK ) : ((|page_refresh [`DRAM_ACC_CMD_IS_ADJ ] ) ? (page_refresh [`DRAM_ACC_CMD_IS_ADJ ] - 1 ) : (page_refresh [`DRAM_ACC_CMD_IS_ADJ ] )));
      end
  end
  
  // we will need immediate feedback, so minimize logic
  always @(posedge clk)
    begin
       cmd_can_go[`DRAM_ACC_CMD_IS_PO ] <= (request_page_open    && can_go) ? 1'b0 :
                                                                              ((page_open   [0] == 0) & (page_open   [1] == 0) & (page_open   [2] == 0) & (page_open   [3] == 0) & (page_open   [4] == 0) & (page_open   [5] == 0)) ;
                                                                   
       cmd_can_go[`DRAM_ACC_CMD_IS_PC ] <= (request_page_close   && can_go) ? 1'b0 :
                                                                              ((page_close  [0] == 0) & (page_close  [1] == 0) & (page_close  [2] == 0) & (page_close  [3] == 0) & (page_close  [4] == 0) & (page_close  [5] == 0)) ;
                                                                   
       cmd_can_go[`DRAM_ACC_CMD_IS_CR ] <= (request_cache_read   && can_go) ? 1'b0 :
                                                                              ((cache_read  [0] == 0) & (cache_read  [1] == 0) & (cache_read  [2] == 0) & (cache_read  [3] == 0) & (cache_read  [4] == 0) ) ;
                                                                   
       cmd_can_go[`DRAM_ACC_CMD_IS_CW ] <= (request_cache_write  && can_go) ? 1'b0 :
                                                                              ((cache_write [0] == 0) & (cache_write [1] == 0) & (cache_write [2] == 0) & (cache_write [3] == 0) & (cache_write [4] == 0) ) ;
                                                                   
       cmd_can_go[`DRAM_ACC_CMD_IS_PR ] <= (request_page_refresh && can_go) ? 1'b0 :
                                                                              ((page_refresh[0] == 0) & (page_refresh[1] == 0) & (page_refresh[2] == 0) & (page_refresh[3] == 0) & (page_refresh[4] == 0) & (page_refresh[5] == 0)) ;

    end

  always @(*)
    begin
      can_go = 0;
      can_go_valid = 1;  // FIXME
      case(request_cmd)
        `DRAM_ACC_CMD_IS_PO:
          begin
            can_go = cmd_can_go [`DRAM_ACC_CMD_IS_PO ] ;
          end

        `DRAM_ACC_CMD_IS_PC:
          begin
            can_go = cmd_can_go [`DRAM_ACC_CMD_IS_PC ] ;
          end

        `DRAM_ACC_CMD_IS_CR:
          begin
            can_go = cmd_can_go [`DRAM_ACC_CMD_IS_CR ] ;
          end

        `DRAM_ACC_CMD_IS_CW:
          begin
            can_go = cmd_can_go [`DRAM_ACC_CMD_IS_CW ] ;
          end

        `DRAM_ACC_CMD_IS_PR:
          begin
            can_go = cmd_can_go [`DRAM_ACC_CMD_IS_PR ] ;
          end
      endcase
    end
  
  
  endmodule
  
  
  
  
  
