
  assign bank_mem[0].mem_acc_state_next = bank_fsm[0].mem_acc_state_next ;
  assign bank_mem[1].mem_acc_state_next = bank_fsm[1].mem_acc_state_next ;
  assign bank_mem[2].mem_acc_state_next = bank_fsm[2].mem_acc_state_next ;
  assign bank_mem[3].mem_acc_state_next = bank_fsm[3].mem_acc_state_next ;
  assign bank_mem[4].mem_acc_state_next = bank_fsm[4].mem_acc_state_next ;
  assign bank_mem[5].mem_acc_state_next = bank_fsm[5].mem_acc_state_next ;
  assign bank_mem[6].mem_acc_state_next = bank_fsm[6].mem_acc_state_next ;
  assign bank_mem[7].mem_acc_state_next = bank_fsm[7].mem_acc_state_next ;
  assign bank_mem[8].mem_acc_state_next = bank_fsm[8].mem_acc_state_next ;
  assign bank_mem[9].mem_acc_state_next = bank_fsm[9].mem_acc_state_next ;
  assign bank_mem[10].mem_acc_state_next = bank_fsm[10].mem_acc_state_next ;
  assign bank_mem[11].mem_acc_state_next = bank_fsm[11].mem_acc_state_next ;
  assign bank_mem[12].mem_acc_state_next = bank_fsm[12].mem_acc_state_next ;
  assign bank_mem[13].mem_acc_state_next = bank_fsm[13].mem_acc_state_next ;
  assign bank_mem[14].mem_acc_state_next = bank_fsm[14].mem_acc_state_next ;
  assign bank_mem[15].mem_acc_state_next = bank_fsm[15].mem_acc_state_next ;
  assign bank_mem[16].mem_acc_state_next = bank_fsm[16].mem_acc_state_next ;
  assign bank_mem[17].mem_acc_state_next = bank_fsm[17].mem_acc_state_next ;
  assign bank_mem[18].mem_acc_state_next = bank_fsm[18].mem_acc_state_next ;
  assign bank_mem[19].mem_acc_state_next = bank_fsm[19].mem_acc_state_next ;
  assign bank_mem[20].mem_acc_state_next = bank_fsm[20].mem_acc_state_next ;
  assign bank_mem[21].mem_acc_state_next = bank_fsm[21].mem_acc_state_next ;
  assign bank_mem[22].mem_acc_state_next = bank_fsm[22].mem_acc_state_next ;
  assign bank_mem[23].mem_acc_state_next = bank_fsm[23].mem_acc_state_next ;
  assign bank_mem[24].mem_acc_state_next = bank_fsm[24].mem_acc_state_next ;
  assign bank_mem[25].mem_acc_state_next = bank_fsm[25].mem_acc_state_next ;
  assign bank_mem[26].mem_acc_state_next = bank_fsm[26].mem_acc_state_next ;
  assign bank_mem[27].mem_acc_state_next = bank_fsm[27].mem_acc_state_next ;
  assign bank_mem[28].mem_acc_state_next = bank_fsm[28].mem_acc_state_next ;
  assign bank_mem[29].mem_acc_state_next = bank_fsm[29].mem_acc_state_next ;
  assign bank_mem[30].mem_acc_state_next = bank_fsm[30].mem_acc_state_next ;
  assign bank_mem[31].mem_acc_state_next = bank_fsm[31].mem_acc_state_next ;

  assign memc__ldst__read_data        = ( ldst_read_addr_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( ldst_read_addr_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( ldst_read_addr_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( ldst_read_addr_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( ldst_read_addr_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( ldst_read_addr_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( ldst_read_addr_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( ldst_read_addr_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( ldst_read_addr_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( ldst_read_addr_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( ldst_read_addr_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( ldst_read_addr_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( ldst_read_addr_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( ldst_read_addr_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( ldst_read_addr_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( ldst_read_addr_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( ldst_read_addr_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( ldst_read_addr_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( ldst_read_addr_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( ldst_read_addr_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( ldst_read_addr_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( ldst_read_addr_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( ldst_read_addr_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( ldst_read_addr_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( ldst_read_addr_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( ldst_read_addr_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( ldst_read_addr_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( ldst_read_addr_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( ldst_read_addr_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( ldst_read_addr_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( ldst_read_addr_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__ldst__read_data_valid  = ( ldst_read_addr_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[0].read_data_ldst_valid : 
                                        ( ldst_read_addr_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[1].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[2].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[3].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[4].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[5].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[6].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[7].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[8].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[9].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[10].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[11].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[12].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[13].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[14].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[15].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[16].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[17].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[18].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[19].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[20].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[21].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[22].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[23].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[24].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[25].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[26].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[27].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[28].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[29].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[30].read_data_ldst_valid :
                                        ( ldst_read_addr_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[31].read_data_ldst_valid :
                                                                                                                                        1'b0                             ;
  assign memc__dma__read_data0        = ( dma_read_addr0_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr0_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr0_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr0_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr0_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr0_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr0_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr0_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr0_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr0_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr0_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr0_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr0_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr0_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr0_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr0_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr0_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr0_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr0_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr0_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr0_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr0_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr0_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr0_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr0_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr0_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr0_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr0_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr0_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr0_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr0_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data1        = ( dma_read_addr1_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr1_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr1_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr1_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr1_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr1_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr1_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr1_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr1_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr1_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr1_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr1_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr1_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr1_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr1_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr1_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr1_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr1_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr1_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr1_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr1_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr1_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr1_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr1_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr1_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr1_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr1_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr1_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr1_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr1_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr1_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data2        = ( dma_read_addr2_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr2_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr2_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr2_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr2_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr2_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr2_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr2_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr2_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr2_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr2_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr2_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr2_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr2_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr2_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr2_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr2_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr2_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr2_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr2_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr2_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr2_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr2_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr2_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr2_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr2_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr2_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr2_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr2_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr2_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr2_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data3        = ( dma_read_addr3_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr3_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr3_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr3_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr3_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr3_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr3_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr3_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr3_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr3_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr3_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr3_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr3_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr3_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr3_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr3_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr3_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr3_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr3_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr3_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr3_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr3_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr3_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr3_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr3_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr3_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr3_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr3_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr3_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr3_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr3_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data4        = ( dma_read_addr4_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr4_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr4_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr4_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr4_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr4_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr4_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr4_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr4_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr4_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr4_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr4_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr4_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr4_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr4_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr4_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr4_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr4_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr4_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr4_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr4_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr4_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr4_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr4_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr4_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr4_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr4_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr4_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr4_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr4_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr4_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data5        = ( dma_read_addr5_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr5_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr5_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr5_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr5_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr5_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr5_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr5_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr5_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr5_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr5_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr5_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr5_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr5_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr5_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr5_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr5_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr5_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr5_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr5_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr5_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr5_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr5_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr5_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr5_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr5_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr5_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr5_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr5_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr5_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr5_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data6        = ( dma_read_addr6_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr6_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr6_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr6_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr6_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr6_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr6_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr6_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr6_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr6_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr6_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr6_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr6_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr6_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr6_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr6_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr6_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr6_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr6_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr6_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr6_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr6_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr6_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr6_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr6_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr6_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr6_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr6_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr6_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr6_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr6_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data7        = ( dma_read_addr7_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr7_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr7_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr7_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr7_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr7_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr7_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr7_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr7_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr7_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr7_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr7_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr7_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr7_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr7_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr7_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr7_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr7_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr7_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr7_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr7_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr7_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr7_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr7_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr7_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr7_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr7_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr7_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr7_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr7_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr7_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data8        = ( dma_read_addr8_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr8_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr8_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr8_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr8_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr8_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr8_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr8_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr8_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr8_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr8_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr8_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr8_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr8_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr8_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr8_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr8_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr8_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr8_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr8_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr8_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr8_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr8_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr8_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr8_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr8_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr8_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr8_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr8_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr8_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr8_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data9        = ( dma_read_addr9_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr9_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr9_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr9_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr9_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr9_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr9_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr9_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr9_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr9_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr9_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr9_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr9_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr9_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr9_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr9_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr9_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr9_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr9_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr9_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr9_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr9_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr9_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr9_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr9_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr9_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr9_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr9_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr9_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr9_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr9_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data10        = ( dma_read_addr10_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr10_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr10_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr10_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr10_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr10_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr10_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr10_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr10_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr10_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr10_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr10_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr10_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr10_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr10_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr10_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr10_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr10_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr10_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr10_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr10_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr10_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr10_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr10_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr10_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr10_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr10_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr10_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr10_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr10_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr10_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data11        = ( dma_read_addr11_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr11_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr11_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr11_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr11_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr11_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr11_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr11_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr11_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr11_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr11_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr11_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr11_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr11_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr11_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr11_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr11_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr11_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr11_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr11_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr11_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr11_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr11_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr11_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr11_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr11_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr11_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr11_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr11_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr11_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr11_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data12        = ( dma_read_addr12_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr12_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr12_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr12_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr12_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr12_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr12_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr12_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr12_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr12_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr12_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr12_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr12_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr12_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr12_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr12_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr12_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr12_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr12_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr12_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr12_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr12_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr12_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr12_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr12_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr12_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr12_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr12_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr12_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr12_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr12_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data13        = ( dma_read_addr13_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr13_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr13_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr13_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr13_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr13_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr13_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr13_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr13_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr13_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr13_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr13_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr13_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr13_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr13_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr13_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr13_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr13_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr13_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr13_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr13_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr13_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr13_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr13_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr13_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr13_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr13_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr13_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr13_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr13_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr13_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data14        = ( dma_read_addr14_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr14_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr14_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr14_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr14_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr14_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr14_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr14_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr14_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr14_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr14_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr14_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr14_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr14_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr14_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr14_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr14_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr14_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr14_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr14_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr14_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr14_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr14_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr14_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr14_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr14_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr14_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr14_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr14_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr14_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr14_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data15        = ( dma_read_addr15_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr15_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr15_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr15_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr15_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr15_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr15_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr15_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr15_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr15_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr15_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr15_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr15_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr15_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr15_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr15_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr15_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr15_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr15_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr15_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr15_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr15_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr15_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr15_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr15_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr15_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr15_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr15_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr15_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr15_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr15_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data16        = ( dma_read_addr16_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr16_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr16_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr16_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr16_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr16_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr16_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr16_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr16_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr16_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr16_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr16_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr16_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr16_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr16_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr16_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr16_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr16_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr16_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr16_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr16_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr16_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr16_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr16_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr16_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr16_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr16_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr16_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr16_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr16_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr16_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data17        = ( dma_read_addr17_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr17_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr17_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr17_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr17_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr17_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr17_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr17_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr17_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr17_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr17_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr17_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr17_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr17_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr17_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr17_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr17_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr17_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr17_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr17_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr17_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr17_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr17_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr17_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr17_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr17_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr17_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr17_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr17_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr17_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr17_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data18        = ( dma_read_addr18_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr18_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr18_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr18_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr18_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr18_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr18_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr18_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr18_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr18_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr18_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr18_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr18_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr18_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr18_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr18_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr18_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr18_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr18_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr18_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr18_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr18_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr18_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr18_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr18_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr18_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr18_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr18_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr18_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr18_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr18_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data19        = ( dma_read_addr19_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr19_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr19_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr19_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr19_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr19_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr19_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr19_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr19_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr19_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr19_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr19_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr19_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr19_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr19_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr19_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr19_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr19_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr19_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr19_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr19_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr19_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr19_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr19_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr19_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr19_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr19_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr19_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr19_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr19_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr19_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data20        = ( dma_read_addr20_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr20_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr20_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr20_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr20_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr20_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr20_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr20_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr20_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr20_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr20_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr20_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr20_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr20_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr20_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr20_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr20_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr20_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr20_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr20_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr20_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr20_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr20_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr20_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr20_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr20_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr20_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr20_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr20_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr20_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr20_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data21        = ( dma_read_addr21_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr21_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr21_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr21_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr21_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr21_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr21_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr21_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr21_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr21_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr21_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr21_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr21_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr21_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr21_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr21_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr21_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr21_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr21_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr21_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr21_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr21_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr21_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr21_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr21_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr21_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr21_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr21_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr21_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr21_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr21_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data22        = ( dma_read_addr22_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr22_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr22_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr22_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr22_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr22_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr22_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr22_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr22_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr22_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr22_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr22_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr22_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr22_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr22_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr22_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr22_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr22_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr22_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr22_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr22_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr22_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr22_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr22_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr22_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr22_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr22_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr22_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr22_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr22_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr22_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data23        = ( dma_read_addr23_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr23_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr23_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr23_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr23_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr23_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr23_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr23_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr23_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr23_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr23_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr23_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr23_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr23_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr23_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr23_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr23_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr23_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr23_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr23_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr23_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr23_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr23_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr23_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr23_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr23_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr23_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr23_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr23_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr23_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr23_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data24        = ( dma_read_addr24_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr24_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr24_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr24_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr24_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr24_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr24_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr24_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr24_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr24_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr24_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr24_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr24_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr24_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr24_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr24_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr24_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr24_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr24_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr24_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr24_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr24_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr24_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr24_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr24_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr24_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr24_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr24_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr24_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr24_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr24_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data25        = ( dma_read_addr25_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr25_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr25_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr25_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr25_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr25_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr25_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr25_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr25_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr25_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr25_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr25_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr25_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr25_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr25_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr25_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr25_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr25_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr25_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr25_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr25_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr25_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr25_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr25_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr25_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr25_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr25_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr25_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr25_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr25_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr25_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data26        = ( dma_read_addr26_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr26_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr26_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr26_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr26_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr26_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr26_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr26_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr26_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr26_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr26_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr26_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr26_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr26_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr26_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr26_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr26_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr26_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr26_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr26_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr26_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr26_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr26_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr26_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr26_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr26_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr26_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr26_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr26_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr26_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr26_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data27        = ( dma_read_addr27_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr27_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr27_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr27_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr27_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr27_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr27_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr27_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr27_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr27_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr27_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr27_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr27_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr27_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr27_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr27_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr27_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr27_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr27_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr27_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr27_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr27_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr27_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr27_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr27_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr27_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr27_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr27_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr27_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr27_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr27_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data28        = ( dma_read_addr28_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr28_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr28_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr28_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr28_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr28_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr28_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr28_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr28_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr28_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr28_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr28_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr28_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr28_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr28_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr28_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr28_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr28_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr28_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr28_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr28_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr28_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr28_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr28_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr28_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr28_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr28_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr28_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr28_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr28_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr28_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data29        = ( dma_read_addr29_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr29_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr29_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr29_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr29_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr29_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr29_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr29_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr29_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr29_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr29_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr29_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr29_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr29_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr29_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr29_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr29_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr29_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr29_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr29_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr29_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr29_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr29_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr29_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr29_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr29_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr29_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr29_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr29_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr29_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr29_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data30        = ( dma_read_addr30_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr30_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr30_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr30_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr30_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr30_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr30_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr30_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr30_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr30_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr30_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr30_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr30_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr30_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr30_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr30_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr30_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr30_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr30_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr30_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr30_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr30_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr30_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr30_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr30_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr30_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr30_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr30_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr30_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr30_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr30_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data31        = ( dma_read_addr31_to_bank0 )  ?  bank_mem[0].read_data             : 
                                        ( dma_read_addr31_to_bank1 )  ?  bank_mem[1].read_data             : 
                                        ( dma_read_addr31_to_bank2 )  ?  bank_mem[2].read_data             : 
                                        ( dma_read_addr31_to_bank3 )  ?  bank_mem[3].read_data             : 
                                        ( dma_read_addr31_to_bank4 )  ?  bank_mem[4].read_data             : 
                                        ( dma_read_addr31_to_bank5 )  ?  bank_mem[5].read_data             : 
                                        ( dma_read_addr31_to_bank6 )  ?  bank_mem[6].read_data             : 
                                        ( dma_read_addr31_to_bank7 )  ?  bank_mem[7].read_data             : 
                                        ( dma_read_addr31_to_bank8 )  ?  bank_mem[8].read_data             : 
                                        ( dma_read_addr31_to_bank9 )  ?  bank_mem[9].read_data             : 
                                        ( dma_read_addr31_to_bank10 )  ?  bank_mem[10].read_data             : 
                                        ( dma_read_addr31_to_bank11 )  ?  bank_mem[11].read_data             : 
                                        ( dma_read_addr31_to_bank12 )  ?  bank_mem[12].read_data             : 
                                        ( dma_read_addr31_to_bank13 )  ?  bank_mem[13].read_data             : 
                                        ( dma_read_addr31_to_bank14 )  ?  bank_mem[14].read_data             : 
                                        ( dma_read_addr31_to_bank15 )  ?  bank_mem[15].read_data             : 
                                        ( dma_read_addr31_to_bank16 )  ?  bank_mem[16].read_data             : 
                                        ( dma_read_addr31_to_bank17 )  ?  bank_mem[17].read_data             : 
                                        ( dma_read_addr31_to_bank18 )  ?  bank_mem[18].read_data             : 
                                        ( dma_read_addr31_to_bank19 )  ?  bank_mem[19].read_data             : 
                                        ( dma_read_addr31_to_bank20 )  ?  bank_mem[20].read_data             : 
                                        ( dma_read_addr31_to_bank21 )  ?  bank_mem[21].read_data             : 
                                        ( dma_read_addr31_to_bank22 )  ?  bank_mem[22].read_data             : 
                                        ( dma_read_addr31_to_bank23 )  ?  bank_mem[23].read_data             : 
                                        ( dma_read_addr31_to_bank24 )  ?  bank_mem[24].read_data             : 
                                        ( dma_read_addr31_to_bank25 )  ?  bank_mem[25].read_data             : 
                                        ( dma_read_addr31_to_bank26 )  ?  bank_mem[26].read_data             : 
                                        ( dma_read_addr31_to_bank27 )  ?  bank_mem[27].read_data             : 
                                        ( dma_read_addr31_to_bank28 )  ?  bank_mem[28].read_data             : 
                                        ( dma_read_addr31_to_bank29 )  ?  bank_mem[29].read_data             : 
                                        ( dma_read_addr31_to_bank30 )  ?  bank_mem[30].read_data             : 
                                                                        bank_mem[31].read_data             ;
  assign memc__dma__read_data_valid0  = ( dma_read_addr0_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[0].read_data_strm0_valid : 
                                        ( dma_read_addr0_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[1].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[2].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[3].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[4].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[5].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[6].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[7].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[8].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[9].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[10].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[11].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[12].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[13].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[14].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[15].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[16].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[17].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[18].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[19].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[20].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[21].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[22].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[23].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[24].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[25].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[26].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[27].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[28].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[29].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[30].read_data_strm0_valid :
                                        ( dma_read_addr0_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS))  ?  bank_mem[31].read_data_strm0_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid1  = ( dma_read_addr1_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[0].read_data_strm1_valid : 
                                        ( dma_read_addr1_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[1].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[2].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[3].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[4].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[5].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[6].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[7].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[8].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[9].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[10].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[11].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[12].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[13].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[14].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[15].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[16].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[17].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[18].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[19].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[20].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[21].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[22].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[23].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[24].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[25].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[26].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[27].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[28].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[29].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[30].read_data_strm1_valid :
                                        ( dma_read_addr1_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS))  ?  bank_mem[31].read_data_strm1_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid2  = ( dma_read_addr2_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[0].read_data_strm2_valid : 
                                        ( dma_read_addr2_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[1].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[2].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[3].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[4].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[5].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[6].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[7].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[8].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[9].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[10].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[11].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[12].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[13].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[14].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[15].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[16].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[17].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[18].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[19].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[20].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[21].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[22].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[23].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[24].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[25].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[26].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[27].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[28].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[29].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[30].read_data_strm2_valid :
                                        ( dma_read_addr2_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS))  ?  bank_mem[31].read_data_strm2_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid3  = ( dma_read_addr3_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[0].read_data_strm3_valid : 
                                        ( dma_read_addr3_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[1].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[2].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[3].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[4].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[5].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[6].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[7].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[8].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[9].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[10].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[11].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[12].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[13].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[14].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[15].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[16].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[17].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[18].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[19].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[20].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[21].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[22].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[23].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[24].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[25].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[26].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[27].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[28].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[29].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[30].read_data_strm3_valid :
                                        ( dma_read_addr3_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS))  ?  bank_mem[31].read_data_strm3_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid4  = ( dma_read_addr4_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[0].read_data_strm4_valid : 
                                        ( dma_read_addr4_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[1].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[2].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[3].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[4].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[5].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[6].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[7].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[8].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[9].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[10].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[11].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[12].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[13].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[14].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[15].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[16].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[17].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[18].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[19].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[20].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[21].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[22].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[23].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[24].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[25].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[26].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[27].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[28].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[29].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[30].read_data_strm4_valid :
                                        ( dma_read_addr4_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS))  ?  bank_mem[31].read_data_strm4_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid5  = ( dma_read_addr5_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[0].read_data_strm5_valid : 
                                        ( dma_read_addr5_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[1].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[2].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[3].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[4].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[5].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[6].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[7].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[8].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[9].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[10].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[11].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[12].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[13].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[14].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[15].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[16].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[17].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[18].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[19].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[20].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[21].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[22].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[23].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[24].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[25].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[26].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[27].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[28].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[29].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[30].read_data_strm5_valid :
                                        ( dma_read_addr5_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS))  ?  bank_mem[31].read_data_strm5_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid6  = ( dma_read_addr6_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[0].read_data_strm6_valid : 
                                        ( dma_read_addr6_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[1].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[2].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[3].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[4].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[5].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[6].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[7].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[8].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[9].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[10].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[11].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[12].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[13].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[14].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[15].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[16].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[17].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[18].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[19].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[20].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[21].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[22].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[23].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[24].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[25].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[26].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[27].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[28].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[29].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[30].read_data_strm6_valid :
                                        ( dma_read_addr6_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS))  ?  bank_mem[31].read_data_strm6_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid7  = ( dma_read_addr7_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[0].read_data_strm7_valid : 
                                        ( dma_read_addr7_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[1].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[2].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[3].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[4].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[5].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[6].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[7].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[8].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[9].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[10].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[11].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[12].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[13].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[14].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[15].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[16].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[17].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[18].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[19].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[20].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[21].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[22].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[23].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[24].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[25].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[26].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[27].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[28].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[29].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[30].read_data_strm7_valid :
                                        ( dma_read_addr7_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS))  ?  bank_mem[31].read_data_strm7_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid8  = ( dma_read_addr8_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[0].read_data_strm8_valid : 
                                        ( dma_read_addr8_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[1].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[2].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[3].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[4].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[5].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[6].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[7].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[8].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[9].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[10].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[11].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[12].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[13].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[14].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[15].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[16].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[17].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[18].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[19].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[20].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[21].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[22].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[23].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[24].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[25].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[26].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[27].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[28].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[29].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[30].read_data_strm8_valid :
                                        ( dma_read_addr8_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS))  ?  bank_mem[31].read_data_strm8_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid9  = ( dma_read_addr9_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[0].read_data_strm9_valid : 
                                        ( dma_read_addr9_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[1].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[2].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[3].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[4].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[5].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[6].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[7].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[8].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[9].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[10].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[11].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[12].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[13].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[14].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[15].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[16].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[17].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[18].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[19].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[20].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[21].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[22].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[23].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[24].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[25].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[26].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[27].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[28].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[29].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[30].read_data_strm9_valid :
                                        ( dma_read_addr9_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS))  ?  bank_mem[31].read_data_strm9_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid10  = ( dma_read_addr10_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[0].read_data_strm10_valid : 
                                        ( dma_read_addr10_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[1].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[2].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[3].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[4].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[5].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[6].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[7].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[8].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[9].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[10].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[11].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[12].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[13].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[14].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[15].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[16].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[17].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[18].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[19].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[20].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[21].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[22].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[23].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[24].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[25].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[26].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[27].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[28].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[29].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[30].read_data_strm10_valid :
                                        ( dma_read_addr10_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS))  ?  bank_mem[31].read_data_strm10_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid11  = ( dma_read_addr11_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[0].read_data_strm11_valid : 
                                        ( dma_read_addr11_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[1].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[2].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[3].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[4].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[5].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[6].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[7].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[8].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[9].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[10].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[11].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[12].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[13].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[14].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[15].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[16].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[17].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[18].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[19].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[20].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[21].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[22].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[23].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[24].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[25].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[26].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[27].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[28].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[29].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[30].read_data_strm11_valid :
                                        ( dma_read_addr11_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS))  ?  bank_mem[31].read_data_strm11_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid12  = ( dma_read_addr12_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[0].read_data_strm12_valid : 
                                        ( dma_read_addr12_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[1].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[2].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[3].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[4].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[5].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[6].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[7].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[8].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[9].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[10].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[11].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[12].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[13].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[14].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[15].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[16].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[17].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[18].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[19].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[20].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[21].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[22].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[23].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[24].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[25].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[26].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[27].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[28].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[29].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[30].read_data_strm12_valid :
                                        ( dma_read_addr12_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS))  ?  bank_mem[31].read_data_strm12_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid13  = ( dma_read_addr13_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[0].read_data_strm13_valid : 
                                        ( dma_read_addr13_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[1].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[2].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[3].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[4].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[5].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[6].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[7].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[8].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[9].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[10].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[11].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[12].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[13].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[14].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[15].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[16].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[17].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[18].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[19].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[20].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[21].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[22].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[23].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[24].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[25].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[26].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[27].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[28].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[29].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[30].read_data_strm13_valid :
                                        ( dma_read_addr13_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS))  ?  bank_mem[31].read_data_strm13_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid14  = ( dma_read_addr14_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[0].read_data_strm14_valid : 
                                        ( dma_read_addr14_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[1].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[2].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[3].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[4].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[5].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[6].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[7].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[8].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[9].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[10].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[11].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[12].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[13].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[14].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[15].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[16].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[17].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[18].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[19].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[20].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[21].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[22].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[23].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[24].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[25].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[26].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[27].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[28].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[29].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[30].read_data_strm14_valid :
                                        ( dma_read_addr14_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS))  ?  bank_mem[31].read_data_strm14_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid15  = ( dma_read_addr15_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[0].read_data_strm15_valid : 
                                        ( dma_read_addr15_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[1].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[2].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[3].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[4].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[5].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[6].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[7].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[8].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[9].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[10].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[11].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[12].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[13].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[14].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[15].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[16].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[17].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[18].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[19].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[20].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[21].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[22].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[23].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[24].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[25].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[26].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[27].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[28].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[29].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[30].read_data_strm15_valid :
                                        ( dma_read_addr15_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS))  ?  bank_mem[31].read_data_strm15_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid16  = ( dma_read_addr16_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[0].read_data_strm16_valid : 
                                        ( dma_read_addr16_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[1].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[2].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[3].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[4].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[5].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[6].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[7].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[8].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[9].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[10].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[11].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[12].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[13].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[14].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[15].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[16].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[17].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[18].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[19].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[20].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[21].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[22].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[23].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[24].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[25].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[26].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[27].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[28].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[29].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[30].read_data_strm16_valid :
                                        ( dma_read_addr16_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS))  ?  bank_mem[31].read_data_strm16_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid17  = ( dma_read_addr17_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[0].read_data_strm17_valid : 
                                        ( dma_read_addr17_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[1].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[2].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[3].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[4].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[5].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[6].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[7].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[8].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[9].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[10].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[11].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[12].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[13].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[14].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[15].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[16].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[17].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[18].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[19].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[20].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[21].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[22].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[23].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[24].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[25].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[26].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[27].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[28].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[29].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[30].read_data_strm17_valid :
                                        ( dma_read_addr17_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS))  ?  bank_mem[31].read_data_strm17_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid18  = ( dma_read_addr18_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[0].read_data_strm18_valid : 
                                        ( dma_read_addr18_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[1].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[2].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[3].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[4].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[5].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[6].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[7].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[8].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[9].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[10].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[11].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[12].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[13].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[14].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[15].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[16].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[17].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[18].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[19].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[20].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[21].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[22].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[23].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[24].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[25].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[26].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[27].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[28].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[29].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[30].read_data_strm18_valid :
                                        ( dma_read_addr18_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS))  ?  bank_mem[31].read_data_strm18_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid19  = ( dma_read_addr19_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[0].read_data_strm19_valid : 
                                        ( dma_read_addr19_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[1].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[2].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[3].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[4].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[5].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[6].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[7].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[8].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[9].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[10].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[11].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[12].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[13].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[14].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[15].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[16].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[17].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[18].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[19].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[20].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[21].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[22].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[23].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[24].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[25].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[26].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[27].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[28].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[29].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[30].read_data_strm19_valid :
                                        ( dma_read_addr19_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS))  ?  bank_mem[31].read_data_strm19_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid20  = ( dma_read_addr20_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[0].read_data_strm20_valid : 
                                        ( dma_read_addr20_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[1].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[2].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[3].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[4].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[5].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[6].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[7].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[8].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[9].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[10].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[11].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[12].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[13].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[14].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[15].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[16].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[17].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[18].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[19].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[20].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[21].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[22].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[23].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[24].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[25].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[26].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[27].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[28].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[29].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[30].read_data_strm20_valid :
                                        ( dma_read_addr20_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS))  ?  bank_mem[31].read_data_strm20_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid21  = ( dma_read_addr21_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[0].read_data_strm21_valid : 
                                        ( dma_read_addr21_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[1].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[2].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[3].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[4].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[5].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[6].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[7].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[8].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[9].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[10].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[11].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[12].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[13].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[14].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[15].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[16].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[17].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[18].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[19].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[20].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[21].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[22].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[23].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[24].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[25].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[26].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[27].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[28].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[29].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[30].read_data_strm21_valid :
                                        ( dma_read_addr21_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS))  ?  bank_mem[31].read_data_strm21_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid22  = ( dma_read_addr22_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[0].read_data_strm22_valid : 
                                        ( dma_read_addr22_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[1].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[2].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[3].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[4].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[5].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[6].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[7].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[8].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[9].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[10].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[11].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[12].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[13].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[14].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[15].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[16].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[17].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[18].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[19].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[20].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[21].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[22].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[23].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[24].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[25].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[26].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[27].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[28].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[29].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[30].read_data_strm22_valid :
                                        ( dma_read_addr22_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS))  ?  bank_mem[31].read_data_strm22_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid23  = ( dma_read_addr23_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[0].read_data_strm23_valid : 
                                        ( dma_read_addr23_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[1].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[2].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[3].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[4].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[5].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[6].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[7].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[8].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[9].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[10].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[11].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[12].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[13].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[14].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[15].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[16].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[17].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[18].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[19].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[20].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[21].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[22].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[23].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[24].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[25].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[26].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[27].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[28].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[29].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[30].read_data_strm23_valid :
                                        ( dma_read_addr23_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS))  ?  bank_mem[31].read_data_strm23_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid24  = ( dma_read_addr24_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[0].read_data_strm24_valid : 
                                        ( dma_read_addr24_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[1].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[2].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[3].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[4].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[5].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[6].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[7].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[8].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[9].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[10].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[11].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[12].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[13].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[14].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[15].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[16].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[17].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[18].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[19].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[20].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[21].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[22].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[23].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[24].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[25].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[26].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[27].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[28].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[29].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[30].read_data_strm24_valid :
                                        ( dma_read_addr24_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS))  ?  bank_mem[31].read_data_strm24_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid25  = ( dma_read_addr25_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[0].read_data_strm25_valid : 
                                        ( dma_read_addr25_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[1].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[2].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[3].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[4].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[5].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[6].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[7].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[8].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[9].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[10].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[11].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[12].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[13].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[14].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[15].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[16].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[17].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[18].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[19].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[20].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[21].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[22].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[23].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[24].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[25].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[26].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[27].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[28].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[29].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[30].read_data_strm25_valid :
                                        ( dma_read_addr25_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS))  ?  bank_mem[31].read_data_strm25_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid26  = ( dma_read_addr26_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[0].read_data_strm26_valid : 
                                        ( dma_read_addr26_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[1].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[2].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[3].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[4].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[5].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[6].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[7].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[8].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[9].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[10].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[11].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[12].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[13].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[14].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[15].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[16].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[17].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[18].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[19].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[20].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[21].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[22].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[23].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[24].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[25].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[26].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[27].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[28].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[29].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[30].read_data_strm26_valid :
                                        ( dma_read_addr26_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS))  ?  bank_mem[31].read_data_strm26_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid27  = ( dma_read_addr27_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[0].read_data_strm27_valid : 
                                        ( dma_read_addr27_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[1].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[2].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[3].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[4].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[5].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[6].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[7].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[8].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[9].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[10].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[11].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[12].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[13].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[14].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[15].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[16].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[17].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[18].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[19].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[20].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[21].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[22].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[23].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[24].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[25].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[26].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[27].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[28].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[29].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[30].read_data_strm27_valid :
                                        ( dma_read_addr27_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS))  ?  bank_mem[31].read_data_strm27_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid28  = ( dma_read_addr28_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[0].read_data_strm28_valid : 
                                        ( dma_read_addr28_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[1].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[2].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[3].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[4].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[5].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[6].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[7].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[8].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[9].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[10].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[11].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[12].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[13].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[14].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[15].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[16].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[17].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[18].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[19].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[20].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[21].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[22].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[23].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[24].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[25].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[26].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[27].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[28].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[29].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[30].read_data_strm28_valid :
                                        ( dma_read_addr28_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS))  ?  bank_mem[31].read_data_strm28_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid29  = ( dma_read_addr29_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[0].read_data_strm29_valid : 
                                        ( dma_read_addr29_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[1].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[2].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[3].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[4].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[5].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[6].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[7].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[8].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[9].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[10].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[11].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[12].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[13].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[14].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[15].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[16].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[17].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[18].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[19].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[20].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[21].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[22].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[23].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[24].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[25].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[26].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[27].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[28].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[29].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[30].read_data_strm29_valid :
                                        ( dma_read_addr29_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS))  ?  bank_mem[31].read_data_strm29_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid30  = ( dma_read_addr30_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[0].read_data_strm30_valid : 
                                        ( dma_read_addr30_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[1].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[2].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[3].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[4].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[5].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[6].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[7].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[8].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[9].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[10].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[11].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[12].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[13].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[14].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[15].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[16].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[17].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[18].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[19].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[20].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[21].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[22].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[23].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[24].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[25].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[26].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[27].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[28].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[29].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[30].read_data_strm30_valid :
                                        ( dma_read_addr30_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS))  ?  bank_mem[31].read_data_strm30_valid :
                                                                                                                                             1'b0                              ;
  assign memc__dma__read_data_valid31  = ( dma_read_addr31_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[0].read_data_strm31_valid : 
                                        ( dma_read_addr31_to_bank1 && (bank_fsm[1].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[1].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank2 && (bank_fsm[2].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[2].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank3 && (bank_fsm[3].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[3].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank4 && (bank_fsm[4].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[4].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank5 && (bank_fsm[5].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[5].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank6 && (bank_fsm[6].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[6].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank7 && (bank_fsm[7].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[7].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank8 && (bank_fsm[8].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[8].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank9 && (bank_fsm[9].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[9].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank10 && (bank_fsm[10].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[10].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank11 && (bank_fsm[11].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[11].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank12 && (bank_fsm[12].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[12].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank13 && (bank_fsm[13].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[13].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank14 && (bank_fsm[14].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[14].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank15 && (bank_fsm[15].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[15].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank16 && (bank_fsm[16].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[16].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank17 && (bank_fsm[17].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[17].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank18 && (bank_fsm[18].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[18].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank19 && (bank_fsm[19].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[19].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank20 && (bank_fsm[20].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[20].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank21 && (bank_fsm[21].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[21].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank22 && (bank_fsm[22].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[22].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank23 && (bank_fsm[23].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[23].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank24 && (bank_fsm[24].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[24].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank25 && (bank_fsm[25].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[25].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank26 && (bank_fsm[26].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[26].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank27 && (bank_fsm[27].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[27].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank28 && (bank_fsm[28].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[28].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank29 && (bank_fsm[29].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[29].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank30 && (bank_fsm[30].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[30].read_data_strm31_valid :
                                        ( dma_read_addr31_to_bank31 && (bank_fsm[31].mem_acc_state == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS))  ?  bank_mem[31].read_data_strm31_valid :
                                                                                                                                             1'b0                              ;
  assign bank_mem[0].dma_read_addr0_to_bank  = dma_read_addr0_to_bank0  ;
  assign bank_mem[0].dma_write_addr0_to_bank = dma_write_addr0_to_bank0 ;
  assign bank_mem[0].dma_read_addr1_to_bank  = dma_read_addr1_to_bank0  ;
  assign bank_mem[0].dma_write_addr1_to_bank = dma_write_addr1_to_bank0 ;
  assign bank_mem[0].dma_read_addr2_to_bank  = dma_read_addr2_to_bank0  ;
  assign bank_mem[0].dma_write_addr2_to_bank = dma_write_addr2_to_bank0 ;
  assign bank_mem[0].dma_read_addr3_to_bank  = dma_read_addr3_to_bank0  ;
  assign bank_mem[0].dma_write_addr3_to_bank = dma_write_addr3_to_bank0 ;
  assign bank_mem[0].dma_read_addr4_to_bank  = dma_read_addr4_to_bank0  ;
  assign bank_mem[0].dma_write_addr4_to_bank = dma_write_addr4_to_bank0 ;
  assign bank_mem[0].dma_read_addr5_to_bank  = dma_read_addr5_to_bank0  ;
  assign bank_mem[0].dma_write_addr5_to_bank = dma_write_addr5_to_bank0 ;
  assign bank_mem[0].dma_read_addr6_to_bank  = dma_read_addr6_to_bank0  ;
  assign bank_mem[0].dma_write_addr6_to_bank = dma_write_addr6_to_bank0 ;
  assign bank_mem[0].dma_read_addr7_to_bank  = dma_read_addr7_to_bank0  ;
  assign bank_mem[0].dma_write_addr7_to_bank = dma_write_addr7_to_bank0 ;
  assign bank_mem[0].dma_read_addr8_to_bank  = dma_read_addr8_to_bank0  ;
  assign bank_mem[0].dma_write_addr8_to_bank = dma_write_addr8_to_bank0 ;
  assign bank_mem[0].dma_read_addr9_to_bank  = dma_read_addr9_to_bank0  ;
  assign bank_mem[0].dma_write_addr9_to_bank = dma_write_addr9_to_bank0 ;
  assign bank_mem[0].dma_read_addr10_to_bank  = dma_read_addr10_to_bank0  ;
  assign bank_mem[0].dma_write_addr10_to_bank = dma_write_addr10_to_bank0 ;
  assign bank_mem[0].dma_read_addr11_to_bank  = dma_read_addr11_to_bank0  ;
  assign bank_mem[0].dma_write_addr11_to_bank = dma_write_addr11_to_bank0 ;
  assign bank_mem[0].dma_read_addr12_to_bank  = dma_read_addr12_to_bank0  ;
  assign bank_mem[0].dma_write_addr12_to_bank = dma_write_addr12_to_bank0 ;
  assign bank_mem[0].dma_read_addr13_to_bank  = dma_read_addr13_to_bank0  ;
  assign bank_mem[0].dma_write_addr13_to_bank = dma_write_addr13_to_bank0 ;
  assign bank_mem[0].dma_read_addr14_to_bank  = dma_read_addr14_to_bank0  ;
  assign bank_mem[0].dma_write_addr14_to_bank = dma_write_addr14_to_bank0 ;
  assign bank_mem[0].dma_read_addr15_to_bank  = dma_read_addr15_to_bank0  ;
  assign bank_mem[0].dma_write_addr15_to_bank = dma_write_addr15_to_bank0 ;
  assign bank_mem[0].dma_read_addr16_to_bank  = dma_read_addr16_to_bank0  ;
  assign bank_mem[0].dma_write_addr16_to_bank = dma_write_addr16_to_bank0 ;
  assign bank_mem[0].dma_read_addr17_to_bank  = dma_read_addr17_to_bank0  ;
  assign bank_mem[0].dma_write_addr17_to_bank = dma_write_addr17_to_bank0 ;
  assign bank_mem[0].dma_read_addr18_to_bank  = dma_read_addr18_to_bank0  ;
  assign bank_mem[0].dma_write_addr18_to_bank = dma_write_addr18_to_bank0 ;
  assign bank_mem[0].dma_read_addr19_to_bank  = dma_read_addr19_to_bank0  ;
  assign bank_mem[0].dma_write_addr19_to_bank = dma_write_addr19_to_bank0 ;
  assign bank_mem[0].dma_read_addr20_to_bank  = dma_read_addr20_to_bank0  ;
  assign bank_mem[0].dma_write_addr20_to_bank = dma_write_addr20_to_bank0 ;
  assign bank_mem[0].dma_read_addr21_to_bank  = dma_read_addr21_to_bank0  ;
  assign bank_mem[0].dma_write_addr21_to_bank = dma_write_addr21_to_bank0 ;
  assign bank_mem[0].dma_read_addr22_to_bank  = dma_read_addr22_to_bank0  ;
  assign bank_mem[0].dma_write_addr22_to_bank = dma_write_addr22_to_bank0 ;
  assign bank_mem[0].dma_read_addr23_to_bank  = dma_read_addr23_to_bank0  ;
  assign bank_mem[0].dma_write_addr23_to_bank = dma_write_addr23_to_bank0 ;
  assign bank_mem[0].dma_read_addr24_to_bank  = dma_read_addr24_to_bank0  ;
  assign bank_mem[0].dma_write_addr24_to_bank = dma_write_addr24_to_bank0 ;
  assign bank_mem[0].dma_read_addr25_to_bank  = dma_read_addr25_to_bank0  ;
  assign bank_mem[0].dma_write_addr25_to_bank = dma_write_addr25_to_bank0 ;
  assign bank_mem[0].dma_read_addr26_to_bank  = dma_read_addr26_to_bank0  ;
  assign bank_mem[0].dma_write_addr26_to_bank = dma_write_addr26_to_bank0 ;
  assign bank_mem[0].dma_read_addr27_to_bank  = dma_read_addr27_to_bank0  ;
  assign bank_mem[0].dma_write_addr27_to_bank = dma_write_addr27_to_bank0 ;
  assign bank_mem[0].dma_read_addr28_to_bank  = dma_read_addr28_to_bank0  ;
  assign bank_mem[0].dma_write_addr28_to_bank = dma_write_addr28_to_bank0 ;
  assign bank_mem[0].dma_read_addr29_to_bank  = dma_read_addr29_to_bank0  ;
  assign bank_mem[0].dma_write_addr29_to_bank = dma_write_addr29_to_bank0 ;
  assign bank_mem[0].dma_read_addr30_to_bank  = dma_read_addr30_to_bank0  ;
  assign bank_mem[0].dma_write_addr30_to_bank = dma_write_addr30_to_bank0 ;
  assign bank_mem[0].dma_read_addr31_to_bank  = dma_read_addr31_to_bank0  ;
  assign bank_mem[0].dma_write_addr31_to_bank = dma_write_addr31_to_bank0 ;
  assign bank_mem[1].dma_read_addr0_to_bank  = dma_read_addr0_to_bank1  ;
  assign bank_mem[1].dma_write_addr0_to_bank = dma_write_addr0_to_bank1 ;
  assign bank_mem[1].dma_read_addr1_to_bank  = dma_read_addr1_to_bank1  ;
  assign bank_mem[1].dma_write_addr1_to_bank = dma_write_addr1_to_bank1 ;
  assign bank_mem[1].dma_read_addr2_to_bank  = dma_read_addr2_to_bank1  ;
  assign bank_mem[1].dma_write_addr2_to_bank = dma_write_addr2_to_bank1 ;
  assign bank_mem[1].dma_read_addr3_to_bank  = dma_read_addr3_to_bank1  ;
  assign bank_mem[1].dma_write_addr3_to_bank = dma_write_addr3_to_bank1 ;
  assign bank_mem[1].dma_read_addr4_to_bank  = dma_read_addr4_to_bank1  ;
  assign bank_mem[1].dma_write_addr4_to_bank = dma_write_addr4_to_bank1 ;
  assign bank_mem[1].dma_read_addr5_to_bank  = dma_read_addr5_to_bank1  ;
  assign bank_mem[1].dma_write_addr5_to_bank = dma_write_addr5_to_bank1 ;
  assign bank_mem[1].dma_read_addr6_to_bank  = dma_read_addr6_to_bank1  ;
  assign bank_mem[1].dma_write_addr6_to_bank = dma_write_addr6_to_bank1 ;
  assign bank_mem[1].dma_read_addr7_to_bank  = dma_read_addr7_to_bank1  ;
  assign bank_mem[1].dma_write_addr7_to_bank = dma_write_addr7_to_bank1 ;
  assign bank_mem[1].dma_read_addr8_to_bank  = dma_read_addr8_to_bank1  ;
  assign bank_mem[1].dma_write_addr8_to_bank = dma_write_addr8_to_bank1 ;
  assign bank_mem[1].dma_read_addr9_to_bank  = dma_read_addr9_to_bank1  ;
  assign bank_mem[1].dma_write_addr9_to_bank = dma_write_addr9_to_bank1 ;
  assign bank_mem[1].dma_read_addr10_to_bank  = dma_read_addr10_to_bank1  ;
  assign bank_mem[1].dma_write_addr10_to_bank = dma_write_addr10_to_bank1 ;
  assign bank_mem[1].dma_read_addr11_to_bank  = dma_read_addr11_to_bank1  ;
  assign bank_mem[1].dma_write_addr11_to_bank = dma_write_addr11_to_bank1 ;
  assign bank_mem[1].dma_read_addr12_to_bank  = dma_read_addr12_to_bank1  ;
  assign bank_mem[1].dma_write_addr12_to_bank = dma_write_addr12_to_bank1 ;
  assign bank_mem[1].dma_read_addr13_to_bank  = dma_read_addr13_to_bank1  ;
  assign bank_mem[1].dma_write_addr13_to_bank = dma_write_addr13_to_bank1 ;
  assign bank_mem[1].dma_read_addr14_to_bank  = dma_read_addr14_to_bank1  ;
  assign bank_mem[1].dma_write_addr14_to_bank = dma_write_addr14_to_bank1 ;
  assign bank_mem[1].dma_read_addr15_to_bank  = dma_read_addr15_to_bank1  ;
  assign bank_mem[1].dma_write_addr15_to_bank = dma_write_addr15_to_bank1 ;
  assign bank_mem[1].dma_read_addr16_to_bank  = dma_read_addr16_to_bank1  ;
  assign bank_mem[1].dma_write_addr16_to_bank = dma_write_addr16_to_bank1 ;
  assign bank_mem[1].dma_read_addr17_to_bank  = dma_read_addr17_to_bank1  ;
  assign bank_mem[1].dma_write_addr17_to_bank = dma_write_addr17_to_bank1 ;
  assign bank_mem[1].dma_read_addr18_to_bank  = dma_read_addr18_to_bank1  ;
  assign bank_mem[1].dma_write_addr18_to_bank = dma_write_addr18_to_bank1 ;
  assign bank_mem[1].dma_read_addr19_to_bank  = dma_read_addr19_to_bank1  ;
  assign bank_mem[1].dma_write_addr19_to_bank = dma_write_addr19_to_bank1 ;
  assign bank_mem[1].dma_read_addr20_to_bank  = dma_read_addr20_to_bank1  ;
  assign bank_mem[1].dma_write_addr20_to_bank = dma_write_addr20_to_bank1 ;
  assign bank_mem[1].dma_read_addr21_to_bank  = dma_read_addr21_to_bank1  ;
  assign bank_mem[1].dma_write_addr21_to_bank = dma_write_addr21_to_bank1 ;
  assign bank_mem[1].dma_read_addr22_to_bank  = dma_read_addr22_to_bank1  ;
  assign bank_mem[1].dma_write_addr22_to_bank = dma_write_addr22_to_bank1 ;
  assign bank_mem[1].dma_read_addr23_to_bank  = dma_read_addr23_to_bank1  ;
  assign bank_mem[1].dma_write_addr23_to_bank = dma_write_addr23_to_bank1 ;
  assign bank_mem[1].dma_read_addr24_to_bank  = dma_read_addr24_to_bank1  ;
  assign bank_mem[1].dma_write_addr24_to_bank = dma_write_addr24_to_bank1 ;
  assign bank_mem[1].dma_read_addr25_to_bank  = dma_read_addr25_to_bank1  ;
  assign bank_mem[1].dma_write_addr25_to_bank = dma_write_addr25_to_bank1 ;
  assign bank_mem[1].dma_read_addr26_to_bank  = dma_read_addr26_to_bank1  ;
  assign bank_mem[1].dma_write_addr26_to_bank = dma_write_addr26_to_bank1 ;
  assign bank_mem[1].dma_read_addr27_to_bank  = dma_read_addr27_to_bank1  ;
  assign bank_mem[1].dma_write_addr27_to_bank = dma_write_addr27_to_bank1 ;
  assign bank_mem[1].dma_read_addr28_to_bank  = dma_read_addr28_to_bank1  ;
  assign bank_mem[1].dma_write_addr28_to_bank = dma_write_addr28_to_bank1 ;
  assign bank_mem[1].dma_read_addr29_to_bank  = dma_read_addr29_to_bank1  ;
  assign bank_mem[1].dma_write_addr29_to_bank = dma_write_addr29_to_bank1 ;
  assign bank_mem[1].dma_read_addr30_to_bank  = dma_read_addr30_to_bank1  ;
  assign bank_mem[1].dma_write_addr30_to_bank = dma_write_addr30_to_bank1 ;
  assign bank_mem[1].dma_read_addr31_to_bank  = dma_read_addr31_to_bank1  ;
  assign bank_mem[1].dma_write_addr31_to_bank = dma_write_addr31_to_bank1 ;
  assign bank_mem[2].dma_read_addr0_to_bank  = dma_read_addr0_to_bank2  ;
  assign bank_mem[2].dma_write_addr0_to_bank = dma_write_addr0_to_bank2 ;
  assign bank_mem[2].dma_read_addr1_to_bank  = dma_read_addr1_to_bank2  ;
  assign bank_mem[2].dma_write_addr1_to_bank = dma_write_addr1_to_bank2 ;
  assign bank_mem[2].dma_read_addr2_to_bank  = dma_read_addr2_to_bank2  ;
  assign bank_mem[2].dma_write_addr2_to_bank = dma_write_addr2_to_bank2 ;
  assign bank_mem[2].dma_read_addr3_to_bank  = dma_read_addr3_to_bank2  ;
  assign bank_mem[2].dma_write_addr3_to_bank = dma_write_addr3_to_bank2 ;
  assign bank_mem[2].dma_read_addr4_to_bank  = dma_read_addr4_to_bank2  ;
  assign bank_mem[2].dma_write_addr4_to_bank = dma_write_addr4_to_bank2 ;
  assign bank_mem[2].dma_read_addr5_to_bank  = dma_read_addr5_to_bank2  ;
  assign bank_mem[2].dma_write_addr5_to_bank = dma_write_addr5_to_bank2 ;
  assign bank_mem[2].dma_read_addr6_to_bank  = dma_read_addr6_to_bank2  ;
  assign bank_mem[2].dma_write_addr6_to_bank = dma_write_addr6_to_bank2 ;
  assign bank_mem[2].dma_read_addr7_to_bank  = dma_read_addr7_to_bank2  ;
  assign bank_mem[2].dma_write_addr7_to_bank = dma_write_addr7_to_bank2 ;
  assign bank_mem[2].dma_read_addr8_to_bank  = dma_read_addr8_to_bank2  ;
  assign bank_mem[2].dma_write_addr8_to_bank = dma_write_addr8_to_bank2 ;
  assign bank_mem[2].dma_read_addr9_to_bank  = dma_read_addr9_to_bank2  ;
  assign bank_mem[2].dma_write_addr9_to_bank = dma_write_addr9_to_bank2 ;
  assign bank_mem[2].dma_read_addr10_to_bank  = dma_read_addr10_to_bank2  ;
  assign bank_mem[2].dma_write_addr10_to_bank = dma_write_addr10_to_bank2 ;
  assign bank_mem[2].dma_read_addr11_to_bank  = dma_read_addr11_to_bank2  ;
  assign bank_mem[2].dma_write_addr11_to_bank = dma_write_addr11_to_bank2 ;
  assign bank_mem[2].dma_read_addr12_to_bank  = dma_read_addr12_to_bank2  ;
  assign bank_mem[2].dma_write_addr12_to_bank = dma_write_addr12_to_bank2 ;
  assign bank_mem[2].dma_read_addr13_to_bank  = dma_read_addr13_to_bank2  ;
  assign bank_mem[2].dma_write_addr13_to_bank = dma_write_addr13_to_bank2 ;
  assign bank_mem[2].dma_read_addr14_to_bank  = dma_read_addr14_to_bank2  ;
  assign bank_mem[2].dma_write_addr14_to_bank = dma_write_addr14_to_bank2 ;
  assign bank_mem[2].dma_read_addr15_to_bank  = dma_read_addr15_to_bank2  ;
  assign bank_mem[2].dma_write_addr15_to_bank = dma_write_addr15_to_bank2 ;
  assign bank_mem[2].dma_read_addr16_to_bank  = dma_read_addr16_to_bank2  ;
  assign bank_mem[2].dma_write_addr16_to_bank = dma_write_addr16_to_bank2 ;
  assign bank_mem[2].dma_read_addr17_to_bank  = dma_read_addr17_to_bank2  ;
  assign bank_mem[2].dma_write_addr17_to_bank = dma_write_addr17_to_bank2 ;
  assign bank_mem[2].dma_read_addr18_to_bank  = dma_read_addr18_to_bank2  ;
  assign bank_mem[2].dma_write_addr18_to_bank = dma_write_addr18_to_bank2 ;
  assign bank_mem[2].dma_read_addr19_to_bank  = dma_read_addr19_to_bank2  ;
  assign bank_mem[2].dma_write_addr19_to_bank = dma_write_addr19_to_bank2 ;
  assign bank_mem[2].dma_read_addr20_to_bank  = dma_read_addr20_to_bank2  ;
  assign bank_mem[2].dma_write_addr20_to_bank = dma_write_addr20_to_bank2 ;
  assign bank_mem[2].dma_read_addr21_to_bank  = dma_read_addr21_to_bank2  ;
  assign bank_mem[2].dma_write_addr21_to_bank = dma_write_addr21_to_bank2 ;
  assign bank_mem[2].dma_read_addr22_to_bank  = dma_read_addr22_to_bank2  ;
  assign bank_mem[2].dma_write_addr22_to_bank = dma_write_addr22_to_bank2 ;
  assign bank_mem[2].dma_read_addr23_to_bank  = dma_read_addr23_to_bank2  ;
  assign bank_mem[2].dma_write_addr23_to_bank = dma_write_addr23_to_bank2 ;
  assign bank_mem[2].dma_read_addr24_to_bank  = dma_read_addr24_to_bank2  ;
  assign bank_mem[2].dma_write_addr24_to_bank = dma_write_addr24_to_bank2 ;
  assign bank_mem[2].dma_read_addr25_to_bank  = dma_read_addr25_to_bank2  ;
  assign bank_mem[2].dma_write_addr25_to_bank = dma_write_addr25_to_bank2 ;
  assign bank_mem[2].dma_read_addr26_to_bank  = dma_read_addr26_to_bank2  ;
  assign bank_mem[2].dma_write_addr26_to_bank = dma_write_addr26_to_bank2 ;
  assign bank_mem[2].dma_read_addr27_to_bank  = dma_read_addr27_to_bank2  ;
  assign bank_mem[2].dma_write_addr27_to_bank = dma_write_addr27_to_bank2 ;
  assign bank_mem[2].dma_read_addr28_to_bank  = dma_read_addr28_to_bank2  ;
  assign bank_mem[2].dma_write_addr28_to_bank = dma_write_addr28_to_bank2 ;
  assign bank_mem[2].dma_read_addr29_to_bank  = dma_read_addr29_to_bank2  ;
  assign bank_mem[2].dma_write_addr29_to_bank = dma_write_addr29_to_bank2 ;
  assign bank_mem[2].dma_read_addr30_to_bank  = dma_read_addr30_to_bank2  ;
  assign bank_mem[2].dma_write_addr30_to_bank = dma_write_addr30_to_bank2 ;
  assign bank_mem[2].dma_read_addr31_to_bank  = dma_read_addr31_to_bank2  ;
  assign bank_mem[2].dma_write_addr31_to_bank = dma_write_addr31_to_bank2 ;
  assign bank_mem[3].dma_read_addr0_to_bank  = dma_read_addr0_to_bank3  ;
  assign bank_mem[3].dma_write_addr0_to_bank = dma_write_addr0_to_bank3 ;
  assign bank_mem[3].dma_read_addr1_to_bank  = dma_read_addr1_to_bank3  ;
  assign bank_mem[3].dma_write_addr1_to_bank = dma_write_addr1_to_bank3 ;
  assign bank_mem[3].dma_read_addr2_to_bank  = dma_read_addr2_to_bank3  ;
  assign bank_mem[3].dma_write_addr2_to_bank = dma_write_addr2_to_bank3 ;
  assign bank_mem[3].dma_read_addr3_to_bank  = dma_read_addr3_to_bank3  ;
  assign bank_mem[3].dma_write_addr3_to_bank = dma_write_addr3_to_bank3 ;
  assign bank_mem[3].dma_read_addr4_to_bank  = dma_read_addr4_to_bank3  ;
  assign bank_mem[3].dma_write_addr4_to_bank = dma_write_addr4_to_bank3 ;
  assign bank_mem[3].dma_read_addr5_to_bank  = dma_read_addr5_to_bank3  ;
  assign bank_mem[3].dma_write_addr5_to_bank = dma_write_addr5_to_bank3 ;
  assign bank_mem[3].dma_read_addr6_to_bank  = dma_read_addr6_to_bank3  ;
  assign bank_mem[3].dma_write_addr6_to_bank = dma_write_addr6_to_bank3 ;
  assign bank_mem[3].dma_read_addr7_to_bank  = dma_read_addr7_to_bank3  ;
  assign bank_mem[3].dma_write_addr7_to_bank = dma_write_addr7_to_bank3 ;
  assign bank_mem[3].dma_read_addr8_to_bank  = dma_read_addr8_to_bank3  ;
  assign bank_mem[3].dma_write_addr8_to_bank = dma_write_addr8_to_bank3 ;
  assign bank_mem[3].dma_read_addr9_to_bank  = dma_read_addr9_to_bank3  ;
  assign bank_mem[3].dma_write_addr9_to_bank = dma_write_addr9_to_bank3 ;
  assign bank_mem[3].dma_read_addr10_to_bank  = dma_read_addr10_to_bank3  ;
  assign bank_mem[3].dma_write_addr10_to_bank = dma_write_addr10_to_bank3 ;
  assign bank_mem[3].dma_read_addr11_to_bank  = dma_read_addr11_to_bank3  ;
  assign bank_mem[3].dma_write_addr11_to_bank = dma_write_addr11_to_bank3 ;
  assign bank_mem[3].dma_read_addr12_to_bank  = dma_read_addr12_to_bank3  ;
  assign bank_mem[3].dma_write_addr12_to_bank = dma_write_addr12_to_bank3 ;
  assign bank_mem[3].dma_read_addr13_to_bank  = dma_read_addr13_to_bank3  ;
  assign bank_mem[3].dma_write_addr13_to_bank = dma_write_addr13_to_bank3 ;
  assign bank_mem[3].dma_read_addr14_to_bank  = dma_read_addr14_to_bank3  ;
  assign bank_mem[3].dma_write_addr14_to_bank = dma_write_addr14_to_bank3 ;
  assign bank_mem[3].dma_read_addr15_to_bank  = dma_read_addr15_to_bank3  ;
  assign bank_mem[3].dma_write_addr15_to_bank = dma_write_addr15_to_bank3 ;
  assign bank_mem[3].dma_read_addr16_to_bank  = dma_read_addr16_to_bank3  ;
  assign bank_mem[3].dma_write_addr16_to_bank = dma_write_addr16_to_bank3 ;
  assign bank_mem[3].dma_read_addr17_to_bank  = dma_read_addr17_to_bank3  ;
  assign bank_mem[3].dma_write_addr17_to_bank = dma_write_addr17_to_bank3 ;
  assign bank_mem[3].dma_read_addr18_to_bank  = dma_read_addr18_to_bank3  ;
  assign bank_mem[3].dma_write_addr18_to_bank = dma_write_addr18_to_bank3 ;
  assign bank_mem[3].dma_read_addr19_to_bank  = dma_read_addr19_to_bank3  ;
  assign bank_mem[3].dma_write_addr19_to_bank = dma_write_addr19_to_bank3 ;
  assign bank_mem[3].dma_read_addr20_to_bank  = dma_read_addr20_to_bank3  ;
  assign bank_mem[3].dma_write_addr20_to_bank = dma_write_addr20_to_bank3 ;
  assign bank_mem[3].dma_read_addr21_to_bank  = dma_read_addr21_to_bank3  ;
  assign bank_mem[3].dma_write_addr21_to_bank = dma_write_addr21_to_bank3 ;
  assign bank_mem[3].dma_read_addr22_to_bank  = dma_read_addr22_to_bank3  ;
  assign bank_mem[3].dma_write_addr22_to_bank = dma_write_addr22_to_bank3 ;
  assign bank_mem[3].dma_read_addr23_to_bank  = dma_read_addr23_to_bank3  ;
  assign bank_mem[3].dma_write_addr23_to_bank = dma_write_addr23_to_bank3 ;
  assign bank_mem[3].dma_read_addr24_to_bank  = dma_read_addr24_to_bank3  ;
  assign bank_mem[3].dma_write_addr24_to_bank = dma_write_addr24_to_bank3 ;
  assign bank_mem[3].dma_read_addr25_to_bank  = dma_read_addr25_to_bank3  ;
  assign bank_mem[3].dma_write_addr25_to_bank = dma_write_addr25_to_bank3 ;
  assign bank_mem[3].dma_read_addr26_to_bank  = dma_read_addr26_to_bank3  ;
  assign bank_mem[3].dma_write_addr26_to_bank = dma_write_addr26_to_bank3 ;
  assign bank_mem[3].dma_read_addr27_to_bank  = dma_read_addr27_to_bank3  ;
  assign bank_mem[3].dma_write_addr27_to_bank = dma_write_addr27_to_bank3 ;
  assign bank_mem[3].dma_read_addr28_to_bank  = dma_read_addr28_to_bank3  ;
  assign bank_mem[3].dma_write_addr28_to_bank = dma_write_addr28_to_bank3 ;
  assign bank_mem[3].dma_read_addr29_to_bank  = dma_read_addr29_to_bank3  ;
  assign bank_mem[3].dma_write_addr29_to_bank = dma_write_addr29_to_bank3 ;
  assign bank_mem[3].dma_read_addr30_to_bank  = dma_read_addr30_to_bank3  ;
  assign bank_mem[3].dma_write_addr30_to_bank = dma_write_addr30_to_bank3 ;
  assign bank_mem[3].dma_read_addr31_to_bank  = dma_read_addr31_to_bank3  ;
  assign bank_mem[3].dma_write_addr31_to_bank = dma_write_addr31_to_bank3 ;
  assign bank_mem[4].dma_read_addr0_to_bank  = dma_read_addr0_to_bank4  ;
  assign bank_mem[4].dma_write_addr0_to_bank = dma_write_addr0_to_bank4 ;
  assign bank_mem[4].dma_read_addr1_to_bank  = dma_read_addr1_to_bank4  ;
  assign bank_mem[4].dma_write_addr1_to_bank = dma_write_addr1_to_bank4 ;
  assign bank_mem[4].dma_read_addr2_to_bank  = dma_read_addr2_to_bank4  ;
  assign bank_mem[4].dma_write_addr2_to_bank = dma_write_addr2_to_bank4 ;
  assign bank_mem[4].dma_read_addr3_to_bank  = dma_read_addr3_to_bank4  ;
  assign bank_mem[4].dma_write_addr3_to_bank = dma_write_addr3_to_bank4 ;
  assign bank_mem[4].dma_read_addr4_to_bank  = dma_read_addr4_to_bank4  ;
  assign bank_mem[4].dma_write_addr4_to_bank = dma_write_addr4_to_bank4 ;
  assign bank_mem[4].dma_read_addr5_to_bank  = dma_read_addr5_to_bank4  ;
  assign bank_mem[4].dma_write_addr5_to_bank = dma_write_addr5_to_bank4 ;
  assign bank_mem[4].dma_read_addr6_to_bank  = dma_read_addr6_to_bank4  ;
  assign bank_mem[4].dma_write_addr6_to_bank = dma_write_addr6_to_bank4 ;
  assign bank_mem[4].dma_read_addr7_to_bank  = dma_read_addr7_to_bank4  ;
  assign bank_mem[4].dma_write_addr7_to_bank = dma_write_addr7_to_bank4 ;
  assign bank_mem[4].dma_read_addr8_to_bank  = dma_read_addr8_to_bank4  ;
  assign bank_mem[4].dma_write_addr8_to_bank = dma_write_addr8_to_bank4 ;
  assign bank_mem[4].dma_read_addr9_to_bank  = dma_read_addr9_to_bank4  ;
  assign bank_mem[4].dma_write_addr9_to_bank = dma_write_addr9_to_bank4 ;
  assign bank_mem[4].dma_read_addr10_to_bank  = dma_read_addr10_to_bank4  ;
  assign bank_mem[4].dma_write_addr10_to_bank = dma_write_addr10_to_bank4 ;
  assign bank_mem[4].dma_read_addr11_to_bank  = dma_read_addr11_to_bank4  ;
  assign bank_mem[4].dma_write_addr11_to_bank = dma_write_addr11_to_bank4 ;
  assign bank_mem[4].dma_read_addr12_to_bank  = dma_read_addr12_to_bank4  ;
  assign bank_mem[4].dma_write_addr12_to_bank = dma_write_addr12_to_bank4 ;
  assign bank_mem[4].dma_read_addr13_to_bank  = dma_read_addr13_to_bank4  ;
  assign bank_mem[4].dma_write_addr13_to_bank = dma_write_addr13_to_bank4 ;
  assign bank_mem[4].dma_read_addr14_to_bank  = dma_read_addr14_to_bank4  ;
  assign bank_mem[4].dma_write_addr14_to_bank = dma_write_addr14_to_bank4 ;
  assign bank_mem[4].dma_read_addr15_to_bank  = dma_read_addr15_to_bank4  ;
  assign bank_mem[4].dma_write_addr15_to_bank = dma_write_addr15_to_bank4 ;
  assign bank_mem[4].dma_read_addr16_to_bank  = dma_read_addr16_to_bank4  ;
  assign bank_mem[4].dma_write_addr16_to_bank = dma_write_addr16_to_bank4 ;
  assign bank_mem[4].dma_read_addr17_to_bank  = dma_read_addr17_to_bank4  ;
  assign bank_mem[4].dma_write_addr17_to_bank = dma_write_addr17_to_bank4 ;
  assign bank_mem[4].dma_read_addr18_to_bank  = dma_read_addr18_to_bank4  ;
  assign bank_mem[4].dma_write_addr18_to_bank = dma_write_addr18_to_bank4 ;
  assign bank_mem[4].dma_read_addr19_to_bank  = dma_read_addr19_to_bank4  ;
  assign bank_mem[4].dma_write_addr19_to_bank = dma_write_addr19_to_bank4 ;
  assign bank_mem[4].dma_read_addr20_to_bank  = dma_read_addr20_to_bank4  ;
  assign bank_mem[4].dma_write_addr20_to_bank = dma_write_addr20_to_bank4 ;
  assign bank_mem[4].dma_read_addr21_to_bank  = dma_read_addr21_to_bank4  ;
  assign bank_mem[4].dma_write_addr21_to_bank = dma_write_addr21_to_bank4 ;
  assign bank_mem[4].dma_read_addr22_to_bank  = dma_read_addr22_to_bank4  ;
  assign bank_mem[4].dma_write_addr22_to_bank = dma_write_addr22_to_bank4 ;
  assign bank_mem[4].dma_read_addr23_to_bank  = dma_read_addr23_to_bank4  ;
  assign bank_mem[4].dma_write_addr23_to_bank = dma_write_addr23_to_bank4 ;
  assign bank_mem[4].dma_read_addr24_to_bank  = dma_read_addr24_to_bank4  ;
  assign bank_mem[4].dma_write_addr24_to_bank = dma_write_addr24_to_bank4 ;
  assign bank_mem[4].dma_read_addr25_to_bank  = dma_read_addr25_to_bank4  ;
  assign bank_mem[4].dma_write_addr25_to_bank = dma_write_addr25_to_bank4 ;
  assign bank_mem[4].dma_read_addr26_to_bank  = dma_read_addr26_to_bank4  ;
  assign bank_mem[4].dma_write_addr26_to_bank = dma_write_addr26_to_bank4 ;
  assign bank_mem[4].dma_read_addr27_to_bank  = dma_read_addr27_to_bank4  ;
  assign bank_mem[4].dma_write_addr27_to_bank = dma_write_addr27_to_bank4 ;
  assign bank_mem[4].dma_read_addr28_to_bank  = dma_read_addr28_to_bank4  ;
  assign bank_mem[4].dma_write_addr28_to_bank = dma_write_addr28_to_bank4 ;
  assign bank_mem[4].dma_read_addr29_to_bank  = dma_read_addr29_to_bank4  ;
  assign bank_mem[4].dma_write_addr29_to_bank = dma_write_addr29_to_bank4 ;
  assign bank_mem[4].dma_read_addr30_to_bank  = dma_read_addr30_to_bank4  ;
  assign bank_mem[4].dma_write_addr30_to_bank = dma_write_addr30_to_bank4 ;
  assign bank_mem[4].dma_read_addr31_to_bank  = dma_read_addr31_to_bank4  ;
  assign bank_mem[4].dma_write_addr31_to_bank = dma_write_addr31_to_bank4 ;
  assign bank_mem[5].dma_read_addr0_to_bank  = dma_read_addr0_to_bank5  ;
  assign bank_mem[5].dma_write_addr0_to_bank = dma_write_addr0_to_bank5 ;
  assign bank_mem[5].dma_read_addr1_to_bank  = dma_read_addr1_to_bank5  ;
  assign bank_mem[5].dma_write_addr1_to_bank = dma_write_addr1_to_bank5 ;
  assign bank_mem[5].dma_read_addr2_to_bank  = dma_read_addr2_to_bank5  ;
  assign bank_mem[5].dma_write_addr2_to_bank = dma_write_addr2_to_bank5 ;
  assign bank_mem[5].dma_read_addr3_to_bank  = dma_read_addr3_to_bank5  ;
  assign bank_mem[5].dma_write_addr3_to_bank = dma_write_addr3_to_bank5 ;
  assign bank_mem[5].dma_read_addr4_to_bank  = dma_read_addr4_to_bank5  ;
  assign bank_mem[5].dma_write_addr4_to_bank = dma_write_addr4_to_bank5 ;
  assign bank_mem[5].dma_read_addr5_to_bank  = dma_read_addr5_to_bank5  ;
  assign bank_mem[5].dma_write_addr5_to_bank = dma_write_addr5_to_bank5 ;
  assign bank_mem[5].dma_read_addr6_to_bank  = dma_read_addr6_to_bank5  ;
  assign bank_mem[5].dma_write_addr6_to_bank = dma_write_addr6_to_bank5 ;
  assign bank_mem[5].dma_read_addr7_to_bank  = dma_read_addr7_to_bank5  ;
  assign bank_mem[5].dma_write_addr7_to_bank = dma_write_addr7_to_bank5 ;
  assign bank_mem[5].dma_read_addr8_to_bank  = dma_read_addr8_to_bank5  ;
  assign bank_mem[5].dma_write_addr8_to_bank = dma_write_addr8_to_bank5 ;
  assign bank_mem[5].dma_read_addr9_to_bank  = dma_read_addr9_to_bank5  ;
  assign bank_mem[5].dma_write_addr9_to_bank = dma_write_addr9_to_bank5 ;
  assign bank_mem[5].dma_read_addr10_to_bank  = dma_read_addr10_to_bank5  ;
  assign bank_mem[5].dma_write_addr10_to_bank = dma_write_addr10_to_bank5 ;
  assign bank_mem[5].dma_read_addr11_to_bank  = dma_read_addr11_to_bank5  ;
  assign bank_mem[5].dma_write_addr11_to_bank = dma_write_addr11_to_bank5 ;
  assign bank_mem[5].dma_read_addr12_to_bank  = dma_read_addr12_to_bank5  ;
  assign bank_mem[5].dma_write_addr12_to_bank = dma_write_addr12_to_bank5 ;
  assign bank_mem[5].dma_read_addr13_to_bank  = dma_read_addr13_to_bank5  ;
  assign bank_mem[5].dma_write_addr13_to_bank = dma_write_addr13_to_bank5 ;
  assign bank_mem[5].dma_read_addr14_to_bank  = dma_read_addr14_to_bank5  ;
  assign bank_mem[5].dma_write_addr14_to_bank = dma_write_addr14_to_bank5 ;
  assign bank_mem[5].dma_read_addr15_to_bank  = dma_read_addr15_to_bank5  ;
  assign bank_mem[5].dma_write_addr15_to_bank = dma_write_addr15_to_bank5 ;
  assign bank_mem[5].dma_read_addr16_to_bank  = dma_read_addr16_to_bank5  ;
  assign bank_mem[5].dma_write_addr16_to_bank = dma_write_addr16_to_bank5 ;
  assign bank_mem[5].dma_read_addr17_to_bank  = dma_read_addr17_to_bank5  ;
  assign bank_mem[5].dma_write_addr17_to_bank = dma_write_addr17_to_bank5 ;
  assign bank_mem[5].dma_read_addr18_to_bank  = dma_read_addr18_to_bank5  ;
  assign bank_mem[5].dma_write_addr18_to_bank = dma_write_addr18_to_bank5 ;
  assign bank_mem[5].dma_read_addr19_to_bank  = dma_read_addr19_to_bank5  ;
  assign bank_mem[5].dma_write_addr19_to_bank = dma_write_addr19_to_bank5 ;
  assign bank_mem[5].dma_read_addr20_to_bank  = dma_read_addr20_to_bank5  ;
  assign bank_mem[5].dma_write_addr20_to_bank = dma_write_addr20_to_bank5 ;
  assign bank_mem[5].dma_read_addr21_to_bank  = dma_read_addr21_to_bank5  ;
  assign bank_mem[5].dma_write_addr21_to_bank = dma_write_addr21_to_bank5 ;
  assign bank_mem[5].dma_read_addr22_to_bank  = dma_read_addr22_to_bank5  ;
  assign bank_mem[5].dma_write_addr22_to_bank = dma_write_addr22_to_bank5 ;
  assign bank_mem[5].dma_read_addr23_to_bank  = dma_read_addr23_to_bank5  ;
  assign bank_mem[5].dma_write_addr23_to_bank = dma_write_addr23_to_bank5 ;
  assign bank_mem[5].dma_read_addr24_to_bank  = dma_read_addr24_to_bank5  ;
  assign bank_mem[5].dma_write_addr24_to_bank = dma_write_addr24_to_bank5 ;
  assign bank_mem[5].dma_read_addr25_to_bank  = dma_read_addr25_to_bank5  ;
  assign bank_mem[5].dma_write_addr25_to_bank = dma_write_addr25_to_bank5 ;
  assign bank_mem[5].dma_read_addr26_to_bank  = dma_read_addr26_to_bank5  ;
  assign bank_mem[5].dma_write_addr26_to_bank = dma_write_addr26_to_bank5 ;
  assign bank_mem[5].dma_read_addr27_to_bank  = dma_read_addr27_to_bank5  ;
  assign bank_mem[5].dma_write_addr27_to_bank = dma_write_addr27_to_bank5 ;
  assign bank_mem[5].dma_read_addr28_to_bank  = dma_read_addr28_to_bank5  ;
  assign bank_mem[5].dma_write_addr28_to_bank = dma_write_addr28_to_bank5 ;
  assign bank_mem[5].dma_read_addr29_to_bank  = dma_read_addr29_to_bank5  ;
  assign bank_mem[5].dma_write_addr29_to_bank = dma_write_addr29_to_bank5 ;
  assign bank_mem[5].dma_read_addr30_to_bank  = dma_read_addr30_to_bank5  ;
  assign bank_mem[5].dma_write_addr30_to_bank = dma_write_addr30_to_bank5 ;
  assign bank_mem[5].dma_read_addr31_to_bank  = dma_read_addr31_to_bank5  ;
  assign bank_mem[5].dma_write_addr31_to_bank = dma_write_addr31_to_bank5 ;
  assign bank_mem[6].dma_read_addr0_to_bank  = dma_read_addr0_to_bank6  ;
  assign bank_mem[6].dma_write_addr0_to_bank = dma_write_addr0_to_bank6 ;
  assign bank_mem[6].dma_read_addr1_to_bank  = dma_read_addr1_to_bank6  ;
  assign bank_mem[6].dma_write_addr1_to_bank = dma_write_addr1_to_bank6 ;
  assign bank_mem[6].dma_read_addr2_to_bank  = dma_read_addr2_to_bank6  ;
  assign bank_mem[6].dma_write_addr2_to_bank = dma_write_addr2_to_bank6 ;
  assign bank_mem[6].dma_read_addr3_to_bank  = dma_read_addr3_to_bank6  ;
  assign bank_mem[6].dma_write_addr3_to_bank = dma_write_addr3_to_bank6 ;
  assign bank_mem[6].dma_read_addr4_to_bank  = dma_read_addr4_to_bank6  ;
  assign bank_mem[6].dma_write_addr4_to_bank = dma_write_addr4_to_bank6 ;
  assign bank_mem[6].dma_read_addr5_to_bank  = dma_read_addr5_to_bank6  ;
  assign bank_mem[6].dma_write_addr5_to_bank = dma_write_addr5_to_bank6 ;
  assign bank_mem[6].dma_read_addr6_to_bank  = dma_read_addr6_to_bank6  ;
  assign bank_mem[6].dma_write_addr6_to_bank = dma_write_addr6_to_bank6 ;
  assign bank_mem[6].dma_read_addr7_to_bank  = dma_read_addr7_to_bank6  ;
  assign bank_mem[6].dma_write_addr7_to_bank = dma_write_addr7_to_bank6 ;
  assign bank_mem[6].dma_read_addr8_to_bank  = dma_read_addr8_to_bank6  ;
  assign bank_mem[6].dma_write_addr8_to_bank = dma_write_addr8_to_bank6 ;
  assign bank_mem[6].dma_read_addr9_to_bank  = dma_read_addr9_to_bank6  ;
  assign bank_mem[6].dma_write_addr9_to_bank = dma_write_addr9_to_bank6 ;
  assign bank_mem[6].dma_read_addr10_to_bank  = dma_read_addr10_to_bank6  ;
  assign bank_mem[6].dma_write_addr10_to_bank = dma_write_addr10_to_bank6 ;
  assign bank_mem[6].dma_read_addr11_to_bank  = dma_read_addr11_to_bank6  ;
  assign bank_mem[6].dma_write_addr11_to_bank = dma_write_addr11_to_bank6 ;
  assign bank_mem[6].dma_read_addr12_to_bank  = dma_read_addr12_to_bank6  ;
  assign bank_mem[6].dma_write_addr12_to_bank = dma_write_addr12_to_bank6 ;
  assign bank_mem[6].dma_read_addr13_to_bank  = dma_read_addr13_to_bank6  ;
  assign bank_mem[6].dma_write_addr13_to_bank = dma_write_addr13_to_bank6 ;
  assign bank_mem[6].dma_read_addr14_to_bank  = dma_read_addr14_to_bank6  ;
  assign bank_mem[6].dma_write_addr14_to_bank = dma_write_addr14_to_bank6 ;
  assign bank_mem[6].dma_read_addr15_to_bank  = dma_read_addr15_to_bank6  ;
  assign bank_mem[6].dma_write_addr15_to_bank = dma_write_addr15_to_bank6 ;
  assign bank_mem[6].dma_read_addr16_to_bank  = dma_read_addr16_to_bank6  ;
  assign bank_mem[6].dma_write_addr16_to_bank = dma_write_addr16_to_bank6 ;
  assign bank_mem[6].dma_read_addr17_to_bank  = dma_read_addr17_to_bank6  ;
  assign bank_mem[6].dma_write_addr17_to_bank = dma_write_addr17_to_bank6 ;
  assign bank_mem[6].dma_read_addr18_to_bank  = dma_read_addr18_to_bank6  ;
  assign bank_mem[6].dma_write_addr18_to_bank = dma_write_addr18_to_bank6 ;
  assign bank_mem[6].dma_read_addr19_to_bank  = dma_read_addr19_to_bank6  ;
  assign bank_mem[6].dma_write_addr19_to_bank = dma_write_addr19_to_bank6 ;
  assign bank_mem[6].dma_read_addr20_to_bank  = dma_read_addr20_to_bank6  ;
  assign bank_mem[6].dma_write_addr20_to_bank = dma_write_addr20_to_bank6 ;
  assign bank_mem[6].dma_read_addr21_to_bank  = dma_read_addr21_to_bank6  ;
  assign bank_mem[6].dma_write_addr21_to_bank = dma_write_addr21_to_bank6 ;
  assign bank_mem[6].dma_read_addr22_to_bank  = dma_read_addr22_to_bank6  ;
  assign bank_mem[6].dma_write_addr22_to_bank = dma_write_addr22_to_bank6 ;
  assign bank_mem[6].dma_read_addr23_to_bank  = dma_read_addr23_to_bank6  ;
  assign bank_mem[6].dma_write_addr23_to_bank = dma_write_addr23_to_bank6 ;
  assign bank_mem[6].dma_read_addr24_to_bank  = dma_read_addr24_to_bank6  ;
  assign bank_mem[6].dma_write_addr24_to_bank = dma_write_addr24_to_bank6 ;
  assign bank_mem[6].dma_read_addr25_to_bank  = dma_read_addr25_to_bank6  ;
  assign bank_mem[6].dma_write_addr25_to_bank = dma_write_addr25_to_bank6 ;
  assign bank_mem[6].dma_read_addr26_to_bank  = dma_read_addr26_to_bank6  ;
  assign bank_mem[6].dma_write_addr26_to_bank = dma_write_addr26_to_bank6 ;
  assign bank_mem[6].dma_read_addr27_to_bank  = dma_read_addr27_to_bank6  ;
  assign bank_mem[6].dma_write_addr27_to_bank = dma_write_addr27_to_bank6 ;
  assign bank_mem[6].dma_read_addr28_to_bank  = dma_read_addr28_to_bank6  ;
  assign bank_mem[6].dma_write_addr28_to_bank = dma_write_addr28_to_bank6 ;
  assign bank_mem[6].dma_read_addr29_to_bank  = dma_read_addr29_to_bank6  ;
  assign bank_mem[6].dma_write_addr29_to_bank = dma_write_addr29_to_bank6 ;
  assign bank_mem[6].dma_read_addr30_to_bank  = dma_read_addr30_to_bank6  ;
  assign bank_mem[6].dma_write_addr30_to_bank = dma_write_addr30_to_bank6 ;
  assign bank_mem[6].dma_read_addr31_to_bank  = dma_read_addr31_to_bank6  ;
  assign bank_mem[6].dma_write_addr31_to_bank = dma_write_addr31_to_bank6 ;
  assign bank_mem[7].dma_read_addr0_to_bank  = dma_read_addr0_to_bank7  ;
  assign bank_mem[7].dma_write_addr0_to_bank = dma_write_addr0_to_bank7 ;
  assign bank_mem[7].dma_read_addr1_to_bank  = dma_read_addr1_to_bank7  ;
  assign bank_mem[7].dma_write_addr1_to_bank = dma_write_addr1_to_bank7 ;
  assign bank_mem[7].dma_read_addr2_to_bank  = dma_read_addr2_to_bank7  ;
  assign bank_mem[7].dma_write_addr2_to_bank = dma_write_addr2_to_bank7 ;
  assign bank_mem[7].dma_read_addr3_to_bank  = dma_read_addr3_to_bank7  ;
  assign bank_mem[7].dma_write_addr3_to_bank = dma_write_addr3_to_bank7 ;
  assign bank_mem[7].dma_read_addr4_to_bank  = dma_read_addr4_to_bank7  ;
  assign bank_mem[7].dma_write_addr4_to_bank = dma_write_addr4_to_bank7 ;
  assign bank_mem[7].dma_read_addr5_to_bank  = dma_read_addr5_to_bank7  ;
  assign bank_mem[7].dma_write_addr5_to_bank = dma_write_addr5_to_bank7 ;
  assign bank_mem[7].dma_read_addr6_to_bank  = dma_read_addr6_to_bank7  ;
  assign bank_mem[7].dma_write_addr6_to_bank = dma_write_addr6_to_bank7 ;
  assign bank_mem[7].dma_read_addr7_to_bank  = dma_read_addr7_to_bank7  ;
  assign bank_mem[7].dma_write_addr7_to_bank = dma_write_addr7_to_bank7 ;
  assign bank_mem[7].dma_read_addr8_to_bank  = dma_read_addr8_to_bank7  ;
  assign bank_mem[7].dma_write_addr8_to_bank = dma_write_addr8_to_bank7 ;
  assign bank_mem[7].dma_read_addr9_to_bank  = dma_read_addr9_to_bank7  ;
  assign bank_mem[7].dma_write_addr9_to_bank = dma_write_addr9_to_bank7 ;
  assign bank_mem[7].dma_read_addr10_to_bank  = dma_read_addr10_to_bank7  ;
  assign bank_mem[7].dma_write_addr10_to_bank = dma_write_addr10_to_bank7 ;
  assign bank_mem[7].dma_read_addr11_to_bank  = dma_read_addr11_to_bank7  ;
  assign bank_mem[7].dma_write_addr11_to_bank = dma_write_addr11_to_bank7 ;
  assign bank_mem[7].dma_read_addr12_to_bank  = dma_read_addr12_to_bank7  ;
  assign bank_mem[7].dma_write_addr12_to_bank = dma_write_addr12_to_bank7 ;
  assign bank_mem[7].dma_read_addr13_to_bank  = dma_read_addr13_to_bank7  ;
  assign bank_mem[7].dma_write_addr13_to_bank = dma_write_addr13_to_bank7 ;
  assign bank_mem[7].dma_read_addr14_to_bank  = dma_read_addr14_to_bank7  ;
  assign bank_mem[7].dma_write_addr14_to_bank = dma_write_addr14_to_bank7 ;
  assign bank_mem[7].dma_read_addr15_to_bank  = dma_read_addr15_to_bank7  ;
  assign bank_mem[7].dma_write_addr15_to_bank = dma_write_addr15_to_bank7 ;
  assign bank_mem[7].dma_read_addr16_to_bank  = dma_read_addr16_to_bank7  ;
  assign bank_mem[7].dma_write_addr16_to_bank = dma_write_addr16_to_bank7 ;
  assign bank_mem[7].dma_read_addr17_to_bank  = dma_read_addr17_to_bank7  ;
  assign bank_mem[7].dma_write_addr17_to_bank = dma_write_addr17_to_bank7 ;
  assign bank_mem[7].dma_read_addr18_to_bank  = dma_read_addr18_to_bank7  ;
  assign bank_mem[7].dma_write_addr18_to_bank = dma_write_addr18_to_bank7 ;
  assign bank_mem[7].dma_read_addr19_to_bank  = dma_read_addr19_to_bank7  ;
  assign bank_mem[7].dma_write_addr19_to_bank = dma_write_addr19_to_bank7 ;
  assign bank_mem[7].dma_read_addr20_to_bank  = dma_read_addr20_to_bank7  ;
  assign bank_mem[7].dma_write_addr20_to_bank = dma_write_addr20_to_bank7 ;
  assign bank_mem[7].dma_read_addr21_to_bank  = dma_read_addr21_to_bank7  ;
  assign bank_mem[7].dma_write_addr21_to_bank = dma_write_addr21_to_bank7 ;
  assign bank_mem[7].dma_read_addr22_to_bank  = dma_read_addr22_to_bank7  ;
  assign bank_mem[7].dma_write_addr22_to_bank = dma_write_addr22_to_bank7 ;
  assign bank_mem[7].dma_read_addr23_to_bank  = dma_read_addr23_to_bank7  ;
  assign bank_mem[7].dma_write_addr23_to_bank = dma_write_addr23_to_bank7 ;
  assign bank_mem[7].dma_read_addr24_to_bank  = dma_read_addr24_to_bank7  ;
  assign bank_mem[7].dma_write_addr24_to_bank = dma_write_addr24_to_bank7 ;
  assign bank_mem[7].dma_read_addr25_to_bank  = dma_read_addr25_to_bank7  ;
  assign bank_mem[7].dma_write_addr25_to_bank = dma_write_addr25_to_bank7 ;
  assign bank_mem[7].dma_read_addr26_to_bank  = dma_read_addr26_to_bank7  ;
  assign bank_mem[7].dma_write_addr26_to_bank = dma_write_addr26_to_bank7 ;
  assign bank_mem[7].dma_read_addr27_to_bank  = dma_read_addr27_to_bank7  ;
  assign bank_mem[7].dma_write_addr27_to_bank = dma_write_addr27_to_bank7 ;
  assign bank_mem[7].dma_read_addr28_to_bank  = dma_read_addr28_to_bank7  ;
  assign bank_mem[7].dma_write_addr28_to_bank = dma_write_addr28_to_bank7 ;
  assign bank_mem[7].dma_read_addr29_to_bank  = dma_read_addr29_to_bank7  ;
  assign bank_mem[7].dma_write_addr29_to_bank = dma_write_addr29_to_bank7 ;
  assign bank_mem[7].dma_read_addr30_to_bank  = dma_read_addr30_to_bank7  ;
  assign bank_mem[7].dma_write_addr30_to_bank = dma_write_addr30_to_bank7 ;
  assign bank_mem[7].dma_read_addr31_to_bank  = dma_read_addr31_to_bank7  ;
  assign bank_mem[7].dma_write_addr31_to_bank = dma_write_addr31_to_bank7 ;
  assign bank_mem[8].dma_read_addr0_to_bank  = dma_read_addr0_to_bank8  ;
  assign bank_mem[8].dma_write_addr0_to_bank = dma_write_addr0_to_bank8 ;
  assign bank_mem[8].dma_read_addr1_to_bank  = dma_read_addr1_to_bank8  ;
  assign bank_mem[8].dma_write_addr1_to_bank = dma_write_addr1_to_bank8 ;
  assign bank_mem[8].dma_read_addr2_to_bank  = dma_read_addr2_to_bank8  ;
  assign bank_mem[8].dma_write_addr2_to_bank = dma_write_addr2_to_bank8 ;
  assign bank_mem[8].dma_read_addr3_to_bank  = dma_read_addr3_to_bank8  ;
  assign bank_mem[8].dma_write_addr3_to_bank = dma_write_addr3_to_bank8 ;
  assign bank_mem[8].dma_read_addr4_to_bank  = dma_read_addr4_to_bank8  ;
  assign bank_mem[8].dma_write_addr4_to_bank = dma_write_addr4_to_bank8 ;
  assign bank_mem[8].dma_read_addr5_to_bank  = dma_read_addr5_to_bank8  ;
  assign bank_mem[8].dma_write_addr5_to_bank = dma_write_addr5_to_bank8 ;
  assign bank_mem[8].dma_read_addr6_to_bank  = dma_read_addr6_to_bank8  ;
  assign bank_mem[8].dma_write_addr6_to_bank = dma_write_addr6_to_bank8 ;
  assign bank_mem[8].dma_read_addr7_to_bank  = dma_read_addr7_to_bank8  ;
  assign bank_mem[8].dma_write_addr7_to_bank = dma_write_addr7_to_bank8 ;
  assign bank_mem[8].dma_read_addr8_to_bank  = dma_read_addr8_to_bank8  ;
  assign bank_mem[8].dma_write_addr8_to_bank = dma_write_addr8_to_bank8 ;
  assign bank_mem[8].dma_read_addr9_to_bank  = dma_read_addr9_to_bank8  ;
  assign bank_mem[8].dma_write_addr9_to_bank = dma_write_addr9_to_bank8 ;
  assign bank_mem[8].dma_read_addr10_to_bank  = dma_read_addr10_to_bank8  ;
  assign bank_mem[8].dma_write_addr10_to_bank = dma_write_addr10_to_bank8 ;
  assign bank_mem[8].dma_read_addr11_to_bank  = dma_read_addr11_to_bank8  ;
  assign bank_mem[8].dma_write_addr11_to_bank = dma_write_addr11_to_bank8 ;
  assign bank_mem[8].dma_read_addr12_to_bank  = dma_read_addr12_to_bank8  ;
  assign bank_mem[8].dma_write_addr12_to_bank = dma_write_addr12_to_bank8 ;
  assign bank_mem[8].dma_read_addr13_to_bank  = dma_read_addr13_to_bank8  ;
  assign bank_mem[8].dma_write_addr13_to_bank = dma_write_addr13_to_bank8 ;
  assign bank_mem[8].dma_read_addr14_to_bank  = dma_read_addr14_to_bank8  ;
  assign bank_mem[8].dma_write_addr14_to_bank = dma_write_addr14_to_bank8 ;
  assign bank_mem[8].dma_read_addr15_to_bank  = dma_read_addr15_to_bank8  ;
  assign bank_mem[8].dma_write_addr15_to_bank = dma_write_addr15_to_bank8 ;
  assign bank_mem[8].dma_read_addr16_to_bank  = dma_read_addr16_to_bank8  ;
  assign bank_mem[8].dma_write_addr16_to_bank = dma_write_addr16_to_bank8 ;
  assign bank_mem[8].dma_read_addr17_to_bank  = dma_read_addr17_to_bank8  ;
  assign bank_mem[8].dma_write_addr17_to_bank = dma_write_addr17_to_bank8 ;
  assign bank_mem[8].dma_read_addr18_to_bank  = dma_read_addr18_to_bank8  ;
  assign bank_mem[8].dma_write_addr18_to_bank = dma_write_addr18_to_bank8 ;
  assign bank_mem[8].dma_read_addr19_to_bank  = dma_read_addr19_to_bank8  ;
  assign bank_mem[8].dma_write_addr19_to_bank = dma_write_addr19_to_bank8 ;
  assign bank_mem[8].dma_read_addr20_to_bank  = dma_read_addr20_to_bank8  ;
  assign bank_mem[8].dma_write_addr20_to_bank = dma_write_addr20_to_bank8 ;
  assign bank_mem[8].dma_read_addr21_to_bank  = dma_read_addr21_to_bank8  ;
  assign bank_mem[8].dma_write_addr21_to_bank = dma_write_addr21_to_bank8 ;
  assign bank_mem[8].dma_read_addr22_to_bank  = dma_read_addr22_to_bank8  ;
  assign bank_mem[8].dma_write_addr22_to_bank = dma_write_addr22_to_bank8 ;
  assign bank_mem[8].dma_read_addr23_to_bank  = dma_read_addr23_to_bank8  ;
  assign bank_mem[8].dma_write_addr23_to_bank = dma_write_addr23_to_bank8 ;
  assign bank_mem[8].dma_read_addr24_to_bank  = dma_read_addr24_to_bank8  ;
  assign bank_mem[8].dma_write_addr24_to_bank = dma_write_addr24_to_bank8 ;
  assign bank_mem[8].dma_read_addr25_to_bank  = dma_read_addr25_to_bank8  ;
  assign bank_mem[8].dma_write_addr25_to_bank = dma_write_addr25_to_bank8 ;
  assign bank_mem[8].dma_read_addr26_to_bank  = dma_read_addr26_to_bank8  ;
  assign bank_mem[8].dma_write_addr26_to_bank = dma_write_addr26_to_bank8 ;
  assign bank_mem[8].dma_read_addr27_to_bank  = dma_read_addr27_to_bank8  ;
  assign bank_mem[8].dma_write_addr27_to_bank = dma_write_addr27_to_bank8 ;
  assign bank_mem[8].dma_read_addr28_to_bank  = dma_read_addr28_to_bank8  ;
  assign bank_mem[8].dma_write_addr28_to_bank = dma_write_addr28_to_bank8 ;
  assign bank_mem[8].dma_read_addr29_to_bank  = dma_read_addr29_to_bank8  ;
  assign bank_mem[8].dma_write_addr29_to_bank = dma_write_addr29_to_bank8 ;
  assign bank_mem[8].dma_read_addr30_to_bank  = dma_read_addr30_to_bank8  ;
  assign bank_mem[8].dma_write_addr30_to_bank = dma_write_addr30_to_bank8 ;
  assign bank_mem[8].dma_read_addr31_to_bank  = dma_read_addr31_to_bank8  ;
  assign bank_mem[8].dma_write_addr31_to_bank = dma_write_addr31_to_bank8 ;
  assign bank_mem[9].dma_read_addr0_to_bank  = dma_read_addr0_to_bank9  ;
  assign bank_mem[9].dma_write_addr0_to_bank = dma_write_addr0_to_bank9 ;
  assign bank_mem[9].dma_read_addr1_to_bank  = dma_read_addr1_to_bank9  ;
  assign bank_mem[9].dma_write_addr1_to_bank = dma_write_addr1_to_bank9 ;
  assign bank_mem[9].dma_read_addr2_to_bank  = dma_read_addr2_to_bank9  ;
  assign bank_mem[9].dma_write_addr2_to_bank = dma_write_addr2_to_bank9 ;
  assign bank_mem[9].dma_read_addr3_to_bank  = dma_read_addr3_to_bank9  ;
  assign bank_mem[9].dma_write_addr3_to_bank = dma_write_addr3_to_bank9 ;
  assign bank_mem[9].dma_read_addr4_to_bank  = dma_read_addr4_to_bank9  ;
  assign bank_mem[9].dma_write_addr4_to_bank = dma_write_addr4_to_bank9 ;
  assign bank_mem[9].dma_read_addr5_to_bank  = dma_read_addr5_to_bank9  ;
  assign bank_mem[9].dma_write_addr5_to_bank = dma_write_addr5_to_bank9 ;
  assign bank_mem[9].dma_read_addr6_to_bank  = dma_read_addr6_to_bank9  ;
  assign bank_mem[9].dma_write_addr6_to_bank = dma_write_addr6_to_bank9 ;
  assign bank_mem[9].dma_read_addr7_to_bank  = dma_read_addr7_to_bank9  ;
  assign bank_mem[9].dma_write_addr7_to_bank = dma_write_addr7_to_bank9 ;
  assign bank_mem[9].dma_read_addr8_to_bank  = dma_read_addr8_to_bank9  ;
  assign bank_mem[9].dma_write_addr8_to_bank = dma_write_addr8_to_bank9 ;
  assign bank_mem[9].dma_read_addr9_to_bank  = dma_read_addr9_to_bank9  ;
  assign bank_mem[9].dma_write_addr9_to_bank = dma_write_addr9_to_bank9 ;
  assign bank_mem[9].dma_read_addr10_to_bank  = dma_read_addr10_to_bank9  ;
  assign bank_mem[9].dma_write_addr10_to_bank = dma_write_addr10_to_bank9 ;
  assign bank_mem[9].dma_read_addr11_to_bank  = dma_read_addr11_to_bank9  ;
  assign bank_mem[9].dma_write_addr11_to_bank = dma_write_addr11_to_bank9 ;
  assign bank_mem[9].dma_read_addr12_to_bank  = dma_read_addr12_to_bank9  ;
  assign bank_mem[9].dma_write_addr12_to_bank = dma_write_addr12_to_bank9 ;
  assign bank_mem[9].dma_read_addr13_to_bank  = dma_read_addr13_to_bank9  ;
  assign bank_mem[9].dma_write_addr13_to_bank = dma_write_addr13_to_bank9 ;
  assign bank_mem[9].dma_read_addr14_to_bank  = dma_read_addr14_to_bank9  ;
  assign bank_mem[9].dma_write_addr14_to_bank = dma_write_addr14_to_bank9 ;
  assign bank_mem[9].dma_read_addr15_to_bank  = dma_read_addr15_to_bank9  ;
  assign bank_mem[9].dma_write_addr15_to_bank = dma_write_addr15_to_bank9 ;
  assign bank_mem[9].dma_read_addr16_to_bank  = dma_read_addr16_to_bank9  ;
  assign bank_mem[9].dma_write_addr16_to_bank = dma_write_addr16_to_bank9 ;
  assign bank_mem[9].dma_read_addr17_to_bank  = dma_read_addr17_to_bank9  ;
  assign bank_mem[9].dma_write_addr17_to_bank = dma_write_addr17_to_bank9 ;
  assign bank_mem[9].dma_read_addr18_to_bank  = dma_read_addr18_to_bank9  ;
  assign bank_mem[9].dma_write_addr18_to_bank = dma_write_addr18_to_bank9 ;
  assign bank_mem[9].dma_read_addr19_to_bank  = dma_read_addr19_to_bank9  ;
  assign bank_mem[9].dma_write_addr19_to_bank = dma_write_addr19_to_bank9 ;
  assign bank_mem[9].dma_read_addr20_to_bank  = dma_read_addr20_to_bank9  ;
  assign bank_mem[9].dma_write_addr20_to_bank = dma_write_addr20_to_bank9 ;
  assign bank_mem[9].dma_read_addr21_to_bank  = dma_read_addr21_to_bank9  ;
  assign bank_mem[9].dma_write_addr21_to_bank = dma_write_addr21_to_bank9 ;
  assign bank_mem[9].dma_read_addr22_to_bank  = dma_read_addr22_to_bank9  ;
  assign bank_mem[9].dma_write_addr22_to_bank = dma_write_addr22_to_bank9 ;
  assign bank_mem[9].dma_read_addr23_to_bank  = dma_read_addr23_to_bank9  ;
  assign bank_mem[9].dma_write_addr23_to_bank = dma_write_addr23_to_bank9 ;
  assign bank_mem[9].dma_read_addr24_to_bank  = dma_read_addr24_to_bank9  ;
  assign bank_mem[9].dma_write_addr24_to_bank = dma_write_addr24_to_bank9 ;
  assign bank_mem[9].dma_read_addr25_to_bank  = dma_read_addr25_to_bank9  ;
  assign bank_mem[9].dma_write_addr25_to_bank = dma_write_addr25_to_bank9 ;
  assign bank_mem[9].dma_read_addr26_to_bank  = dma_read_addr26_to_bank9  ;
  assign bank_mem[9].dma_write_addr26_to_bank = dma_write_addr26_to_bank9 ;
  assign bank_mem[9].dma_read_addr27_to_bank  = dma_read_addr27_to_bank9  ;
  assign bank_mem[9].dma_write_addr27_to_bank = dma_write_addr27_to_bank9 ;
  assign bank_mem[9].dma_read_addr28_to_bank  = dma_read_addr28_to_bank9  ;
  assign bank_mem[9].dma_write_addr28_to_bank = dma_write_addr28_to_bank9 ;
  assign bank_mem[9].dma_read_addr29_to_bank  = dma_read_addr29_to_bank9  ;
  assign bank_mem[9].dma_write_addr29_to_bank = dma_write_addr29_to_bank9 ;
  assign bank_mem[9].dma_read_addr30_to_bank  = dma_read_addr30_to_bank9  ;
  assign bank_mem[9].dma_write_addr30_to_bank = dma_write_addr30_to_bank9 ;
  assign bank_mem[9].dma_read_addr31_to_bank  = dma_read_addr31_to_bank9  ;
  assign bank_mem[9].dma_write_addr31_to_bank = dma_write_addr31_to_bank9 ;
  assign bank_mem[10].dma_read_addr0_to_bank  = dma_read_addr0_to_bank10  ;
  assign bank_mem[10].dma_write_addr0_to_bank = dma_write_addr0_to_bank10 ;
  assign bank_mem[10].dma_read_addr1_to_bank  = dma_read_addr1_to_bank10  ;
  assign bank_mem[10].dma_write_addr1_to_bank = dma_write_addr1_to_bank10 ;
  assign bank_mem[10].dma_read_addr2_to_bank  = dma_read_addr2_to_bank10  ;
  assign bank_mem[10].dma_write_addr2_to_bank = dma_write_addr2_to_bank10 ;
  assign bank_mem[10].dma_read_addr3_to_bank  = dma_read_addr3_to_bank10  ;
  assign bank_mem[10].dma_write_addr3_to_bank = dma_write_addr3_to_bank10 ;
  assign bank_mem[10].dma_read_addr4_to_bank  = dma_read_addr4_to_bank10  ;
  assign bank_mem[10].dma_write_addr4_to_bank = dma_write_addr4_to_bank10 ;
  assign bank_mem[10].dma_read_addr5_to_bank  = dma_read_addr5_to_bank10  ;
  assign bank_mem[10].dma_write_addr5_to_bank = dma_write_addr5_to_bank10 ;
  assign bank_mem[10].dma_read_addr6_to_bank  = dma_read_addr6_to_bank10  ;
  assign bank_mem[10].dma_write_addr6_to_bank = dma_write_addr6_to_bank10 ;
  assign bank_mem[10].dma_read_addr7_to_bank  = dma_read_addr7_to_bank10  ;
  assign bank_mem[10].dma_write_addr7_to_bank = dma_write_addr7_to_bank10 ;
  assign bank_mem[10].dma_read_addr8_to_bank  = dma_read_addr8_to_bank10  ;
  assign bank_mem[10].dma_write_addr8_to_bank = dma_write_addr8_to_bank10 ;
  assign bank_mem[10].dma_read_addr9_to_bank  = dma_read_addr9_to_bank10  ;
  assign bank_mem[10].dma_write_addr9_to_bank = dma_write_addr9_to_bank10 ;
  assign bank_mem[10].dma_read_addr10_to_bank  = dma_read_addr10_to_bank10  ;
  assign bank_mem[10].dma_write_addr10_to_bank = dma_write_addr10_to_bank10 ;
  assign bank_mem[10].dma_read_addr11_to_bank  = dma_read_addr11_to_bank10  ;
  assign bank_mem[10].dma_write_addr11_to_bank = dma_write_addr11_to_bank10 ;
  assign bank_mem[10].dma_read_addr12_to_bank  = dma_read_addr12_to_bank10  ;
  assign bank_mem[10].dma_write_addr12_to_bank = dma_write_addr12_to_bank10 ;
  assign bank_mem[10].dma_read_addr13_to_bank  = dma_read_addr13_to_bank10  ;
  assign bank_mem[10].dma_write_addr13_to_bank = dma_write_addr13_to_bank10 ;
  assign bank_mem[10].dma_read_addr14_to_bank  = dma_read_addr14_to_bank10  ;
  assign bank_mem[10].dma_write_addr14_to_bank = dma_write_addr14_to_bank10 ;
  assign bank_mem[10].dma_read_addr15_to_bank  = dma_read_addr15_to_bank10  ;
  assign bank_mem[10].dma_write_addr15_to_bank = dma_write_addr15_to_bank10 ;
  assign bank_mem[10].dma_read_addr16_to_bank  = dma_read_addr16_to_bank10  ;
  assign bank_mem[10].dma_write_addr16_to_bank = dma_write_addr16_to_bank10 ;
  assign bank_mem[10].dma_read_addr17_to_bank  = dma_read_addr17_to_bank10  ;
  assign bank_mem[10].dma_write_addr17_to_bank = dma_write_addr17_to_bank10 ;
  assign bank_mem[10].dma_read_addr18_to_bank  = dma_read_addr18_to_bank10  ;
  assign bank_mem[10].dma_write_addr18_to_bank = dma_write_addr18_to_bank10 ;
  assign bank_mem[10].dma_read_addr19_to_bank  = dma_read_addr19_to_bank10  ;
  assign bank_mem[10].dma_write_addr19_to_bank = dma_write_addr19_to_bank10 ;
  assign bank_mem[10].dma_read_addr20_to_bank  = dma_read_addr20_to_bank10  ;
  assign bank_mem[10].dma_write_addr20_to_bank = dma_write_addr20_to_bank10 ;
  assign bank_mem[10].dma_read_addr21_to_bank  = dma_read_addr21_to_bank10  ;
  assign bank_mem[10].dma_write_addr21_to_bank = dma_write_addr21_to_bank10 ;
  assign bank_mem[10].dma_read_addr22_to_bank  = dma_read_addr22_to_bank10  ;
  assign bank_mem[10].dma_write_addr22_to_bank = dma_write_addr22_to_bank10 ;
  assign bank_mem[10].dma_read_addr23_to_bank  = dma_read_addr23_to_bank10  ;
  assign bank_mem[10].dma_write_addr23_to_bank = dma_write_addr23_to_bank10 ;
  assign bank_mem[10].dma_read_addr24_to_bank  = dma_read_addr24_to_bank10  ;
  assign bank_mem[10].dma_write_addr24_to_bank = dma_write_addr24_to_bank10 ;
  assign bank_mem[10].dma_read_addr25_to_bank  = dma_read_addr25_to_bank10  ;
  assign bank_mem[10].dma_write_addr25_to_bank = dma_write_addr25_to_bank10 ;
  assign bank_mem[10].dma_read_addr26_to_bank  = dma_read_addr26_to_bank10  ;
  assign bank_mem[10].dma_write_addr26_to_bank = dma_write_addr26_to_bank10 ;
  assign bank_mem[10].dma_read_addr27_to_bank  = dma_read_addr27_to_bank10  ;
  assign bank_mem[10].dma_write_addr27_to_bank = dma_write_addr27_to_bank10 ;
  assign bank_mem[10].dma_read_addr28_to_bank  = dma_read_addr28_to_bank10  ;
  assign bank_mem[10].dma_write_addr28_to_bank = dma_write_addr28_to_bank10 ;
  assign bank_mem[10].dma_read_addr29_to_bank  = dma_read_addr29_to_bank10  ;
  assign bank_mem[10].dma_write_addr29_to_bank = dma_write_addr29_to_bank10 ;
  assign bank_mem[10].dma_read_addr30_to_bank  = dma_read_addr30_to_bank10  ;
  assign bank_mem[10].dma_write_addr30_to_bank = dma_write_addr30_to_bank10 ;
  assign bank_mem[10].dma_read_addr31_to_bank  = dma_read_addr31_to_bank10  ;
  assign bank_mem[10].dma_write_addr31_to_bank = dma_write_addr31_to_bank10 ;
  assign bank_mem[11].dma_read_addr0_to_bank  = dma_read_addr0_to_bank11  ;
  assign bank_mem[11].dma_write_addr0_to_bank = dma_write_addr0_to_bank11 ;
  assign bank_mem[11].dma_read_addr1_to_bank  = dma_read_addr1_to_bank11  ;
  assign bank_mem[11].dma_write_addr1_to_bank = dma_write_addr1_to_bank11 ;
  assign bank_mem[11].dma_read_addr2_to_bank  = dma_read_addr2_to_bank11  ;
  assign bank_mem[11].dma_write_addr2_to_bank = dma_write_addr2_to_bank11 ;
  assign bank_mem[11].dma_read_addr3_to_bank  = dma_read_addr3_to_bank11  ;
  assign bank_mem[11].dma_write_addr3_to_bank = dma_write_addr3_to_bank11 ;
  assign bank_mem[11].dma_read_addr4_to_bank  = dma_read_addr4_to_bank11  ;
  assign bank_mem[11].dma_write_addr4_to_bank = dma_write_addr4_to_bank11 ;
  assign bank_mem[11].dma_read_addr5_to_bank  = dma_read_addr5_to_bank11  ;
  assign bank_mem[11].dma_write_addr5_to_bank = dma_write_addr5_to_bank11 ;
  assign bank_mem[11].dma_read_addr6_to_bank  = dma_read_addr6_to_bank11  ;
  assign bank_mem[11].dma_write_addr6_to_bank = dma_write_addr6_to_bank11 ;
  assign bank_mem[11].dma_read_addr7_to_bank  = dma_read_addr7_to_bank11  ;
  assign bank_mem[11].dma_write_addr7_to_bank = dma_write_addr7_to_bank11 ;
  assign bank_mem[11].dma_read_addr8_to_bank  = dma_read_addr8_to_bank11  ;
  assign bank_mem[11].dma_write_addr8_to_bank = dma_write_addr8_to_bank11 ;
  assign bank_mem[11].dma_read_addr9_to_bank  = dma_read_addr9_to_bank11  ;
  assign bank_mem[11].dma_write_addr9_to_bank = dma_write_addr9_to_bank11 ;
  assign bank_mem[11].dma_read_addr10_to_bank  = dma_read_addr10_to_bank11  ;
  assign bank_mem[11].dma_write_addr10_to_bank = dma_write_addr10_to_bank11 ;
  assign bank_mem[11].dma_read_addr11_to_bank  = dma_read_addr11_to_bank11  ;
  assign bank_mem[11].dma_write_addr11_to_bank = dma_write_addr11_to_bank11 ;
  assign bank_mem[11].dma_read_addr12_to_bank  = dma_read_addr12_to_bank11  ;
  assign bank_mem[11].dma_write_addr12_to_bank = dma_write_addr12_to_bank11 ;
  assign bank_mem[11].dma_read_addr13_to_bank  = dma_read_addr13_to_bank11  ;
  assign bank_mem[11].dma_write_addr13_to_bank = dma_write_addr13_to_bank11 ;
  assign bank_mem[11].dma_read_addr14_to_bank  = dma_read_addr14_to_bank11  ;
  assign bank_mem[11].dma_write_addr14_to_bank = dma_write_addr14_to_bank11 ;
  assign bank_mem[11].dma_read_addr15_to_bank  = dma_read_addr15_to_bank11  ;
  assign bank_mem[11].dma_write_addr15_to_bank = dma_write_addr15_to_bank11 ;
  assign bank_mem[11].dma_read_addr16_to_bank  = dma_read_addr16_to_bank11  ;
  assign bank_mem[11].dma_write_addr16_to_bank = dma_write_addr16_to_bank11 ;
  assign bank_mem[11].dma_read_addr17_to_bank  = dma_read_addr17_to_bank11  ;
  assign bank_mem[11].dma_write_addr17_to_bank = dma_write_addr17_to_bank11 ;
  assign bank_mem[11].dma_read_addr18_to_bank  = dma_read_addr18_to_bank11  ;
  assign bank_mem[11].dma_write_addr18_to_bank = dma_write_addr18_to_bank11 ;
  assign bank_mem[11].dma_read_addr19_to_bank  = dma_read_addr19_to_bank11  ;
  assign bank_mem[11].dma_write_addr19_to_bank = dma_write_addr19_to_bank11 ;
  assign bank_mem[11].dma_read_addr20_to_bank  = dma_read_addr20_to_bank11  ;
  assign bank_mem[11].dma_write_addr20_to_bank = dma_write_addr20_to_bank11 ;
  assign bank_mem[11].dma_read_addr21_to_bank  = dma_read_addr21_to_bank11  ;
  assign bank_mem[11].dma_write_addr21_to_bank = dma_write_addr21_to_bank11 ;
  assign bank_mem[11].dma_read_addr22_to_bank  = dma_read_addr22_to_bank11  ;
  assign bank_mem[11].dma_write_addr22_to_bank = dma_write_addr22_to_bank11 ;
  assign bank_mem[11].dma_read_addr23_to_bank  = dma_read_addr23_to_bank11  ;
  assign bank_mem[11].dma_write_addr23_to_bank = dma_write_addr23_to_bank11 ;
  assign bank_mem[11].dma_read_addr24_to_bank  = dma_read_addr24_to_bank11  ;
  assign bank_mem[11].dma_write_addr24_to_bank = dma_write_addr24_to_bank11 ;
  assign bank_mem[11].dma_read_addr25_to_bank  = dma_read_addr25_to_bank11  ;
  assign bank_mem[11].dma_write_addr25_to_bank = dma_write_addr25_to_bank11 ;
  assign bank_mem[11].dma_read_addr26_to_bank  = dma_read_addr26_to_bank11  ;
  assign bank_mem[11].dma_write_addr26_to_bank = dma_write_addr26_to_bank11 ;
  assign bank_mem[11].dma_read_addr27_to_bank  = dma_read_addr27_to_bank11  ;
  assign bank_mem[11].dma_write_addr27_to_bank = dma_write_addr27_to_bank11 ;
  assign bank_mem[11].dma_read_addr28_to_bank  = dma_read_addr28_to_bank11  ;
  assign bank_mem[11].dma_write_addr28_to_bank = dma_write_addr28_to_bank11 ;
  assign bank_mem[11].dma_read_addr29_to_bank  = dma_read_addr29_to_bank11  ;
  assign bank_mem[11].dma_write_addr29_to_bank = dma_write_addr29_to_bank11 ;
  assign bank_mem[11].dma_read_addr30_to_bank  = dma_read_addr30_to_bank11  ;
  assign bank_mem[11].dma_write_addr30_to_bank = dma_write_addr30_to_bank11 ;
  assign bank_mem[11].dma_read_addr31_to_bank  = dma_read_addr31_to_bank11  ;
  assign bank_mem[11].dma_write_addr31_to_bank = dma_write_addr31_to_bank11 ;
  assign bank_mem[12].dma_read_addr0_to_bank  = dma_read_addr0_to_bank12  ;
  assign bank_mem[12].dma_write_addr0_to_bank = dma_write_addr0_to_bank12 ;
  assign bank_mem[12].dma_read_addr1_to_bank  = dma_read_addr1_to_bank12  ;
  assign bank_mem[12].dma_write_addr1_to_bank = dma_write_addr1_to_bank12 ;
  assign bank_mem[12].dma_read_addr2_to_bank  = dma_read_addr2_to_bank12  ;
  assign bank_mem[12].dma_write_addr2_to_bank = dma_write_addr2_to_bank12 ;
  assign bank_mem[12].dma_read_addr3_to_bank  = dma_read_addr3_to_bank12  ;
  assign bank_mem[12].dma_write_addr3_to_bank = dma_write_addr3_to_bank12 ;
  assign bank_mem[12].dma_read_addr4_to_bank  = dma_read_addr4_to_bank12  ;
  assign bank_mem[12].dma_write_addr4_to_bank = dma_write_addr4_to_bank12 ;
  assign bank_mem[12].dma_read_addr5_to_bank  = dma_read_addr5_to_bank12  ;
  assign bank_mem[12].dma_write_addr5_to_bank = dma_write_addr5_to_bank12 ;
  assign bank_mem[12].dma_read_addr6_to_bank  = dma_read_addr6_to_bank12  ;
  assign bank_mem[12].dma_write_addr6_to_bank = dma_write_addr6_to_bank12 ;
  assign bank_mem[12].dma_read_addr7_to_bank  = dma_read_addr7_to_bank12  ;
  assign bank_mem[12].dma_write_addr7_to_bank = dma_write_addr7_to_bank12 ;
  assign bank_mem[12].dma_read_addr8_to_bank  = dma_read_addr8_to_bank12  ;
  assign bank_mem[12].dma_write_addr8_to_bank = dma_write_addr8_to_bank12 ;
  assign bank_mem[12].dma_read_addr9_to_bank  = dma_read_addr9_to_bank12  ;
  assign bank_mem[12].dma_write_addr9_to_bank = dma_write_addr9_to_bank12 ;
  assign bank_mem[12].dma_read_addr10_to_bank  = dma_read_addr10_to_bank12  ;
  assign bank_mem[12].dma_write_addr10_to_bank = dma_write_addr10_to_bank12 ;
  assign bank_mem[12].dma_read_addr11_to_bank  = dma_read_addr11_to_bank12  ;
  assign bank_mem[12].dma_write_addr11_to_bank = dma_write_addr11_to_bank12 ;
  assign bank_mem[12].dma_read_addr12_to_bank  = dma_read_addr12_to_bank12  ;
  assign bank_mem[12].dma_write_addr12_to_bank = dma_write_addr12_to_bank12 ;
  assign bank_mem[12].dma_read_addr13_to_bank  = dma_read_addr13_to_bank12  ;
  assign bank_mem[12].dma_write_addr13_to_bank = dma_write_addr13_to_bank12 ;
  assign bank_mem[12].dma_read_addr14_to_bank  = dma_read_addr14_to_bank12  ;
  assign bank_mem[12].dma_write_addr14_to_bank = dma_write_addr14_to_bank12 ;
  assign bank_mem[12].dma_read_addr15_to_bank  = dma_read_addr15_to_bank12  ;
  assign bank_mem[12].dma_write_addr15_to_bank = dma_write_addr15_to_bank12 ;
  assign bank_mem[12].dma_read_addr16_to_bank  = dma_read_addr16_to_bank12  ;
  assign bank_mem[12].dma_write_addr16_to_bank = dma_write_addr16_to_bank12 ;
  assign bank_mem[12].dma_read_addr17_to_bank  = dma_read_addr17_to_bank12  ;
  assign bank_mem[12].dma_write_addr17_to_bank = dma_write_addr17_to_bank12 ;
  assign bank_mem[12].dma_read_addr18_to_bank  = dma_read_addr18_to_bank12  ;
  assign bank_mem[12].dma_write_addr18_to_bank = dma_write_addr18_to_bank12 ;
  assign bank_mem[12].dma_read_addr19_to_bank  = dma_read_addr19_to_bank12  ;
  assign bank_mem[12].dma_write_addr19_to_bank = dma_write_addr19_to_bank12 ;
  assign bank_mem[12].dma_read_addr20_to_bank  = dma_read_addr20_to_bank12  ;
  assign bank_mem[12].dma_write_addr20_to_bank = dma_write_addr20_to_bank12 ;
  assign bank_mem[12].dma_read_addr21_to_bank  = dma_read_addr21_to_bank12  ;
  assign bank_mem[12].dma_write_addr21_to_bank = dma_write_addr21_to_bank12 ;
  assign bank_mem[12].dma_read_addr22_to_bank  = dma_read_addr22_to_bank12  ;
  assign bank_mem[12].dma_write_addr22_to_bank = dma_write_addr22_to_bank12 ;
  assign bank_mem[12].dma_read_addr23_to_bank  = dma_read_addr23_to_bank12  ;
  assign bank_mem[12].dma_write_addr23_to_bank = dma_write_addr23_to_bank12 ;
  assign bank_mem[12].dma_read_addr24_to_bank  = dma_read_addr24_to_bank12  ;
  assign bank_mem[12].dma_write_addr24_to_bank = dma_write_addr24_to_bank12 ;
  assign bank_mem[12].dma_read_addr25_to_bank  = dma_read_addr25_to_bank12  ;
  assign bank_mem[12].dma_write_addr25_to_bank = dma_write_addr25_to_bank12 ;
  assign bank_mem[12].dma_read_addr26_to_bank  = dma_read_addr26_to_bank12  ;
  assign bank_mem[12].dma_write_addr26_to_bank = dma_write_addr26_to_bank12 ;
  assign bank_mem[12].dma_read_addr27_to_bank  = dma_read_addr27_to_bank12  ;
  assign bank_mem[12].dma_write_addr27_to_bank = dma_write_addr27_to_bank12 ;
  assign bank_mem[12].dma_read_addr28_to_bank  = dma_read_addr28_to_bank12  ;
  assign bank_mem[12].dma_write_addr28_to_bank = dma_write_addr28_to_bank12 ;
  assign bank_mem[12].dma_read_addr29_to_bank  = dma_read_addr29_to_bank12  ;
  assign bank_mem[12].dma_write_addr29_to_bank = dma_write_addr29_to_bank12 ;
  assign bank_mem[12].dma_read_addr30_to_bank  = dma_read_addr30_to_bank12  ;
  assign bank_mem[12].dma_write_addr30_to_bank = dma_write_addr30_to_bank12 ;
  assign bank_mem[12].dma_read_addr31_to_bank  = dma_read_addr31_to_bank12  ;
  assign bank_mem[12].dma_write_addr31_to_bank = dma_write_addr31_to_bank12 ;
  assign bank_mem[13].dma_read_addr0_to_bank  = dma_read_addr0_to_bank13  ;
  assign bank_mem[13].dma_write_addr0_to_bank = dma_write_addr0_to_bank13 ;
  assign bank_mem[13].dma_read_addr1_to_bank  = dma_read_addr1_to_bank13  ;
  assign bank_mem[13].dma_write_addr1_to_bank = dma_write_addr1_to_bank13 ;
  assign bank_mem[13].dma_read_addr2_to_bank  = dma_read_addr2_to_bank13  ;
  assign bank_mem[13].dma_write_addr2_to_bank = dma_write_addr2_to_bank13 ;
  assign bank_mem[13].dma_read_addr3_to_bank  = dma_read_addr3_to_bank13  ;
  assign bank_mem[13].dma_write_addr3_to_bank = dma_write_addr3_to_bank13 ;
  assign bank_mem[13].dma_read_addr4_to_bank  = dma_read_addr4_to_bank13  ;
  assign bank_mem[13].dma_write_addr4_to_bank = dma_write_addr4_to_bank13 ;
  assign bank_mem[13].dma_read_addr5_to_bank  = dma_read_addr5_to_bank13  ;
  assign bank_mem[13].dma_write_addr5_to_bank = dma_write_addr5_to_bank13 ;
  assign bank_mem[13].dma_read_addr6_to_bank  = dma_read_addr6_to_bank13  ;
  assign bank_mem[13].dma_write_addr6_to_bank = dma_write_addr6_to_bank13 ;
  assign bank_mem[13].dma_read_addr7_to_bank  = dma_read_addr7_to_bank13  ;
  assign bank_mem[13].dma_write_addr7_to_bank = dma_write_addr7_to_bank13 ;
  assign bank_mem[13].dma_read_addr8_to_bank  = dma_read_addr8_to_bank13  ;
  assign bank_mem[13].dma_write_addr8_to_bank = dma_write_addr8_to_bank13 ;
  assign bank_mem[13].dma_read_addr9_to_bank  = dma_read_addr9_to_bank13  ;
  assign bank_mem[13].dma_write_addr9_to_bank = dma_write_addr9_to_bank13 ;
  assign bank_mem[13].dma_read_addr10_to_bank  = dma_read_addr10_to_bank13  ;
  assign bank_mem[13].dma_write_addr10_to_bank = dma_write_addr10_to_bank13 ;
  assign bank_mem[13].dma_read_addr11_to_bank  = dma_read_addr11_to_bank13  ;
  assign bank_mem[13].dma_write_addr11_to_bank = dma_write_addr11_to_bank13 ;
  assign bank_mem[13].dma_read_addr12_to_bank  = dma_read_addr12_to_bank13  ;
  assign bank_mem[13].dma_write_addr12_to_bank = dma_write_addr12_to_bank13 ;
  assign bank_mem[13].dma_read_addr13_to_bank  = dma_read_addr13_to_bank13  ;
  assign bank_mem[13].dma_write_addr13_to_bank = dma_write_addr13_to_bank13 ;
  assign bank_mem[13].dma_read_addr14_to_bank  = dma_read_addr14_to_bank13  ;
  assign bank_mem[13].dma_write_addr14_to_bank = dma_write_addr14_to_bank13 ;
  assign bank_mem[13].dma_read_addr15_to_bank  = dma_read_addr15_to_bank13  ;
  assign bank_mem[13].dma_write_addr15_to_bank = dma_write_addr15_to_bank13 ;
  assign bank_mem[13].dma_read_addr16_to_bank  = dma_read_addr16_to_bank13  ;
  assign bank_mem[13].dma_write_addr16_to_bank = dma_write_addr16_to_bank13 ;
  assign bank_mem[13].dma_read_addr17_to_bank  = dma_read_addr17_to_bank13  ;
  assign bank_mem[13].dma_write_addr17_to_bank = dma_write_addr17_to_bank13 ;
  assign bank_mem[13].dma_read_addr18_to_bank  = dma_read_addr18_to_bank13  ;
  assign bank_mem[13].dma_write_addr18_to_bank = dma_write_addr18_to_bank13 ;
  assign bank_mem[13].dma_read_addr19_to_bank  = dma_read_addr19_to_bank13  ;
  assign bank_mem[13].dma_write_addr19_to_bank = dma_write_addr19_to_bank13 ;
  assign bank_mem[13].dma_read_addr20_to_bank  = dma_read_addr20_to_bank13  ;
  assign bank_mem[13].dma_write_addr20_to_bank = dma_write_addr20_to_bank13 ;
  assign bank_mem[13].dma_read_addr21_to_bank  = dma_read_addr21_to_bank13  ;
  assign bank_mem[13].dma_write_addr21_to_bank = dma_write_addr21_to_bank13 ;
  assign bank_mem[13].dma_read_addr22_to_bank  = dma_read_addr22_to_bank13  ;
  assign bank_mem[13].dma_write_addr22_to_bank = dma_write_addr22_to_bank13 ;
  assign bank_mem[13].dma_read_addr23_to_bank  = dma_read_addr23_to_bank13  ;
  assign bank_mem[13].dma_write_addr23_to_bank = dma_write_addr23_to_bank13 ;
  assign bank_mem[13].dma_read_addr24_to_bank  = dma_read_addr24_to_bank13  ;
  assign bank_mem[13].dma_write_addr24_to_bank = dma_write_addr24_to_bank13 ;
  assign bank_mem[13].dma_read_addr25_to_bank  = dma_read_addr25_to_bank13  ;
  assign bank_mem[13].dma_write_addr25_to_bank = dma_write_addr25_to_bank13 ;
  assign bank_mem[13].dma_read_addr26_to_bank  = dma_read_addr26_to_bank13  ;
  assign bank_mem[13].dma_write_addr26_to_bank = dma_write_addr26_to_bank13 ;
  assign bank_mem[13].dma_read_addr27_to_bank  = dma_read_addr27_to_bank13  ;
  assign bank_mem[13].dma_write_addr27_to_bank = dma_write_addr27_to_bank13 ;
  assign bank_mem[13].dma_read_addr28_to_bank  = dma_read_addr28_to_bank13  ;
  assign bank_mem[13].dma_write_addr28_to_bank = dma_write_addr28_to_bank13 ;
  assign bank_mem[13].dma_read_addr29_to_bank  = dma_read_addr29_to_bank13  ;
  assign bank_mem[13].dma_write_addr29_to_bank = dma_write_addr29_to_bank13 ;
  assign bank_mem[13].dma_read_addr30_to_bank  = dma_read_addr30_to_bank13  ;
  assign bank_mem[13].dma_write_addr30_to_bank = dma_write_addr30_to_bank13 ;
  assign bank_mem[13].dma_read_addr31_to_bank  = dma_read_addr31_to_bank13  ;
  assign bank_mem[13].dma_write_addr31_to_bank = dma_write_addr31_to_bank13 ;
  assign bank_mem[14].dma_read_addr0_to_bank  = dma_read_addr0_to_bank14  ;
  assign bank_mem[14].dma_write_addr0_to_bank = dma_write_addr0_to_bank14 ;
  assign bank_mem[14].dma_read_addr1_to_bank  = dma_read_addr1_to_bank14  ;
  assign bank_mem[14].dma_write_addr1_to_bank = dma_write_addr1_to_bank14 ;
  assign bank_mem[14].dma_read_addr2_to_bank  = dma_read_addr2_to_bank14  ;
  assign bank_mem[14].dma_write_addr2_to_bank = dma_write_addr2_to_bank14 ;
  assign bank_mem[14].dma_read_addr3_to_bank  = dma_read_addr3_to_bank14  ;
  assign bank_mem[14].dma_write_addr3_to_bank = dma_write_addr3_to_bank14 ;
  assign bank_mem[14].dma_read_addr4_to_bank  = dma_read_addr4_to_bank14  ;
  assign bank_mem[14].dma_write_addr4_to_bank = dma_write_addr4_to_bank14 ;
  assign bank_mem[14].dma_read_addr5_to_bank  = dma_read_addr5_to_bank14  ;
  assign bank_mem[14].dma_write_addr5_to_bank = dma_write_addr5_to_bank14 ;
  assign bank_mem[14].dma_read_addr6_to_bank  = dma_read_addr6_to_bank14  ;
  assign bank_mem[14].dma_write_addr6_to_bank = dma_write_addr6_to_bank14 ;
  assign bank_mem[14].dma_read_addr7_to_bank  = dma_read_addr7_to_bank14  ;
  assign bank_mem[14].dma_write_addr7_to_bank = dma_write_addr7_to_bank14 ;
  assign bank_mem[14].dma_read_addr8_to_bank  = dma_read_addr8_to_bank14  ;
  assign bank_mem[14].dma_write_addr8_to_bank = dma_write_addr8_to_bank14 ;
  assign bank_mem[14].dma_read_addr9_to_bank  = dma_read_addr9_to_bank14  ;
  assign bank_mem[14].dma_write_addr9_to_bank = dma_write_addr9_to_bank14 ;
  assign bank_mem[14].dma_read_addr10_to_bank  = dma_read_addr10_to_bank14  ;
  assign bank_mem[14].dma_write_addr10_to_bank = dma_write_addr10_to_bank14 ;
  assign bank_mem[14].dma_read_addr11_to_bank  = dma_read_addr11_to_bank14  ;
  assign bank_mem[14].dma_write_addr11_to_bank = dma_write_addr11_to_bank14 ;
  assign bank_mem[14].dma_read_addr12_to_bank  = dma_read_addr12_to_bank14  ;
  assign bank_mem[14].dma_write_addr12_to_bank = dma_write_addr12_to_bank14 ;
  assign bank_mem[14].dma_read_addr13_to_bank  = dma_read_addr13_to_bank14  ;
  assign bank_mem[14].dma_write_addr13_to_bank = dma_write_addr13_to_bank14 ;
  assign bank_mem[14].dma_read_addr14_to_bank  = dma_read_addr14_to_bank14  ;
  assign bank_mem[14].dma_write_addr14_to_bank = dma_write_addr14_to_bank14 ;
  assign bank_mem[14].dma_read_addr15_to_bank  = dma_read_addr15_to_bank14  ;
  assign bank_mem[14].dma_write_addr15_to_bank = dma_write_addr15_to_bank14 ;
  assign bank_mem[14].dma_read_addr16_to_bank  = dma_read_addr16_to_bank14  ;
  assign bank_mem[14].dma_write_addr16_to_bank = dma_write_addr16_to_bank14 ;
  assign bank_mem[14].dma_read_addr17_to_bank  = dma_read_addr17_to_bank14  ;
  assign bank_mem[14].dma_write_addr17_to_bank = dma_write_addr17_to_bank14 ;
  assign bank_mem[14].dma_read_addr18_to_bank  = dma_read_addr18_to_bank14  ;
  assign bank_mem[14].dma_write_addr18_to_bank = dma_write_addr18_to_bank14 ;
  assign bank_mem[14].dma_read_addr19_to_bank  = dma_read_addr19_to_bank14  ;
  assign bank_mem[14].dma_write_addr19_to_bank = dma_write_addr19_to_bank14 ;
  assign bank_mem[14].dma_read_addr20_to_bank  = dma_read_addr20_to_bank14  ;
  assign bank_mem[14].dma_write_addr20_to_bank = dma_write_addr20_to_bank14 ;
  assign bank_mem[14].dma_read_addr21_to_bank  = dma_read_addr21_to_bank14  ;
  assign bank_mem[14].dma_write_addr21_to_bank = dma_write_addr21_to_bank14 ;
  assign bank_mem[14].dma_read_addr22_to_bank  = dma_read_addr22_to_bank14  ;
  assign bank_mem[14].dma_write_addr22_to_bank = dma_write_addr22_to_bank14 ;
  assign bank_mem[14].dma_read_addr23_to_bank  = dma_read_addr23_to_bank14  ;
  assign bank_mem[14].dma_write_addr23_to_bank = dma_write_addr23_to_bank14 ;
  assign bank_mem[14].dma_read_addr24_to_bank  = dma_read_addr24_to_bank14  ;
  assign bank_mem[14].dma_write_addr24_to_bank = dma_write_addr24_to_bank14 ;
  assign bank_mem[14].dma_read_addr25_to_bank  = dma_read_addr25_to_bank14  ;
  assign bank_mem[14].dma_write_addr25_to_bank = dma_write_addr25_to_bank14 ;
  assign bank_mem[14].dma_read_addr26_to_bank  = dma_read_addr26_to_bank14  ;
  assign bank_mem[14].dma_write_addr26_to_bank = dma_write_addr26_to_bank14 ;
  assign bank_mem[14].dma_read_addr27_to_bank  = dma_read_addr27_to_bank14  ;
  assign bank_mem[14].dma_write_addr27_to_bank = dma_write_addr27_to_bank14 ;
  assign bank_mem[14].dma_read_addr28_to_bank  = dma_read_addr28_to_bank14  ;
  assign bank_mem[14].dma_write_addr28_to_bank = dma_write_addr28_to_bank14 ;
  assign bank_mem[14].dma_read_addr29_to_bank  = dma_read_addr29_to_bank14  ;
  assign bank_mem[14].dma_write_addr29_to_bank = dma_write_addr29_to_bank14 ;
  assign bank_mem[14].dma_read_addr30_to_bank  = dma_read_addr30_to_bank14  ;
  assign bank_mem[14].dma_write_addr30_to_bank = dma_write_addr30_to_bank14 ;
  assign bank_mem[14].dma_read_addr31_to_bank  = dma_read_addr31_to_bank14  ;
  assign bank_mem[14].dma_write_addr31_to_bank = dma_write_addr31_to_bank14 ;
  assign bank_mem[15].dma_read_addr0_to_bank  = dma_read_addr0_to_bank15  ;
  assign bank_mem[15].dma_write_addr0_to_bank = dma_write_addr0_to_bank15 ;
  assign bank_mem[15].dma_read_addr1_to_bank  = dma_read_addr1_to_bank15  ;
  assign bank_mem[15].dma_write_addr1_to_bank = dma_write_addr1_to_bank15 ;
  assign bank_mem[15].dma_read_addr2_to_bank  = dma_read_addr2_to_bank15  ;
  assign bank_mem[15].dma_write_addr2_to_bank = dma_write_addr2_to_bank15 ;
  assign bank_mem[15].dma_read_addr3_to_bank  = dma_read_addr3_to_bank15  ;
  assign bank_mem[15].dma_write_addr3_to_bank = dma_write_addr3_to_bank15 ;
  assign bank_mem[15].dma_read_addr4_to_bank  = dma_read_addr4_to_bank15  ;
  assign bank_mem[15].dma_write_addr4_to_bank = dma_write_addr4_to_bank15 ;
  assign bank_mem[15].dma_read_addr5_to_bank  = dma_read_addr5_to_bank15  ;
  assign bank_mem[15].dma_write_addr5_to_bank = dma_write_addr5_to_bank15 ;
  assign bank_mem[15].dma_read_addr6_to_bank  = dma_read_addr6_to_bank15  ;
  assign bank_mem[15].dma_write_addr6_to_bank = dma_write_addr6_to_bank15 ;
  assign bank_mem[15].dma_read_addr7_to_bank  = dma_read_addr7_to_bank15  ;
  assign bank_mem[15].dma_write_addr7_to_bank = dma_write_addr7_to_bank15 ;
  assign bank_mem[15].dma_read_addr8_to_bank  = dma_read_addr8_to_bank15  ;
  assign bank_mem[15].dma_write_addr8_to_bank = dma_write_addr8_to_bank15 ;
  assign bank_mem[15].dma_read_addr9_to_bank  = dma_read_addr9_to_bank15  ;
  assign bank_mem[15].dma_write_addr9_to_bank = dma_write_addr9_to_bank15 ;
  assign bank_mem[15].dma_read_addr10_to_bank  = dma_read_addr10_to_bank15  ;
  assign bank_mem[15].dma_write_addr10_to_bank = dma_write_addr10_to_bank15 ;
  assign bank_mem[15].dma_read_addr11_to_bank  = dma_read_addr11_to_bank15  ;
  assign bank_mem[15].dma_write_addr11_to_bank = dma_write_addr11_to_bank15 ;
  assign bank_mem[15].dma_read_addr12_to_bank  = dma_read_addr12_to_bank15  ;
  assign bank_mem[15].dma_write_addr12_to_bank = dma_write_addr12_to_bank15 ;
  assign bank_mem[15].dma_read_addr13_to_bank  = dma_read_addr13_to_bank15  ;
  assign bank_mem[15].dma_write_addr13_to_bank = dma_write_addr13_to_bank15 ;
  assign bank_mem[15].dma_read_addr14_to_bank  = dma_read_addr14_to_bank15  ;
  assign bank_mem[15].dma_write_addr14_to_bank = dma_write_addr14_to_bank15 ;
  assign bank_mem[15].dma_read_addr15_to_bank  = dma_read_addr15_to_bank15  ;
  assign bank_mem[15].dma_write_addr15_to_bank = dma_write_addr15_to_bank15 ;
  assign bank_mem[15].dma_read_addr16_to_bank  = dma_read_addr16_to_bank15  ;
  assign bank_mem[15].dma_write_addr16_to_bank = dma_write_addr16_to_bank15 ;
  assign bank_mem[15].dma_read_addr17_to_bank  = dma_read_addr17_to_bank15  ;
  assign bank_mem[15].dma_write_addr17_to_bank = dma_write_addr17_to_bank15 ;
  assign bank_mem[15].dma_read_addr18_to_bank  = dma_read_addr18_to_bank15  ;
  assign bank_mem[15].dma_write_addr18_to_bank = dma_write_addr18_to_bank15 ;
  assign bank_mem[15].dma_read_addr19_to_bank  = dma_read_addr19_to_bank15  ;
  assign bank_mem[15].dma_write_addr19_to_bank = dma_write_addr19_to_bank15 ;
  assign bank_mem[15].dma_read_addr20_to_bank  = dma_read_addr20_to_bank15  ;
  assign bank_mem[15].dma_write_addr20_to_bank = dma_write_addr20_to_bank15 ;
  assign bank_mem[15].dma_read_addr21_to_bank  = dma_read_addr21_to_bank15  ;
  assign bank_mem[15].dma_write_addr21_to_bank = dma_write_addr21_to_bank15 ;
  assign bank_mem[15].dma_read_addr22_to_bank  = dma_read_addr22_to_bank15  ;
  assign bank_mem[15].dma_write_addr22_to_bank = dma_write_addr22_to_bank15 ;
  assign bank_mem[15].dma_read_addr23_to_bank  = dma_read_addr23_to_bank15  ;
  assign bank_mem[15].dma_write_addr23_to_bank = dma_write_addr23_to_bank15 ;
  assign bank_mem[15].dma_read_addr24_to_bank  = dma_read_addr24_to_bank15  ;
  assign bank_mem[15].dma_write_addr24_to_bank = dma_write_addr24_to_bank15 ;
  assign bank_mem[15].dma_read_addr25_to_bank  = dma_read_addr25_to_bank15  ;
  assign bank_mem[15].dma_write_addr25_to_bank = dma_write_addr25_to_bank15 ;
  assign bank_mem[15].dma_read_addr26_to_bank  = dma_read_addr26_to_bank15  ;
  assign bank_mem[15].dma_write_addr26_to_bank = dma_write_addr26_to_bank15 ;
  assign bank_mem[15].dma_read_addr27_to_bank  = dma_read_addr27_to_bank15  ;
  assign bank_mem[15].dma_write_addr27_to_bank = dma_write_addr27_to_bank15 ;
  assign bank_mem[15].dma_read_addr28_to_bank  = dma_read_addr28_to_bank15  ;
  assign bank_mem[15].dma_write_addr28_to_bank = dma_write_addr28_to_bank15 ;
  assign bank_mem[15].dma_read_addr29_to_bank  = dma_read_addr29_to_bank15  ;
  assign bank_mem[15].dma_write_addr29_to_bank = dma_write_addr29_to_bank15 ;
  assign bank_mem[15].dma_read_addr30_to_bank  = dma_read_addr30_to_bank15  ;
  assign bank_mem[15].dma_write_addr30_to_bank = dma_write_addr30_to_bank15 ;
  assign bank_mem[15].dma_read_addr31_to_bank  = dma_read_addr31_to_bank15  ;
  assign bank_mem[15].dma_write_addr31_to_bank = dma_write_addr31_to_bank15 ;
  assign bank_mem[16].dma_read_addr0_to_bank  = dma_read_addr0_to_bank16  ;
  assign bank_mem[16].dma_write_addr0_to_bank = dma_write_addr0_to_bank16 ;
  assign bank_mem[16].dma_read_addr1_to_bank  = dma_read_addr1_to_bank16  ;
  assign bank_mem[16].dma_write_addr1_to_bank = dma_write_addr1_to_bank16 ;
  assign bank_mem[16].dma_read_addr2_to_bank  = dma_read_addr2_to_bank16  ;
  assign bank_mem[16].dma_write_addr2_to_bank = dma_write_addr2_to_bank16 ;
  assign bank_mem[16].dma_read_addr3_to_bank  = dma_read_addr3_to_bank16  ;
  assign bank_mem[16].dma_write_addr3_to_bank = dma_write_addr3_to_bank16 ;
  assign bank_mem[16].dma_read_addr4_to_bank  = dma_read_addr4_to_bank16  ;
  assign bank_mem[16].dma_write_addr4_to_bank = dma_write_addr4_to_bank16 ;
  assign bank_mem[16].dma_read_addr5_to_bank  = dma_read_addr5_to_bank16  ;
  assign bank_mem[16].dma_write_addr5_to_bank = dma_write_addr5_to_bank16 ;
  assign bank_mem[16].dma_read_addr6_to_bank  = dma_read_addr6_to_bank16  ;
  assign bank_mem[16].dma_write_addr6_to_bank = dma_write_addr6_to_bank16 ;
  assign bank_mem[16].dma_read_addr7_to_bank  = dma_read_addr7_to_bank16  ;
  assign bank_mem[16].dma_write_addr7_to_bank = dma_write_addr7_to_bank16 ;
  assign bank_mem[16].dma_read_addr8_to_bank  = dma_read_addr8_to_bank16  ;
  assign bank_mem[16].dma_write_addr8_to_bank = dma_write_addr8_to_bank16 ;
  assign bank_mem[16].dma_read_addr9_to_bank  = dma_read_addr9_to_bank16  ;
  assign bank_mem[16].dma_write_addr9_to_bank = dma_write_addr9_to_bank16 ;
  assign bank_mem[16].dma_read_addr10_to_bank  = dma_read_addr10_to_bank16  ;
  assign bank_mem[16].dma_write_addr10_to_bank = dma_write_addr10_to_bank16 ;
  assign bank_mem[16].dma_read_addr11_to_bank  = dma_read_addr11_to_bank16  ;
  assign bank_mem[16].dma_write_addr11_to_bank = dma_write_addr11_to_bank16 ;
  assign bank_mem[16].dma_read_addr12_to_bank  = dma_read_addr12_to_bank16  ;
  assign bank_mem[16].dma_write_addr12_to_bank = dma_write_addr12_to_bank16 ;
  assign bank_mem[16].dma_read_addr13_to_bank  = dma_read_addr13_to_bank16  ;
  assign bank_mem[16].dma_write_addr13_to_bank = dma_write_addr13_to_bank16 ;
  assign bank_mem[16].dma_read_addr14_to_bank  = dma_read_addr14_to_bank16  ;
  assign bank_mem[16].dma_write_addr14_to_bank = dma_write_addr14_to_bank16 ;
  assign bank_mem[16].dma_read_addr15_to_bank  = dma_read_addr15_to_bank16  ;
  assign bank_mem[16].dma_write_addr15_to_bank = dma_write_addr15_to_bank16 ;
  assign bank_mem[16].dma_read_addr16_to_bank  = dma_read_addr16_to_bank16  ;
  assign bank_mem[16].dma_write_addr16_to_bank = dma_write_addr16_to_bank16 ;
  assign bank_mem[16].dma_read_addr17_to_bank  = dma_read_addr17_to_bank16  ;
  assign bank_mem[16].dma_write_addr17_to_bank = dma_write_addr17_to_bank16 ;
  assign bank_mem[16].dma_read_addr18_to_bank  = dma_read_addr18_to_bank16  ;
  assign bank_mem[16].dma_write_addr18_to_bank = dma_write_addr18_to_bank16 ;
  assign bank_mem[16].dma_read_addr19_to_bank  = dma_read_addr19_to_bank16  ;
  assign bank_mem[16].dma_write_addr19_to_bank = dma_write_addr19_to_bank16 ;
  assign bank_mem[16].dma_read_addr20_to_bank  = dma_read_addr20_to_bank16  ;
  assign bank_mem[16].dma_write_addr20_to_bank = dma_write_addr20_to_bank16 ;
  assign bank_mem[16].dma_read_addr21_to_bank  = dma_read_addr21_to_bank16  ;
  assign bank_mem[16].dma_write_addr21_to_bank = dma_write_addr21_to_bank16 ;
  assign bank_mem[16].dma_read_addr22_to_bank  = dma_read_addr22_to_bank16  ;
  assign bank_mem[16].dma_write_addr22_to_bank = dma_write_addr22_to_bank16 ;
  assign bank_mem[16].dma_read_addr23_to_bank  = dma_read_addr23_to_bank16  ;
  assign bank_mem[16].dma_write_addr23_to_bank = dma_write_addr23_to_bank16 ;
  assign bank_mem[16].dma_read_addr24_to_bank  = dma_read_addr24_to_bank16  ;
  assign bank_mem[16].dma_write_addr24_to_bank = dma_write_addr24_to_bank16 ;
  assign bank_mem[16].dma_read_addr25_to_bank  = dma_read_addr25_to_bank16  ;
  assign bank_mem[16].dma_write_addr25_to_bank = dma_write_addr25_to_bank16 ;
  assign bank_mem[16].dma_read_addr26_to_bank  = dma_read_addr26_to_bank16  ;
  assign bank_mem[16].dma_write_addr26_to_bank = dma_write_addr26_to_bank16 ;
  assign bank_mem[16].dma_read_addr27_to_bank  = dma_read_addr27_to_bank16  ;
  assign bank_mem[16].dma_write_addr27_to_bank = dma_write_addr27_to_bank16 ;
  assign bank_mem[16].dma_read_addr28_to_bank  = dma_read_addr28_to_bank16  ;
  assign bank_mem[16].dma_write_addr28_to_bank = dma_write_addr28_to_bank16 ;
  assign bank_mem[16].dma_read_addr29_to_bank  = dma_read_addr29_to_bank16  ;
  assign bank_mem[16].dma_write_addr29_to_bank = dma_write_addr29_to_bank16 ;
  assign bank_mem[16].dma_read_addr30_to_bank  = dma_read_addr30_to_bank16  ;
  assign bank_mem[16].dma_write_addr30_to_bank = dma_write_addr30_to_bank16 ;
  assign bank_mem[16].dma_read_addr31_to_bank  = dma_read_addr31_to_bank16  ;
  assign bank_mem[16].dma_write_addr31_to_bank = dma_write_addr31_to_bank16 ;
  assign bank_mem[17].dma_read_addr0_to_bank  = dma_read_addr0_to_bank17  ;
  assign bank_mem[17].dma_write_addr0_to_bank = dma_write_addr0_to_bank17 ;
  assign bank_mem[17].dma_read_addr1_to_bank  = dma_read_addr1_to_bank17  ;
  assign bank_mem[17].dma_write_addr1_to_bank = dma_write_addr1_to_bank17 ;
  assign bank_mem[17].dma_read_addr2_to_bank  = dma_read_addr2_to_bank17  ;
  assign bank_mem[17].dma_write_addr2_to_bank = dma_write_addr2_to_bank17 ;
  assign bank_mem[17].dma_read_addr3_to_bank  = dma_read_addr3_to_bank17  ;
  assign bank_mem[17].dma_write_addr3_to_bank = dma_write_addr3_to_bank17 ;
  assign bank_mem[17].dma_read_addr4_to_bank  = dma_read_addr4_to_bank17  ;
  assign bank_mem[17].dma_write_addr4_to_bank = dma_write_addr4_to_bank17 ;
  assign bank_mem[17].dma_read_addr5_to_bank  = dma_read_addr5_to_bank17  ;
  assign bank_mem[17].dma_write_addr5_to_bank = dma_write_addr5_to_bank17 ;
  assign bank_mem[17].dma_read_addr6_to_bank  = dma_read_addr6_to_bank17  ;
  assign bank_mem[17].dma_write_addr6_to_bank = dma_write_addr6_to_bank17 ;
  assign bank_mem[17].dma_read_addr7_to_bank  = dma_read_addr7_to_bank17  ;
  assign bank_mem[17].dma_write_addr7_to_bank = dma_write_addr7_to_bank17 ;
  assign bank_mem[17].dma_read_addr8_to_bank  = dma_read_addr8_to_bank17  ;
  assign bank_mem[17].dma_write_addr8_to_bank = dma_write_addr8_to_bank17 ;
  assign bank_mem[17].dma_read_addr9_to_bank  = dma_read_addr9_to_bank17  ;
  assign bank_mem[17].dma_write_addr9_to_bank = dma_write_addr9_to_bank17 ;
  assign bank_mem[17].dma_read_addr10_to_bank  = dma_read_addr10_to_bank17  ;
  assign bank_mem[17].dma_write_addr10_to_bank = dma_write_addr10_to_bank17 ;
  assign bank_mem[17].dma_read_addr11_to_bank  = dma_read_addr11_to_bank17  ;
  assign bank_mem[17].dma_write_addr11_to_bank = dma_write_addr11_to_bank17 ;
  assign bank_mem[17].dma_read_addr12_to_bank  = dma_read_addr12_to_bank17  ;
  assign bank_mem[17].dma_write_addr12_to_bank = dma_write_addr12_to_bank17 ;
  assign bank_mem[17].dma_read_addr13_to_bank  = dma_read_addr13_to_bank17  ;
  assign bank_mem[17].dma_write_addr13_to_bank = dma_write_addr13_to_bank17 ;
  assign bank_mem[17].dma_read_addr14_to_bank  = dma_read_addr14_to_bank17  ;
  assign bank_mem[17].dma_write_addr14_to_bank = dma_write_addr14_to_bank17 ;
  assign bank_mem[17].dma_read_addr15_to_bank  = dma_read_addr15_to_bank17  ;
  assign bank_mem[17].dma_write_addr15_to_bank = dma_write_addr15_to_bank17 ;
  assign bank_mem[17].dma_read_addr16_to_bank  = dma_read_addr16_to_bank17  ;
  assign bank_mem[17].dma_write_addr16_to_bank = dma_write_addr16_to_bank17 ;
  assign bank_mem[17].dma_read_addr17_to_bank  = dma_read_addr17_to_bank17  ;
  assign bank_mem[17].dma_write_addr17_to_bank = dma_write_addr17_to_bank17 ;
  assign bank_mem[17].dma_read_addr18_to_bank  = dma_read_addr18_to_bank17  ;
  assign bank_mem[17].dma_write_addr18_to_bank = dma_write_addr18_to_bank17 ;
  assign bank_mem[17].dma_read_addr19_to_bank  = dma_read_addr19_to_bank17  ;
  assign bank_mem[17].dma_write_addr19_to_bank = dma_write_addr19_to_bank17 ;
  assign bank_mem[17].dma_read_addr20_to_bank  = dma_read_addr20_to_bank17  ;
  assign bank_mem[17].dma_write_addr20_to_bank = dma_write_addr20_to_bank17 ;
  assign bank_mem[17].dma_read_addr21_to_bank  = dma_read_addr21_to_bank17  ;
  assign bank_mem[17].dma_write_addr21_to_bank = dma_write_addr21_to_bank17 ;
  assign bank_mem[17].dma_read_addr22_to_bank  = dma_read_addr22_to_bank17  ;
  assign bank_mem[17].dma_write_addr22_to_bank = dma_write_addr22_to_bank17 ;
  assign bank_mem[17].dma_read_addr23_to_bank  = dma_read_addr23_to_bank17  ;
  assign bank_mem[17].dma_write_addr23_to_bank = dma_write_addr23_to_bank17 ;
  assign bank_mem[17].dma_read_addr24_to_bank  = dma_read_addr24_to_bank17  ;
  assign bank_mem[17].dma_write_addr24_to_bank = dma_write_addr24_to_bank17 ;
  assign bank_mem[17].dma_read_addr25_to_bank  = dma_read_addr25_to_bank17  ;
  assign bank_mem[17].dma_write_addr25_to_bank = dma_write_addr25_to_bank17 ;
  assign bank_mem[17].dma_read_addr26_to_bank  = dma_read_addr26_to_bank17  ;
  assign bank_mem[17].dma_write_addr26_to_bank = dma_write_addr26_to_bank17 ;
  assign bank_mem[17].dma_read_addr27_to_bank  = dma_read_addr27_to_bank17  ;
  assign bank_mem[17].dma_write_addr27_to_bank = dma_write_addr27_to_bank17 ;
  assign bank_mem[17].dma_read_addr28_to_bank  = dma_read_addr28_to_bank17  ;
  assign bank_mem[17].dma_write_addr28_to_bank = dma_write_addr28_to_bank17 ;
  assign bank_mem[17].dma_read_addr29_to_bank  = dma_read_addr29_to_bank17  ;
  assign bank_mem[17].dma_write_addr29_to_bank = dma_write_addr29_to_bank17 ;
  assign bank_mem[17].dma_read_addr30_to_bank  = dma_read_addr30_to_bank17  ;
  assign bank_mem[17].dma_write_addr30_to_bank = dma_write_addr30_to_bank17 ;
  assign bank_mem[17].dma_read_addr31_to_bank  = dma_read_addr31_to_bank17  ;
  assign bank_mem[17].dma_write_addr31_to_bank = dma_write_addr31_to_bank17 ;
  assign bank_mem[18].dma_read_addr0_to_bank  = dma_read_addr0_to_bank18  ;
  assign bank_mem[18].dma_write_addr0_to_bank = dma_write_addr0_to_bank18 ;
  assign bank_mem[18].dma_read_addr1_to_bank  = dma_read_addr1_to_bank18  ;
  assign bank_mem[18].dma_write_addr1_to_bank = dma_write_addr1_to_bank18 ;
  assign bank_mem[18].dma_read_addr2_to_bank  = dma_read_addr2_to_bank18  ;
  assign bank_mem[18].dma_write_addr2_to_bank = dma_write_addr2_to_bank18 ;
  assign bank_mem[18].dma_read_addr3_to_bank  = dma_read_addr3_to_bank18  ;
  assign bank_mem[18].dma_write_addr3_to_bank = dma_write_addr3_to_bank18 ;
  assign bank_mem[18].dma_read_addr4_to_bank  = dma_read_addr4_to_bank18  ;
  assign bank_mem[18].dma_write_addr4_to_bank = dma_write_addr4_to_bank18 ;
  assign bank_mem[18].dma_read_addr5_to_bank  = dma_read_addr5_to_bank18  ;
  assign bank_mem[18].dma_write_addr5_to_bank = dma_write_addr5_to_bank18 ;
  assign bank_mem[18].dma_read_addr6_to_bank  = dma_read_addr6_to_bank18  ;
  assign bank_mem[18].dma_write_addr6_to_bank = dma_write_addr6_to_bank18 ;
  assign bank_mem[18].dma_read_addr7_to_bank  = dma_read_addr7_to_bank18  ;
  assign bank_mem[18].dma_write_addr7_to_bank = dma_write_addr7_to_bank18 ;
  assign bank_mem[18].dma_read_addr8_to_bank  = dma_read_addr8_to_bank18  ;
  assign bank_mem[18].dma_write_addr8_to_bank = dma_write_addr8_to_bank18 ;
  assign bank_mem[18].dma_read_addr9_to_bank  = dma_read_addr9_to_bank18  ;
  assign bank_mem[18].dma_write_addr9_to_bank = dma_write_addr9_to_bank18 ;
  assign bank_mem[18].dma_read_addr10_to_bank  = dma_read_addr10_to_bank18  ;
  assign bank_mem[18].dma_write_addr10_to_bank = dma_write_addr10_to_bank18 ;
  assign bank_mem[18].dma_read_addr11_to_bank  = dma_read_addr11_to_bank18  ;
  assign bank_mem[18].dma_write_addr11_to_bank = dma_write_addr11_to_bank18 ;
  assign bank_mem[18].dma_read_addr12_to_bank  = dma_read_addr12_to_bank18  ;
  assign bank_mem[18].dma_write_addr12_to_bank = dma_write_addr12_to_bank18 ;
  assign bank_mem[18].dma_read_addr13_to_bank  = dma_read_addr13_to_bank18  ;
  assign bank_mem[18].dma_write_addr13_to_bank = dma_write_addr13_to_bank18 ;
  assign bank_mem[18].dma_read_addr14_to_bank  = dma_read_addr14_to_bank18  ;
  assign bank_mem[18].dma_write_addr14_to_bank = dma_write_addr14_to_bank18 ;
  assign bank_mem[18].dma_read_addr15_to_bank  = dma_read_addr15_to_bank18  ;
  assign bank_mem[18].dma_write_addr15_to_bank = dma_write_addr15_to_bank18 ;
  assign bank_mem[18].dma_read_addr16_to_bank  = dma_read_addr16_to_bank18  ;
  assign bank_mem[18].dma_write_addr16_to_bank = dma_write_addr16_to_bank18 ;
  assign bank_mem[18].dma_read_addr17_to_bank  = dma_read_addr17_to_bank18  ;
  assign bank_mem[18].dma_write_addr17_to_bank = dma_write_addr17_to_bank18 ;
  assign bank_mem[18].dma_read_addr18_to_bank  = dma_read_addr18_to_bank18  ;
  assign bank_mem[18].dma_write_addr18_to_bank = dma_write_addr18_to_bank18 ;
  assign bank_mem[18].dma_read_addr19_to_bank  = dma_read_addr19_to_bank18  ;
  assign bank_mem[18].dma_write_addr19_to_bank = dma_write_addr19_to_bank18 ;
  assign bank_mem[18].dma_read_addr20_to_bank  = dma_read_addr20_to_bank18  ;
  assign bank_mem[18].dma_write_addr20_to_bank = dma_write_addr20_to_bank18 ;
  assign bank_mem[18].dma_read_addr21_to_bank  = dma_read_addr21_to_bank18  ;
  assign bank_mem[18].dma_write_addr21_to_bank = dma_write_addr21_to_bank18 ;
  assign bank_mem[18].dma_read_addr22_to_bank  = dma_read_addr22_to_bank18  ;
  assign bank_mem[18].dma_write_addr22_to_bank = dma_write_addr22_to_bank18 ;
  assign bank_mem[18].dma_read_addr23_to_bank  = dma_read_addr23_to_bank18  ;
  assign bank_mem[18].dma_write_addr23_to_bank = dma_write_addr23_to_bank18 ;
  assign bank_mem[18].dma_read_addr24_to_bank  = dma_read_addr24_to_bank18  ;
  assign bank_mem[18].dma_write_addr24_to_bank = dma_write_addr24_to_bank18 ;
  assign bank_mem[18].dma_read_addr25_to_bank  = dma_read_addr25_to_bank18  ;
  assign bank_mem[18].dma_write_addr25_to_bank = dma_write_addr25_to_bank18 ;
  assign bank_mem[18].dma_read_addr26_to_bank  = dma_read_addr26_to_bank18  ;
  assign bank_mem[18].dma_write_addr26_to_bank = dma_write_addr26_to_bank18 ;
  assign bank_mem[18].dma_read_addr27_to_bank  = dma_read_addr27_to_bank18  ;
  assign bank_mem[18].dma_write_addr27_to_bank = dma_write_addr27_to_bank18 ;
  assign bank_mem[18].dma_read_addr28_to_bank  = dma_read_addr28_to_bank18  ;
  assign bank_mem[18].dma_write_addr28_to_bank = dma_write_addr28_to_bank18 ;
  assign bank_mem[18].dma_read_addr29_to_bank  = dma_read_addr29_to_bank18  ;
  assign bank_mem[18].dma_write_addr29_to_bank = dma_write_addr29_to_bank18 ;
  assign bank_mem[18].dma_read_addr30_to_bank  = dma_read_addr30_to_bank18  ;
  assign bank_mem[18].dma_write_addr30_to_bank = dma_write_addr30_to_bank18 ;
  assign bank_mem[18].dma_read_addr31_to_bank  = dma_read_addr31_to_bank18  ;
  assign bank_mem[18].dma_write_addr31_to_bank = dma_write_addr31_to_bank18 ;
  assign bank_mem[19].dma_read_addr0_to_bank  = dma_read_addr0_to_bank19  ;
  assign bank_mem[19].dma_write_addr0_to_bank = dma_write_addr0_to_bank19 ;
  assign bank_mem[19].dma_read_addr1_to_bank  = dma_read_addr1_to_bank19  ;
  assign bank_mem[19].dma_write_addr1_to_bank = dma_write_addr1_to_bank19 ;
  assign bank_mem[19].dma_read_addr2_to_bank  = dma_read_addr2_to_bank19  ;
  assign bank_mem[19].dma_write_addr2_to_bank = dma_write_addr2_to_bank19 ;
  assign bank_mem[19].dma_read_addr3_to_bank  = dma_read_addr3_to_bank19  ;
  assign bank_mem[19].dma_write_addr3_to_bank = dma_write_addr3_to_bank19 ;
  assign bank_mem[19].dma_read_addr4_to_bank  = dma_read_addr4_to_bank19  ;
  assign bank_mem[19].dma_write_addr4_to_bank = dma_write_addr4_to_bank19 ;
  assign bank_mem[19].dma_read_addr5_to_bank  = dma_read_addr5_to_bank19  ;
  assign bank_mem[19].dma_write_addr5_to_bank = dma_write_addr5_to_bank19 ;
  assign bank_mem[19].dma_read_addr6_to_bank  = dma_read_addr6_to_bank19  ;
  assign bank_mem[19].dma_write_addr6_to_bank = dma_write_addr6_to_bank19 ;
  assign bank_mem[19].dma_read_addr7_to_bank  = dma_read_addr7_to_bank19  ;
  assign bank_mem[19].dma_write_addr7_to_bank = dma_write_addr7_to_bank19 ;
  assign bank_mem[19].dma_read_addr8_to_bank  = dma_read_addr8_to_bank19  ;
  assign bank_mem[19].dma_write_addr8_to_bank = dma_write_addr8_to_bank19 ;
  assign bank_mem[19].dma_read_addr9_to_bank  = dma_read_addr9_to_bank19  ;
  assign bank_mem[19].dma_write_addr9_to_bank = dma_write_addr9_to_bank19 ;
  assign bank_mem[19].dma_read_addr10_to_bank  = dma_read_addr10_to_bank19  ;
  assign bank_mem[19].dma_write_addr10_to_bank = dma_write_addr10_to_bank19 ;
  assign bank_mem[19].dma_read_addr11_to_bank  = dma_read_addr11_to_bank19  ;
  assign bank_mem[19].dma_write_addr11_to_bank = dma_write_addr11_to_bank19 ;
  assign bank_mem[19].dma_read_addr12_to_bank  = dma_read_addr12_to_bank19  ;
  assign bank_mem[19].dma_write_addr12_to_bank = dma_write_addr12_to_bank19 ;
  assign bank_mem[19].dma_read_addr13_to_bank  = dma_read_addr13_to_bank19  ;
  assign bank_mem[19].dma_write_addr13_to_bank = dma_write_addr13_to_bank19 ;
  assign bank_mem[19].dma_read_addr14_to_bank  = dma_read_addr14_to_bank19  ;
  assign bank_mem[19].dma_write_addr14_to_bank = dma_write_addr14_to_bank19 ;
  assign bank_mem[19].dma_read_addr15_to_bank  = dma_read_addr15_to_bank19  ;
  assign bank_mem[19].dma_write_addr15_to_bank = dma_write_addr15_to_bank19 ;
  assign bank_mem[19].dma_read_addr16_to_bank  = dma_read_addr16_to_bank19  ;
  assign bank_mem[19].dma_write_addr16_to_bank = dma_write_addr16_to_bank19 ;
  assign bank_mem[19].dma_read_addr17_to_bank  = dma_read_addr17_to_bank19  ;
  assign bank_mem[19].dma_write_addr17_to_bank = dma_write_addr17_to_bank19 ;
  assign bank_mem[19].dma_read_addr18_to_bank  = dma_read_addr18_to_bank19  ;
  assign bank_mem[19].dma_write_addr18_to_bank = dma_write_addr18_to_bank19 ;
  assign bank_mem[19].dma_read_addr19_to_bank  = dma_read_addr19_to_bank19  ;
  assign bank_mem[19].dma_write_addr19_to_bank = dma_write_addr19_to_bank19 ;
  assign bank_mem[19].dma_read_addr20_to_bank  = dma_read_addr20_to_bank19  ;
  assign bank_mem[19].dma_write_addr20_to_bank = dma_write_addr20_to_bank19 ;
  assign bank_mem[19].dma_read_addr21_to_bank  = dma_read_addr21_to_bank19  ;
  assign bank_mem[19].dma_write_addr21_to_bank = dma_write_addr21_to_bank19 ;
  assign bank_mem[19].dma_read_addr22_to_bank  = dma_read_addr22_to_bank19  ;
  assign bank_mem[19].dma_write_addr22_to_bank = dma_write_addr22_to_bank19 ;
  assign bank_mem[19].dma_read_addr23_to_bank  = dma_read_addr23_to_bank19  ;
  assign bank_mem[19].dma_write_addr23_to_bank = dma_write_addr23_to_bank19 ;
  assign bank_mem[19].dma_read_addr24_to_bank  = dma_read_addr24_to_bank19  ;
  assign bank_mem[19].dma_write_addr24_to_bank = dma_write_addr24_to_bank19 ;
  assign bank_mem[19].dma_read_addr25_to_bank  = dma_read_addr25_to_bank19  ;
  assign bank_mem[19].dma_write_addr25_to_bank = dma_write_addr25_to_bank19 ;
  assign bank_mem[19].dma_read_addr26_to_bank  = dma_read_addr26_to_bank19  ;
  assign bank_mem[19].dma_write_addr26_to_bank = dma_write_addr26_to_bank19 ;
  assign bank_mem[19].dma_read_addr27_to_bank  = dma_read_addr27_to_bank19  ;
  assign bank_mem[19].dma_write_addr27_to_bank = dma_write_addr27_to_bank19 ;
  assign bank_mem[19].dma_read_addr28_to_bank  = dma_read_addr28_to_bank19  ;
  assign bank_mem[19].dma_write_addr28_to_bank = dma_write_addr28_to_bank19 ;
  assign bank_mem[19].dma_read_addr29_to_bank  = dma_read_addr29_to_bank19  ;
  assign bank_mem[19].dma_write_addr29_to_bank = dma_write_addr29_to_bank19 ;
  assign bank_mem[19].dma_read_addr30_to_bank  = dma_read_addr30_to_bank19  ;
  assign bank_mem[19].dma_write_addr30_to_bank = dma_write_addr30_to_bank19 ;
  assign bank_mem[19].dma_read_addr31_to_bank  = dma_read_addr31_to_bank19  ;
  assign bank_mem[19].dma_write_addr31_to_bank = dma_write_addr31_to_bank19 ;
  assign bank_mem[20].dma_read_addr0_to_bank  = dma_read_addr0_to_bank20  ;
  assign bank_mem[20].dma_write_addr0_to_bank = dma_write_addr0_to_bank20 ;
  assign bank_mem[20].dma_read_addr1_to_bank  = dma_read_addr1_to_bank20  ;
  assign bank_mem[20].dma_write_addr1_to_bank = dma_write_addr1_to_bank20 ;
  assign bank_mem[20].dma_read_addr2_to_bank  = dma_read_addr2_to_bank20  ;
  assign bank_mem[20].dma_write_addr2_to_bank = dma_write_addr2_to_bank20 ;
  assign bank_mem[20].dma_read_addr3_to_bank  = dma_read_addr3_to_bank20  ;
  assign bank_mem[20].dma_write_addr3_to_bank = dma_write_addr3_to_bank20 ;
  assign bank_mem[20].dma_read_addr4_to_bank  = dma_read_addr4_to_bank20  ;
  assign bank_mem[20].dma_write_addr4_to_bank = dma_write_addr4_to_bank20 ;
  assign bank_mem[20].dma_read_addr5_to_bank  = dma_read_addr5_to_bank20  ;
  assign bank_mem[20].dma_write_addr5_to_bank = dma_write_addr5_to_bank20 ;
  assign bank_mem[20].dma_read_addr6_to_bank  = dma_read_addr6_to_bank20  ;
  assign bank_mem[20].dma_write_addr6_to_bank = dma_write_addr6_to_bank20 ;
  assign bank_mem[20].dma_read_addr7_to_bank  = dma_read_addr7_to_bank20  ;
  assign bank_mem[20].dma_write_addr7_to_bank = dma_write_addr7_to_bank20 ;
  assign bank_mem[20].dma_read_addr8_to_bank  = dma_read_addr8_to_bank20  ;
  assign bank_mem[20].dma_write_addr8_to_bank = dma_write_addr8_to_bank20 ;
  assign bank_mem[20].dma_read_addr9_to_bank  = dma_read_addr9_to_bank20  ;
  assign bank_mem[20].dma_write_addr9_to_bank = dma_write_addr9_to_bank20 ;
  assign bank_mem[20].dma_read_addr10_to_bank  = dma_read_addr10_to_bank20  ;
  assign bank_mem[20].dma_write_addr10_to_bank = dma_write_addr10_to_bank20 ;
  assign bank_mem[20].dma_read_addr11_to_bank  = dma_read_addr11_to_bank20  ;
  assign bank_mem[20].dma_write_addr11_to_bank = dma_write_addr11_to_bank20 ;
  assign bank_mem[20].dma_read_addr12_to_bank  = dma_read_addr12_to_bank20  ;
  assign bank_mem[20].dma_write_addr12_to_bank = dma_write_addr12_to_bank20 ;
  assign bank_mem[20].dma_read_addr13_to_bank  = dma_read_addr13_to_bank20  ;
  assign bank_mem[20].dma_write_addr13_to_bank = dma_write_addr13_to_bank20 ;
  assign bank_mem[20].dma_read_addr14_to_bank  = dma_read_addr14_to_bank20  ;
  assign bank_mem[20].dma_write_addr14_to_bank = dma_write_addr14_to_bank20 ;
  assign bank_mem[20].dma_read_addr15_to_bank  = dma_read_addr15_to_bank20  ;
  assign bank_mem[20].dma_write_addr15_to_bank = dma_write_addr15_to_bank20 ;
  assign bank_mem[20].dma_read_addr16_to_bank  = dma_read_addr16_to_bank20  ;
  assign bank_mem[20].dma_write_addr16_to_bank = dma_write_addr16_to_bank20 ;
  assign bank_mem[20].dma_read_addr17_to_bank  = dma_read_addr17_to_bank20  ;
  assign bank_mem[20].dma_write_addr17_to_bank = dma_write_addr17_to_bank20 ;
  assign bank_mem[20].dma_read_addr18_to_bank  = dma_read_addr18_to_bank20  ;
  assign bank_mem[20].dma_write_addr18_to_bank = dma_write_addr18_to_bank20 ;
  assign bank_mem[20].dma_read_addr19_to_bank  = dma_read_addr19_to_bank20  ;
  assign bank_mem[20].dma_write_addr19_to_bank = dma_write_addr19_to_bank20 ;
  assign bank_mem[20].dma_read_addr20_to_bank  = dma_read_addr20_to_bank20  ;
  assign bank_mem[20].dma_write_addr20_to_bank = dma_write_addr20_to_bank20 ;
  assign bank_mem[20].dma_read_addr21_to_bank  = dma_read_addr21_to_bank20  ;
  assign bank_mem[20].dma_write_addr21_to_bank = dma_write_addr21_to_bank20 ;
  assign bank_mem[20].dma_read_addr22_to_bank  = dma_read_addr22_to_bank20  ;
  assign bank_mem[20].dma_write_addr22_to_bank = dma_write_addr22_to_bank20 ;
  assign bank_mem[20].dma_read_addr23_to_bank  = dma_read_addr23_to_bank20  ;
  assign bank_mem[20].dma_write_addr23_to_bank = dma_write_addr23_to_bank20 ;
  assign bank_mem[20].dma_read_addr24_to_bank  = dma_read_addr24_to_bank20  ;
  assign bank_mem[20].dma_write_addr24_to_bank = dma_write_addr24_to_bank20 ;
  assign bank_mem[20].dma_read_addr25_to_bank  = dma_read_addr25_to_bank20  ;
  assign bank_mem[20].dma_write_addr25_to_bank = dma_write_addr25_to_bank20 ;
  assign bank_mem[20].dma_read_addr26_to_bank  = dma_read_addr26_to_bank20  ;
  assign bank_mem[20].dma_write_addr26_to_bank = dma_write_addr26_to_bank20 ;
  assign bank_mem[20].dma_read_addr27_to_bank  = dma_read_addr27_to_bank20  ;
  assign bank_mem[20].dma_write_addr27_to_bank = dma_write_addr27_to_bank20 ;
  assign bank_mem[20].dma_read_addr28_to_bank  = dma_read_addr28_to_bank20  ;
  assign bank_mem[20].dma_write_addr28_to_bank = dma_write_addr28_to_bank20 ;
  assign bank_mem[20].dma_read_addr29_to_bank  = dma_read_addr29_to_bank20  ;
  assign bank_mem[20].dma_write_addr29_to_bank = dma_write_addr29_to_bank20 ;
  assign bank_mem[20].dma_read_addr30_to_bank  = dma_read_addr30_to_bank20  ;
  assign bank_mem[20].dma_write_addr30_to_bank = dma_write_addr30_to_bank20 ;
  assign bank_mem[20].dma_read_addr31_to_bank  = dma_read_addr31_to_bank20  ;
  assign bank_mem[20].dma_write_addr31_to_bank = dma_write_addr31_to_bank20 ;
  assign bank_mem[21].dma_read_addr0_to_bank  = dma_read_addr0_to_bank21  ;
  assign bank_mem[21].dma_write_addr0_to_bank = dma_write_addr0_to_bank21 ;
  assign bank_mem[21].dma_read_addr1_to_bank  = dma_read_addr1_to_bank21  ;
  assign bank_mem[21].dma_write_addr1_to_bank = dma_write_addr1_to_bank21 ;
  assign bank_mem[21].dma_read_addr2_to_bank  = dma_read_addr2_to_bank21  ;
  assign bank_mem[21].dma_write_addr2_to_bank = dma_write_addr2_to_bank21 ;
  assign bank_mem[21].dma_read_addr3_to_bank  = dma_read_addr3_to_bank21  ;
  assign bank_mem[21].dma_write_addr3_to_bank = dma_write_addr3_to_bank21 ;
  assign bank_mem[21].dma_read_addr4_to_bank  = dma_read_addr4_to_bank21  ;
  assign bank_mem[21].dma_write_addr4_to_bank = dma_write_addr4_to_bank21 ;
  assign bank_mem[21].dma_read_addr5_to_bank  = dma_read_addr5_to_bank21  ;
  assign bank_mem[21].dma_write_addr5_to_bank = dma_write_addr5_to_bank21 ;
  assign bank_mem[21].dma_read_addr6_to_bank  = dma_read_addr6_to_bank21  ;
  assign bank_mem[21].dma_write_addr6_to_bank = dma_write_addr6_to_bank21 ;
  assign bank_mem[21].dma_read_addr7_to_bank  = dma_read_addr7_to_bank21  ;
  assign bank_mem[21].dma_write_addr7_to_bank = dma_write_addr7_to_bank21 ;
  assign bank_mem[21].dma_read_addr8_to_bank  = dma_read_addr8_to_bank21  ;
  assign bank_mem[21].dma_write_addr8_to_bank = dma_write_addr8_to_bank21 ;
  assign bank_mem[21].dma_read_addr9_to_bank  = dma_read_addr9_to_bank21  ;
  assign bank_mem[21].dma_write_addr9_to_bank = dma_write_addr9_to_bank21 ;
  assign bank_mem[21].dma_read_addr10_to_bank  = dma_read_addr10_to_bank21  ;
  assign bank_mem[21].dma_write_addr10_to_bank = dma_write_addr10_to_bank21 ;
  assign bank_mem[21].dma_read_addr11_to_bank  = dma_read_addr11_to_bank21  ;
  assign bank_mem[21].dma_write_addr11_to_bank = dma_write_addr11_to_bank21 ;
  assign bank_mem[21].dma_read_addr12_to_bank  = dma_read_addr12_to_bank21  ;
  assign bank_mem[21].dma_write_addr12_to_bank = dma_write_addr12_to_bank21 ;
  assign bank_mem[21].dma_read_addr13_to_bank  = dma_read_addr13_to_bank21  ;
  assign bank_mem[21].dma_write_addr13_to_bank = dma_write_addr13_to_bank21 ;
  assign bank_mem[21].dma_read_addr14_to_bank  = dma_read_addr14_to_bank21  ;
  assign bank_mem[21].dma_write_addr14_to_bank = dma_write_addr14_to_bank21 ;
  assign bank_mem[21].dma_read_addr15_to_bank  = dma_read_addr15_to_bank21  ;
  assign bank_mem[21].dma_write_addr15_to_bank = dma_write_addr15_to_bank21 ;
  assign bank_mem[21].dma_read_addr16_to_bank  = dma_read_addr16_to_bank21  ;
  assign bank_mem[21].dma_write_addr16_to_bank = dma_write_addr16_to_bank21 ;
  assign bank_mem[21].dma_read_addr17_to_bank  = dma_read_addr17_to_bank21  ;
  assign bank_mem[21].dma_write_addr17_to_bank = dma_write_addr17_to_bank21 ;
  assign bank_mem[21].dma_read_addr18_to_bank  = dma_read_addr18_to_bank21  ;
  assign bank_mem[21].dma_write_addr18_to_bank = dma_write_addr18_to_bank21 ;
  assign bank_mem[21].dma_read_addr19_to_bank  = dma_read_addr19_to_bank21  ;
  assign bank_mem[21].dma_write_addr19_to_bank = dma_write_addr19_to_bank21 ;
  assign bank_mem[21].dma_read_addr20_to_bank  = dma_read_addr20_to_bank21  ;
  assign bank_mem[21].dma_write_addr20_to_bank = dma_write_addr20_to_bank21 ;
  assign bank_mem[21].dma_read_addr21_to_bank  = dma_read_addr21_to_bank21  ;
  assign bank_mem[21].dma_write_addr21_to_bank = dma_write_addr21_to_bank21 ;
  assign bank_mem[21].dma_read_addr22_to_bank  = dma_read_addr22_to_bank21  ;
  assign bank_mem[21].dma_write_addr22_to_bank = dma_write_addr22_to_bank21 ;
  assign bank_mem[21].dma_read_addr23_to_bank  = dma_read_addr23_to_bank21  ;
  assign bank_mem[21].dma_write_addr23_to_bank = dma_write_addr23_to_bank21 ;
  assign bank_mem[21].dma_read_addr24_to_bank  = dma_read_addr24_to_bank21  ;
  assign bank_mem[21].dma_write_addr24_to_bank = dma_write_addr24_to_bank21 ;
  assign bank_mem[21].dma_read_addr25_to_bank  = dma_read_addr25_to_bank21  ;
  assign bank_mem[21].dma_write_addr25_to_bank = dma_write_addr25_to_bank21 ;
  assign bank_mem[21].dma_read_addr26_to_bank  = dma_read_addr26_to_bank21  ;
  assign bank_mem[21].dma_write_addr26_to_bank = dma_write_addr26_to_bank21 ;
  assign bank_mem[21].dma_read_addr27_to_bank  = dma_read_addr27_to_bank21  ;
  assign bank_mem[21].dma_write_addr27_to_bank = dma_write_addr27_to_bank21 ;
  assign bank_mem[21].dma_read_addr28_to_bank  = dma_read_addr28_to_bank21  ;
  assign bank_mem[21].dma_write_addr28_to_bank = dma_write_addr28_to_bank21 ;
  assign bank_mem[21].dma_read_addr29_to_bank  = dma_read_addr29_to_bank21  ;
  assign bank_mem[21].dma_write_addr29_to_bank = dma_write_addr29_to_bank21 ;
  assign bank_mem[21].dma_read_addr30_to_bank  = dma_read_addr30_to_bank21  ;
  assign bank_mem[21].dma_write_addr30_to_bank = dma_write_addr30_to_bank21 ;
  assign bank_mem[21].dma_read_addr31_to_bank  = dma_read_addr31_to_bank21  ;
  assign bank_mem[21].dma_write_addr31_to_bank = dma_write_addr31_to_bank21 ;
  assign bank_mem[22].dma_read_addr0_to_bank  = dma_read_addr0_to_bank22  ;
  assign bank_mem[22].dma_write_addr0_to_bank = dma_write_addr0_to_bank22 ;
  assign bank_mem[22].dma_read_addr1_to_bank  = dma_read_addr1_to_bank22  ;
  assign bank_mem[22].dma_write_addr1_to_bank = dma_write_addr1_to_bank22 ;
  assign bank_mem[22].dma_read_addr2_to_bank  = dma_read_addr2_to_bank22  ;
  assign bank_mem[22].dma_write_addr2_to_bank = dma_write_addr2_to_bank22 ;
  assign bank_mem[22].dma_read_addr3_to_bank  = dma_read_addr3_to_bank22  ;
  assign bank_mem[22].dma_write_addr3_to_bank = dma_write_addr3_to_bank22 ;
  assign bank_mem[22].dma_read_addr4_to_bank  = dma_read_addr4_to_bank22  ;
  assign bank_mem[22].dma_write_addr4_to_bank = dma_write_addr4_to_bank22 ;
  assign bank_mem[22].dma_read_addr5_to_bank  = dma_read_addr5_to_bank22  ;
  assign bank_mem[22].dma_write_addr5_to_bank = dma_write_addr5_to_bank22 ;
  assign bank_mem[22].dma_read_addr6_to_bank  = dma_read_addr6_to_bank22  ;
  assign bank_mem[22].dma_write_addr6_to_bank = dma_write_addr6_to_bank22 ;
  assign bank_mem[22].dma_read_addr7_to_bank  = dma_read_addr7_to_bank22  ;
  assign bank_mem[22].dma_write_addr7_to_bank = dma_write_addr7_to_bank22 ;
  assign bank_mem[22].dma_read_addr8_to_bank  = dma_read_addr8_to_bank22  ;
  assign bank_mem[22].dma_write_addr8_to_bank = dma_write_addr8_to_bank22 ;
  assign bank_mem[22].dma_read_addr9_to_bank  = dma_read_addr9_to_bank22  ;
  assign bank_mem[22].dma_write_addr9_to_bank = dma_write_addr9_to_bank22 ;
  assign bank_mem[22].dma_read_addr10_to_bank  = dma_read_addr10_to_bank22  ;
  assign bank_mem[22].dma_write_addr10_to_bank = dma_write_addr10_to_bank22 ;
  assign bank_mem[22].dma_read_addr11_to_bank  = dma_read_addr11_to_bank22  ;
  assign bank_mem[22].dma_write_addr11_to_bank = dma_write_addr11_to_bank22 ;
  assign bank_mem[22].dma_read_addr12_to_bank  = dma_read_addr12_to_bank22  ;
  assign bank_mem[22].dma_write_addr12_to_bank = dma_write_addr12_to_bank22 ;
  assign bank_mem[22].dma_read_addr13_to_bank  = dma_read_addr13_to_bank22  ;
  assign bank_mem[22].dma_write_addr13_to_bank = dma_write_addr13_to_bank22 ;
  assign bank_mem[22].dma_read_addr14_to_bank  = dma_read_addr14_to_bank22  ;
  assign bank_mem[22].dma_write_addr14_to_bank = dma_write_addr14_to_bank22 ;
  assign bank_mem[22].dma_read_addr15_to_bank  = dma_read_addr15_to_bank22  ;
  assign bank_mem[22].dma_write_addr15_to_bank = dma_write_addr15_to_bank22 ;
  assign bank_mem[22].dma_read_addr16_to_bank  = dma_read_addr16_to_bank22  ;
  assign bank_mem[22].dma_write_addr16_to_bank = dma_write_addr16_to_bank22 ;
  assign bank_mem[22].dma_read_addr17_to_bank  = dma_read_addr17_to_bank22  ;
  assign bank_mem[22].dma_write_addr17_to_bank = dma_write_addr17_to_bank22 ;
  assign bank_mem[22].dma_read_addr18_to_bank  = dma_read_addr18_to_bank22  ;
  assign bank_mem[22].dma_write_addr18_to_bank = dma_write_addr18_to_bank22 ;
  assign bank_mem[22].dma_read_addr19_to_bank  = dma_read_addr19_to_bank22  ;
  assign bank_mem[22].dma_write_addr19_to_bank = dma_write_addr19_to_bank22 ;
  assign bank_mem[22].dma_read_addr20_to_bank  = dma_read_addr20_to_bank22  ;
  assign bank_mem[22].dma_write_addr20_to_bank = dma_write_addr20_to_bank22 ;
  assign bank_mem[22].dma_read_addr21_to_bank  = dma_read_addr21_to_bank22  ;
  assign bank_mem[22].dma_write_addr21_to_bank = dma_write_addr21_to_bank22 ;
  assign bank_mem[22].dma_read_addr22_to_bank  = dma_read_addr22_to_bank22  ;
  assign bank_mem[22].dma_write_addr22_to_bank = dma_write_addr22_to_bank22 ;
  assign bank_mem[22].dma_read_addr23_to_bank  = dma_read_addr23_to_bank22  ;
  assign bank_mem[22].dma_write_addr23_to_bank = dma_write_addr23_to_bank22 ;
  assign bank_mem[22].dma_read_addr24_to_bank  = dma_read_addr24_to_bank22  ;
  assign bank_mem[22].dma_write_addr24_to_bank = dma_write_addr24_to_bank22 ;
  assign bank_mem[22].dma_read_addr25_to_bank  = dma_read_addr25_to_bank22  ;
  assign bank_mem[22].dma_write_addr25_to_bank = dma_write_addr25_to_bank22 ;
  assign bank_mem[22].dma_read_addr26_to_bank  = dma_read_addr26_to_bank22  ;
  assign bank_mem[22].dma_write_addr26_to_bank = dma_write_addr26_to_bank22 ;
  assign bank_mem[22].dma_read_addr27_to_bank  = dma_read_addr27_to_bank22  ;
  assign bank_mem[22].dma_write_addr27_to_bank = dma_write_addr27_to_bank22 ;
  assign bank_mem[22].dma_read_addr28_to_bank  = dma_read_addr28_to_bank22  ;
  assign bank_mem[22].dma_write_addr28_to_bank = dma_write_addr28_to_bank22 ;
  assign bank_mem[22].dma_read_addr29_to_bank  = dma_read_addr29_to_bank22  ;
  assign bank_mem[22].dma_write_addr29_to_bank = dma_write_addr29_to_bank22 ;
  assign bank_mem[22].dma_read_addr30_to_bank  = dma_read_addr30_to_bank22  ;
  assign bank_mem[22].dma_write_addr30_to_bank = dma_write_addr30_to_bank22 ;
  assign bank_mem[22].dma_read_addr31_to_bank  = dma_read_addr31_to_bank22  ;
  assign bank_mem[22].dma_write_addr31_to_bank = dma_write_addr31_to_bank22 ;
  assign bank_mem[23].dma_read_addr0_to_bank  = dma_read_addr0_to_bank23  ;
  assign bank_mem[23].dma_write_addr0_to_bank = dma_write_addr0_to_bank23 ;
  assign bank_mem[23].dma_read_addr1_to_bank  = dma_read_addr1_to_bank23  ;
  assign bank_mem[23].dma_write_addr1_to_bank = dma_write_addr1_to_bank23 ;
  assign bank_mem[23].dma_read_addr2_to_bank  = dma_read_addr2_to_bank23  ;
  assign bank_mem[23].dma_write_addr2_to_bank = dma_write_addr2_to_bank23 ;
  assign bank_mem[23].dma_read_addr3_to_bank  = dma_read_addr3_to_bank23  ;
  assign bank_mem[23].dma_write_addr3_to_bank = dma_write_addr3_to_bank23 ;
  assign bank_mem[23].dma_read_addr4_to_bank  = dma_read_addr4_to_bank23  ;
  assign bank_mem[23].dma_write_addr4_to_bank = dma_write_addr4_to_bank23 ;
  assign bank_mem[23].dma_read_addr5_to_bank  = dma_read_addr5_to_bank23  ;
  assign bank_mem[23].dma_write_addr5_to_bank = dma_write_addr5_to_bank23 ;
  assign bank_mem[23].dma_read_addr6_to_bank  = dma_read_addr6_to_bank23  ;
  assign bank_mem[23].dma_write_addr6_to_bank = dma_write_addr6_to_bank23 ;
  assign bank_mem[23].dma_read_addr7_to_bank  = dma_read_addr7_to_bank23  ;
  assign bank_mem[23].dma_write_addr7_to_bank = dma_write_addr7_to_bank23 ;
  assign bank_mem[23].dma_read_addr8_to_bank  = dma_read_addr8_to_bank23  ;
  assign bank_mem[23].dma_write_addr8_to_bank = dma_write_addr8_to_bank23 ;
  assign bank_mem[23].dma_read_addr9_to_bank  = dma_read_addr9_to_bank23  ;
  assign bank_mem[23].dma_write_addr9_to_bank = dma_write_addr9_to_bank23 ;
  assign bank_mem[23].dma_read_addr10_to_bank  = dma_read_addr10_to_bank23  ;
  assign bank_mem[23].dma_write_addr10_to_bank = dma_write_addr10_to_bank23 ;
  assign bank_mem[23].dma_read_addr11_to_bank  = dma_read_addr11_to_bank23  ;
  assign bank_mem[23].dma_write_addr11_to_bank = dma_write_addr11_to_bank23 ;
  assign bank_mem[23].dma_read_addr12_to_bank  = dma_read_addr12_to_bank23  ;
  assign bank_mem[23].dma_write_addr12_to_bank = dma_write_addr12_to_bank23 ;
  assign bank_mem[23].dma_read_addr13_to_bank  = dma_read_addr13_to_bank23  ;
  assign bank_mem[23].dma_write_addr13_to_bank = dma_write_addr13_to_bank23 ;
  assign bank_mem[23].dma_read_addr14_to_bank  = dma_read_addr14_to_bank23  ;
  assign bank_mem[23].dma_write_addr14_to_bank = dma_write_addr14_to_bank23 ;
  assign bank_mem[23].dma_read_addr15_to_bank  = dma_read_addr15_to_bank23  ;
  assign bank_mem[23].dma_write_addr15_to_bank = dma_write_addr15_to_bank23 ;
  assign bank_mem[23].dma_read_addr16_to_bank  = dma_read_addr16_to_bank23  ;
  assign bank_mem[23].dma_write_addr16_to_bank = dma_write_addr16_to_bank23 ;
  assign bank_mem[23].dma_read_addr17_to_bank  = dma_read_addr17_to_bank23  ;
  assign bank_mem[23].dma_write_addr17_to_bank = dma_write_addr17_to_bank23 ;
  assign bank_mem[23].dma_read_addr18_to_bank  = dma_read_addr18_to_bank23  ;
  assign bank_mem[23].dma_write_addr18_to_bank = dma_write_addr18_to_bank23 ;
  assign bank_mem[23].dma_read_addr19_to_bank  = dma_read_addr19_to_bank23  ;
  assign bank_mem[23].dma_write_addr19_to_bank = dma_write_addr19_to_bank23 ;
  assign bank_mem[23].dma_read_addr20_to_bank  = dma_read_addr20_to_bank23  ;
  assign bank_mem[23].dma_write_addr20_to_bank = dma_write_addr20_to_bank23 ;
  assign bank_mem[23].dma_read_addr21_to_bank  = dma_read_addr21_to_bank23  ;
  assign bank_mem[23].dma_write_addr21_to_bank = dma_write_addr21_to_bank23 ;
  assign bank_mem[23].dma_read_addr22_to_bank  = dma_read_addr22_to_bank23  ;
  assign bank_mem[23].dma_write_addr22_to_bank = dma_write_addr22_to_bank23 ;
  assign bank_mem[23].dma_read_addr23_to_bank  = dma_read_addr23_to_bank23  ;
  assign bank_mem[23].dma_write_addr23_to_bank = dma_write_addr23_to_bank23 ;
  assign bank_mem[23].dma_read_addr24_to_bank  = dma_read_addr24_to_bank23  ;
  assign bank_mem[23].dma_write_addr24_to_bank = dma_write_addr24_to_bank23 ;
  assign bank_mem[23].dma_read_addr25_to_bank  = dma_read_addr25_to_bank23  ;
  assign bank_mem[23].dma_write_addr25_to_bank = dma_write_addr25_to_bank23 ;
  assign bank_mem[23].dma_read_addr26_to_bank  = dma_read_addr26_to_bank23  ;
  assign bank_mem[23].dma_write_addr26_to_bank = dma_write_addr26_to_bank23 ;
  assign bank_mem[23].dma_read_addr27_to_bank  = dma_read_addr27_to_bank23  ;
  assign bank_mem[23].dma_write_addr27_to_bank = dma_write_addr27_to_bank23 ;
  assign bank_mem[23].dma_read_addr28_to_bank  = dma_read_addr28_to_bank23  ;
  assign bank_mem[23].dma_write_addr28_to_bank = dma_write_addr28_to_bank23 ;
  assign bank_mem[23].dma_read_addr29_to_bank  = dma_read_addr29_to_bank23  ;
  assign bank_mem[23].dma_write_addr29_to_bank = dma_write_addr29_to_bank23 ;
  assign bank_mem[23].dma_read_addr30_to_bank  = dma_read_addr30_to_bank23  ;
  assign bank_mem[23].dma_write_addr30_to_bank = dma_write_addr30_to_bank23 ;
  assign bank_mem[23].dma_read_addr31_to_bank  = dma_read_addr31_to_bank23  ;
  assign bank_mem[23].dma_write_addr31_to_bank = dma_write_addr31_to_bank23 ;
  assign bank_mem[24].dma_read_addr0_to_bank  = dma_read_addr0_to_bank24  ;
  assign bank_mem[24].dma_write_addr0_to_bank = dma_write_addr0_to_bank24 ;
  assign bank_mem[24].dma_read_addr1_to_bank  = dma_read_addr1_to_bank24  ;
  assign bank_mem[24].dma_write_addr1_to_bank = dma_write_addr1_to_bank24 ;
  assign bank_mem[24].dma_read_addr2_to_bank  = dma_read_addr2_to_bank24  ;
  assign bank_mem[24].dma_write_addr2_to_bank = dma_write_addr2_to_bank24 ;
  assign bank_mem[24].dma_read_addr3_to_bank  = dma_read_addr3_to_bank24  ;
  assign bank_mem[24].dma_write_addr3_to_bank = dma_write_addr3_to_bank24 ;
  assign bank_mem[24].dma_read_addr4_to_bank  = dma_read_addr4_to_bank24  ;
  assign bank_mem[24].dma_write_addr4_to_bank = dma_write_addr4_to_bank24 ;
  assign bank_mem[24].dma_read_addr5_to_bank  = dma_read_addr5_to_bank24  ;
  assign bank_mem[24].dma_write_addr5_to_bank = dma_write_addr5_to_bank24 ;
  assign bank_mem[24].dma_read_addr6_to_bank  = dma_read_addr6_to_bank24  ;
  assign bank_mem[24].dma_write_addr6_to_bank = dma_write_addr6_to_bank24 ;
  assign bank_mem[24].dma_read_addr7_to_bank  = dma_read_addr7_to_bank24  ;
  assign bank_mem[24].dma_write_addr7_to_bank = dma_write_addr7_to_bank24 ;
  assign bank_mem[24].dma_read_addr8_to_bank  = dma_read_addr8_to_bank24  ;
  assign bank_mem[24].dma_write_addr8_to_bank = dma_write_addr8_to_bank24 ;
  assign bank_mem[24].dma_read_addr9_to_bank  = dma_read_addr9_to_bank24  ;
  assign bank_mem[24].dma_write_addr9_to_bank = dma_write_addr9_to_bank24 ;
  assign bank_mem[24].dma_read_addr10_to_bank  = dma_read_addr10_to_bank24  ;
  assign bank_mem[24].dma_write_addr10_to_bank = dma_write_addr10_to_bank24 ;
  assign bank_mem[24].dma_read_addr11_to_bank  = dma_read_addr11_to_bank24  ;
  assign bank_mem[24].dma_write_addr11_to_bank = dma_write_addr11_to_bank24 ;
  assign bank_mem[24].dma_read_addr12_to_bank  = dma_read_addr12_to_bank24  ;
  assign bank_mem[24].dma_write_addr12_to_bank = dma_write_addr12_to_bank24 ;
  assign bank_mem[24].dma_read_addr13_to_bank  = dma_read_addr13_to_bank24  ;
  assign bank_mem[24].dma_write_addr13_to_bank = dma_write_addr13_to_bank24 ;
  assign bank_mem[24].dma_read_addr14_to_bank  = dma_read_addr14_to_bank24  ;
  assign bank_mem[24].dma_write_addr14_to_bank = dma_write_addr14_to_bank24 ;
  assign bank_mem[24].dma_read_addr15_to_bank  = dma_read_addr15_to_bank24  ;
  assign bank_mem[24].dma_write_addr15_to_bank = dma_write_addr15_to_bank24 ;
  assign bank_mem[24].dma_read_addr16_to_bank  = dma_read_addr16_to_bank24  ;
  assign bank_mem[24].dma_write_addr16_to_bank = dma_write_addr16_to_bank24 ;
  assign bank_mem[24].dma_read_addr17_to_bank  = dma_read_addr17_to_bank24  ;
  assign bank_mem[24].dma_write_addr17_to_bank = dma_write_addr17_to_bank24 ;
  assign bank_mem[24].dma_read_addr18_to_bank  = dma_read_addr18_to_bank24  ;
  assign bank_mem[24].dma_write_addr18_to_bank = dma_write_addr18_to_bank24 ;
  assign bank_mem[24].dma_read_addr19_to_bank  = dma_read_addr19_to_bank24  ;
  assign bank_mem[24].dma_write_addr19_to_bank = dma_write_addr19_to_bank24 ;
  assign bank_mem[24].dma_read_addr20_to_bank  = dma_read_addr20_to_bank24  ;
  assign bank_mem[24].dma_write_addr20_to_bank = dma_write_addr20_to_bank24 ;
  assign bank_mem[24].dma_read_addr21_to_bank  = dma_read_addr21_to_bank24  ;
  assign bank_mem[24].dma_write_addr21_to_bank = dma_write_addr21_to_bank24 ;
  assign bank_mem[24].dma_read_addr22_to_bank  = dma_read_addr22_to_bank24  ;
  assign bank_mem[24].dma_write_addr22_to_bank = dma_write_addr22_to_bank24 ;
  assign bank_mem[24].dma_read_addr23_to_bank  = dma_read_addr23_to_bank24  ;
  assign bank_mem[24].dma_write_addr23_to_bank = dma_write_addr23_to_bank24 ;
  assign bank_mem[24].dma_read_addr24_to_bank  = dma_read_addr24_to_bank24  ;
  assign bank_mem[24].dma_write_addr24_to_bank = dma_write_addr24_to_bank24 ;
  assign bank_mem[24].dma_read_addr25_to_bank  = dma_read_addr25_to_bank24  ;
  assign bank_mem[24].dma_write_addr25_to_bank = dma_write_addr25_to_bank24 ;
  assign bank_mem[24].dma_read_addr26_to_bank  = dma_read_addr26_to_bank24  ;
  assign bank_mem[24].dma_write_addr26_to_bank = dma_write_addr26_to_bank24 ;
  assign bank_mem[24].dma_read_addr27_to_bank  = dma_read_addr27_to_bank24  ;
  assign bank_mem[24].dma_write_addr27_to_bank = dma_write_addr27_to_bank24 ;
  assign bank_mem[24].dma_read_addr28_to_bank  = dma_read_addr28_to_bank24  ;
  assign bank_mem[24].dma_write_addr28_to_bank = dma_write_addr28_to_bank24 ;
  assign bank_mem[24].dma_read_addr29_to_bank  = dma_read_addr29_to_bank24  ;
  assign bank_mem[24].dma_write_addr29_to_bank = dma_write_addr29_to_bank24 ;
  assign bank_mem[24].dma_read_addr30_to_bank  = dma_read_addr30_to_bank24  ;
  assign bank_mem[24].dma_write_addr30_to_bank = dma_write_addr30_to_bank24 ;
  assign bank_mem[24].dma_read_addr31_to_bank  = dma_read_addr31_to_bank24  ;
  assign bank_mem[24].dma_write_addr31_to_bank = dma_write_addr31_to_bank24 ;
  assign bank_mem[25].dma_read_addr0_to_bank  = dma_read_addr0_to_bank25  ;
  assign bank_mem[25].dma_write_addr0_to_bank = dma_write_addr0_to_bank25 ;
  assign bank_mem[25].dma_read_addr1_to_bank  = dma_read_addr1_to_bank25  ;
  assign bank_mem[25].dma_write_addr1_to_bank = dma_write_addr1_to_bank25 ;
  assign bank_mem[25].dma_read_addr2_to_bank  = dma_read_addr2_to_bank25  ;
  assign bank_mem[25].dma_write_addr2_to_bank = dma_write_addr2_to_bank25 ;
  assign bank_mem[25].dma_read_addr3_to_bank  = dma_read_addr3_to_bank25  ;
  assign bank_mem[25].dma_write_addr3_to_bank = dma_write_addr3_to_bank25 ;
  assign bank_mem[25].dma_read_addr4_to_bank  = dma_read_addr4_to_bank25  ;
  assign bank_mem[25].dma_write_addr4_to_bank = dma_write_addr4_to_bank25 ;
  assign bank_mem[25].dma_read_addr5_to_bank  = dma_read_addr5_to_bank25  ;
  assign bank_mem[25].dma_write_addr5_to_bank = dma_write_addr5_to_bank25 ;
  assign bank_mem[25].dma_read_addr6_to_bank  = dma_read_addr6_to_bank25  ;
  assign bank_mem[25].dma_write_addr6_to_bank = dma_write_addr6_to_bank25 ;
  assign bank_mem[25].dma_read_addr7_to_bank  = dma_read_addr7_to_bank25  ;
  assign bank_mem[25].dma_write_addr7_to_bank = dma_write_addr7_to_bank25 ;
  assign bank_mem[25].dma_read_addr8_to_bank  = dma_read_addr8_to_bank25  ;
  assign bank_mem[25].dma_write_addr8_to_bank = dma_write_addr8_to_bank25 ;
  assign bank_mem[25].dma_read_addr9_to_bank  = dma_read_addr9_to_bank25  ;
  assign bank_mem[25].dma_write_addr9_to_bank = dma_write_addr9_to_bank25 ;
  assign bank_mem[25].dma_read_addr10_to_bank  = dma_read_addr10_to_bank25  ;
  assign bank_mem[25].dma_write_addr10_to_bank = dma_write_addr10_to_bank25 ;
  assign bank_mem[25].dma_read_addr11_to_bank  = dma_read_addr11_to_bank25  ;
  assign bank_mem[25].dma_write_addr11_to_bank = dma_write_addr11_to_bank25 ;
  assign bank_mem[25].dma_read_addr12_to_bank  = dma_read_addr12_to_bank25  ;
  assign bank_mem[25].dma_write_addr12_to_bank = dma_write_addr12_to_bank25 ;
  assign bank_mem[25].dma_read_addr13_to_bank  = dma_read_addr13_to_bank25  ;
  assign bank_mem[25].dma_write_addr13_to_bank = dma_write_addr13_to_bank25 ;
  assign bank_mem[25].dma_read_addr14_to_bank  = dma_read_addr14_to_bank25  ;
  assign bank_mem[25].dma_write_addr14_to_bank = dma_write_addr14_to_bank25 ;
  assign bank_mem[25].dma_read_addr15_to_bank  = dma_read_addr15_to_bank25  ;
  assign bank_mem[25].dma_write_addr15_to_bank = dma_write_addr15_to_bank25 ;
  assign bank_mem[25].dma_read_addr16_to_bank  = dma_read_addr16_to_bank25  ;
  assign bank_mem[25].dma_write_addr16_to_bank = dma_write_addr16_to_bank25 ;
  assign bank_mem[25].dma_read_addr17_to_bank  = dma_read_addr17_to_bank25  ;
  assign bank_mem[25].dma_write_addr17_to_bank = dma_write_addr17_to_bank25 ;
  assign bank_mem[25].dma_read_addr18_to_bank  = dma_read_addr18_to_bank25  ;
  assign bank_mem[25].dma_write_addr18_to_bank = dma_write_addr18_to_bank25 ;
  assign bank_mem[25].dma_read_addr19_to_bank  = dma_read_addr19_to_bank25  ;
  assign bank_mem[25].dma_write_addr19_to_bank = dma_write_addr19_to_bank25 ;
  assign bank_mem[25].dma_read_addr20_to_bank  = dma_read_addr20_to_bank25  ;
  assign bank_mem[25].dma_write_addr20_to_bank = dma_write_addr20_to_bank25 ;
  assign bank_mem[25].dma_read_addr21_to_bank  = dma_read_addr21_to_bank25  ;
  assign bank_mem[25].dma_write_addr21_to_bank = dma_write_addr21_to_bank25 ;
  assign bank_mem[25].dma_read_addr22_to_bank  = dma_read_addr22_to_bank25  ;
  assign bank_mem[25].dma_write_addr22_to_bank = dma_write_addr22_to_bank25 ;
  assign bank_mem[25].dma_read_addr23_to_bank  = dma_read_addr23_to_bank25  ;
  assign bank_mem[25].dma_write_addr23_to_bank = dma_write_addr23_to_bank25 ;
  assign bank_mem[25].dma_read_addr24_to_bank  = dma_read_addr24_to_bank25  ;
  assign bank_mem[25].dma_write_addr24_to_bank = dma_write_addr24_to_bank25 ;
  assign bank_mem[25].dma_read_addr25_to_bank  = dma_read_addr25_to_bank25  ;
  assign bank_mem[25].dma_write_addr25_to_bank = dma_write_addr25_to_bank25 ;
  assign bank_mem[25].dma_read_addr26_to_bank  = dma_read_addr26_to_bank25  ;
  assign bank_mem[25].dma_write_addr26_to_bank = dma_write_addr26_to_bank25 ;
  assign bank_mem[25].dma_read_addr27_to_bank  = dma_read_addr27_to_bank25  ;
  assign bank_mem[25].dma_write_addr27_to_bank = dma_write_addr27_to_bank25 ;
  assign bank_mem[25].dma_read_addr28_to_bank  = dma_read_addr28_to_bank25  ;
  assign bank_mem[25].dma_write_addr28_to_bank = dma_write_addr28_to_bank25 ;
  assign bank_mem[25].dma_read_addr29_to_bank  = dma_read_addr29_to_bank25  ;
  assign bank_mem[25].dma_write_addr29_to_bank = dma_write_addr29_to_bank25 ;
  assign bank_mem[25].dma_read_addr30_to_bank  = dma_read_addr30_to_bank25  ;
  assign bank_mem[25].dma_write_addr30_to_bank = dma_write_addr30_to_bank25 ;
  assign bank_mem[25].dma_read_addr31_to_bank  = dma_read_addr31_to_bank25  ;
  assign bank_mem[25].dma_write_addr31_to_bank = dma_write_addr31_to_bank25 ;
  assign bank_mem[26].dma_read_addr0_to_bank  = dma_read_addr0_to_bank26  ;
  assign bank_mem[26].dma_write_addr0_to_bank = dma_write_addr0_to_bank26 ;
  assign bank_mem[26].dma_read_addr1_to_bank  = dma_read_addr1_to_bank26  ;
  assign bank_mem[26].dma_write_addr1_to_bank = dma_write_addr1_to_bank26 ;
  assign bank_mem[26].dma_read_addr2_to_bank  = dma_read_addr2_to_bank26  ;
  assign bank_mem[26].dma_write_addr2_to_bank = dma_write_addr2_to_bank26 ;
  assign bank_mem[26].dma_read_addr3_to_bank  = dma_read_addr3_to_bank26  ;
  assign bank_mem[26].dma_write_addr3_to_bank = dma_write_addr3_to_bank26 ;
  assign bank_mem[26].dma_read_addr4_to_bank  = dma_read_addr4_to_bank26  ;
  assign bank_mem[26].dma_write_addr4_to_bank = dma_write_addr4_to_bank26 ;
  assign bank_mem[26].dma_read_addr5_to_bank  = dma_read_addr5_to_bank26  ;
  assign bank_mem[26].dma_write_addr5_to_bank = dma_write_addr5_to_bank26 ;
  assign bank_mem[26].dma_read_addr6_to_bank  = dma_read_addr6_to_bank26  ;
  assign bank_mem[26].dma_write_addr6_to_bank = dma_write_addr6_to_bank26 ;
  assign bank_mem[26].dma_read_addr7_to_bank  = dma_read_addr7_to_bank26  ;
  assign bank_mem[26].dma_write_addr7_to_bank = dma_write_addr7_to_bank26 ;
  assign bank_mem[26].dma_read_addr8_to_bank  = dma_read_addr8_to_bank26  ;
  assign bank_mem[26].dma_write_addr8_to_bank = dma_write_addr8_to_bank26 ;
  assign bank_mem[26].dma_read_addr9_to_bank  = dma_read_addr9_to_bank26  ;
  assign bank_mem[26].dma_write_addr9_to_bank = dma_write_addr9_to_bank26 ;
  assign bank_mem[26].dma_read_addr10_to_bank  = dma_read_addr10_to_bank26  ;
  assign bank_mem[26].dma_write_addr10_to_bank = dma_write_addr10_to_bank26 ;
  assign bank_mem[26].dma_read_addr11_to_bank  = dma_read_addr11_to_bank26  ;
  assign bank_mem[26].dma_write_addr11_to_bank = dma_write_addr11_to_bank26 ;
  assign bank_mem[26].dma_read_addr12_to_bank  = dma_read_addr12_to_bank26  ;
  assign bank_mem[26].dma_write_addr12_to_bank = dma_write_addr12_to_bank26 ;
  assign bank_mem[26].dma_read_addr13_to_bank  = dma_read_addr13_to_bank26  ;
  assign bank_mem[26].dma_write_addr13_to_bank = dma_write_addr13_to_bank26 ;
  assign bank_mem[26].dma_read_addr14_to_bank  = dma_read_addr14_to_bank26  ;
  assign bank_mem[26].dma_write_addr14_to_bank = dma_write_addr14_to_bank26 ;
  assign bank_mem[26].dma_read_addr15_to_bank  = dma_read_addr15_to_bank26  ;
  assign bank_mem[26].dma_write_addr15_to_bank = dma_write_addr15_to_bank26 ;
  assign bank_mem[26].dma_read_addr16_to_bank  = dma_read_addr16_to_bank26  ;
  assign bank_mem[26].dma_write_addr16_to_bank = dma_write_addr16_to_bank26 ;
  assign bank_mem[26].dma_read_addr17_to_bank  = dma_read_addr17_to_bank26  ;
  assign bank_mem[26].dma_write_addr17_to_bank = dma_write_addr17_to_bank26 ;
  assign bank_mem[26].dma_read_addr18_to_bank  = dma_read_addr18_to_bank26  ;
  assign bank_mem[26].dma_write_addr18_to_bank = dma_write_addr18_to_bank26 ;
  assign bank_mem[26].dma_read_addr19_to_bank  = dma_read_addr19_to_bank26  ;
  assign bank_mem[26].dma_write_addr19_to_bank = dma_write_addr19_to_bank26 ;
  assign bank_mem[26].dma_read_addr20_to_bank  = dma_read_addr20_to_bank26  ;
  assign bank_mem[26].dma_write_addr20_to_bank = dma_write_addr20_to_bank26 ;
  assign bank_mem[26].dma_read_addr21_to_bank  = dma_read_addr21_to_bank26  ;
  assign bank_mem[26].dma_write_addr21_to_bank = dma_write_addr21_to_bank26 ;
  assign bank_mem[26].dma_read_addr22_to_bank  = dma_read_addr22_to_bank26  ;
  assign bank_mem[26].dma_write_addr22_to_bank = dma_write_addr22_to_bank26 ;
  assign bank_mem[26].dma_read_addr23_to_bank  = dma_read_addr23_to_bank26  ;
  assign bank_mem[26].dma_write_addr23_to_bank = dma_write_addr23_to_bank26 ;
  assign bank_mem[26].dma_read_addr24_to_bank  = dma_read_addr24_to_bank26  ;
  assign bank_mem[26].dma_write_addr24_to_bank = dma_write_addr24_to_bank26 ;
  assign bank_mem[26].dma_read_addr25_to_bank  = dma_read_addr25_to_bank26  ;
  assign bank_mem[26].dma_write_addr25_to_bank = dma_write_addr25_to_bank26 ;
  assign bank_mem[26].dma_read_addr26_to_bank  = dma_read_addr26_to_bank26  ;
  assign bank_mem[26].dma_write_addr26_to_bank = dma_write_addr26_to_bank26 ;
  assign bank_mem[26].dma_read_addr27_to_bank  = dma_read_addr27_to_bank26  ;
  assign bank_mem[26].dma_write_addr27_to_bank = dma_write_addr27_to_bank26 ;
  assign bank_mem[26].dma_read_addr28_to_bank  = dma_read_addr28_to_bank26  ;
  assign bank_mem[26].dma_write_addr28_to_bank = dma_write_addr28_to_bank26 ;
  assign bank_mem[26].dma_read_addr29_to_bank  = dma_read_addr29_to_bank26  ;
  assign bank_mem[26].dma_write_addr29_to_bank = dma_write_addr29_to_bank26 ;
  assign bank_mem[26].dma_read_addr30_to_bank  = dma_read_addr30_to_bank26  ;
  assign bank_mem[26].dma_write_addr30_to_bank = dma_write_addr30_to_bank26 ;
  assign bank_mem[26].dma_read_addr31_to_bank  = dma_read_addr31_to_bank26  ;
  assign bank_mem[26].dma_write_addr31_to_bank = dma_write_addr31_to_bank26 ;
  assign bank_mem[27].dma_read_addr0_to_bank  = dma_read_addr0_to_bank27  ;
  assign bank_mem[27].dma_write_addr0_to_bank = dma_write_addr0_to_bank27 ;
  assign bank_mem[27].dma_read_addr1_to_bank  = dma_read_addr1_to_bank27  ;
  assign bank_mem[27].dma_write_addr1_to_bank = dma_write_addr1_to_bank27 ;
  assign bank_mem[27].dma_read_addr2_to_bank  = dma_read_addr2_to_bank27  ;
  assign bank_mem[27].dma_write_addr2_to_bank = dma_write_addr2_to_bank27 ;
  assign bank_mem[27].dma_read_addr3_to_bank  = dma_read_addr3_to_bank27  ;
  assign bank_mem[27].dma_write_addr3_to_bank = dma_write_addr3_to_bank27 ;
  assign bank_mem[27].dma_read_addr4_to_bank  = dma_read_addr4_to_bank27  ;
  assign bank_mem[27].dma_write_addr4_to_bank = dma_write_addr4_to_bank27 ;
  assign bank_mem[27].dma_read_addr5_to_bank  = dma_read_addr5_to_bank27  ;
  assign bank_mem[27].dma_write_addr5_to_bank = dma_write_addr5_to_bank27 ;
  assign bank_mem[27].dma_read_addr6_to_bank  = dma_read_addr6_to_bank27  ;
  assign bank_mem[27].dma_write_addr6_to_bank = dma_write_addr6_to_bank27 ;
  assign bank_mem[27].dma_read_addr7_to_bank  = dma_read_addr7_to_bank27  ;
  assign bank_mem[27].dma_write_addr7_to_bank = dma_write_addr7_to_bank27 ;
  assign bank_mem[27].dma_read_addr8_to_bank  = dma_read_addr8_to_bank27  ;
  assign bank_mem[27].dma_write_addr8_to_bank = dma_write_addr8_to_bank27 ;
  assign bank_mem[27].dma_read_addr9_to_bank  = dma_read_addr9_to_bank27  ;
  assign bank_mem[27].dma_write_addr9_to_bank = dma_write_addr9_to_bank27 ;
  assign bank_mem[27].dma_read_addr10_to_bank  = dma_read_addr10_to_bank27  ;
  assign bank_mem[27].dma_write_addr10_to_bank = dma_write_addr10_to_bank27 ;
  assign bank_mem[27].dma_read_addr11_to_bank  = dma_read_addr11_to_bank27  ;
  assign bank_mem[27].dma_write_addr11_to_bank = dma_write_addr11_to_bank27 ;
  assign bank_mem[27].dma_read_addr12_to_bank  = dma_read_addr12_to_bank27  ;
  assign bank_mem[27].dma_write_addr12_to_bank = dma_write_addr12_to_bank27 ;
  assign bank_mem[27].dma_read_addr13_to_bank  = dma_read_addr13_to_bank27  ;
  assign bank_mem[27].dma_write_addr13_to_bank = dma_write_addr13_to_bank27 ;
  assign bank_mem[27].dma_read_addr14_to_bank  = dma_read_addr14_to_bank27  ;
  assign bank_mem[27].dma_write_addr14_to_bank = dma_write_addr14_to_bank27 ;
  assign bank_mem[27].dma_read_addr15_to_bank  = dma_read_addr15_to_bank27  ;
  assign bank_mem[27].dma_write_addr15_to_bank = dma_write_addr15_to_bank27 ;
  assign bank_mem[27].dma_read_addr16_to_bank  = dma_read_addr16_to_bank27  ;
  assign bank_mem[27].dma_write_addr16_to_bank = dma_write_addr16_to_bank27 ;
  assign bank_mem[27].dma_read_addr17_to_bank  = dma_read_addr17_to_bank27  ;
  assign bank_mem[27].dma_write_addr17_to_bank = dma_write_addr17_to_bank27 ;
  assign bank_mem[27].dma_read_addr18_to_bank  = dma_read_addr18_to_bank27  ;
  assign bank_mem[27].dma_write_addr18_to_bank = dma_write_addr18_to_bank27 ;
  assign bank_mem[27].dma_read_addr19_to_bank  = dma_read_addr19_to_bank27  ;
  assign bank_mem[27].dma_write_addr19_to_bank = dma_write_addr19_to_bank27 ;
  assign bank_mem[27].dma_read_addr20_to_bank  = dma_read_addr20_to_bank27  ;
  assign bank_mem[27].dma_write_addr20_to_bank = dma_write_addr20_to_bank27 ;
  assign bank_mem[27].dma_read_addr21_to_bank  = dma_read_addr21_to_bank27  ;
  assign bank_mem[27].dma_write_addr21_to_bank = dma_write_addr21_to_bank27 ;
  assign bank_mem[27].dma_read_addr22_to_bank  = dma_read_addr22_to_bank27  ;
  assign bank_mem[27].dma_write_addr22_to_bank = dma_write_addr22_to_bank27 ;
  assign bank_mem[27].dma_read_addr23_to_bank  = dma_read_addr23_to_bank27  ;
  assign bank_mem[27].dma_write_addr23_to_bank = dma_write_addr23_to_bank27 ;
  assign bank_mem[27].dma_read_addr24_to_bank  = dma_read_addr24_to_bank27  ;
  assign bank_mem[27].dma_write_addr24_to_bank = dma_write_addr24_to_bank27 ;
  assign bank_mem[27].dma_read_addr25_to_bank  = dma_read_addr25_to_bank27  ;
  assign bank_mem[27].dma_write_addr25_to_bank = dma_write_addr25_to_bank27 ;
  assign bank_mem[27].dma_read_addr26_to_bank  = dma_read_addr26_to_bank27  ;
  assign bank_mem[27].dma_write_addr26_to_bank = dma_write_addr26_to_bank27 ;
  assign bank_mem[27].dma_read_addr27_to_bank  = dma_read_addr27_to_bank27  ;
  assign bank_mem[27].dma_write_addr27_to_bank = dma_write_addr27_to_bank27 ;
  assign bank_mem[27].dma_read_addr28_to_bank  = dma_read_addr28_to_bank27  ;
  assign bank_mem[27].dma_write_addr28_to_bank = dma_write_addr28_to_bank27 ;
  assign bank_mem[27].dma_read_addr29_to_bank  = dma_read_addr29_to_bank27  ;
  assign bank_mem[27].dma_write_addr29_to_bank = dma_write_addr29_to_bank27 ;
  assign bank_mem[27].dma_read_addr30_to_bank  = dma_read_addr30_to_bank27  ;
  assign bank_mem[27].dma_write_addr30_to_bank = dma_write_addr30_to_bank27 ;
  assign bank_mem[27].dma_read_addr31_to_bank  = dma_read_addr31_to_bank27  ;
  assign bank_mem[27].dma_write_addr31_to_bank = dma_write_addr31_to_bank27 ;
  assign bank_mem[28].dma_read_addr0_to_bank  = dma_read_addr0_to_bank28  ;
  assign bank_mem[28].dma_write_addr0_to_bank = dma_write_addr0_to_bank28 ;
  assign bank_mem[28].dma_read_addr1_to_bank  = dma_read_addr1_to_bank28  ;
  assign bank_mem[28].dma_write_addr1_to_bank = dma_write_addr1_to_bank28 ;
  assign bank_mem[28].dma_read_addr2_to_bank  = dma_read_addr2_to_bank28  ;
  assign bank_mem[28].dma_write_addr2_to_bank = dma_write_addr2_to_bank28 ;
  assign bank_mem[28].dma_read_addr3_to_bank  = dma_read_addr3_to_bank28  ;
  assign bank_mem[28].dma_write_addr3_to_bank = dma_write_addr3_to_bank28 ;
  assign bank_mem[28].dma_read_addr4_to_bank  = dma_read_addr4_to_bank28  ;
  assign bank_mem[28].dma_write_addr4_to_bank = dma_write_addr4_to_bank28 ;
  assign bank_mem[28].dma_read_addr5_to_bank  = dma_read_addr5_to_bank28  ;
  assign bank_mem[28].dma_write_addr5_to_bank = dma_write_addr5_to_bank28 ;
  assign bank_mem[28].dma_read_addr6_to_bank  = dma_read_addr6_to_bank28  ;
  assign bank_mem[28].dma_write_addr6_to_bank = dma_write_addr6_to_bank28 ;
  assign bank_mem[28].dma_read_addr7_to_bank  = dma_read_addr7_to_bank28  ;
  assign bank_mem[28].dma_write_addr7_to_bank = dma_write_addr7_to_bank28 ;
  assign bank_mem[28].dma_read_addr8_to_bank  = dma_read_addr8_to_bank28  ;
  assign bank_mem[28].dma_write_addr8_to_bank = dma_write_addr8_to_bank28 ;
  assign bank_mem[28].dma_read_addr9_to_bank  = dma_read_addr9_to_bank28  ;
  assign bank_mem[28].dma_write_addr9_to_bank = dma_write_addr9_to_bank28 ;
  assign bank_mem[28].dma_read_addr10_to_bank  = dma_read_addr10_to_bank28  ;
  assign bank_mem[28].dma_write_addr10_to_bank = dma_write_addr10_to_bank28 ;
  assign bank_mem[28].dma_read_addr11_to_bank  = dma_read_addr11_to_bank28  ;
  assign bank_mem[28].dma_write_addr11_to_bank = dma_write_addr11_to_bank28 ;
  assign bank_mem[28].dma_read_addr12_to_bank  = dma_read_addr12_to_bank28  ;
  assign bank_mem[28].dma_write_addr12_to_bank = dma_write_addr12_to_bank28 ;
  assign bank_mem[28].dma_read_addr13_to_bank  = dma_read_addr13_to_bank28  ;
  assign bank_mem[28].dma_write_addr13_to_bank = dma_write_addr13_to_bank28 ;
  assign bank_mem[28].dma_read_addr14_to_bank  = dma_read_addr14_to_bank28  ;
  assign bank_mem[28].dma_write_addr14_to_bank = dma_write_addr14_to_bank28 ;
  assign bank_mem[28].dma_read_addr15_to_bank  = dma_read_addr15_to_bank28  ;
  assign bank_mem[28].dma_write_addr15_to_bank = dma_write_addr15_to_bank28 ;
  assign bank_mem[28].dma_read_addr16_to_bank  = dma_read_addr16_to_bank28  ;
  assign bank_mem[28].dma_write_addr16_to_bank = dma_write_addr16_to_bank28 ;
  assign bank_mem[28].dma_read_addr17_to_bank  = dma_read_addr17_to_bank28  ;
  assign bank_mem[28].dma_write_addr17_to_bank = dma_write_addr17_to_bank28 ;
  assign bank_mem[28].dma_read_addr18_to_bank  = dma_read_addr18_to_bank28  ;
  assign bank_mem[28].dma_write_addr18_to_bank = dma_write_addr18_to_bank28 ;
  assign bank_mem[28].dma_read_addr19_to_bank  = dma_read_addr19_to_bank28  ;
  assign bank_mem[28].dma_write_addr19_to_bank = dma_write_addr19_to_bank28 ;
  assign bank_mem[28].dma_read_addr20_to_bank  = dma_read_addr20_to_bank28  ;
  assign bank_mem[28].dma_write_addr20_to_bank = dma_write_addr20_to_bank28 ;
  assign bank_mem[28].dma_read_addr21_to_bank  = dma_read_addr21_to_bank28  ;
  assign bank_mem[28].dma_write_addr21_to_bank = dma_write_addr21_to_bank28 ;
  assign bank_mem[28].dma_read_addr22_to_bank  = dma_read_addr22_to_bank28  ;
  assign bank_mem[28].dma_write_addr22_to_bank = dma_write_addr22_to_bank28 ;
  assign bank_mem[28].dma_read_addr23_to_bank  = dma_read_addr23_to_bank28  ;
  assign bank_mem[28].dma_write_addr23_to_bank = dma_write_addr23_to_bank28 ;
  assign bank_mem[28].dma_read_addr24_to_bank  = dma_read_addr24_to_bank28  ;
  assign bank_mem[28].dma_write_addr24_to_bank = dma_write_addr24_to_bank28 ;
  assign bank_mem[28].dma_read_addr25_to_bank  = dma_read_addr25_to_bank28  ;
  assign bank_mem[28].dma_write_addr25_to_bank = dma_write_addr25_to_bank28 ;
  assign bank_mem[28].dma_read_addr26_to_bank  = dma_read_addr26_to_bank28  ;
  assign bank_mem[28].dma_write_addr26_to_bank = dma_write_addr26_to_bank28 ;
  assign bank_mem[28].dma_read_addr27_to_bank  = dma_read_addr27_to_bank28  ;
  assign bank_mem[28].dma_write_addr27_to_bank = dma_write_addr27_to_bank28 ;
  assign bank_mem[28].dma_read_addr28_to_bank  = dma_read_addr28_to_bank28  ;
  assign bank_mem[28].dma_write_addr28_to_bank = dma_write_addr28_to_bank28 ;
  assign bank_mem[28].dma_read_addr29_to_bank  = dma_read_addr29_to_bank28  ;
  assign bank_mem[28].dma_write_addr29_to_bank = dma_write_addr29_to_bank28 ;
  assign bank_mem[28].dma_read_addr30_to_bank  = dma_read_addr30_to_bank28  ;
  assign bank_mem[28].dma_write_addr30_to_bank = dma_write_addr30_to_bank28 ;
  assign bank_mem[28].dma_read_addr31_to_bank  = dma_read_addr31_to_bank28  ;
  assign bank_mem[28].dma_write_addr31_to_bank = dma_write_addr31_to_bank28 ;
  assign bank_mem[29].dma_read_addr0_to_bank  = dma_read_addr0_to_bank29  ;
  assign bank_mem[29].dma_write_addr0_to_bank = dma_write_addr0_to_bank29 ;
  assign bank_mem[29].dma_read_addr1_to_bank  = dma_read_addr1_to_bank29  ;
  assign bank_mem[29].dma_write_addr1_to_bank = dma_write_addr1_to_bank29 ;
  assign bank_mem[29].dma_read_addr2_to_bank  = dma_read_addr2_to_bank29  ;
  assign bank_mem[29].dma_write_addr2_to_bank = dma_write_addr2_to_bank29 ;
  assign bank_mem[29].dma_read_addr3_to_bank  = dma_read_addr3_to_bank29  ;
  assign bank_mem[29].dma_write_addr3_to_bank = dma_write_addr3_to_bank29 ;
  assign bank_mem[29].dma_read_addr4_to_bank  = dma_read_addr4_to_bank29  ;
  assign bank_mem[29].dma_write_addr4_to_bank = dma_write_addr4_to_bank29 ;
  assign bank_mem[29].dma_read_addr5_to_bank  = dma_read_addr5_to_bank29  ;
  assign bank_mem[29].dma_write_addr5_to_bank = dma_write_addr5_to_bank29 ;
  assign bank_mem[29].dma_read_addr6_to_bank  = dma_read_addr6_to_bank29  ;
  assign bank_mem[29].dma_write_addr6_to_bank = dma_write_addr6_to_bank29 ;
  assign bank_mem[29].dma_read_addr7_to_bank  = dma_read_addr7_to_bank29  ;
  assign bank_mem[29].dma_write_addr7_to_bank = dma_write_addr7_to_bank29 ;
  assign bank_mem[29].dma_read_addr8_to_bank  = dma_read_addr8_to_bank29  ;
  assign bank_mem[29].dma_write_addr8_to_bank = dma_write_addr8_to_bank29 ;
  assign bank_mem[29].dma_read_addr9_to_bank  = dma_read_addr9_to_bank29  ;
  assign bank_mem[29].dma_write_addr9_to_bank = dma_write_addr9_to_bank29 ;
  assign bank_mem[29].dma_read_addr10_to_bank  = dma_read_addr10_to_bank29  ;
  assign bank_mem[29].dma_write_addr10_to_bank = dma_write_addr10_to_bank29 ;
  assign bank_mem[29].dma_read_addr11_to_bank  = dma_read_addr11_to_bank29  ;
  assign bank_mem[29].dma_write_addr11_to_bank = dma_write_addr11_to_bank29 ;
  assign bank_mem[29].dma_read_addr12_to_bank  = dma_read_addr12_to_bank29  ;
  assign bank_mem[29].dma_write_addr12_to_bank = dma_write_addr12_to_bank29 ;
  assign bank_mem[29].dma_read_addr13_to_bank  = dma_read_addr13_to_bank29  ;
  assign bank_mem[29].dma_write_addr13_to_bank = dma_write_addr13_to_bank29 ;
  assign bank_mem[29].dma_read_addr14_to_bank  = dma_read_addr14_to_bank29  ;
  assign bank_mem[29].dma_write_addr14_to_bank = dma_write_addr14_to_bank29 ;
  assign bank_mem[29].dma_read_addr15_to_bank  = dma_read_addr15_to_bank29  ;
  assign bank_mem[29].dma_write_addr15_to_bank = dma_write_addr15_to_bank29 ;
  assign bank_mem[29].dma_read_addr16_to_bank  = dma_read_addr16_to_bank29  ;
  assign bank_mem[29].dma_write_addr16_to_bank = dma_write_addr16_to_bank29 ;
  assign bank_mem[29].dma_read_addr17_to_bank  = dma_read_addr17_to_bank29  ;
  assign bank_mem[29].dma_write_addr17_to_bank = dma_write_addr17_to_bank29 ;
  assign bank_mem[29].dma_read_addr18_to_bank  = dma_read_addr18_to_bank29  ;
  assign bank_mem[29].dma_write_addr18_to_bank = dma_write_addr18_to_bank29 ;
  assign bank_mem[29].dma_read_addr19_to_bank  = dma_read_addr19_to_bank29  ;
  assign bank_mem[29].dma_write_addr19_to_bank = dma_write_addr19_to_bank29 ;
  assign bank_mem[29].dma_read_addr20_to_bank  = dma_read_addr20_to_bank29  ;
  assign bank_mem[29].dma_write_addr20_to_bank = dma_write_addr20_to_bank29 ;
  assign bank_mem[29].dma_read_addr21_to_bank  = dma_read_addr21_to_bank29  ;
  assign bank_mem[29].dma_write_addr21_to_bank = dma_write_addr21_to_bank29 ;
  assign bank_mem[29].dma_read_addr22_to_bank  = dma_read_addr22_to_bank29  ;
  assign bank_mem[29].dma_write_addr22_to_bank = dma_write_addr22_to_bank29 ;
  assign bank_mem[29].dma_read_addr23_to_bank  = dma_read_addr23_to_bank29  ;
  assign bank_mem[29].dma_write_addr23_to_bank = dma_write_addr23_to_bank29 ;
  assign bank_mem[29].dma_read_addr24_to_bank  = dma_read_addr24_to_bank29  ;
  assign bank_mem[29].dma_write_addr24_to_bank = dma_write_addr24_to_bank29 ;
  assign bank_mem[29].dma_read_addr25_to_bank  = dma_read_addr25_to_bank29  ;
  assign bank_mem[29].dma_write_addr25_to_bank = dma_write_addr25_to_bank29 ;
  assign bank_mem[29].dma_read_addr26_to_bank  = dma_read_addr26_to_bank29  ;
  assign bank_mem[29].dma_write_addr26_to_bank = dma_write_addr26_to_bank29 ;
  assign bank_mem[29].dma_read_addr27_to_bank  = dma_read_addr27_to_bank29  ;
  assign bank_mem[29].dma_write_addr27_to_bank = dma_write_addr27_to_bank29 ;
  assign bank_mem[29].dma_read_addr28_to_bank  = dma_read_addr28_to_bank29  ;
  assign bank_mem[29].dma_write_addr28_to_bank = dma_write_addr28_to_bank29 ;
  assign bank_mem[29].dma_read_addr29_to_bank  = dma_read_addr29_to_bank29  ;
  assign bank_mem[29].dma_write_addr29_to_bank = dma_write_addr29_to_bank29 ;
  assign bank_mem[29].dma_read_addr30_to_bank  = dma_read_addr30_to_bank29  ;
  assign bank_mem[29].dma_write_addr30_to_bank = dma_write_addr30_to_bank29 ;
  assign bank_mem[29].dma_read_addr31_to_bank  = dma_read_addr31_to_bank29  ;
  assign bank_mem[29].dma_write_addr31_to_bank = dma_write_addr31_to_bank29 ;
  assign bank_mem[30].dma_read_addr0_to_bank  = dma_read_addr0_to_bank30  ;
  assign bank_mem[30].dma_write_addr0_to_bank = dma_write_addr0_to_bank30 ;
  assign bank_mem[30].dma_read_addr1_to_bank  = dma_read_addr1_to_bank30  ;
  assign bank_mem[30].dma_write_addr1_to_bank = dma_write_addr1_to_bank30 ;
  assign bank_mem[30].dma_read_addr2_to_bank  = dma_read_addr2_to_bank30  ;
  assign bank_mem[30].dma_write_addr2_to_bank = dma_write_addr2_to_bank30 ;
  assign bank_mem[30].dma_read_addr3_to_bank  = dma_read_addr3_to_bank30  ;
  assign bank_mem[30].dma_write_addr3_to_bank = dma_write_addr3_to_bank30 ;
  assign bank_mem[30].dma_read_addr4_to_bank  = dma_read_addr4_to_bank30  ;
  assign bank_mem[30].dma_write_addr4_to_bank = dma_write_addr4_to_bank30 ;
  assign bank_mem[30].dma_read_addr5_to_bank  = dma_read_addr5_to_bank30  ;
  assign bank_mem[30].dma_write_addr5_to_bank = dma_write_addr5_to_bank30 ;
  assign bank_mem[30].dma_read_addr6_to_bank  = dma_read_addr6_to_bank30  ;
  assign bank_mem[30].dma_write_addr6_to_bank = dma_write_addr6_to_bank30 ;
  assign bank_mem[30].dma_read_addr7_to_bank  = dma_read_addr7_to_bank30  ;
  assign bank_mem[30].dma_write_addr7_to_bank = dma_write_addr7_to_bank30 ;
  assign bank_mem[30].dma_read_addr8_to_bank  = dma_read_addr8_to_bank30  ;
  assign bank_mem[30].dma_write_addr8_to_bank = dma_write_addr8_to_bank30 ;
  assign bank_mem[30].dma_read_addr9_to_bank  = dma_read_addr9_to_bank30  ;
  assign bank_mem[30].dma_write_addr9_to_bank = dma_write_addr9_to_bank30 ;
  assign bank_mem[30].dma_read_addr10_to_bank  = dma_read_addr10_to_bank30  ;
  assign bank_mem[30].dma_write_addr10_to_bank = dma_write_addr10_to_bank30 ;
  assign bank_mem[30].dma_read_addr11_to_bank  = dma_read_addr11_to_bank30  ;
  assign bank_mem[30].dma_write_addr11_to_bank = dma_write_addr11_to_bank30 ;
  assign bank_mem[30].dma_read_addr12_to_bank  = dma_read_addr12_to_bank30  ;
  assign bank_mem[30].dma_write_addr12_to_bank = dma_write_addr12_to_bank30 ;
  assign bank_mem[30].dma_read_addr13_to_bank  = dma_read_addr13_to_bank30  ;
  assign bank_mem[30].dma_write_addr13_to_bank = dma_write_addr13_to_bank30 ;
  assign bank_mem[30].dma_read_addr14_to_bank  = dma_read_addr14_to_bank30  ;
  assign bank_mem[30].dma_write_addr14_to_bank = dma_write_addr14_to_bank30 ;
  assign bank_mem[30].dma_read_addr15_to_bank  = dma_read_addr15_to_bank30  ;
  assign bank_mem[30].dma_write_addr15_to_bank = dma_write_addr15_to_bank30 ;
  assign bank_mem[30].dma_read_addr16_to_bank  = dma_read_addr16_to_bank30  ;
  assign bank_mem[30].dma_write_addr16_to_bank = dma_write_addr16_to_bank30 ;
  assign bank_mem[30].dma_read_addr17_to_bank  = dma_read_addr17_to_bank30  ;
  assign bank_mem[30].dma_write_addr17_to_bank = dma_write_addr17_to_bank30 ;
  assign bank_mem[30].dma_read_addr18_to_bank  = dma_read_addr18_to_bank30  ;
  assign bank_mem[30].dma_write_addr18_to_bank = dma_write_addr18_to_bank30 ;
  assign bank_mem[30].dma_read_addr19_to_bank  = dma_read_addr19_to_bank30  ;
  assign bank_mem[30].dma_write_addr19_to_bank = dma_write_addr19_to_bank30 ;
  assign bank_mem[30].dma_read_addr20_to_bank  = dma_read_addr20_to_bank30  ;
  assign bank_mem[30].dma_write_addr20_to_bank = dma_write_addr20_to_bank30 ;
  assign bank_mem[30].dma_read_addr21_to_bank  = dma_read_addr21_to_bank30  ;
  assign bank_mem[30].dma_write_addr21_to_bank = dma_write_addr21_to_bank30 ;
  assign bank_mem[30].dma_read_addr22_to_bank  = dma_read_addr22_to_bank30  ;
  assign bank_mem[30].dma_write_addr22_to_bank = dma_write_addr22_to_bank30 ;
  assign bank_mem[30].dma_read_addr23_to_bank  = dma_read_addr23_to_bank30  ;
  assign bank_mem[30].dma_write_addr23_to_bank = dma_write_addr23_to_bank30 ;
  assign bank_mem[30].dma_read_addr24_to_bank  = dma_read_addr24_to_bank30  ;
  assign bank_mem[30].dma_write_addr24_to_bank = dma_write_addr24_to_bank30 ;
  assign bank_mem[30].dma_read_addr25_to_bank  = dma_read_addr25_to_bank30  ;
  assign bank_mem[30].dma_write_addr25_to_bank = dma_write_addr25_to_bank30 ;
  assign bank_mem[30].dma_read_addr26_to_bank  = dma_read_addr26_to_bank30  ;
  assign bank_mem[30].dma_write_addr26_to_bank = dma_write_addr26_to_bank30 ;
  assign bank_mem[30].dma_read_addr27_to_bank  = dma_read_addr27_to_bank30  ;
  assign bank_mem[30].dma_write_addr27_to_bank = dma_write_addr27_to_bank30 ;
  assign bank_mem[30].dma_read_addr28_to_bank  = dma_read_addr28_to_bank30  ;
  assign bank_mem[30].dma_write_addr28_to_bank = dma_write_addr28_to_bank30 ;
  assign bank_mem[30].dma_read_addr29_to_bank  = dma_read_addr29_to_bank30  ;
  assign bank_mem[30].dma_write_addr29_to_bank = dma_write_addr29_to_bank30 ;
  assign bank_mem[30].dma_read_addr30_to_bank  = dma_read_addr30_to_bank30  ;
  assign bank_mem[30].dma_write_addr30_to_bank = dma_write_addr30_to_bank30 ;
  assign bank_mem[30].dma_read_addr31_to_bank  = dma_read_addr31_to_bank30  ;
  assign bank_mem[30].dma_write_addr31_to_bank = dma_write_addr31_to_bank30 ;
  assign bank_mem[31].dma_read_addr0_to_bank  = dma_read_addr0_to_bank31  ;
  assign bank_mem[31].dma_write_addr0_to_bank = dma_write_addr0_to_bank31 ;
  assign bank_mem[31].dma_read_addr1_to_bank  = dma_read_addr1_to_bank31  ;
  assign bank_mem[31].dma_write_addr1_to_bank = dma_write_addr1_to_bank31 ;
  assign bank_mem[31].dma_read_addr2_to_bank  = dma_read_addr2_to_bank31  ;
  assign bank_mem[31].dma_write_addr2_to_bank = dma_write_addr2_to_bank31 ;
  assign bank_mem[31].dma_read_addr3_to_bank  = dma_read_addr3_to_bank31  ;
  assign bank_mem[31].dma_write_addr3_to_bank = dma_write_addr3_to_bank31 ;
  assign bank_mem[31].dma_read_addr4_to_bank  = dma_read_addr4_to_bank31  ;
  assign bank_mem[31].dma_write_addr4_to_bank = dma_write_addr4_to_bank31 ;
  assign bank_mem[31].dma_read_addr5_to_bank  = dma_read_addr5_to_bank31  ;
  assign bank_mem[31].dma_write_addr5_to_bank = dma_write_addr5_to_bank31 ;
  assign bank_mem[31].dma_read_addr6_to_bank  = dma_read_addr6_to_bank31  ;
  assign bank_mem[31].dma_write_addr6_to_bank = dma_write_addr6_to_bank31 ;
  assign bank_mem[31].dma_read_addr7_to_bank  = dma_read_addr7_to_bank31  ;
  assign bank_mem[31].dma_write_addr7_to_bank = dma_write_addr7_to_bank31 ;
  assign bank_mem[31].dma_read_addr8_to_bank  = dma_read_addr8_to_bank31  ;
  assign bank_mem[31].dma_write_addr8_to_bank = dma_write_addr8_to_bank31 ;
  assign bank_mem[31].dma_read_addr9_to_bank  = dma_read_addr9_to_bank31  ;
  assign bank_mem[31].dma_write_addr9_to_bank = dma_write_addr9_to_bank31 ;
  assign bank_mem[31].dma_read_addr10_to_bank  = dma_read_addr10_to_bank31  ;
  assign bank_mem[31].dma_write_addr10_to_bank = dma_write_addr10_to_bank31 ;
  assign bank_mem[31].dma_read_addr11_to_bank  = dma_read_addr11_to_bank31  ;
  assign bank_mem[31].dma_write_addr11_to_bank = dma_write_addr11_to_bank31 ;
  assign bank_mem[31].dma_read_addr12_to_bank  = dma_read_addr12_to_bank31  ;
  assign bank_mem[31].dma_write_addr12_to_bank = dma_write_addr12_to_bank31 ;
  assign bank_mem[31].dma_read_addr13_to_bank  = dma_read_addr13_to_bank31  ;
  assign bank_mem[31].dma_write_addr13_to_bank = dma_write_addr13_to_bank31 ;
  assign bank_mem[31].dma_read_addr14_to_bank  = dma_read_addr14_to_bank31  ;
  assign bank_mem[31].dma_write_addr14_to_bank = dma_write_addr14_to_bank31 ;
  assign bank_mem[31].dma_read_addr15_to_bank  = dma_read_addr15_to_bank31  ;
  assign bank_mem[31].dma_write_addr15_to_bank = dma_write_addr15_to_bank31 ;
  assign bank_mem[31].dma_read_addr16_to_bank  = dma_read_addr16_to_bank31  ;
  assign bank_mem[31].dma_write_addr16_to_bank = dma_write_addr16_to_bank31 ;
  assign bank_mem[31].dma_read_addr17_to_bank  = dma_read_addr17_to_bank31  ;
  assign bank_mem[31].dma_write_addr17_to_bank = dma_write_addr17_to_bank31 ;
  assign bank_mem[31].dma_read_addr18_to_bank  = dma_read_addr18_to_bank31  ;
  assign bank_mem[31].dma_write_addr18_to_bank = dma_write_addr18_to_bank31 ;
  assign bank_mem[31].dma_read_addr19_to_bank  = dma_read_addr19_to_bank31  ;
  assign bank_mem[31].dma_write_addr19_to_bank = dma_write_addr19_to_bank31 ;
  assign bank_mem[31].dma_read_addr20_to_bank  = dma_read_addr20_to_bank31  ;
  assign bank_mem[31].dma_write_addr20_to_bank = dma_write_addr20_to_bank31 ;
  assign bank_mem[31].dma_read_addr21_to_bank  = dma_read_addr21_to_bank31  ;
  assign bank_mem[31].dma_write_addr21_to_bank = dma_write_addr21_to_bank31 ;
  assign bank_mem[31].dma_read_addr22_to_bank  = dma_read_addr22_to_bank31  ;
  assign bank_mem[31].dma_write_addr22_to_bank = dma_write_addr22_to_bank31 ;
  assign bank_mem[31].dma_read_addr23_to_bank  = dma_read_addr23_to_bank31  ;
  assign bank_mem[31].dma_write_addr23_to_bank = dma_write_addr23_to_bank31 ;
  assign bank_mem[31].dma_read_addr24_to_bank  = dma_read_addr24_to_bank31  ;
  assign bank_mem[31].dma_write_addr24_to_bank = dma_write_addr24_to_bank31 ;
  assign bank_mem[31].dma_read_addr25_to_bank  = dma_read_addr25_to_bank31  ;
  assign bank_mem[31].dma_write_addr25_to_bank = dma_write_addr25_to_bank31 ;
  assign bank_mem[31].dma_read_addr26_to_bank  = dma_read_addr26_to_bank31  ;
  assign bank_mem[31].dma_write_addr26_to_bank = dma_write_addr26_to_bank31 ;
  assign bank_mem[31].dma_read_addr27_to_bank  = dma_read_addr27_to_bank31  ;
  assign bank_mem[31].dma_write_addr27_to_bank = dma_write_addr27_to_bank31 ;
  assign bank_mem[31].dma_read_addr28_to_bank  = dma_read_addr28_to_bank31  ;
  assign bank_mem[31].dma_write_addr28_to_bank = dma_write_addr28_to_bank31 ;
  assign bank_mem[31].dma_read_addr29_to_bank  = dma_read_addr29_to_bank31  ;
  assign bank_mem[31].dma_write_addr29_to_bank = dma_write_addr29_to_bank31 ;
  assign bank_mem[31].dma_read_addr30_to_bank  = dma_read_addr30_to_bank31  ;
  assign bank_mem[31].dma_write_addr30_to_bank = dma_write_addr30_to_bank31 ;
  assign bank_mem[31].dma_read_addr31_to_bank  = dma_read_addr31_to_bank31  ;
  assign bank_mem[31].dma_write_addr31_to_bank = dma_write_addr31_to_bank31 ;