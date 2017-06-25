/*********************************************************************************************

    File name   : main_mem_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2017
    email       : lbbaker@ncsu.edu

    Description : Take commands fro mrc_cntl and access dram
                  
      Note: leveraged from https://github.ncsu.edu/ECE-Memory-Controller-IS/ece-diram4-memory-controller/blob/master/HDL/run_s/scheduler

*********************************************************************************************/
    
`timescale 1ns/10ps

`include "common.vh"
`include "manager.vh"
`include "main_mem_cntl.vh"

module main_mem_cntl (

            //-------------------------------
            // Main Memory Controller interface
            //
            input   wire                                           mrc__mmc__valid                                   ,
            input   wire  [`COMMON_STD_INTF_CNTL_RANGE      ]      mrc__mmc__cntl                                    ,
            output  reg                                            mmc__mrc__ready                                   ,
            input   wire  [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      mrc__mmc__channel                                 ,
            input   wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      mrc__mmc__bank                                    ,
            input   wire  [ `MGR_DRAM_PAGE_ADDRESS_RANGE    ]      mrc__mmc__page                                    ,
            input   wire  [ `MGR_DRAM_WORD_ADDRESS_RANGE    ]      mrc__mmc__word                                    ,
                                                                                                                    
            // MMC provides data from each DRAM channel
            // - response must be in order of request
            output  reg                                            mmc__mrc__valid   [`MGR_DRAM_NUM_CHANNELS ]                                 ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      mmc__mrc__cntl    [`MGR_DRAM_NUM_CHANNELS ]                                 ,
            input   wire                                           mrc__mmc__ready   [`MGR_DRAM_NUM_CHANNELS ]                                 ,
            output  reg   [ `MGR_EXEC_LANE_WIDTH_RANGE      ]      mmc__mrc__data    [`MGR_DRAM_NUM_CHANNELS ] [`MGR_MMC_TO_MRC_INTF_NUM_WORDS ] ,


            //-------------------------------
            // General
            //
            input  wire  [`MGR_MGR_ID_RANGE    ]  sys__mgr__mgrId ,

            input  wire                           clk             ,
            input  wire                           reset_poweron  
 
              );   


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Register inputs and outputs

  //--------------------------------------------------
  // Memory request input
  reg                                            mrc__mmc__valid_d1      ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      mrc__mmc__cntl_d1       ;
  reg                                            mmc__mrc__ready_e1      ;
  reg   [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      mrc__mmc__channel_d1    ;
  reg   [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      mrc__mmc__bank_d1       ;
  reg   [ `MGR_DRAM_PAGE_ADDRESS_RANGE    ]      mrc__mmc__page_d1       ;
  reg   [ `MGR_DRAM_WORD_ADDRESS_RANGE    ]      mrc__mmc__word_d1       ;
       
  always @(posedge clk) 
    begin
      mrc__mmc__valid_d1     <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__valid     ; 
      mrc__mmc__cntl_d1      <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__cntl      ; 
      mmc__mrc__ready        <=   ( reset_poweron   ) ? 'd0  :  mmc__mrc__ready_e1  ; 
      mrc__mmc__channel_d1   <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__channel   ; 
      mrc__mmc__bank_d1      <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__bank      ; 
      mrc__mmc__page_d1      <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__page      ; 
      mrc__mmc__word_d1      <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__word      ; 
    end

  reg                                         mmc__mrc__valid_e1   [`MGR_DRAM_NUM_CHANNELS ]                                 ;
  reg  [`COMMON_STD_INTF_CNTL_RANGE      ]    mmc__mrc__cntl_d1    [`MGR_DRAM_NUM_CHANNELS ]                                 ;
  reg                                         mrc__mmc__ready_e1   [`MGR_DRAM_NUM_CHANNELS ]                                 ;
  reg  [ `MGR_EXEC_LANE_WIDTH_RANGE      ]    mmc__mrc__data_e1    [`MGR_DRAM_NUM_CHANNELS ] [`MGR_MMC_TO_MRC_INTF_NUM_WORDS ] ;

  always @(posedge clk) 
    begin
      for (int chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
        begin: mem_responce
          mmc__mrc__valid    [chan]  <=   ( reset_poweron   ) ? 'd0  :  mmc__mrc__valid_e1 [chan]  ; 
          mmc__mrc__cntl     [chan]  <=   ( reset_poweron   ) ? 'd0  :  mmc__mrc__cntl_e1  [chan]  ; 
          mrc__mmc__ready_d1 [chan]  <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__ready    [chan]  ; 
          mmc__mrc__data     [chan]  <=   ( reset_poweron   ) ? 'd0  :  mmc__mrc__data_e1  [chan]  ; 
        end
    end

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Request input FIFO

  genvar gvi ;
  generate
    for (gvi=0; gvi<2 ; gvi=gvi+1) 
      begin: request_fifo

        wire  clear        ;
        wire  almost_full  ;
        wire                                           write        ;
        wire                                           pipe_valid   ;
        wire                                           pipe_read    ;

        wire  [ `COMMON_STD_INTF_CNTL_RANGE     ]      pipe_request_cntl     ;
        wire  [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      pipe_request_channel  ;
        wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      pipe_request_bank     ;
        wire  [ `MGR_DRAM_PAGE_ADDRESS_RANGE    ]      pipe_request_page     ;
        wire  [ `MGR_DRAM_WORD_ADDRESS_RANGE    ]      pipe_request_word     ;

        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_REQUEST_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_REQUEST_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_REQUEST_AGGREGATE_FIFO_WIDTH       )
                        ) gpfifo (
                                 // Status
                                .almost_full      ( almost_full           ),
                                 // Write                                 
                                .write            ( write                 ),
                                .write_data       ({mrc__mmc__cntl_d1, mrc__mmc__channel_d1, mrc__mmc__bank_d1, mrc__mmc__page_d1, mrc__mmc__word_d1}),
                                 // Read                                  
                                .pipe_valid       ( pipe_valid            ),
                                .write_data       ({pipe_request_cntl, pipe_request_channel, pipe_request_bank, pipe_request_page, pipe_request_word}),
                                .pipe_data        ( pipe_data             ),
                                .pipe_read        ( pipe_read             ),

                                // General
                                .clear            ( clear                 ),
                                .reset_poweron    ( reset_poweron         ),
                                .clk              ( clk                   )
                                );

        wire   pipe_som     =  (pipe_request_cntl == `COMMON_STD_INTF_CNTL_SOM    ); 
        wire   pipe_eom     =  (pipe_request_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (pipe_request_cntl == `COMMON_STD_INTF_CNTL_EOM);
      end
  endgenerate

  always @(*)
    begin
      mmc__mrc__ready_e1     = ~request_fifo[0].almost_full ;
      request_fifo[0].write  = mrc__mmc__valid_d1           ;
    end

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Open Page registers

  generate
    for (gvi=0; gvi<MGR_DRAM_NUM_BANKS ; gvi=gvi+1) 
      begin: bank_info

        reg                                ]    a_page_is_open ;
        reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE ]    open_page_id   ;

      end
  endgenerate

