
           `MEM_ACC_CONT_DMA:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 
           `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request0  )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  write_request1  )  ? `MEM_ACC_CONT_DMA_STRM1_WRITE_ACCESS : 
                                  (  write_request2  )  ? `MEM_ACC_CONT_DMA_STRM2_WRITE_ACCESS : 
                                  (  write_request3  )  ? `MEM_ACC_CONT_DMA_STRM3_WRITE_ACCESS : 
                                  (  write_request4  )  ? `MEM_ACC_CONT_DMA_STRM4_WRITE_ACCESS : 
                                  (  write_request5  )  ? `MEM_ACC_CONT_DMA_STRM5_WRITE_ACCESS : 
                                  (  write_request6  )  ? `MEM_ACC_CONT_DMA_STRM6_WRITE_ACCESS : 
                                  (  write_request7  )  ? `MEM_ACC_CONT_DMA_STRM7_WRITE_ACCESS : 
                                  (  write_request8  )  ? `MEM_ACC_CONT_DMA_STRM8_WRITE_ACCESS : 
                                  (  write_request9  )  ? `MEM_ACC_CONT_DMA_STRM9_WRITE_ACCESS : 
                                  (  write_request10  )  ? `MEM_ACC_CONT_DMA_STRM10_WRITE_ACCESS : 
                                  (  write_request11  )  ? `MEM_ACC_CONT_DMA_STRM11_WRITE_ACCESS : 
                                  (  write_request12  )  ? `MEM_ACC_CONT_DMA_STRM12_WRITE_ACCESS : 
                                  (  write_request13  )  ? `MEM_ACC_CONT_DMA_STRM13_WRITE_ACCESS : 
                                  (  write_request14  )  ? `MEM_ACC_CONT_DMA_STRM14_WRITE_ACCESS : 
                                  (  write_request15  )  ? `MEM_ACC_CONT_DMA_STRM15_WRITE_ACCESS : 
                                  (  write_request16  )  ? `MEM_ACC_CONT_DMA_STRM16_WRITE_ACCESS : 
                                  (  write_request17  )  ? `MEM_ACC_CONT_DMA_STRM17_WRITE_ACCESS : 
                                  (  write_request18  )  ? `MEM_ACC_CONT_DMA_STRM18_WRITE_ACCESS : 
                                  (  write_request19  )  ? `MEM_ACC_CONT_DMA_STRM19_WRITE_ACCESS : 
                                  (  write_request20  )  ? `MEM_ACC_CONT_DMA_STRM20_WRITE_ACCESS : 
                                  (  write_request21  )  ? `MEM_ACC_CONT_DMA_STRM21_WRITE_ACCESS : 
                                  (  write_request22  )  ? `MEM_ACC_CONT_DMA_STRM22_WRITE_ACCESS : 
                                  (  write_request23  )  ? `MEM_ACC_CONT_DMA_STRM23_WRITE_ACCESS : 
                                  (  write_request24  )  ? `MEM_ACC_CONT_DMA_STRM24_WRITE_ACCESS : 
                                  (  write_request25  )  ? `MEM_ACC_CONT_DMA_STRM25_WRITE_ACCESS : 
                                  (  write_request26  )  ? `MEM_ACC_CONT_DMA_STRM26_WRITE_ACCESS : 
                                  (  write_request27  )  ? `MEM_ACC_CONT_DMA_STRM27_WRITE_ACCESS : 
                                  (  write_request28  )  ? `MEM_ACC_CONT_DMA_STRM28_WRITE_ACCESS : 
                                  (  write_request29  )  ? `MEM_ACC_CONT_DMA_STRM29_WRITE_ACCESS : 
                                  (  write_request30  )  ? `MEM_ACC_CONT_DMA_STRM30_WRITE_ACCESS : 
                                  (  write_request31  )  ? `MEM_ACC_CONT_DMA_STRM31_WRITE_ACCESS : 
                                  (  read_request0 && ~read_pause0   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                  (  read_request1 && ~read_pause1   )  ? `MEM_ACC_CONT_DMA_STRM1_READ_ACCESS  : 
                                  (  read_request2 && ~read_pause2   )  ? `MEM_ACC_CONT_DMA_STRM2_READ_ACCESS  : 
                                  (  read_request3 && ~read_pause3   )  ? `MEM_ACC_CONT_DMA_STRM3_READ_ACCESS  : 
                                  (  read_request4 && ~read_pause4   )  ? `MEM_ACC_CONT_DMA_STRM4_READ_ACCESS  : 
                                  (  read_request5 && ~read_pause5   )  ? `MEM_ACC_CONT_DMA_STRM5_READ_ACCESS  : 
                                  (  read_request6 && ~read_pause6   )  ? `MEM_ACC_CONT_DMA_STRM6_READ_ACCESS  : 
                                  (  read_request7 && ~read_pause7   )  ? `MEM_ACC_CONT_DMA_STRM7_READ_ACCESS  : 
                                  (  read_request8 && ~read_pause8   )  ? `MEM_ACC_CONT_DMA_STRM8_READ_ACCESS  : 
                                  (  read_request9 && ~read_pause9   )  ? `MEM_ACC_CONT_DMA_STRM9_READ_ACCESS  : 
                                  (  read_request10 && ~read_pause10   )  ? `MEM_ACC_CONT_DMA_STRM10_READ_ACCESS  : 
                                  (  read_request11 && ~read_pause11   )  ? `MEM_ACC_CONT_DMA_STRM11_READ_ACCESS  : 
                                  (  read_request12 && ~read_pause12   )  ? `MEM_ACC_CONT_DMA_STRM12_READ_ACCESS  : 
                                  (  read_request13 && ~read_pause13   )  ? `MEM_ACC_CONT_DMA_STRM13_READ_ACCESS  : 
                                  (  read_request14 && ~read_pause14   )  ? `MEM_ACC_CONT_DMA_STRM14_READ_ACCESS  : 
                                  (  read_request15 && ~read_pause15   )  ? `MEM_ACC_CONT_DMA_STRM15_READ_ACCESS  : 
                                  (  read_request16 && ~read_pause16   )  ? `MEM_ACC_CONT_DMA_STRM16_READ_ACCESS  : 
                                  (  read_request17 && ~read_pause17   )  ? `MEM_ACC_CONT_DMA_STRM17_READ_ACCESS  : 
                                  (  read_request18 && ~read_pause18   )  ? `MEM_ACC_CONT_DMA_STRM18_READ_ACCESS  : 
                                  (  read_request19 && ~read_pause19   )  ? `MEM_ACC_CONT_DMA_STRM19_READ_ACCESS  : 
                                  (  read_request20 && ~read_pause20   )  ? `MEM_ACC_CONT_DMA_STRM20_READ_ACCESS  : 
                                  (  read_request21 && ~read_pause21   )  ? `MEM_ACC_CONT_DMA_STRM21_READ_ACCESS  : 
                                  (  read_request22 && ~read_pause22   )  ? `MEM_ACC_CONT_DMA_STRM22_READ_ACCESS  : 
                                  (  read_request23 && ~read_pause23   )  ? `MEM_ACC_CONT_DMA_STRM23_READ_ACCESS  : 
                                  (  read_request24 && ~read_pause24   )  ? `MEM_ACC_CONT_DMA_STRM24_READ_ACCESS  : 
                                  (  read_request25 && ~read_pause25   )  ? `MEM_ACC_CONT_DMA_STRM25_READ_ACCESS  : 
                                  (  read_request26 && ~read_pause26   )  ? `MEM_ACC_CONT_DMA_STRM26_READ_ACCESS  : 
                                  (  read_request27 && ~read_pause27   )  ? `MEM_ACC_CONT_DMA_STRM27_READ_ACCESS  : 
                                  (  read_request28 && ~read_pause28   )  ? `MEM_ACC_CONT_DMA_STRM28_READ_ACCESS  : 
                                  (  read_request29 && ~read_pause29   )  ? `MEM_ACC_CONT_DMA_STRM29_READ_ACCESS  : 
                                  (  read_request30 && ~read_pause30   )  ? `MEM_ACC_CONT_DMA_STRM30_READ_ACCESS  : 
                                  (  read_request31 && ~read_pause31   )  ? `MEM_ACC_CONT_DMA_STRM31_READ_ACCESS  : 
                                                          `MEM_ACC_CONT_DMA                    ; 