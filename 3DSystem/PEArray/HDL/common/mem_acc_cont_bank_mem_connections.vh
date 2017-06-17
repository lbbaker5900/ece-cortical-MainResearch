
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 0
  assign bank_mem[ 0].mem_acc_state_next = bank_fsm[ 0].mem_acc_state_next ;

  assign bank_mem[ 0].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 0].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 0].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 0].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 0].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 0].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 0].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[ 0].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 0].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 0].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 0].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[ 0].write_enable  =  
                                           ( bank_fsm[ 0].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid0 |
                                           ( bank_fsm[ 0].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[ 0].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 1
  assign bank_mem[ 1].mem_acc_state_next = bank_fsm[ 1].mem_acc_state_next ;

  assign bank_mem[ 1].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 1].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address1[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 1].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 1].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 1].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address1[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 1].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 1].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[ 1].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 1].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data1[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 1].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 1].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[ 1].write_enable  =  
                                           ( bank_fsm[ 1].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid1 |
                                           ( bank_fsm[ 1].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[ 1].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 2
  assign bank_mem[ 2].mem_acc_state_next = bank_fsm[ 2].mem_acc_state_next ;

  assign bank_mem[ 2].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 2].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address2[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 2].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 2].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 2].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address2[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 2].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 2].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[ 2].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 2].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data2[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 2].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 2].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[ 2].write_enable  =  
                                           ( bank_fsm[ 2].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid2 |
                                           ( bank_fsm[ 2].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[ 2].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 3
  assign bank_mem[ 3].mem_acc_state_next = bank_fsm[ 3].mem_acc_state_next ;

  assign bank_mem[ 3].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 3].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address3[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 3].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 3].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 3].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address3[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 3].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 3].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[ 3].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 3].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data3[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 3].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 3].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[ 3].write_enable  =  
                                           ( bank_fsm[ 3].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid3 |
                                           ( bank_fsm[ 3].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[ 3].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 4
  assign bank_mem[ 4].mem_acc_state_next = bank_fsm[ 4].mem_acc_state_next ;

  assign bank_mem[ 4].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 4].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address4[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 4].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 4].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 4].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address4[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 4].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 4].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[ 4].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 4].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data4[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 4].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 4].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[ 4].write_enable  =  
                                           ( bank_fsm[ 4].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid4 |
                                           ( bank_fsm[ 4].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[ 4].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 5
  assign bank_mem[ 5].mem_acc_state_next = bank_fsm[ 5].mem_acc_state_next ;

  assign bank_mem[ 5].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 5].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address5[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 5].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 5].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 5].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address5[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 5].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 5].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[ 5].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 5].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data5[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 5].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 5].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[ 5].write_enable  =  
                                           ( bank_fsm[ 5].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid5 |
                                           ( bank_fsm[ 5].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[ 5].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 6
  assign bank_mem[ 6].mem_acc_state_next = bank_fsm[ 6].mem_acc_state_next ;

  assign bank_mem[ 6].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 6].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address6[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 6].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 6].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 6].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address6[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 6].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 6].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[ 6].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 6].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data6[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 6].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 6].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[ 6].write_enable  =  
                                           ( bank_fsm[ 6].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid6 |
                                           ( bank_fsm[ 6].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[ 6].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 7
  assign bank_mem[ 7].mem_acc_state_next = bank_fsm[ 7].mem_acc_state_next ;

  assign bank_mem[ 7].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 7].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address7[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 7].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 7].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 7].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address7[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 7].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 7].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[ 7].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 7].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data7[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 7].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 7].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[ 7].write_enable  =  
                                           ( bank_fsm[ 7].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid7 |
                                           ( bank_fsm[ 7].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[ 7].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 8
  assign bank_mem[ 8].mem_acc_state_next = bank_fsm[ 8].mem_acc_state_next ;

  assign bank_mem[ 8].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 8].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address8[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 8].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 8].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 8].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address8[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 8].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 8].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[ 8].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 8].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data8[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 8].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 8].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[ 8].write_enable  =  
                                           ( bank_fsm[ 8].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid8 |
                                           ( bank_fsm[ 8].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[ 8].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 9
  assign bank_mem[ 9].mem_acc_state_next = bank_fsm[ 9].mem_acc_state_next ;

  assign bank_mem[ 9].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 9].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address9[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 9].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 9].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 9].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address9[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 9].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[ 9].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[ 9].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 9].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data9[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 9].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[ 9].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[ 9].write_enable  =  
                                           ( bank_fsm[ 9].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid9 |
                                           ( bank_fsm[ 9].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[ 9].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 10
  assign bank_mem[10].mem_acc_state_next = bank_fsm[10].mem_acc_state_next ;

  assign bank_mem[10].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[10].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address10[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[10].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[10].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[10].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address10[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[10].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[10].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[10].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[10].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data10[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[10].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[10].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[10].write_enable  =  
                                           ( bank_fsm[10].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid10 |
                                           ( bank_fsm[10].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[10].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 11
  assign bank_mem[11].mem_acc_state_next = bank_fsm[11].mem_acc_state_next ;

  assign bank_mem[11].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[11].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address11[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[11].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[11].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[11].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address11[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[11].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[11].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[11].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[11].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data11[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[11].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[11].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[11].write_enable  =  
                                           ( bank_fsm[11].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid11 |
                                           ( bank_fsm[11].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[11].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 12
  assign bank_mem[12].mem_acc_state_next = bank_fsm[12].mem_acc_state_next ;

  assign bank_mem[12].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[12].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address12[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[12].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[12].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[12].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address12[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[12].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[12].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[12].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[12].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data12[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[12].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[12].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[12].write_enable  =  
                                           ( bank_fsm[12].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid12 |
                                           ( bank_fsm[12].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[12].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 13
  assign bank_mem[13].mem_acc_state_next = bank_fsm[13].mem_acc_state_next ;

  assign bank_mem[13].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[13].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address13[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[13].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[13].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[13].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address13[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[13].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[13].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[13].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[13].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data13[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[13].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[13].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[13].write_enable  =  
                                           ( bank_fsm[13].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid13 |
                                           ( bank_fsm[13].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[13].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 14
  assign bank_mem[14].mem_acc_state_next = bank_fsm[14].mem_acc_state_next ;

  assign bank_mem[14].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[14].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address14[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[14].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[14].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[14].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address14[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[14].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[14].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[14].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[14].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data14[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[14].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[14].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[14].write_enable  =  
                                           ( bank_fsm[14].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid14 |
                                           ( bank_fsm[14].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[14].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 15
  assign bank_mem[15].mem_acc_state_next = bank_fsm[15].mem_acc_state_next ;

  assign bank_mem[15].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[15].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address15[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[15].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[15].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[15].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address15[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[15].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[15].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[15].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[15].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data15[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[15].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[15].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[15].write_enable  =  
                                           ( bank_fsm[15].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid15 |
                                           ( bank_fsm[15].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[15].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 16
  assign bank_mem[16].mem_acc_state_next = bank_fsm[16].mem_acc_state_next ;

  assign bank_mem[16].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[16].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address16[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[16].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[16].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[16].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address16[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[16].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[16].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[16].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[16].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data16[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[16].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[16].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[16].write_enable  =  
                                           ( bank_fsm[16].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid16 |
                                           ( bank_fsm[16].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[16].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 17
  assign bank_mem[17].mem_acc_state_next = bank_fsm[17].mem_acc_state_next ;

  assign bank_mem[17].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[17].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address17[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[17].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[17].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[17].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address17[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[17].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[17].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[17].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[17].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data17[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[17].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[17].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[17].write_enable  =  
                                           ( bank_fsm[17].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid17 |
                                           ( bank_fsm[17].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[17].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 18
  assign bank_mem[18].mem_acc_state_next = bank_fsm[18].mem_acc_state_next ;

  assign bank_mem[18].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[18].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address18[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[18].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[18].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[18].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address18[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[18].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[18].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[18].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[18].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data18[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[18].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[18].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[18].write_enable  =  
                                           ( bank_fsm[18].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid18 |
                                           ( bank_fsm[18].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[18].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 19
  assign bank_mem[19].mem_acc_state_next = bank_fsm[19].mem_acc_state_next ;

  assign bank_mem[19].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[19].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address19[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[19].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[19].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[19].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address19[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[19].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[19].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[19].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[19].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data19[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[19].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[19].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[19].write_enable  =  
                                           ( bank_fsm[19].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid19 |
                                           ( bank_fsm[19].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[19].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 20
  assign bank_mem[20].mem_acc_state_next = bank_fsm[20].mem_acc_state_next ;

  assign bank_mem[20].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[20].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address20[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[20].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[20].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[20].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address20[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[20].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[20].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[20].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[20].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data20[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[20].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[20].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[20].write_enable  =  
                                           ( bank_fsm[20].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid20 |
                                           ( bank_fsm[20].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[20].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 21
  assign bank_mem[21].mem_acc_state_next = bank_fsm[21].mem_acc_state_next ;

  assign bank_mem[21].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[21].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address21[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[21].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[21].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[21].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address21[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[21].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[21].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[21].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[21].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data21[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[21].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[21].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[21].write_enable  =  
                                           ( bank_fsm[21].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid21 |
                                           ( bank_fsm[21].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[21].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 22
  assign bank_mem[22].mem_acc_state_next = bank_fsm[22].mem_acc_state_next ;

  assign bank_mem[22].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[22].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address22[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[22].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[22].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[22].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address22[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[22].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[22].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[22].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[22].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data22[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[22].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[22].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[22].write_enable  =  
                                           ( bank_fsm[22].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid22 |
                                           ( bank_fsm[22].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[22].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 23
  assign bank_mem[23].mem_acc_state_next = bank_fsm[23].mem_acc_state_next ;

  assign bank_mem[23].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[23].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address23[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[23].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[23].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[23].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address23[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[23].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[23].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[23].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[23].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data23[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[23].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[23].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[23].write_enable  =  
                                           ( bank_fsm[23].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid23 |
                                           ( bank_fsm[23].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[23].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 24
  assign bank_mem[24].mem_acc_state_next = bank_fsm[24].mem_acc_state_next ;

  assign bank_mem[24].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[24].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address24[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[24].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[24].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[24].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address24[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[24].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[24].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[24].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[24].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data24[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[24].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[24].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[24].write_enable  =  
                                           ( bank_fsm[24].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid24 |
                                           ( bank_fsm[24].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[24].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 25
  assign bank_mem[25].mem_acc_state_next = bank_fsm[25].mem_acc_state_next ;

  assign bank_mem[25].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[25].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address25[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[25].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[25].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[25].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address25[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[25].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[25].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[25].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[25].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data25[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[25].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[25].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[25].write_enable  =  
                                           ( bank_fsm[25].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid25 |
                                           ( bank_fsm[25].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[25].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 26
  assign bank_mem[26].mem_acc_state_next = bank_fsm[26].mem_acc_state_next ;

  assign bank_mem[26].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[26].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address26[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[26].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[26].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[26].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address26[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[26].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[26].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[26].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[26].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data26[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[26].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[26].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[26].write_enable  =  
                                           ( bank_fsm[26].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid26 |
                                           ( bank_fsm[26].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[26].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 27
  assign bank_mem[27].mem_acc_state_next = bank_fsm[27].mem_acc_state_next ;

  assign bank_mem[27].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[27].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address27[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[27].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[27].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[27].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address27[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[27].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[27].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[27].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[27].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data27[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[27].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[27].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[27].write_enable  =  
                                           ( bank_fsm[27].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid27 |
                                           ( bank_fsm[27].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[27].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 28
  assign bank_mem[28].mem_acc_state_next = bank_fsm[28].mem_acc_state_next ;

  assign bank_mem[28].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[28].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address28[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[28].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[28].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[28].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address28[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[28].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[28].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[28].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[28].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data28[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[28].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[28].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[28].write_enable  =  
                                           ( bank_fsm[28].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid28 |
                                           ( bank_fsm[28].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[28].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 29
  assign bank_mem[29].mem_acc_state_next = bank_fsm[29].mem_acc_state_next ;

  assign bank_mem[29].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[29].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address29[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[29].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[29].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[29].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address29[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[29].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[29].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[29].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[29].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data29[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[29].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[29].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[29].write_enable  =  
                                           ( bank_fsm[29].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid29 |
                                           ( bank_fsm[29].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[29].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 30
  assign bank_mem[30].mem_acc_state_next = bank_fsm[30].mem_acc_state_next ;

  assign bank_mem[30].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[30].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address30[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[30].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[30].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[30].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address30[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[30].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[30].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[30].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[30].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data30[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[30].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[30].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[30].write_enable  =  
                                           ( bank_fsm[30].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid30 |
                                           ( bank_fsm[30].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[30].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Bank 31
  assign bank_mem[31].mem_acc_state_next = bank_fsm[31].mem_acc_state_next ;

  assign bank_mem[31].address       =  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[31].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address31[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[31].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[31].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[31].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address31[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[31].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[31].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                           {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;

  assign bank_mem[31].write_data    =  
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[31].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data31[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[31].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                           {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[31].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;

  assign bank_mem[31].write_enable  =  
                                           ( bank_fsm[31].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid31 |
                                           ( bank_fsm[31].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid0 |
                                           ( bank_fsm[31].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid ;

  assign memc__ldst__read_data        = 
                                           ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 0].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS )}} & bank_mem[ 0].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 1].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[ 1].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 2].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[ 2].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 3].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[ 3].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 4].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[ 4].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 5].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[ 5].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 6].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[ 6].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 7].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[ 7].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 8].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[ 8].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 9].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[ 9].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[10].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[11].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[12].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[13].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[14].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[15].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[16].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[17].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[18].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[19].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[20].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[21].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[22].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[23].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[24].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[25].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[26].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[27].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[28].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[29].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[30].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)}} & bank_mem[31].read_data ) ; 

  assign memc__ldst__read_data_valid  = (( (bank_fsm[ 0].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[ 0].read_data_ldst_valid) | 
                                        (( (bank_fsm[ 1].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[ 1].read_data_ldst_valid) |
                                        (( (bank_fsm[ 2].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[ 2].read_data_ldst_valid) |
                                        (( (bank_fsm[ 3].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[ 3].read_data_ldst_valid) |
                                        (( (bank_fsm[ 4].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[ 4].read_data_ldst_valid) |
                                        (( (bank_fsm[ 5].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[ 5].read_data_ldst_valid) |
                                        (( (bank_fsm[ 6].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[ 6].read_data_ldst_valid) |
                                        (( (bank_fsm[ 7].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[ 7].read_data_ldst_valid) |
                                        (( (bank_fsm[ 8].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[ 8].read_data_ldst_valid) |
                                        (( (bank_fsm[ 9].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[ 9].read_data_ldst_valid) |
                                        (( (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[10].read_data_ldst_valid) |
                                        (( (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[11].read_data_ldst_valid) |
                                        (( (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[12].read_data_ldst_valid) |
                                        (( (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[13].read_data_ldst_valid) |
                                        (( (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[14].read_data_ldst_valid) |
                                        (( (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[15].read_data_ldst_valid) |
                                        (( (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[16].read_data_ldst_valid) |
                                        (( (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[17].read_data_ldst_valid) |
                                        (( (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[18].read_data_ldst_valid) |
                                        (( (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[19].read_data_ldst_valid) |
                                        (( (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[20].read_data_ldst_valid) |
                                        (( (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[21].read_data_ldst_valid) |
                                        (( (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[22].read_data_ldst_valid) |
                                        (( (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[23].read_data_ldst_valid) |
                                        (( (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[24].read_data_ldst_valid) |
                                        (( (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[25].read_data_ldst_valid) |
                                        (( (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[26].read_data_ldst_valid) |
                                        (( (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[27].read_data_ldst_valid) |
                                        (( (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[28].read_data_ldst_valid) |
                                        (( (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[29].read_data_ldst_valid) |
                                        (( (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[30].read_data_ldst_valid) |
                                        (( (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS)) & bank_mem[31].read_data_ldst_valid) |
                                                                                                                        1'b0                              ;
  assign memc__dma__read_data0         =  
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS )}} & bank_mem[ 0].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[ 0].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[ 1].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[ 2].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[ 3].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[ 4].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[ 5].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[ 6].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[ 7].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[ 8].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[ 9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[ 9].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[10].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[11].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[12].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[13].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[14].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[15].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[16].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[17].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[18].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[19].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[20].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[21].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[22].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[23].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[24].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[25].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[26].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[27].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[28].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[29].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[30].read_data ) | 
                                             ({`MEM_ACC_CONT_MEMORY_DATA_WIDTH {(bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)}} & bank_mem[31].read_data ) ; 

  assign memc__dma__read_data1         = bank_mem[ 1].read_data             ; 
  assign memc__dma__read_data2         = bank_mem[ 2].read_data             ; 
  assign memc__dma__read_data3         = bank_mem[ 3].read_data             ; 
  assign memc__dma__read_data4         = bank_mem[ 4].read_data             ; 
  assign memc__dma__read_data5         = bank_mem[ 5].read_data             ; 
  assign memc__dma__read_data6         = bank_mem[ 6].read_data             ; 
  assign memc__dma__read_data7         = bank_mem[ 7].read_data             ; 
  assign memc__dma__read_data8         = bank_mem[ 8].read_data             ; 
  assign memc__dma__read_data9         = bank_mem[ 9].read_data             ; 
  assign memc__dma__read_data10        = bank_mem[10].read_data             ; 
  assign memc__dma__read_data11        = bank_mem[11].read_data             ; 
  assign memc__dma__read_data12        = bank_mem[12].read_data             ; 
  assign memc__dma__read_data13        = bank_mem[13].read_data             ; 
  assign memc__dma__read_data14        = bank_mem[14].read_data             ; 
  assign memc__dma__read_data15        = bank_mem[15].read_data             ; 
  assign memc__dma__read_data16        = bank_mem[16].read_data             ; 
  assign memc__dma__read_data17        = bank_mem[17].read_data             ; 
  assign memc__dma__read_data18        = bank_mem[18].read_data             ; 
  assign memc__dma__read_data19        = bank_mem[19].read_data             ; 
  assign memc__dma__read_data20        = bank_mem[20].read_data             ; 
  assign memc__dma__read_data21        = bank_mem[21].read_data             ; 
  assign memc__dma__read_data22        = bank_mem[22].read_data             ; 
  assign memc__dma__read_data23        = bank_mem[23].read_data             ; 
  assign memc__dma__read_data24        = bank_mem[24].read_data             ; 
  assign memc__dma__read_data25        = bank_mem[25].read_data             ; 
  assign memc__dma__read_data26        = bank_mem[26].read_data             ; 
  assign memc__dma__read_data27        = bank_mem[27].read_data             ; 
  assign memc__dma__read_data28        = bank_mem[28].read_data             ; 
  assign memc__dma__read_data29        = bank_mem[29].read_data             ; 
  assign memc__dma__read_data30        = bank_mem[30].read_data             ; 
  assign memc__dma__read_data31        = bank_mem[31].read_data             ; 

  assign memc__dma__read_data_valid0   = ((bank_fsm[ 0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS )  &  bank_mem[0].read_data_strm_valid) | 
                                         ((bank_fsm[ 0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[0].read_data_strm_valid) | 
                                         ((bank_fsm[ 1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[1].read_data_strm_valid) | 
                                         ((bank_fsm[ 2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[2].read_data_strm_valid) | 
                                         ((bank_fsm[ 3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[3].read_data_strm_valid) | 
                                         ((bank_fsm[ 4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[4].read_data_strm_valid) | 
                                         ((bank_fsm[ 5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[5].read_data_strm_valid) | 
                                         ((bank_fsm[ 6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[6].read_data_strm_valid) | 
                                         ((bank_fsm[ 7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[7].read_data_strm_valid) | 
                                         ((bank_fsm[ 8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[8].read_data_strm_valid) | 
                                         ((bank_fsm[ 9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[9].read_data_strm_valid) | 
                                         ((bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[10].read_data_strm_valid) | 
                                         ((bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[11].read_data_strm_valid) | 
                                         ((bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[12].read_data_strm_valid) | 
                                         ((bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[13].read_data_strm_valid) | 
                                         ((bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[14].read_data_strm_valid) | 
                                         ((bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[15].read_data_strm_valid) | 
                                         ((bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[16].read_data_strm_valid) | 
                                         ((bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[17].read_data_strm_valid) | 
                                         ((bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[18].read_data_strm_valid) | 
                                         ((bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[19].read_data_strm_valid) | 
                                         ((bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[20].read_data_strm_valid) | 
                                         ((bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[21].read_data_strm_valid) | 
                                         ((bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[22].read_data_strm_valid) | 
                                         ((bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[23].read_data_strm_valid) | 
                                         ((bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[24].read_data_strm_valid) | 
                                         ((bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[25].read_data_strm_valid) | 
                                         ((bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[26].read_data_strm_valid) | 
                                         ((bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[27].read_data_strm_valid) | 
                                         ((bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[28].read_data_strm_valid) | 
                                         ((bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[29].read_data_strm_valid) | 
                                         ((bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[30].read_data_strm_valid) | 
                                         ((bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS )  &  bank_mem[31].read_data_strm_valid) | 
                                                                                                                   1'b0                               ;

  assign memc__dma__read_data_valid1   = (bank_fsm[ 1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[1].read_data_strm_valid ; 

  assign memc__dma__read_data_valid2   = (bank_fsm[ 2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[2].read_data_strm_valid ; 

  assign memc__dma__read_data_valid3   = (bank_fsm[ 3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[3].read_data_strm_valid ; 

  assign memc__dma__read_data_valid4   = (bank_fsm[ 4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[4].read_data_strm_valid ; 

  assign memc__dma__read_data_valid5   = (bank_fsm[ 5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[5].read_data_strm_valid ; 

  assign memc__dma__read_data_valid6   = (bank_fsm[ 6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[6].read_data_strm_valid ; 

  assign memc__dma__read_data_valid7   = (bank_fsm[ 7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[7].read_data_strm_valid ; 

  assign memc__dma__read_data_valid8   = (bank_fsm[ 8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[8].read_data_strm_valid ; 

  assign memc__dma__read_data_valid9   = (bank_fsm[ 9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[9].read_data_strm_valid ; 

  assign memc__dma__read_data_valid10  = (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[10].read_data_strm_valid ; 

  assign memc__dma__read_data_valid11  = (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[11].read_data_strm_valid ; 

  assign memc__dma__read_data_valid12  = (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[12].read_data_strm_valid ; 

  assign memc__dma__read_data_valid13  = (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[13].read_data_strm_valid ; 

  assign memc__dma__read_data_valid14  = (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[14].read_data_strm_valid ; 

  assign memc__dma__read_data_valid15  = (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[15].read_data_strm_valid ; 

  assign memc__dma__read_data_valid16  = (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[16].read_data_strm_valid ; 

  assign memc__dma__read_data_valid17  = (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[17].read_data_strm_valid ; 

  assign memc__dma__read_data_valid18  = (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[18].read_data_strm_valid ; 

  assign memc__dma__read_data_valid19  = (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[19].read_data_strm_valid ; 

  assign memc__dma__read_data_valid20  = (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[20].read_data_strm_valid ; 

  assign memc__dma__read_data_valid21  = (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[21].read_data_strm_valid ; 

  assign memc__dma__read_data_valid22  = (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[22].read_data_strm_valid ; 

  assign memc__dma__read_data_valid23  = (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[23].read_data_strm_valid ; 

  assign memc__dma__read_data_valid24  = (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[24].read_data_strm_valid ; 

  assign memc__dma__read_data_valid25  = (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[25].read_data_strm_valid ; 

  assign memc__dma__read_data_valid26  = (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[26].read_data_strm_valid ; 

  assign memc__dma__read_data_valid27  = (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[27].read_data_strm_valid ; 

  assign memc__dma__read_data_valid28  = (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[28].read_data_strm_valid ; 

  assign memc__dma__read_data_valid29  = (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[29].read_data_strm_valid ; 

  assign memc__dma__read_data_valid30  = (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[30].read_data_strm_valid ; 

  assign memc__dma__read_data_valid31  = (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  &  bank_mem[31].read_data_strm_valid ; 