//--------------------------------------------------------------------------------
// Page Final Queue
//
input fq__drv__pgcmd_cmd_empty;
input fq__drv__pgcmd_bank_addr_empty;  // FIXME: Not used
input fq__drv__pgcmd_page_addr_empty;  // FIXME: Not used

output reg drv__fq__pgcmd_cmd_rd_en;
output reg drv__fq__pgcmd_bank_addr_rd_en;
output reg drv__fq__pgcmd_cache_addr_rd_en;
output reg drv__fq__pgcmd_page_addr_rd_en;

input [`SCH__DFI_CMD_RANGE         ]  fq__drv__pgcmd_cmd_rd_data                     ;
input [`SCH__DFI_CMD_RANGE         ]  fq__drv__pgcmd_cmd_peek_rd_data                ; // need to anticipate whether a RW command is a write
input [`SCH__DFI_CMD_RANGE         ]  fq__drv__pgcmd_cmd_peek_twoIn_rd_data          ; // need to anticipate whether a RW command is a write
input [`SCH__FNS_BANK_ADDRESS_RANGE]  fq__drv__pgcmd_bank_addr_rd_data               ;
input [`SCH__FNS_PAGE_ADDRESS_RANGE]  fq__drv__pgcmd_page_addr_rd_data               ;
input [`SCH__FNS_COL_ADDRESS_RANGE ]  fq__drv__pgcmd_cache_addr_rd_data              ;  // FIXME: Not used
input                                 fq__drv__pgcmd_hasTwoOrMoreEntires             ;

