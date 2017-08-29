/*********************************************************************************************

    File name   : sdp_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : July 2017
    email       : lbbaker@ncsu.edu

    Description : Take storage descriptor pointer, number of lanes, transfer type and target and generate memory access commands. 

                  Data from the main memory controller comes ib a width matching the downstream stack bus. This is currently 64 words or 2048 bits.
                  This module requests an amount equal to this data width. Therefore, a "line" is considered to be a chunk of 2048 bits.
                  To a DRAM, a "line" most often means a burst of data or cache line.
                  Our baseline DRAM is the Tezzaron DiRAM4. This operates in burst of 2 or 8. We will use 2 as 8 is too coarse.
                  The default page size is 4096.
                  The default interface is DDR which at 2048 bit wide means we have excess bandwidth to support the 2048 bit
                  downstream stack bus.
                  We have options to "customize the DRAM but these will be our starting baseline operation.
                  Given that, when we send a request to the DRAM, we will receive a burst of two 2048-bit data which is the entire page over two cycles.

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
`include "wu_memory.vh"
`include "wu_decode.vh"
`include "sdp_cntl.vh"
`include "python_typedef.vh"


module sdp_cntl (  

            input   wire                                           xxx__sdp__storage_desc_processing_enable     ,
            output  reg                                            sdp__xxx__storage_desc_processing_complete   ,
            input   wire  [`MGR_STORAGE_DESC_ADDRESS_RANGE  ]      xxx__sdp__storage_desc_ptr                   ,  // pointer to local storage descriptor although msb's contain manager ID, so remove
            input   wire  [`MGR_NUM_LANES_RANGE             ]      xxx__sdp__num_lanes                          ,
            input   wire  [`MGR_INST_OPTION_TRANSFER_RANGE  ]      xxx__sdp__txfer_type                         ,
            input   wire  [`MGR_INST_OPTION_TGT_RANGE       ]      xxx__sdp__target                             ,

            //-------------------------------
            // Main Memory Controller interface
            // - response must be in order
            //
            output  reg                                            sdp__xxx__mem_request_valid              ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      sdp__xxx__mem_request_cntl               ,
            input   wire                                           xxx__sdp__mem_request_ready              ,
            output  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE  ]      sdp__xxx__mem_request_channel            ,
            output  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE     ]      sdp__xxx__mem_request_bank               ,
            output  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]      sdp__xxx__mem_request_page               ,
            output  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE     ]      sdp__xxx__mem_request_word               ,

            input   wire  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   xxx__sdp__mem_request_channel_data_valid                          ,  // valid data from channel data fifo

            //-------------------------------
            // from MMC fifo Control
            output  reg   [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   sdp__xxx__get_next_line                                    ,
            output  reg   [`MGR_NUM_OF_EXEC_LANES_RANGE        ]   sdp__xxx__lane_valid                                       ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE         ]   sdp__xxx__lane_cntl                                        ,
            output  reg   [`MGR_NUM_OF_EXEC_LANES_RANGE        ]   sdp__xxx__lane_enable                                      ,
            output  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE     ]   sdp__xxx__lane_channel_ptr [`MGR_NUM_OF_EXEC_LANES_RANGE ] ,
            output  reg   [`MGR_MMC_TO_MRC_WORD_ADDRESS_RANGE  ]   sdp__xxx__lane_word_ptr    [`MGR_NUM_OF_EXEC_LANES_RANGE ] ,
            output  reg                                            sdp__xxx__current_channel                                  ,
            input   wire  [`MGR_NUM_OF_EXEC_LANES_RANGE        ]   xxx__sdp__lane_ready                                       ,
           

            //
            //-------------------------------
            // General
            //
            input  wire  [`MGR_MGR_ID_RANGE    ]  sys__mgr__mgrId ,

            input  wire                           clk             ,
            input  wire                           reset_poweron  
                        );


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Registers and Wires
 

  wire                                            sdpr__sdps__cfg_valid       ;
  wire   [`MGR_DRAM_LOCAL_ADDRESS_RANGE       ]   sdpr__sdps__cfg_addr        ;
  wire   [`MGR_INST_OPTION_ORDER_RANGE        ]   sdpr__sdps__cfg_accessOrder ;
  wire                                            sdps__sdpr__cfg_ready       ;
  wire                                            sdps__sdpr__complete        ;
  wire                                            sdpr__sdps__complete        ;
                                                  
  wire                                            sdpr__sdps__consJump_valid  ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE         ]   sdpr__sdps__consJump_cntl   ;
  wire   [`MGR_OP_MAX_NUM_OF_OPERANDS_RANGE   ]   sdpr__sdps__consJump_value  ;
  wire                                            sdps__sdpr__consJump_ready  ;

  wire                                            sdpr__sdps__response_id_valid   ;
  wire  [`COMMON_STD_INTF_CNTL_RANGE          ]   sdpr__sdps__response_id_cntl    ;
  wire                                            sdps__sdpr__response_id_ready   ;
  wire  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE      ]   sdpr__sdps__response_id_channel ;
  wire  [`MGR_DRAM_BANK_ADDRESS_RANGE         ]   sdpr__sdps__response_id_bank    ;
  wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE         ]   sdpr__sdps__response_id_page    ;
  wire  [`MGR_DRAM_WORD_ADDRESS_RANGE         ]   sdpr__sdps__response_id_word    ;

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Storage Descriptor Memory Request Generator
  // - Contains the storage descriptor and consequtive/jump memory
  // - generates memory requests and passes starting address and consequtive/jump values to the storage descriptor stream controller
  // - sends the channel/bank/page/line address associated with each request to the main memory controller

  sdp_request_cntl sdp_request_cntl (  

            .xxx__sdp__storage_desc_processing_enable     ( xxx__sdp__storage_desc_processing_enable   ),
            .sdp__xxx__storage_desc_processing_complete   ( sdp__xxx__storage_desc_processing_complete ),
            .xxx__sdp__storage_desc_ptr                   ( xxx__sdp__storage_desc_ptr                 ),  // pointer to local storage descriptor although msb's contain manager ID, so remove

            .sdp__xxx__mem_request_valid                  ( sdp__xxx__mem_request_valid                ),
            .sdp__xxx__mem_request_cntl                   ( sdp__xxx__mem_request_cntl                 ),

            .xxx__sdp__mem_request_ready                  ( xxx__sdp__mem_request_ready                ),

            .sdp__xxx__mem_request_channel                ( sdp__xxx__mem_request_channel              ),
            .sdp__xxx__mem_request_bank                   ( sdp__xxx__mem_request_bank                 ),
            .sdp__xxx__mem_request_page                   ( sdp__xxx__mem_request_page                 ),
            .sdp__xxx__mem_request_word                   ( sdp__xxx__mem_request_word                 ),

            .sdpr__sdps__response_id_valid                ( sdpr__sdps__response_id_valid              ),
            .sdpr__sdps__response_id_cntl                 ( sdpr__sdps__response_id_cntl               ),
            .sdps__sdpr__response_id_ready                ( sdps__sdpr__response_id_ready              ),
            .sdpr__sdps__response_id_channel              ( sdpr__sdps__response_id_channel            ),
            .sdpr__sdps__response_id_bank                 ( sdpr__sdps__response_id_bank               ),
            .sdpr__sdps__response_id_page                 ( sdpr__sdps__response_id_page               ),
            .sdpr__sdps__response_id_word                 ( sdpr__sdps__response_id_word               ),

            .sdpr__sdps__cfg_valid                        ( sdpr__sdps__cfg_valid                      ),
            .sdpr__sdps__cfg_addr                         ( sdpr__sdps__cfg_addr                       ),
            .sdpr__sdps__cfg_accessOrder                  ( sdpr__sdps__cfg_accessOrder                ),
            .sdps__sdpr__cfg_ready                        ( sdps__sdpr__cfg_ready                      ),
            .sdps__sdpr__complete                         ( sdps__sdpr__complete                       ),
            .sdpr__sdps__complete                         ( sdpr__sdps__complete                       ),

            .sdpr__sdps__consJump_valid                   ( sdpr__sdps__consJump_valid                 ),
            .sdpr__sdps__consJump_cntl                    ( sdpr__sdps__consJump_cntl                  ),
            .sdpr__sdps__consJump_value                   ( sdpr__sdps__consJump_value                 ),
            .sdps__sdpr__consJump_ready                   ( sdps__sdpr__consJump_ready                 ),

            //------------------------------
            // General
            //
            .sys__mgr__mgrId                              ( sys__mgr__mgrId ),
            .clk                                          ( clk             ),
            .reset_poweron                                ( reset_poweron   )
                        );
 
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Storage Descriptor Stream Control
  // - receives the starting address and consequtive/jump values to the storage descriptor stream controller
  // - receives the channel/bank/page/line address for each response from the main memory controller
  // - generates word select values for each downstream lane
  // - outputs a "get line" pulse to read the from MMC fifo when all words in the current line have been sent downstream

  sdp_stream_cntl sdp_stream_cntl (  

            .xxx__sdp__storage_desc_processing_enable     ( xxx__sdp__storage_desc_processing_enable   ),
            .xxx__sdp__storage_desc_ptr                   ( xxx__sdp__storage_desc_ptr                 ),  // pointer to local storage descriptor although msb's contain manager ID, so remove
            .xxx__sdp__num_lanes                          ( xxx__sdp__num_lanes                        ),
            .xxx__sdp__txfer_type                         ( xxx__sdp__txfer_type                       ),
            .xxx__sdp__target                             ( xxx__sdp__target                           ),

            //-------------------------------
            // from MMC fifo Control
            .xxx__sdp__mem_request_channel_data_valid                ,  // valid data from channel data fifo and downstream ready

            // From request generator
            // - Contains the associated address for the next mmc line
            // - automatically updated when "get_line" is asserted
            .sdpr__sdps__response_id_valid                ( sdpr__sdps__response_id_valid              ),
            .sdpr__sdps__response_id_cntl                 ( sdpr__sdps__response_id_cntl               ),
            .sdps__sdpr__response_id_ready                ( sdps__sdpr__response_id_ready              ),
            .sdpr__sdps__response_id_channel              ( sdpr__sdps__response_id_channel            ),
            .sdpr__sdps__response_id_bank                 ( sdpr__sdps__response_id_bank               ),
            .sdpr__sdps__response_id_page                 ( sdpr__sdps__response_id_page               ),
            .sdpr__sdps__response_id_word                 ( sdpr__sdps__response_id_word               ),

            .sdp__xxx__get_next_line                      ( sdp__xxx__get_next_line                    ),
            .sdp__xxx__lane_valid                         ( sdp__xxx__lane_valid                       ),
            .sdp__xxx__lane_cntl                          ( sdp__xxx__lane_cntl                        ),
            .sdp__xxx__lane_enable                        ( sdp__xxx__lane_enable                      ),
            .sdp__xxx__lane_channel_ptr                   ( sdp__xxx__lane_channel_ptr                 ),
            .sdp__xxx__lane_word_ptr                      ( sdp__xxx__lane_word_ptr                    ),
            .sdp__xxx__current_channel                    ( sdp__xxx__current_channel                  ),

            .xxx__sdp__lane_ready                         ( xxx__sdp__lane_ready                       ),
           

            //-------------------------------
            // from Storage Descriptor request control
            // - sent here during request generation request generation happens faster than streaming
            // - two buses :, cfg contains start address and access order and we receive one transaction per stream
            //                consJump contains the set of consequtive/jump fields which may be one or more
            //
            .sdpr__sdps__cfg_valid                        ( sdpr__sdps__cfg_valid                      ),
            .sdpr__sdps__cfg_addr                         ( sdpr__sdps__cfg_addr                       ),
            .sdpr__sdps__cfg_accessOrder                  ( sdpr__sdps__cfg_accessOrder                ),
            .sdps__sdpr__cfg_ready                        ( sdps__sdpr__cfg_ready                      ),
            .sdps__sdpr__complete                         ( sdps__sdpr__complete                       ),
            .sdpr__sdps__complete                         ( sdpr__sdps__complete                       ),

            .sdpr__sdps__consJump_valid                   ( sdpr__sdps__consJump_valid                 ),
            .sdpr__sdps__consJump_cntl                    ( sdpr__sdps__consJump_cntl                  ),
            .sdpr__sdps__consJump_value                   ( sdpr__sdps__consJump_value                 ),
            .sdps__sdpr__consJump_ready                   ( sdps__sdpr__consJump_ready                 ),

            //
            //-------------------------------
            // General
            //
            .sys__mgr__mgrId                              ( sys__mgr__mgrId ),
            .clk                                          ( clk             ),
            .reset_poweron                                ( reset_poweron   )
                        );


  //----------------------------------------------------------------------------------------------------
  //
  //
  //
endmodule

