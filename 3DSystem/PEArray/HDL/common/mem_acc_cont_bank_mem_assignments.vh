
       assign read_data_ldst_valid_next   = ( mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS    );
       assign read_address  = (( dma_read_addr0_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS    )) ? dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr1_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS    )) ? dma__memc__read_address1[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr2_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS    )) ? dma__memc__read_address2[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr3_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS    )) ? dma__memc__read_address3[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr4_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS    )) ? dma__memc__read_address4[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr5_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS    )) ? dma__memc__read_address5[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr6_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS    )) ? dma__memc__read_address6[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr7_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS    )) ? dma__memc__read_address7[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr8_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS    )) ? dma__memc__read_address8[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr9_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS    )) ? dma__memc__read_address9[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr10_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS    )) ? dma__memc__read_address10[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr11_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS    )) ? dma__memc__read_address11[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr12_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS    )) ? dma__memc__read_address12[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr13_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS    )) ? dma__memc__read_address13[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr14_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS    )) ? dma__memc__read_address14[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr15_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS    )) ? dma__memc__read_address15[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr16_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS    )) ? dma__memc__read_address16[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr17_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS    )) ? dma__memc__read_address17[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr18_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS    )) ? dma__memc__read_address18[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr19_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS    )) ? dma__memc__read_address19[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr20_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS    )) ? dma__memc__read_address20[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr21_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS    )) ? dma__memc__read_address21[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr22_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS    )) ? dma__memc__read_address22[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr23_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS    )) ? dma__memc__read_address23[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr24_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS    )) ? dma__memc__read_address24[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr25_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS    )) ? dma__memc__read_address25[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr26_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS    )) ? dma__memc__read_address26[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr27_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS    )) ? dma__memc__read_address27[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr28_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS    )) ? dma__memc__read_address28[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr29_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS    )) ? dma__memc__read_address29[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr30_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS    )) ? dma__memc__read_address30[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                              (( dma_read_addr31_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS    )) ? dma__memc__read_address31[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                                                                                                                 ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] ;
       assign read_data_strm0_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS    );
       assign read_data_strm1_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS    );
       assign read_data_strm2_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS    );
       assign read_data_strm3_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS    );
       assign read_data_strm4_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS    );
       assign read_data_strm5_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS    );
       assign read_data_strm6_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS    );
       assign read_data_strm7_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS    );
       assign read_data_strm8_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS    );
       assign read_data_strm9_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS    );
       assign read_data_strm10_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS    );
       assign read_data_strm11_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS    );
       assign read_data_strm12_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS    );
       assign read_data_strm13_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS    );
       assign read_data_strm14_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS    );
       assign read_data_strm15_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS    );
       assign read_data_strm16_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS    );
       assign read_data_strm17_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS    );
       assign read_data_strm18_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS    );
       assign read_data_strm19_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS    );
       assign read_data_strm20_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS    );
       assign read_data_strm21_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS    );
       assign read_data_strm22_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS    );
       assign read_data_strm23_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS    );
       assign read_data_strm24_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS    );
       assign read_data_strm25_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS    );
       assign read_data_strm26_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS    );
       assign read_data_strm27_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS    );
       assign read_data_strm28_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS    );
       assign read_data_strm29_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS    );
       assign read_data_strm30_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS    );
       assign read_data_strm31_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS    );
       assign write_address =      (( dma_write_addr0_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS    )) ? dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr1_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS    )) ? dma__memc__write_address1[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr2_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS    )) ? dma__memc__write_address2[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr3_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS    )) ? dma__memc__write_address3[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr4_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS    )) ? dma__memc__write_address4[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr5_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS    )) ? dma__memc__write_address5[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr6_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS    )) ? dma__memc__write_address6[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr7_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS    )) ? dma__memc__write_address7[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr8_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS    )) ? dma__memc__write_address8[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr9_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS    )) ? dma__memc__write_address9[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr10_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS    )) ? dma__memc__write_address10[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr11_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS    )) ? dma__memc__write_address11[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr12_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS    )) ? dma__memc__write_address12[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr13_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS    )) ? dma__memc__write_address13[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr14_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS    )) ? dma__memc__write_address14[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr15_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS    )) ? dma__memc__write_address15[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr16_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS    )) ? dma__memc__write_address16[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr17_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS    )) ? dma__memc__write_address17[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr18_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS    )) ? dma__memc__write_address18[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr19_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS    )) ? dma__memc__write_address19[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr20_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS    )) ? dma__memc__write_address20[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr21_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS    )) ? dma__memc__write_address21[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr22_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS    )) ? dma__memc__write_address22[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr23_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS    )) ? dma__memc__write_address23[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr24_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS    )) ? dma__memc__write_address24[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr25_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS    )) ? dma__memc__write_address25[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr26_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS    )) ? dma__memc__write_address26[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr27_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS    )) ? dma__memc__write_address27[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr28_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS    )) ? dma__memc__write_address28[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr29_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS    )) ? dma__memc__write_address29[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr30_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS    )) ? dma__memc__write_address30[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                   (( dma_write_addr31_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS    )) ? dma__memc__write_address31[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :
                                                                                                                                        ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] ;
       assign write_data    =      (( dma_write_addr0_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS    )) ? dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr1_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS    )) ? dma__memc__write_data1[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr2_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS    )) ? dma__memc__write_data2[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr3_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS    )) ? dma__memc__write_data3[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr4_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS    )) ? dma__memc__write_data4[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr5_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS    )) ? dma__memc__write_data5[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr6_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS    )) ? dma__memc__write_data6[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr7_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS    )) ? dma__memc__write_data7[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr8_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS    )) ? dma__memc__write_data8[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr9_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS    )) ? dma__memc__write_data9[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr10_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS    )) ? dma__memc__write_data10[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr11_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS    )) ? dma__memc__write_data11[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr12_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS    )) ? dma__memc__write_data12[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr13_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS    )) ? dma__memc__write_data13[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr14_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS    )) ? dma__memc__write_data14[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr15_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS    )) ? dma__memc__write_data15[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr16_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS    )) ? dma__memc__write_data16[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr17_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS    )) ? dma__memc__write_data17[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr18_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS    )) ? dma__memc__write_data18[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr19_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS    )) ? dma__memc__write_data19[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr20_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS    )) ? dma__memc__write_data20[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr21_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS    )) ? dma__memc__write_data21[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr22_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS    )) ? dma__memc__write_data22[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr23_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS    )) ? dma__memc__write_data23[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr24_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS    )) ? dma__memc__write_data24[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr25_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS    )) ? dma__memc__write_data25[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr26_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS    )) ? dma__memc__write_data26[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr27_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS    )) ? dma__memc__write_data27[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr28_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS    )) ? dma__memc__write_data28[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr29_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS    )) ? dma__memc__write_data29[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr30_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS    )) ? dma__memc__write_data30[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                   (( dma_write_addr31_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS    )) ? dma__memc__write_data31[`MEM_ACC_CONT_BANK_DATA_RANGE] :
                                                                                                                                        ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;
       assign write_enable  =      (( dma_write_addr0_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS    )) ? dma__memc__write_valid0 :
                                   (( dma_write_addr1_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS    )) ? dma__memc__write_valid1 :
                                   (( dma_write_addr2_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS    )) ? dma__memc__write_valid2 :
                                   (( dma_write_addr3_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS    )) ? dma__memc__write_valid3 :
                                   (( dma_write_addr4_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS    )) ? dma__memc__write_valid4 :
                                   (( dma_write_addr5_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS    )) ? dma__memc__write_valid5 :
                                   (( dma_write_addr6_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS    )) ? dma__memc__write_valid6 :
                                   (( dma_write_addr7_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS    )) ? dma__memc__write_valid7 :
                                   (( dma_write_addr8_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS    )) ? dma__memc__write_valid8 :
                                   (( dma_write_addr9_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS    )) ? dma__memc__write_valid9 :
                                   (( dma_write_addr10_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS    )) ? dma__memc__write_valid10 :
                                   (( dma_write_addr11_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS    )) ? dma__memc__write_valid11 :
                                   (( dma_write_addr12_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS    )) ? dma__memc__write_valid12 :
                                   (( dma_write_addr13_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS    )) ? dma__memc__write_valid13 :
                                   (( dma_write_addr14_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS    )) ? dma__memc__write_valid14 :
                                   (( dma_write_addr15_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS    )) ? dma__memc__write_valid15 :
                                   (( dma_write_addr16_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS    )) ? dma__memc__write_valid16 :
                                   (( dma_write_addr17_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS    )) ? dma__memc__write_valid17 :
                                   (( dma_write_addr18_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS    )) ? dma__memc__write_valid18 :
                                   (( dma_write_addr19_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS    )) ? dma__memc__write_valid19 :
                                   (( dma_write_addr20_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS    )) ? dma__memc__write_valid20 :
                                   (( dma_write_addr21_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS    )) ? dma__memc__write_valid21 :
                                   (( dma_write_addr22_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS    )) ? dma__memc__write_valid22 :
                                   (( dma_write_addr23_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS    )) ? dma__memc__write_valid23 :
                                   (( dma_write_addr24_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS    )) ? dma__memc__write_valid24 :
                                   (( dma_write_addr25_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS    )) ? dma__memc__write_valid25 :
                                   (( dma_write_addr26_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS    )) ? dma__memc__write_valid26 :
                                   (( dma_write_addr27_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS    )) ? dma__memc__write_valid27 :
                                   (( dma_write_addr28_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS    )) ? dma__memc__write_valid28 :
                                   (( dma_write_addr29_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS    )) ? dma__memc__write_valid29 :
                                   (( dma_write_addr30_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS    )) ? dma__memc__write_valid30 :
                                   (( dma_write_addr31_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS    )) ? dma__memc__write_valid31 :
                                                                                                                                        ldst__memc__write_valid ;
       // outputs 
       always @(posedge clk)
         begin
           read_data              <= ( reset_poweron ) ? 'b0  : read_data_next              ;
           read_data_ldst_valid   <= ( reset_poweron ) ? 'b0  : read_data_ldst_valid_next   ;
           read_data_strm0_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm0_valid_next  ;
           read_data_strm1_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm1_valid_next  ;
           read_data_strm2_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm2_valid_next  ;
           read_data_strm3_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm3_valid_next  ;
           read_data_strm4_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm4_valid_next  ;
           read_data_strm5_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm5_valid_next  ;
           read_data_strm6_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm6_valid_next  ;
           read_data_strm7_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm7_valid_next  ;
           read_data_strm8_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm8_valid_next  ;
           read_data_strm9_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm9_valid_next  ;
           read_data_strm10_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm10_valid_next  ;
           read_data_strm11_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm11_valid_next  ;
           read_data_strm12_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm12_valid_next  ;
           read_data_strm13_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm13_valid_next  ;
           read_data_strm14_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm14_valid_next  ;
           read_data_strm15_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm15_valid_next  ;
           read_data_strm16_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm16_valid_next  ;
           read_data_strm17_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm17_valid_next  ;
           read_data_strm18_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm18_valid_next  ;
           read_data_strm19_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm19_valid_next  ;
           read_data_strm20_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm20_valid_next  ;
           read_data_strm21_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm21_valid_next  ;
           read_data_strm22_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm22_valid_next  ;
           read_data_strm23_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm23_valid_next  ;
           read_data_strm24_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm24_valid_next  ;
           read_data_strm25_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm25_valid_next  ;
           read_data_strm26_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm26_valid_next  ;
           read_data_strm27_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm27_valid_next  ;
           read_data_strm28_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm28_valid_next  ;
           read_data_strm29_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm29_valid_next  ;
           read_data_strm30_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm30_valid_next  ;
           read_data_strm31_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm31_valid_next  ;
         end