//--------------------------------------------------------------------------------
// Read/Write Final Queue
//
input fq__drv__rwcmd_cmd_empty;
input fq__drv__rwcmd_bank_addr_empty;
input fq__drv__rwcmd_cache_addr_empty;      // FIXME: not used

output reg drv__fq__rwcmd_cmd_rd_en;
output reg drv__fq__rwcmd_bank_addr_rd_en;
output reg drv__fq__rwcmd_page_addr_rd_en;
output reg drv__fq__rwcmd_cache_addr_rd_en;

input [`SCH__DFI_CMD_RANGE         ]  fq__drv__rwcmd_cmd_rd_data                     ; // FIXME : Not used
input [`SCH__DFI_CMD_RANGE         ]  fq__drv__rwcmd_cmd_peek_rd_data                ; // need to anticipate whether a RW command is a write
input [`SCH__DFI_CMD_RANGE         ]  fq__drv__rwcmd_cmd_peek_twoIn_rd_data          ; // need to anticipate whether a RW command is a write
input [`SCH__FNS_BANK_ADDRESS_RANGE]  fq__drv__rwcmd_bank_addr_rd_data               ;
input [`SCH__FNS_BANK_ADDRESS_RANGE]  fq__drv__rwcmd_bank_addr_peek_rd_data          ; // if the anticipated RW command is a write, we need to peek the bank address to determine which data fifo to read
input [`SCH__FNS_BANK_ADDRESS_RANGE]  fq__drv__rwcmd_bank_addr_peek_twoIn_rd_data    ; // if the anticipated RW command is a write, we need to peek the bank address to determine which data fifo to read
input [`SCH__FNS_PAGE_ADDRESS_RANGE]  fq__drv__rwcmd_page_addr_rd_data               ; // FIXME: Not used
input [`SCH__FNS_COL_ADDRESS_RANGE ]  fq__drv__rwcmd_cache_addr_rd_data              ; 
input                                 fq__drv__rwcmd_hasTwoOrMoreEntires             ;




