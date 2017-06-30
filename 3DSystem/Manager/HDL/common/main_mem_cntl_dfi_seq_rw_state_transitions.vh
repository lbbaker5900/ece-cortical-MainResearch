// do not use `ifndef _main_mem_cntl_dfi_seq_rw_state_transitions_vh
// do not use `define _main_mem_cntl_dfi_seq_rw_state_transitions_vh

/*****************************************************************

    File name   : main_mem_cntl_dfi_seq_rw_state_transitions.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


  // During any 'RW' phase, the next state can be either a nop page command, a nop page command with write data, a page command or a page command with write data
  // so if the RW command fifo isnt empty and the RW command is a write, we need to read the target data fifo based on the
  // "peeked" RW bank address so the write data can be available during the 'Page' phase
  
  if (final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW)
    begin
      // Command fifo empty so just jump to the NOP PG phase
      mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD;
  
    end

  // Remember, we are in the RW phase so we need to jump to a PG phase state

  // First check if the next command is a RW command (this may happen if there has been no page command activity)

  // if the next command is a CW, we need to jump to the NOP PG phase but output write data during that next PG phase
  // do not read the fifo
  else if (final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW)
    begin
      mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD_WITH_WR_DATA;
  
      // need to prepare write data to be output one cycle early with page command
      //`include "sch_driver_select_data_fifo.vh"  
  
    end

  // if the next command is a CR, we need to jump to the NOP PG phase 
  else if (final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CR)
    begin
      mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD;
  
    end

  // OK, we didnt see a RW command in the next rwcmd fifo entry so it must be a PG command
  // so the fifo isnt empty and its not a RW command

  // so we know the next command is a PG command, so lets look ahead and see if a CW is the next command after the PG command
  else if (final_page_cmd_fifo[chan].pipe_peek_twoIn_valid && (final_cache_cmd_fifo[chan].pipe_peek_twoIn_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW) )
    begin
          // Page command fifo not empty and the next RW command is a Write, so pre-read the RW fifo so the write data is available during the next 'page' phase
          mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD_WITH_WR_DATA;
      
          // need to prepare write data to be output one cycle early with page command
          // we are gonna select the data fifo from the command entry that is the enrty after the next PG entry
          //`include "sch_driver_peek_select_data_fifo.vh"  
    end

  else 
    begin
      // Page command fifo not empty and the RW command afterward isnt a write, so its a normal PG phase
      mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD;
    end






//------------------------------------------------------------------------------------------------------------

// do not use `endif



    
