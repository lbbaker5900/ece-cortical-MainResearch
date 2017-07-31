// This is included multiple times:
// do not use `ifndef _main_mem_cntl_dfi_seq_rw_state_transitions_vh
// do not use `define _main_mem_cntl_dfi_seq_rw_state_transitions_vh

/*****************************************************************

    File name   : main_mem_cntl_dfi_seq_rw_state_transitions.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


                        if (!final_page_cmd_fifo[chan].pipe_peek_valid  )
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NODATA_NOP_PAGE_CMD;
                        
                          end
                        else if (final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW)
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD_WITH_WR_DATA;
                        
                          end
                        else if ((final_page_cmd_fifo[chan].pipe_peek_cmd != `MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_NOP) && (final_cache_cmd_fifo[chan].pipe_peek_twoIn_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW))
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD_WITH_WR_DATA;
                        
                          end
                        else if (final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP)
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD;
                        
                          end





//------------------------------------------------------------------------------------------------------------

// do not use `endif



    