`include "sch_driver_data_ports_instance.vh"


//--------------------------------------------------------------------------------
// DFI Interface
//
input                                     dfi__drv__init_done;
input    [OCP_WIDTH*PORT_NO-1:0       ]   dfi__drv__rddata;
input                                     dfi__drv__rddata_valid;
output reg                                drv__dfi__cs;
output reg                                drv__dfi__cmd0; 
output reg                                drv__dfi__cmd1;
output reg [`SCH__DFI_DATA_WIDTH_RANGE  ] drv__dfi__data1;
output reg [`SCH__DFI_DATA_WIDTH_RANGE  ] drv__dfi__data2;
output reg [`SCH__FNS_BANK_ADDRESS_RANGE] drv__dfi__bank_addr;
output reg [`SCH__FNS_PAGE_ADDRESS_RANGE] drv__dfi__rc_addr;

reg cmd_mode;
reg [7:0] current_state;
reg [7:0] next_state;


localparam WAIT                       = 8'b0000_0001 ;

localparam NOP_PAGE_CMD               = 8'b0000_0010 ;
localparam NOP_PAGE_CMD_WITH_WR_DATA  = 8'b0000_0100 ;
localparam PAGE_CMD                   = 8'b0000_1000 ;
localparam PAGE_CMD_WITH_WR_DATA      = 8'b0001_0000 ;

localparam NOP_RW_CMD                 = 8'b0010_0000 ;
localparam RD_CMD                     = 8'b0100_0000 ;
localparam WR_CMD                     = 8'b1000_0000 ;

localparam PO  = 3'b000; 
localparam PC  = 3'b001; 
localparam PR  = 3'b100; //Nikhil - changed from 010
localparam CR  = 3'b010; //changed from 011
localparam CW  = 3'b011; //changed from 001
localparam NOP = 3'b111;

always@(posedge clock)
begin
  if(reset || !dfi__drv__init_done)
     cmd_mode <= 0;
  else
     cmd_mode <= ~cmd_mode; 
end


always@(posedge clock)
  begin
    if(reset)
      current_state <= WAIT;
    else
      current_state <= next_state;
  end

`define SCH_DRIVER_READ_FINAL_QUEUES \
                    drv__fq__pgcmd_cmd_rd_en        = 1'b1; \
                    drv__fq__pgcmd_bank_addr_rd_en  = 1'b1; \
                    drv__fq__pgcmd_page_addr_rd_en  = 1'b1; \
                    drv__fq__pgcmd_cache_addr_rd_en = 1'b1; \
                   \
                    drv__fq__rwcmd_cmd_rd_en        = 1'b1; \
                    drv__fq__rwcmd_bank_addr_rd_en  = 1'b1; \
                    drv__fq__rwcmd_page_addr_rd_en  = 1'b1; \
                    drv__fq__rwcmd_cache_addr_rd_en = 1'b1;

`define SCH_DRIVER_DO_NOT_READ_FINAL_QUEUES \
                    drv__fq__pgcmd_cmd_rd_en        = 1'b0; \
                    drv__fq__pgcmd_bank_addr_rd_en  = 1'b0; \
                    drv__fq__pgcmd_page_addr_rd_en  = 1'b0; \
                    drv__fq__pgcmd_cache_addr_rd_en = 1'b0; \
                   \
                    drv__fq__rwcmd_cmd_rd_en        = 1'b0; \
                    drv__fq__rwcmd_bank_addr_rd_en  = 1'b0; \
                    drv__fq__rwcmd_page_addr_rd_en  = 1'b0; \
                    drv__fq__rwcmd_cache_addr_rd_en = 1'b0;


//------------------------------------------------------------------------------------------
//wires 
//------------------------------------------------------------------------------------------
 
// now we only really have one fifo, create a generic command fifo empty and
// cerate an error flags if the two empty signals arent the same
wire fq__drv__cmd_empty               = fq__drv__pgcmd_cmd_empty ;
wire fq__drv__cmd_hasTwoOrMoreEntires = fq__drv__pgcmd_hasTwoOrMoreEntires ;

wire exc_fq__drv__cmd_fifo_error = (fq__drv__pgcmd_cmd_empty != fq__drv__rwcmd_cmd_empty                     ) |
                                   (fq__drv__pgcmd_hasTwoOrMoreEntires != fq__drv__rwcmd_hasTwoOrMoreEntires ) ;

always@(*)
  begin

    //----------------------------------------------------------------------------------------------------
    // Default drive values

    `SCH_DRIVER_DO_NOT_READ_FINAL_QUEUES 

    {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b000 ;  // NOP
    drv__dfi__bank_addr                          = 0      ; 
    drv__dfi__rc_addr                            = 0      ; 
    drv__dfi__data1                              = 0      ;
    drv__dfi__data2                              = 0      ;
    
    `include "sch_driver_data_rd_en_disable.vh"  

    //----------------------------------------------------------------------------------------------------
    // State defined drive values

    case(current_state)
    
        WAIT: 
            begin
    
            if(reset || !dfi__drv__init_done || fq__drv__cmd_empty || (cmd_mode == 1'b1)) //if initialization not done
              begin
                  next_state = WAIT;
              end
            // we will always see a page command first, but ensure we first respond to page command after reset to synchronize with the DiRAM4
            else  
              begin
    
                 `SCH_DRIVER_READ_FINAL_QUEUES 

                 // From the WAIT state, the next state can be     // so if the RW command fifo isnt empty and the RW command is a write, we need to read the target data fifo based on the
                 // "peeked" RW bank address
                  // first time thu its gonna be 
                  if      (fq__drv__cmd_hasTwoOrMoreEntires &&  (fq__drv__rwcmd_cmd_peek_twoIn_rd_data == CR) || (fq__drv__rwcmd_cmd_peek_twoIn_rd_data == NOP))
                    begin
                      next_state = PAGE_CMD;
                    end
                  else if (fq__drv__cmd_hasTwoOrMoreEntires &&  fq__drv__rwcmd_cmd_peek_twoIn_rd_data == CW)
                    begin
                      next_state = PAGE_CMD_WITH_WR_DATA;
    
                      // need to prepare write data to be output one cycle early with page command
                      `include "sch_driver_peek_select_data_fifo.vh"  
                    end
                  else
                    begin
                      next_state = PAGE_CMD;
                    end
    
             end   
           end
    
        PAGE_CMD: 
            begin
                // This state cmd_mode == 1
            
                // DFI Output
                if(fq__drv__pgcmd_cmd_rd_data == PO)
                   {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b011; //page open  // FIXME : use defines
                else if(fq__drv__pgcmd_cmd_rd_data == PC)
                   {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b010; //page close
                else if(fq__drv__pgcmd_cmd_rd_data == PR)
                   {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b001; //page refresh
                else if(fq__drv__pgcmd_cmd_rd_data == NOP)
                   {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b000; //nop
            
                drv__dfi__bank_addr                             = fq__drv__pgcmd_bank_addr_rd_data; 
                drv__dfi__rc_addr                               = fq__drv__pgcmd_page_addr_rd_data; 
            
                if(fq__drv__cmd_empty)
                  begin
                    next_state = NOP_RW_CMD;
                  end
      
                else if (fq__drv__rwcmd_cmd_peek_rd_data == NOP)  // queue has data but the next RW is not a valid RW command
                  begin

                    next_state = NOP_RW_CMD;
                  end
                else
                  // if the RW command fifo isnt empty, we either got to the page command because the RW fifo contains a read 
                  // 'or' a write command has just arrived
                  // If a write command has just arrived, its too late to preread the data to have it available during this current command phase,
                  // so we'll jump to the RW NOP state where we can assert the data fifo read enable and then we'll jump to the PAGE_CMD_WITH_WR_DATA state
                  begin
    
                    if      (fq__drv__rwcmd_cmd_peek_rd_data == CR)
                      begin
                        `SCH_DRIVER_READ_FINAL_QUEUES 

                        next_state = RD_CMD;

                      end
                    // The only option left is a WR in the RW cmd fifo
                    // jump to the NOP_RW_CMD state so we can pre-load the
                    // data during the next PG phase
                    else
                      begin
                        next_state = NOP_RW_CMD;
                      end
                  end              
            end
    
        PAGE_CMD_WITH_WR_DATA: 
            begin
                // This state cmd_mode == 1
                //
                // To get to this state, we have pre-read the RW fifo and write data fifo, so drive the write data using the RW bank address
                // We also know the next 'RW' phase is a write and as we have pre-read the RW fifo just transition to the WR_CMD state
            
                // It is a valid 'Page' phase, so drive the DFI interface
                if(fq__drv__pgcmd_cmd_rd_data == PO)
                   {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b011; //page open
                else if(fq__drv__pgcmd_cmd_rd_data == PC)
                   {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b010; //page close
                else if(fq__drv__pgcmd_cmd_rd_data == PR)
                   {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b001; //page refresh
                else if(fq__drv__pgcmd_cmd_rd_data == NOP)
                   {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b000; //nop
            
                drv__dfi__bank_addr                             = fq__drv__pgcmd_bank_addr_rd_data; 
                drv__dfi__rc_addr                               = fq__drv__pgcmd_page_addr_rd_data; 
            
                `SCH_DRIVER_READ_FINAL_QUEUES 

                // We already know the next RW command is a WR and we have pre-read the write data fifo, so use the peeked RW bank addr to 
                // select data to drive onto the dfi interface drv__dfi__data[1:2]
                // remember, we write the first chunk of data during the PG cmd phase prior to the WR during the RW phase
                `include "sch_driver_peek_get_data_fifo.vh"  
            
                 // We know the next 'RW' phase is a write so transition to the WR_CMD state and load the second data word  
                 // Remember, we had pre-read the RW fifo so no RW fifo reads occur in this state
                 next_state = WR_CMD;
            
                // Pre-read the write data fifo based on the bank address in the peeked RW bank address fifo
                 `include "sch_driver_select_data_fifo.vh"  
            end
    
        NOP_PAGE_CMD: 
            begin
                // This state cmd_mode == 1
            
                if(fq__drv__cmd_empty)
                  begin
                    next_state = NOP_RW_CMD;
                  end
      
                else if (fq__drv__rwcmd_cmd_peek_rd_data == NOP)  // queue has data but the next RW is not a valid RW command
                  begin

                    next_state = NOP_RW_CMD;
                  end
                else
                  // if the RW command fifo isnt empty, we either got to the page command because the RW fifo contains a read 
                  // 'or' a write command has just arrived
                  // If a write command has just arrived, its too late to preread the data to have it available during this current command phase,
                  // so we'll jump to the RW NOP state where we can assert the data fifo read enable and then we'll jump to the PAGE_CMD_WITH_WR_DATA state
                  begin
    
                    if      (fq__drv__rwcmd_cmd_peek_rd_data == CR)
                      begin
                        `SCH_DRIVER_READ_FINAL_QUEUES 

                        next_state = RD_CMD;

                      end
                    // The only option left is a WR in the RW cmd fifo
                    // jump to the NOP_RW_CMD state so we can pre-load the
                    // data during the next PG phase
                    else
                      begin
                        next_state = NOP_RW_CMD;
                      end
                  end              
            end
    
    
        NOP_PAGE_CMD_WITH_WR_DATA: 
            begin
                // This state cmd_mode == 1
                //
                // To get to this state, we have pre-read the RW fifo and write data fifo, so drive the write data using the RW bank address
                // So we know the next 'RW' phase will be a write
                `SCH_DRIVER_READ_FINAL_QUEUES 
            
                // Output of write data fifo is valid so drive onto dfi interface
                // driver drv__dfi__data[1:2]
                `include "sch_driver_peek_get_data_fifo.vh"  
            
                // We know the next 'RW' phase is a write so transition to the WR_CMD state and load the second data word  
                // Remember, we had pre-read the RW fifo so no RW fifo reads occur in this state
                next_state = WR_CMD;
            
                `include "sch_driver_select_data_fifo.vh"  
            end
    
        RD_CMD: 
            begin
            
                // This state cmd_mode == 0
                {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b010; //cache read 
                drv__dfi__bank_addr                          = fq__drv__rwcmd_bank_addr_rd_data; 
                drv__dfi__rc_addr                            = fq__drv__rwcmd_cache_addr_rd_data; 
                drv__dfi__data1                              = 0;
                drv__dfi__data2                              = 0;
            
                `include "sch_driver_rw_state_transitions.vh"  
            
            end
    
        WR_CMD:
            begin
            
                // This state cmd_mode == 0
                {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b011; //cache write 
                drv__dfi__bank_addr                          = fq__drv__rwcmd_bank_addr_rd_data; 
                drv__dfi__rc_addr                            = fq__drv__rwcmd_cache_addr_rd_data; 
            
                `include "sch_driver_rw_state_transitions.vh"  
                `include "sch_driver_get_data_fifo.vh"  
            end
    
        NOP_RW_CMD: 
            begin
                `include "sch_driver_rw_state_transitions.vh"  
            end
   default: begin //EDIT DA
		next_state = WAIT;
	end 
    endcase 
    end

endmodule 
