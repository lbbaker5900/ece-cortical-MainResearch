
  
  // Pass signals to/from the FSM's in the generate function
  // Bank 0
  assign bank_fsm[0].ldst_read_request        = ldst_read_request_to_bank0   ;
  assign bank_fsm[0].ldst_read_access         = ldst_read_access_to_bank0    ;
  
  assign bank_fsm[0].ldst_write_request       = ldst_write_request_to_bank0  ;
  assign bank_fsm[0].ldst_write_access        = ldst_write_access_to_bank0   ;
  //
  // this banks dma channel
  assign bank_fsm[0].read_pause              = read_pause0                  ;
  assign bank_fsm[0].read_request            = read_request0_to_bank0       ;
  assign bank_fsm[0].read_access             = read_access0_to_bank0        ;
  assign bank_fsm[0].write_request           = write_request0_to_bank0      ;
  assign bank_fsm[0].write_access            = write_access0_to_bank0       ;
  
  // dma channel 0
  assign bank_fsm[0].read_pause0              = read_pause0                  ;
  assign bank_fsm[0].read_request0            = read_request0_to_bank0       ;
  assign bank_fsm[0].read_access0             = read_access0_to_bank0        ;
  assign bank_fsm[0].write_request0           = write_request0_to_bank0      ;
  assign bank_fsm[0].write_access0            = write_access0_to_bank0       ;
  
  // Bank 1
  assign bank_fsm[1].ldst_read_request        = ldst_read_request_to_bank1   ;
  assign bank_fsm[1].ldst_read_access         = ldst_read_access_to_bank1    ;
  
  assign bank_fsm[1].ldst_write_request       = ldst_write_request_to_bank1  ;
  assign bank_fsm[1].ldst_write_access        = ldst_write_access_to_bank1   ;
  //
  // this banks dma channel
  assign bank_fsm[1].read_pause              = read_pause1                  ;
  assign bank_fsm[1].read_request            = read_request1_to_bank1       ;
  assign bank_fsm[1].read_access             = read_access1_to_bank1        ;
  assign bank_fsm[1].write_request           = write_request1_to_bank1      ;
  assign bank_fsm[1].write_access            = write_access1_to_bank1       ;
  
  // dma channel 0
  assign bank_fsm[1].read_pause0              = read_pause0                  ;
  assign bank_fsm[1].read_request0            = read_request0_to_bank1       ;
  assign bank_fsm[1].read_access0             = read_access0_to_bank1        ;
  assign bank_fsm[1].write_request0           = write_request0_to_bank1      ;
  assign bank_fsm[1].write_access0            = write_access0_to_bank1       ;
  
  // Bank 2
  assign bank_fsm[2].ldst_read_request        = ldst_read_request_to_bank2   ;
  assign bank_fsm[2].ldst_read_access         = ldst_read_access_to_bank2    ;
  
  assign bank_fsm[2].ldst_write_request       = ldst_write_request_to_bank2  ;
  assign bank_fsm[2].ldst_write_access        = ldst_write_access_to_bank2   ;
  //
  // this banks dma channel
  assign bank_fsm[2].read_pause              = read_pause2                  ;
  assign bank_fsm[2].read_request            = read_request2_to_bank2       ;
  assign bank_fsm[2].read_access             = read_access2_to_bank2        ;
  assign bank_fsm[2].write_request           = write_request2_to_bank2      ;
  assign bank_fsm[2].write_access            = write_access2_to_bank2       ;
  
  // dma channel 0
  assign bank_fsm[2].read_pause0              = read_pause0                  ;
  assign bank_fsm[2].read_request0            = read_request0_to_bank2       ;
  assign bank_fsm[2].read_access0             = read_access0_to_bank2        ;
  assign bank_fsm[2].write_request0           = write_request0_to_bank2      ;
  assign bank_fsm[2].write_access0            = write_access0_to_bank2       ;
  
  // Bank 3
  assign bank_fsm[3].ldst_read_request        = ldst_read_request_to_bank3   ;
  assign bank_fsm[3].ldst_read_access         = ldst_read_access_to_bank3    ;
  
  assign bank_fsm[3].ldst_write_request       = ldst_write_request_to_bank3  ;
  assign bank_fsm[3].ldst_write_access        = ldst_write_access_to_bank3   ;
  //
  // this banks dma channel
  assign bank_fsm[3].read_pause              = read_pause3                  ;
  assign bank_fsm[3].read_request            = read_request3_to_bank3       ;
  assign bank_fsm[3].read_access             = read_access3_to_bank3        ;
  assign bank_fsm[3].write_request           = write_request3_to_bank3      ;
  assign bank_fsm[3].write_access            = write_access3_to_bank3       ;
  
  // dma channel 0
  assign bank_fsm[3].read_pause0              = read_pause0                  ;
  assign bank_fsm[3].read_request0            = read_request0_to_bank3       ;
  assign bank_fsm[3].read_access0             = read_access0_to_bank3        ;
  assign bank_fsm[3].write_request0           = write_request0_to_bank3      ;
  assign bank_fsm[3].write_access0            = write_access0_to_bank3       ;
  
  // Bank 4
  assign bank_fsm[4].ldst_read_request        = ldst_read_request_to_bank4   ;
  assign bank_fsm[4].ldst_read_access         = ldst_read_access_to_bank4    ;
  
  assign bank_fsm[4].ldst_write_request       = ldst_write_request_to_bank4  ;
  assign bank_fsm[4].ldst_write_access        = ldst_write_access_to_bank4   ;
  //
  // this banks dma channel
  assign bank_fsm[4].read_pause              = read_pause4                  ;
  assign bank_fsm[4].read_request            = read_request4_to_bank4       ;
  assign bank_fsm[4].read_access             = read_access4_to_bank4        ;
  assign bank_fsm[4].write_request           = write_request4_to_bank4      ;
  assign bank_fsm[4].write_access            = write_access4_to_bank4       ;
  
  // dma channel 0
  assign bank_fsm[4].read_pause0              = read_pause0                  ;
  assign bank_fsm[4].read_request0            = read_request0_to_bank4       ;
  assign bank_fsm[4].read_access0             = read_access0_to_bank4        ;
  assign bank_fsm[4].write_request0           = write_request0_to_bank4      ;
  assign bank_fsm[4].write_access0            = write_access0_to_bank4       ;
  
  // Bank 5
  assign bank_fsm[5].ldst_read_request        = ldst_read_request_to_bank5   ;
  assign bank_fsm[5].ldst_read_access         = ldst_read_access_to_bank5    ;
  
  assign bank_fsm[5].ldst_write_request       = ldst_write_request_to_bank5  ;
  assign bank_fsm[5].ldst_write_access        = ldst_write_access_to_bank5   ;
  //
  // this banks dma channel
  assign bank_fsm[5].read_pause              = read_pause5                  ;
  assign bank_fsm[5].read_request            = read_request5_to_bank5       ;
  assign bank_fsm[5].read_access             = read_access5_to_bank5        ;
  assign bank_fsm[5].write_request           = write_request5_to_bank5      ;
  assign bank_fsm[5].write_access            = write_access5_to_bank5       ;
  
  // dma channel 0
  assign bank_fsm[5].read_pause0              = read_pause0                  ;
  assign bank_fsm[5].read_request0            = read_request0_to_bank5       ;
  assign bank_fsm[5].read_access0             = read_access0_to_bank5        ;
  assign bank_fsm[5].write_request0           = write_request0_to_bank5      ;
  assign bank_fsm[5].write_access0            = write_access0_to_bank5       ;
  
  // Bank 6
  assign bank_fsm[6].ldst_read_request        = ldst_read_request_to_bank6   ;
  assign bank_fsm[6].ldst_read_access         = ldst_read_access_to_bank6    ;
  
  assign bank_fsm[6].ldst_write_request       = ldst_write_request_to_bank6  ;
  assign bank_fsm[6].ldst_write_access        = ldst_write_access_to_bank6   ;
  //
  // this banks dma channel
  assign bank_fsm[6].read_pause              = read_pause6                  ;
  assign bank_fsm[6].read_request            = read_request6_to_bank6       ;
  assign bank_fsm[6].read_access             = read_access6_to_bank6        ;
  assign bank_fsm[6].write_request           = write_request6_to_bank6      ;
  assign bank_fsm[6].write_access            = write_access6_to_bank6       ;
  
  // dma channel 0
  assign bank_fsm[6].read_pause0              = read_pause0                  ;
  assign bank_fsm[6].read_request0            = read_request0_to_bank6       ;
  assign bank_fsm[6].read_access0             = read_access0_to_bank6        ;
  assign bank_fsm[6].write_request0           = write_request0_to_bank6      ;
  assign bank_fsm[6].write_access0            = write_access0_to_bank6       ;
  
  // Bank 7
  assign bank_fsm[7].ldst_read_request        = ldst_read_request_to_bank7   ;
  assign bank_fsm[7].ldst_read_access         = ldst_read_access_to_bank7    ;
  
  assign bank_fsm[7].ldst_write_request       = ldst_write_request_to_bank7  ;
  assign bank_fsm[7].ldst_write_access        = ldst_write_access_to_bank7   ;
  //
  // this banks dma channel
  assign bank_fsm[7].read_pause              = read_pause7                  ;
  assign bank_fsm[7].read_request            = read_request7_to_bank7       ;
  assign bank_fsm[7].read_access             = read_access7_to_bank7        ;
  assign bank_fsm[7].write_request           = write_request7_to_bank7      ;
  assign bank_fsm[7].write_access            = write_access7_to_bank7       ;
  
  // dma channel 0
  assign bank_fsm[7].read_pause0              = read_pause0                  ;
  assign bank_fsm[7].read_request0            = read_request0_to_bank7       ;
  assign bank_fsm[7].read_access0             = read_access0_to_bank7        ;
  assign bank_fsm[7].write_request0           = write_request0_to_bank7      ;
  assign bank_fsm[7].write_access0            = write_access0_to_bank7       ;
  
  // Bank 8
  assign bank_fsm[8].ldst_read_request        = ldst_read_request_to_bank8   ;
  assign bank_fsm[8].ldst_read_access         = ldst_read_access_to_bank8    ;
  
  assign bank_fsm[8].ldst_write_request       = ldst_write_request_to_bank8  ;
  assign bank_fsm[8].ldst_write_access        = ldst_write_access_to_bank8   ;
  //
  // this banks dma channel
  assign bank_fsm[8].read_pause              = read_pause8                  ;
  assign bank_fsm[8].read_request            = read_request8_to_bank8       ;
  assign bank_fsm[8].read_access             = read_access8_to_bank8        ;
  assign bank_fsm[8].write_request           = write_request8_to_bank8      ;
  assign bank_fsm[8].write_access            = write_access8_to_bank8       ;
  
  // dma channel 0
  assign bank_fsm[8].read_pause0              = read_pause0                  ;
  assign bank_fsm[8].read_request0            = read_request0_to_bank8       ;
  assign bank_fsm[8].read_access0             = read_access0_to_bank8        ;
  assign bank_fsm[8].write_request0           = write_request0_to_bank8      ;
  assign bank_fsm[8].write_access0            = write_access0_to_bank8       ;
  
  // Bank 9
  assign bank_fsm[9].ldst_read_request        = ldst_read_request_to_bank9   ;
  assign bank_fsm[9].ldst_read_access         = ldst_read_access_to_bank9    ;
  
  assign bank_fsm[9].ldst_write_request       = ldst_write_request_to_bank9  ;
  assign bank_fsm[9].ldst_write_access        = ldst_write_access_to_bank9   ;
  //
  // this banks dma channel
  assign bank_fsm[9].read_pause              = read_pause9                  ;
  assign bank_fsm[9].read_request            = read_request9_to_bank9       ;
  assign bank_fsm[9].read_access             = read_access9_to_bank9        ;
  assign bank_fsm[9].write_request           = write_request9_to_bank9      ;
  assign bank_fsm[9].write_access            = write_access9_to_bank9       ;
  
  // dma channel 0
  assign bank_fsm[9].read_pause0              = read_pause0                  ;
  assign bank_fsm[9].read_request0            = read_request0_to_bank9       ;
  assign bank_fsm[9].read_access0             = read_access0_to_bank9        ;
  assign bank_fsm[9].write_request0           = write_request0_to_bank9      ;
  assign bank_fsm[9].write_access0            = write_access0_to_bank9       ;
  
  // Bank 10
  assign bank_fsm[10].ldst_read_request        = ldst_read_request_to_bank10   ;
  assign bank_fsm[10].ldst_read_access         = ldst_read_access_to_bank10    ;
  
  assign bank_fsm[10].ldst_write_request       = ldst_write_request_to_bank10  ;
  assign bank_fsm[10].ldst_write_access        = ldst_write_access_to_bank10   ;
  //
  // this banks dma channel
  assign bank_fsm[10].read_pause              = read_pause10                  ;
  assign bank_fsm[10].read_request            = read_request10_to_bank10       ;
  assign bank_fsm[10].read_access             = read_access10_to_bank10        ;
  assign bank_fsm[10].write_request           = write_request10_to_bank10      ;
  assign bank_fsm[10].write_access            = write_access10_to_bank10       ;
  
  // dma channel 0
  assign bank_fsm[10].read_pause0              = read_pause0                  ;
  assign bank_fsm[10].read_request0            = read_request0_to_bank10       ;
  assign bank_fsm[10].read_access0             = read_access0_to_bank10        ;
  assign bank_fsm[10].write_request0           = write_request0_to_bank10      ;
  assign bank_fsm[10].write_access0            = write_access0_to_bank10       ;
  
  // Bank 11
  assign bank_fsm[11].ldst_read_request        = ldst_read_request_to_bank11   ;
  assign bank_fsm[11].ldst_read_access         = ldst_read_access_to_bank11    ;
  
  assign bank_fsm[11].ldst_write_request       = ldst_write_request_to_bank11  ;
  assign bank_fsm[11].ldst_write_access        = ldst_write_access_to_bank11   ;
  //
  // this banks dma channel
  assign bank_fsm[11].read_pause              = read_pause11                  ;
  assign bank_fsm[11].read_request            = read_request11_to_bank11       ;
  assign bank_fsm[11].read_access             = read_access11_to_bank11        ;
  assign bank_fsm[11].write_request           = write_request11_to_bank11      ;
  assign bank_fsm[11].write_access            = write_access11_to_bank11       ;
  
  // dma channel 0
  assign bank_fsm[11].read_pause0              = read_pause0                  ;
  assign bank_fsm[11].read_request0            = read_request0_to_bank11       ;
  assign bank_fsm[11].read_access0             = read_access0_to_bank11        ;
  assign bank_fsm[11].write_request0           = write_request0_to_bank11      ;
  assign bank_fsm[11].write_access0            = write_access0_to_bank11       ;
  
  // Bank 12
  assign bank_fsm[12].ldst_read_request        = ldst_read_request_to_bank12   ;
  assign bank_fsm[12].ldst_read_access         = ldst_read_access_to_bank12    ;
  
  assign bank_fsm[12].ldst_write_request       = ldst_write_request_to_bank12  ;
  assign bank_fsm[12].ldst_write_access        = ldst_write_access_to_bank12   ;
  //
  // this banks dma channel
  assign bank_fsm[12].read_pause              = read_pause12                  ;
  assign bank_fsm[12].read_request            = read_request12_to_bank12       ;
  assign bank_fsm[12].read_access             = read_access12_to_bank12        ;
  assign bank_fsm[12].write_request           = write_request12_to_bank12      ;
  assign bank_fsm[12].write_access            = write_access12_to_bank12       ;
  
  // dma channel 0
  assign bank_fsm[12].read_pause0              = read_pause0                  ;
  assign bank_fsm[12].read_request0            = read_request0_to_bank12       ;
  assign bank_fsm[12].read_access0             = read_access0_to_bank12        ;
  assign bank_fsm[12].write_request0           = write_request0_to_bank12      ;
  assign bank_fsm[12].write_access0            = write_access0_to_bank12       ;
  
  // Bank 13
  assign bank_fsm[13].ldst_read_request        = ldst_read_request_to_bank13   ;
  assign bank_fsm[13].ldst_read_access         = ldst_read_access_to_bank13    ;
  
  assign bank_fsm[13].ldst_write_request       = ldst_write_request_to_bank13  ;
  assign bank_fsm[13].ldst_write_access        = ldst_write_access_to_bank13   ;
  //
  // this banks dma channel
  assign bank_fsm[13].read_pause              = read_pause13                  ;
  assign bank_fsm[13].read_request            = read_request13_to_bank13       ;
  assign bank_fsm[13].read_access             = read_access13_to_bank13        ;
  assign bank_fsm[13].write_request           = write_request13_to_bank13      ;
  assign bank_fsm[13].write_access            = write_access13_to_bank13       ;
  
  // dma channel 0
  assign bank_fsm[13].read_pause0              = read_pause0                  ;
  assign bank_fsm[13].read_request0            = read_request0_to_bank13       ;
  assign bank_fsm[13].read_access0             = read_access0_to_bank13        ;
  assign bank_fsm[13].write_request0           = write_request0_to_bank13      ;
  assign bank_fsm[13].write_access0            = write_access0_to_bank13       ;
  
  // Bank 14
  assign bank_fsm[14].ldst_read_request        = ldst_read_request_to_bank14   ;
  assign bank_fsm[14].ldst_read_access         = ldst_read_access_to_bank14    ;
  
  assign bank_fsm[14].ldst_write_request       = ldst_write_request_to_bank14  ;
  assign bank_fsm[14].ldst_write_access        = ldst_write_access_to_bank14   ;
  //
  // this banks dma channel
  assign bank_fsm[14].read_pause              = read_pause14                  ;
  assign bank_fsm[14].read_request            = read_request14_to_bank14       ;
  assign bank_fsm[14].read_access             = read_access14_to_bank14        ;
  assign bank_fsm[14].write_request           = write_request14_to_bank14      ;
  assign bank_fsm[14].write_access            = write_access14_to_bank14       ;
  
  // dma channel 0
  assign bank_fsm[14].read_pause0              = read_pause0                  ;
  assign bank_fsm[14].read_request0            = read_request0_to_bank14       ;
  assign bank_fsm[14].read_access0             = read_access0_to_bank14        ;
  assign bank_fsm[14].write_request0           = write_request0_to_bank14      ;
  assign bank_fsm[14].write_access0            = write_access0_to_bank14       ;
  
  // Bank 15
  assign bank_fsm[15].ldst_read_request        = ldst_read_request_to_bank15   ;
  assign bank_fsm[15].ldst_read_access         = ldst_read_access_to_bank15    ;
  
  assign bank_fsm[15].ldst_write_request       = ldst_write_request_to_bank15  ;
  assign bank_fsm[15].ldst_write_access        = ldst_write_access_to_bank15   ;
  //
  // this banks dma channel
  assign bank_fsm[15].read_pause              = read_pause15                  ;
  assign bank_fsm[15].read_request            = read_request15_to_bank15       ;
  assign bank_fsm[15].read_access             = read_access15_to_bank15        ;
  assign bank_fsm[15].write_request           = write_request15_to_bank15      ;
  assign bank_fsm[15].write_access            = write_access15_to_bank15       ;
  
  // dma channel 0
  assign bank_fsm[15].read_pause0              = read_pause0                  ;
  assign bank_fsm[15].read_request0            = read_request0_to_bank15       ;
  assign bank_fsm[15].read_access0             = read_access0_to_bank15        ;
  assign bank_fsm[15].write_request0           = write_request0_to_bank15      ;
  assign bank_fsm[15].write_access0            = write_access0_to_bank15       ;
  
  // Bank 16
  assign bank_fsm[16].ldst_read_request        = ldst_read_request_to_bank16   ;
  assign bank_fsm[16].ldst_read_access         = ldst_read_access_to_bank16    ;
  
  assign bank_fsm[16].ldst_write_request       = ldst_write_request_to_bank16  ;
  assign bank_fsm[16].ldst_write_access        = ldst_write_access_to_bank16   ;
  //
  // this banks dma channel
  assign bank_fsm[16].read_pause              = read_pause16                  ;
  assign bank_fsm[16].read_request            = read_request16_to_bank16       ;
  assign bank_fsm[16].read_access             = read_access16_to_bank16        ;
  assign bank_fsm[16].write_request           = write_request16_to_bank16      ;
  assign bank_fsm[16].write_access            = write_access16_to_bank16       ;
  
  // dma channel 0
  assign bank_fsm[16].read_pause0              = read_pause0                  ;
  assign bank_fsm[16].read_request0            = read_request0_to_bank16       ;
  assign bank_fsm[16].read_access0             = read_access0_to_bank16        ;
  assign bank_fsm[16].write_request0           = write_request0_to_bank16      ;
  assign bank_fsm[16].write_access0            = write_access0_to_bank16       ;
  
  // Bank 17
  assign bank_fsm[17].ldst_read_request        = ldst_read_request_to_bank17   ;
  assign bank_fsm[17].ldst_read_access         = ldst_read_access_to_bank17    ;
  
  assign bank_fsm[17].ldst_write_request       = ldst_write_request_to_bank17  ;
  assign bank_fsm[17].ldst_write_access        = ldst_write_access_to_bank17   ;
  //
  // this banks dma channel
  assign bank_fsm[17].read_pause              = read_pause17                  ;
  assign bank_fsm[17].read_request            = read_request17_to_bank17       ;
  assign bank_fsm[17].read_access             = read_access17_to_bank17        ;
  assign bank_fsm[17].write_request           = write_request17_to_bank17      ;
  assign bank_fsm[17].write_access            = write_access17_to_bank17       ;
  
  // dma channel 0
  assign bank_fsm[17].read_pause0              = read_pause0                  ;
  assign bank_fsm[17].read_request0            = read_request0_to_bank17       ;
  assign bank_fsm[17].read_access0             = read_access0_to_bank17        ;
  assign bank_fsm[17].write_request0           = write_request0_to_bank17      ;
  assign bank_fsm[17].write_access0            = write_access0_to_bank17       ;
  
  // Bank 18
  assign bank_fsm[18].ldst_read_request        = ldst_read_request_to_bank18   ;
  assign bank_fsm[18].ldst_read_access         = ldst_read_access_to_bank18    ;
  
  assign bank_fsm[18].ldst_write_request       = ldst_write_request_to_bank18  ;
  assign bank_fsm[18].ldst_write_access        = ldst_write_access_to_bank18   ;
  //
  // this banks dma channel
  assign bank_fsm[18].read_pause              = read_pause18                  ;
  assign bank_fsm[18].read_request            = read_request18_to_bank18       ;
  assign bank_fsm[18].read_access             = read_access18_to_bank18        ;
  assign bank_fsm[18].write_request           = write_request18_to_bank18      ;
  assign bank_fsm[18].write_access            = write_access18_to_bank18       ;
  
  // dma channel 0
  assign bank_fsm[18].read_pause0              = read_pause0                  ;
  assign bank_fsm[18].read_request0            = read_request0_to_bank18       ;
  assign bank_fsm[18].read_access0             = read_access0_to_bank18        ;
  assign bank_fsm[18].write_request0           = write_request0_to_bank18      ;
  assign bank_fsm[18].write_access0            = write_access0_to_bank18       ;
  
  // Bank 19
  assign bank_fsm[19].ldst_read_request        = ldst_read_request_to_bank19   ;
  assign bank_fsm[19].ldst_read_access         = ldst_read_access_to_bank19    ;
  
  assign bank_fsm[19].ldst_write_request       = ldst_write_request_to_bank19  ;
  assign bank_fsm[19].ldst_write_access        = ldst_write_access_to_bank19   ;
  //
  // this banks dma channel
  assign bank_fsm[19].read_pause              = read_pause19                  ;
  assign bank_fsm[19].read_request            = read_request19_to_bank19       ;
  assign bank_fsm[19].read_access             = read_access19_to_bank19        ;
  assign bank_fsm[19].write_request           = write_request19_to_bank19      ;
  assign bank_fsm[19].write_access            = write_access19_to_bank19       ;
  
  // dma channel 0
  assign bank_fsm[19].read_pause0              = read_pause0                  ;
  assign bank_fsm[19].read_request0            = read_request0_to_bank19       ;
  assign bank_fsm[19].read_access0             = read_access0_to_bank19        ;
  assign bank_fsm[19].write_request0           = write_request0_to_bank19      ;
  assign bank_fsm[19].write_access0            = write_access0_to_bank19       ;
  
  // Bank 20
  assign bank_fsm[20].ldst_read_request        = ldst_read_request_to_bank20   ;
  assign bank_fsm[20].ldst_read_access         = ldst_read_access_to_bank20    ;
  
  assign bank_fsm[20].ldst_write_request       = ldst_write_request_to_bank20  ;
  assign bank_fsm[20].ldst_write_access        = ldst_write_access_to_bank20   ;
  //
  // this banks dma channel
  assign bank_fsm[20].read_pause              = read_pause20                  ;
  assign bank_fsm[20].read_request            = read_request20_to_bank20       ;
  assign bank_fsm[20].read_access             = read_access20_to_bank20        ;
  assign bank_fsm[20].write_request           = write_request20_to_bank20      ;
  assign bank_fsm[20].write_access            = write_access20_to_bank20       ;
  
  // dma channel 0
  assign bank_fsm[20].read_pause0              = read_pause0                  ;
  assign bank_fsm[20].read_request0            = read_request0_to_bank20       ;
  assign bank_fsm[20].read_access0             = read_access0_to_bank20        ;
  assign bank_fsm[20].write_request0           = write_request0_to_bank20      ;
  assign bank_fsm[20].write_access0            = write_access0_to_bank20       ;
  
  // Bank 21
  assign bank_fsm[21].ldst_read_request        = ldst_read_request_to_bank21   ;
  assign bank_fsm[21].ldst_read_access         = ldst_read_access_to_bank21    ;
  
  assign bank_fsm[21].ldst_write_request       = ldst_write_request_to_bank21  ;
  assign bank_fsm[21].ldst_write_access        = ldst_write_access_to_bank21   ;
  //
  // this banks dma channel
  assign bank_fsm[21].read_pause              = read_pause21                  ;
  assign bank_fsm[21].read_request            = read_request21_to_bank21       ;
  assign bank_fsm[21].read_access             = read_access21_to_bank21        ;
  assign bank_fsm[21].write_request           = write_request21_to_bank21      ;
  assign bank_fsm[21].write_access            = write_access21_to_bank21       ;
  
  // dma channel 0
  assign bank_fsm[21].read_pause0              = read_pause0                  ;
  assign bank_fsm[21].read_request0            = read_request0_to_bank21       ;
  assign bank_fsm[21].read_access0             = read_access0_to_bank21        ;
  assign bank_fsm[21].write_request0           = write_request0_to_bank21      ;
  assign bank_fsm[21].write_access0            = write_access0_to_bank21       ;
  
  // Bank 22
  assign bank_fsm[22].ldst_read_request        = ldst_read_request_to_bank22   ;
  assign bank_fsm[22].ldst_read_access         = ldst_read_access_to_bank22    ;
  
  assign bank_fsm[22].ldst_write_request       = ldst_write_request_to_bank22  ;
  assign bank_fsm[22].ldst_write_access        = ldst_write_access_to_bank22   ;
  //
  // this banks dma channel
  assign bank_fsm[22].read_pause              = read_pause22                  ;
  assign bank_fsm[22].read_request            = read_request22_to_bank22       ;
  assign bank_fsm[22].read_access             = read_access22_to_bank22        ;
  assign bank_fsm[22].write_request           = write_request22_to_bank22      ;
  assign bank_fsm[22].write_access            = write_access22_to_bank22       ;
  
  // dma channel 0
  assign bank_fsm[22].read_pause0              = read_pause0                  ;
  assign bank_fsm[22].read_request0            = read_request0_to_bank22       ;
  assign bank_fsm[22].read_access0             = read_access0_to_bank22        ;
  assign bank_fsm[22].write_request0           = write_request0_to_bank22      ;
  assign bank_fsm[22].write_access0            = write_access0_to_bank22       ;
  
  // Bank 23
  assign bank_fsm[23].ldst_read_request        = ldst_read_request_to_bank23   ;
  assign bank_fsm[23].ldst_read_access         = ldst_read_access_to_bank23    ;
  
  assign bank_fsm[23].ldst_write_request       = ldst_write_request_to_bank23  ;
  assign bank_fsm[23].ldst_write_access        = ldst_write_access_to_bank23   ;
  //
  // this banks dma channel
  assign bank_fsm[23].read_pause              = read_pause23                  ;
  assign bank_fsm[23].read_request            = read_request23_to_bank23       ;
  assign bank_fsm[23].read_access             = read_access23_to_bank23        ;
  assign bank_fsm[23].write_request           = write_request23_to_bank23      ;
  assign bank_fsm[23].write_access            = write_access23_to_bank23       ;
  
  // dma channel 0
  assign bank_fsm[23].read_pause0              = read_pause0                  ;
  assign bank_fsm[23].read_request0            = read_request0_to_bank23       ;
  assign bank_fsm[23].read_access0             = read_access0_to_bank23        ;
  assign bank_fsm[23].write_request0           = write_request0_to_bank23      ;
  assign bank_fsm[23].write_access0            = write_access0_to_bank23       ;
  
  // Bank 24
  assign bank_fsm[24].ldst_read_request        = ldst_read_request_to_bank24   ;
  assign bank_fsm[24].ldst_read_access         = ldst_read_access_to_bank24    ;
  
  assign bank_fsm[24].ldst_write_request       = ldst_write_request_to_bank24  ;
  assign bank_fsm[24].ldst_write_access        = ldst_write_access_to_bank24   ;
  //
  // this banks dma channel
  assign bank_fsm[24].read_pause              = read_pause24                  ;
  assign bank_fsm[24].read_request            = read_request24_to_bank24       ;
  assign bank_fsm[24].read_access             = read_access24_to_bank24        ;
  assign bank_fsm[24].write_request           = write_request24_to_bank24      ;
  assign bank_fsm[24].write_access            = write_access24_to_bank24       ;
  
  // dma channel 0
  assign bank_fsm[24].read_pause0              = read_pause0                  ;
  assign bank_fsm[24].read_request0            = read_request0_to_bank24       ;
  assign bank_fsm[24].read_access0             = read_access0_to_bank24        ;
  assign bank_fsm[24].write_request0           = write_request0_to_bank24      ;
  assign bank_fsm[24].write_access0            = write_access0_to_bank24       ;
  
  // Bank 25
  assign bank_fsm[25].ldst_read_request        = ldst_read_request_to_bank25   ;
  assign bank_fsm[25].ldst_read_access         = ldst_read_access_to_bank25    ;
  
  assign bank_fsm[25].ldst_write_request       = ldst_write_request_to_bank25  ;
  assign bank_fsm[25].ldst_write_access        = ldst_write_access_to_bank25   ;
  //
  // this banks dma channel
  assign bank_fsm[25].read_pause              = read_pause25                  ;
  assign bank_fsm[25].read_request            = read_request25_to_bank25       ;
  assign bank_fsm[25].read_access             = read_access25_to_bank25        ;
  assign bank_fsm[25].write_request           = write_request25_to_bank25      ;
  assign bank_fsm[25].write_access            = write_access25_to_bank25       ;
  
  // dma channel 0
  assign bank_fsm[25].read_pause0              = read_pause0                  ;
  assign bank_fsm[25].read_request0            = read_request0_to_bank25       ;
  assign bank_fsm[25].read_access0             = read_access0_to_bank25        ;
  assign bank_fsm[25].write_request0           = write_request0_to_bank25      ;
  assign bank_fsm[25].write_access0            = write_access0_to_bank25       ;
  
  // Bank 26
  assign bank_fsm[26].ldst_read_request        = ldst_read_request_to_bank26   ;
  assign bank_fsm[26].ldst_read_access         = ldst_read_access_to_bank26    ;
  
  assign bank_fsm[26].ldst_write_request       = ldst_write_request_to_bank26  ;
  assign bank_fsm[26].ldst_write_access        = ldst_write_access_to_bank26   ;
  //
  // this banks dma channel
  assign bank_fsm[26].read_pause              = read_pause26                  ;
  assign bank_fsm[26].read_request            = read_request26_to_bank26       ;
  assign bank_fsm[26].read_access             = read_access26_to_bank26        ;
  assign bank_fsm[26].write_request           = write_request26_to_bank26      ;
  assign bank_fsm[26].write_access            = write_access26_to_bank26       ;
  
  // dma channel 0
  assign bank_fsm[26].read_pause0              = read_pause0                  ;
  assign bank_fsm[26].read_request0            = read_request0_to_bank26       ;
  assign bank_fsm[26].read_access0             = read_access0_to_bank26        ;
  assign bank_fsm[26].write_request0           = write_request0_to_bank26      ;
  assign bank_fsm[26].write_access0            = write_access0_to_bank26       ;
  
  // Bank 27
  assign bank_fsm[27].ldst_read_request        = ldst_read_request_to_bank27   ;
  assign bank_fsm[27].ldst_read_access         = ldst_read_access_to_bank27    ;
  
  assign bank_fsm[27].ldst_write_request       = ldst_write_request_to_bank27  ;
  assign bank_fsm[27].ldst_write_access        = ldst_write_access_to_bank27   ;
  //
  // this banks dma channel
  assign bank_fsm[27].read_pause              = read_pause27                  ;
  assign bank_fsm[27].read_request            = read_request27_to_bank27       ;
  assign bank_fsm[27].read_access             = read_access27_to_bank27        ;
  assign bank_fsm[27].write_request           = write_request27_to_bank27      ;
  assign bank_fsm[27].write_access            = write_access27_to_bank27       ;
  
  // dma channel 0
  assign bank_fsm[27].read_pause0              = read_pause0                  ;
  assign bank_fsm[27].read_request0            = read_request0_to_bank27       ;
  assign bank_fsm[27].read_access0             = read_access0_to_bank27        ;
  assign bank_fsm[27].write_request0           = write_request0_to_bank27      ;
  assign bank_fsm[27].write_access0            = write_access0_to_bank27       ;
  
  // Bank 28
  assign bank_fsm[28].ldst_read_request        = ldst_read_request_to_bank28   ;
  assign bank_fsm[28].ldst_read_access         = ldst_read_access_to_bank28    ;
  
  assign bank_fsm[28].ldst_write_request       = ldst_write_request_to_bank28  ;
  assign bank_fsm[28].ldst_write_access        = ldst_write_access_to_bank28   ;
  //
  // this banks dma channel
  assign bank_fsm[28].read_pause              = read_pause28                  ;
  assign bank_fsm[28].read_request            = read_request28_to_bank28       ;
  assign bank_fsm[28].read_access             = read_access28_to_bank28        ;
  assign bank_fsm[28].write_request           = write_request28_to_bank28      ;
  assign bank_fsm[28].write_access            = write_access28_to_bank28       ;
  
  // dma channel 0
  assign bank_fsm[28].read_pause0              = read_pause0                  ;
  assign bank_fsm[28].read_request0            = read_request0_to_bank28       ;
  assign bank_fsm[28].read_access0             = read_access0_to_bank28        ;
  assign bank_fsm[28].write_request0           = write_request0_to_bank28      ;
  assign bank_fsm[28].write_access0            = write_access0_to_bank28       ;
  
  // Bank 29
  assign bank_fsm[29].ldst_read_request        = ldst_read_request_to_bank29   ;
  assign bank_fsm[29].ldst_read_access         = ldst_read_access_to_bank29    ;
  
  assign bank_fsm[29].ldst_write_request       = ldst_write_request_to_bank29  ;
  assign bank_fsm[29].ldst_write_access        = ldst_write_access_to_bank29   ;
  //
  // this banks dma channel
  assign bank_fsm[29].read_pause              = read_pause29                  ;
  assign bank_fsm[29].read_request            = read_request29_to_bank29       ;
  assign bank_fsm[29].read_access             = read_access29_to_bank29        ;
  assign bank_fsm[29].write_request           = write_request29_to_bank29      ;
  assign bank_fsm[29].write_access            = write_access29_to_bank29       ;
  
  // dma channel 0
  assign bank_fsm[29].read_pause0              = read_pause0                  ;
  assign bank_fsm[29].read_request0            = read_request0_to_bank29       ;
  assign bank_fsm[29].read_access0             = read_access0_to_bank29        ;
  assign bank_fsm[29].write_request0           = write_request0_to_bank29      ;
  assign bank_fsm[29].write_access0            = write_access0_to_bank29       ;
  
  // Bank 30
  assign bank_fsm[30].ldst_read_request        = ldst_read_request_to_bank30   ;
  assign bank_fsm[30].ldst_read_access         = ldst_read_access_to_bank30    ;
  
  assign bank_fsm[30].ldst_write_request       = ldst_write_request_to_bank30  ;
  assign bank_fsm[30].ldst_write_access        = ldst_write_access_to_bank30   ;
  //
  // this banks dma channel
  assign bank_fsm[30].read_pause              = read_pause30                  ;
  assign bank_fsm[30].read_request            = read_request30_to_bank30       ;
  assign bank_fsm[30].read_access             = read_access30_to_bank30        ;
  assign bank_fsm[30].write_request           = write_request30_to_bank30      ;
  assign bank_fsm[30].write_access            = write_access30_to_bank30       ;
  
  // dma channel 0
  assign bank_fsm[30].read_pause0              = read_pause0                  ;
  assign bank_fsm[30].read_request0            = read_request0_to_bank30       ;
  assign bank_fsm[30].read_access0             = read_access0_to_bank30        ;
  assign bank_fsm[30].write_request0           = write_request0_to_bank30      ;
  assign bank_fsm[30].write_access0            = write_access0_to_bank30       ;
  
  // Bank 31
  assign bank_fsm[31].ldst_read_request        = ldst_read_request_to_bank31   ;
  assign bank_fsm[31].ldst_read_access         = ldst_read_access_to_bank31    ;
  
  assign bank_fsm[31].ldst_write_request       = ldst_write_request_to_bank31  ;
  assign bank_fsm[31].ldst_write_access        = ldst_write_access_to_bank31   ;
  //
  // this banks dma channel
  assign bank_fsm[31].read_pause              = read_pause31                  ;
  assign bank_fsm[31].read_request            = read_request31_to_bank31       ;
  assign bank_fsm[31].read_access             = read_access31_to_bank31        ;
  assign bank_fsm[31].write_request           = write_request31_to_bank31      ;
  assign bank_fsm[31].write_access            = write_access31_to_bank31       ;
  
  // dma channel 0
  assign bank_fsm[31].read_pause0              = read_pause0                  ;
  assign bank_fsm[31].read_request0            = read_request0_to_bank31       ;
  assign bank_fsm[31].read_access0             = read_access0_to_bank31        ;
  assign bank_fsm[31].write_request0           = write_request0_to_bank31      ;
  assign bank_fsm[31].write_access0            = write_access0_to_bank31       ;
  
  assign memc__ldst__read_ready =  bank_fsm[ 0].ldst_read_ready
                                 | bank_fsm[ 1].ldst_read_ready
                                 | bank_fsm[ 2].ldst_read_ready
                                 | bank_fsm[ 3].ldst_read_ready
                                 | bank_fsm[ 4].ldst_read_ready
                                 | bank_fsm[ 5].ldst_read_ready
                                 | bank_fsm[ 6].ldst_read_ready
                                 | bank_fsm[ 7].ldst_read_ready
                                 | bank_fsm[ 8].ldst_read_ready
                                 | bank_fsm[ 9].ldst_read_ready
                                 | bank_fsm[10].ldst_read_ready
                                 | bank_fsm[11].ldst_read_ready
                                 | bank_fsm[12].ldst_read_ready
                                 | bank_fsm[13].ldst_read_ready
                                 | bank_fsm[14].ldst_read_ready
                                 | bank_fsm[15].ldst_read_ready
                                 | bank_fsm[16].ldst_read_ready
                                 | bank_fsm[17].ldst_read_ready
                                 | bank_fsm[18].ldst_read_ready
                                 | bank_fsm[19].ldst_read_ready
                                 | bank_fsm[20].ldst_read_ready
                                 | bank_fsm[21].ldst_read_ready
                                 | bank_fsm[22].ldst_read_ready
                                 | bank_fsm[23].ldst_read_ready
                                 | bank_fsm[24].ldst_read_ready
                                 | bank_fsm[25].ldst_read_ready
                                 | bank_fsm[26].ldst_read_ready
                                 | bank_fsm[27].ldst_read_ready
                                 | bank_fsm[28].ldst_read_ready
                                 | bank_fsm[29].ldst_read_ready
                                 | bank_fsm[30].ldst_read_ready
                                 | bank_fsm[31].ldst_read_ready
                                 ;
  assign memc__ldst__write_ready =  bank_fsm[ 0].ldst_write_ready
                                  | bank_fsm[ 1].ldst_write_ready
                                  | bank_fsm[ 2].ldst_write_ready
                                  | bank_fsm[ 3].ldst_write_ready
                                  | bank_fsm[ 4].ldst_write_ready
                                  | bank_fsm[ 5].ldst_write_ready
                                  | bank_fsm[ 6].ldst_write_ready
                                  | bank_fsm[ 7].ldst_write_ready
                                  | bank_fsm[ 8].ldst_write_ready
                                  | bank_fsm[ 9].ldst_write_ready
                                  | bank_fsm[10].ldst_write_ready
                                  | bank_fsm[11].ldst_write_ready
                                  | bank_fsm[12].ldst_write_ready
                                  | bank_fsm[13].ldst_write_ready
                                  | bank_fsm[14].ldst_write_ready
                                  | bank_fsm[15].ldst_write_ready
                                  | bank_fsm[16].ldst_write_ready
                                  | bank_fsm[17].ldst_write_ready
                                  | bank_fsm[18].ldst_write_ready
                                  | bank_fsm[19].ldst_write_ready
                                  | bank_fsm[20].ldst_write_ready
                                  | bank_fsm[21].ldst_write_ready
                                  | bank_fsm[22].ldst_write_ready
                                  | bank_fsm[23].ldst_write_ready
                                  | bank_fsm[24].ldst_write_ready
                                  | bank_fsm[25].ldst_write_ready
                                  | bank_fsm[26].ldst_write_ready
                                  | bank_fsm[27].ldst_write_ready
                                  | bank_fsm[28].ldst_write_ready
                                  | bank_fsm[29].ldst_write_ready
                                  | bank_fsm[30].ldst_write_ready
                                  | bank_fsm[31].ldst_write_ready
                                  ;
  assign memc__dma__write_ready0 = bank_fsm[ 0].write_ready_strm
                                 | bank_fsm[ 0].write_ready_strm0
                                 | bank_fsm[ 1].write_ready_strm0
                                 | bank_fsm[ 2].write_ready_strm0
                                 | bank_fsm[ 3].write_ready_strm0
                                 | bank_fsm[ 4].write_ready_strm0
                                 | bank_fsm[ 5].write_ready_strm0
                                 | bank_fsm[ 6].write_ready_strm0
                                 | bank_fsm[ 7].write_ready_strm0
                                 | bank_fsm[ 8].write_ready_strm0
                                 | bank_fsm[ 9].write_ready_strm0
                                 | bank_fsm[10].write_ready_strm0
                                 | bank_fsm[11].write_ready_strm0
                                 | bank_fsm[12].write_ready_strm0
                                 | bank_fsm[13].write_ready_strm0
                                 | bank_fsm[14].write_ready_strm0
                                 | bank_fsm[15].write_ready_strm0
                                 | bank_fsm[16].write_ready_strm0
                                 | bank_fsm[17].write_ready_strm0
                                 | bank_fsm[18].write_ready_strm0
                                 | bank_fsm[19].write_ready_strm0
                                 | bank_fsm[20].write_ready_strm0
                                 | bank_fsm[21].write_ready_strm0
                                 | bank_fsm[22].write_ready_strm0
                                 | bank_fsm[23].write_ready_strm0
                                 | bank_fsm[24].write_ready_strm0
                                 | bank_fsm[25].write_ready_strm0
                                 | bank_fsm[26].write_ready_strm0
                                 | bank_fsm[27].write_ready_strm0
                                 | bank_fsm[28].write_ready_strm0
                                 | bank_fsm[29].write_ready_strm0
                                 | bank_fsm[30].write_ready_strm0
                                 | bank_fsm[31].write_ready_strm0
                                  ;
  assign memc__dma__read_ready0  = bank_fsm[ 0].read_ready_strm 
                                 | bank_fsm[ 0].read_ready_strm0 
                                 | bank_fsm[ 1].read_ready_strm0 
                                 | bank_fsm[ 2].read_ready_strm0 
                                 | bank_fsm[ 3].read_ready_strm0 
                                 | bank_fsm[ 4].read_ready_strm0 
                                 | bank_fsm[ 5].read_ready_strm0 
                                 | bank_fsm[ 6].read_ready_strm0 
                                 | bank_fsm[ 7].read_ready_strm0 
                                 | bank_fsm[ 8].read_ready_strm0 
                                 | bank_fsm[ 9].read_ready_strm0 
                                 | bank_fsm[10].read_ready_strm0 
                                 | bank_fsm[11].read_ready_strm0 
                                 | bank_fsm[12].read_ready_strm0 
                                 | bank_fsm[13].read_ready_strm0 
                                 | bank_fsm[14].read_ready_strm0 
                                 | bank_fsm[15].read_ready_strm0 
                                 | bank_fsm[16].read_ready_strm0 
                                 | bank_fsm[17].read_ready_strm0 
                                 | bank_fsm[18].read_ready_strm0 
                                 | bank_fsm[19].read_ready_strm0 
                                 | bank_fsm[20].read_ready_strm0 
                                 | bank_fsm[21].read_ready_strm0 
                                 | bank_fsm[22].read_ready_strm0 
                                 | bank_fsm[23].read_ready_strm0 
                                 | bank_fsm[24].read_ready_strm0 
                                 | bank_fsm[25].read_ready_strm0 
                                 | bank_fsm[26].read_ready_strm0 
                                 | bank_fsm[27].read_ready_strm0 
                                 | bank_fsm[28].read_ready_strm0 
                                 | bank_fsm[29].read_ready_strm0 
                                 | bank_fsm[30].read_ready_strm0 
                                 | bank_fsm[31].read_ready_strm0 
                                  ;
  assign memc__dma__write_ready1  = bank_fsm[ 1].write_ready_strm;
  assign memc__dma__read_ready1   = bank_fsm[ 1].read_ready_strm ;

  assign memc__dma__write_ready2  = bank_fsm[ 2].write_ready_strm;
  assign memc__dma__read_ready2   = bank_fsm[ 2].read_ready_strm ;

  assign memc__dma__write_ready3  = bank_fsm[ 3].write_ready_strm;
  assign memc__dma__read_ready3   = bank_fsm[ 3].read_ready_strm ;

  assign memc__dma__write_ready4  = bank_fsm[ 4].write_ready_strm;
  assign memc__dma__read_ready4   = bank_fsm[ 4].read_ready_strm ;

  assign memc__dma__write_ready5  = bank_fsm[ 5].write_ready_strm;
  assign memc__dma__read_ready5   = bank_fsm[ 5].read_ready_strm ;

  assign memc__dma__write_ready6  = bank_fsm[ 6].write_ready_strm;
  assign memc__dma__read_ready6   = bank_fsm[ 6].read_ready_strm ;

  assign memc__dma__write_ready7  = bank_fsm[ 7].write_ready_strm;
  assign memc__dma__read_ready7   = bank_fsm[ 7].read_ready_strm ;

  assign memc__dma__write_ready8  = bank_fsm[ 8].write_ready_strm;
  assign memc__dma__read_ready8   = bank_fsm[ 8].read_ready_strm ;

  assign memc__dma__write_ready9  = bank_fsm[ 9].write_ready_strm;
  assign memc__dma__read_ready9   = bank_fsm[ 9].read_ready_strm ;

  assign memc__dma__write_ready10 = bank_fsm[10].write_ready_strm;
  assign memc__dma__read_ready10  = bank_fsm[10].read_ready_strm ;

  assign memc__dma__write_ready11 = bank_fsm[11].write_ready_strm;
  assign memc__dma__read_ready11  = bank_fsm[11].read_ready_strm ;

  assign memc__dma__write_ready12 = bank_fsm[12].write_ready_strm;
  assign memc__dma__read_ready12  = bank_fsm[12].read_ready_strm ;

  assign memc__dma__write_ready13 = bank_fsm[13].write_ready_strm;
  assign memc__dma__read_ready13  = bank_fsm[13].read_ready_strm ;

  assign memc__dma__write_ready14 = bank_fsm[14].write_ready_strm;
  assign memc__dma__read_ready14  = bank_fsm[14].read_ready_strm ;

  assign memc__dma__write_ready15 = bank_fsm[15].write_ready_strm;
  assign memc__dma__read_ready15  = bank_fsm[15].read_ready_strm ;

  assign memc__dma__write_ready16 = bank_fsm[16].write_ready_strm;
  assign memc__dma__read_ready16  = bank_fsm[16].read_ready_strm ;

  assign memc__dma__write_ready17 = bank_fsm[17].write_ready_strm;
  assign memc__dma__read_ready17  = bank_fsm[17].read_ready_strm ;

  assign memc__dma__write_ready18 = bank_fsm[18].write_ready_strm;
  assign memc__dma__read_ready18  = bank_fsm[18].read_ready_strm ;

  assign memc__dma__write_ready19 = bank_fsm[19].write_ready_strm;
  assign memc__dma__read_ready19  = bank_fsm[19].read_ready_strm ;

  assign memc__dma__write_ready20 = bank_fsm[20].write_ready_strm;
  assign memc__dma__read_ready20  = bank_fsm[20].read_ready_strm ;

  assign memc__dma__write_ready21 = bank_fsm[21].write_ready_strm;
  assign memc__dma__read_ready21  = bank_fsm[21].read_ready_strm ;

  assign memc__dma__write_ready22 = bank_fsm[22].write_ready_strm;
  assign memc__dma__read_ready22  = bank_fsm[22].read_ready_strm ;

  assign memc__dma__write_ready23 = bank_fsm[23].write_ready_strm;
  assign memc__dma__read_ready23  = bank_fsm[23].read_ready_strm ;

  assign memc__dma__write_ready24 = bank_fsm[24].write_ready_strm;
  assign memc__dma__read_ready24  = bank_fsm[24].read_ready_strm ;

  assign memc__dma__write_ready25 = bank_fsm[25].write_ready_strm;
  assign memc__dma__read_ready25  = bank_fsm[25].read_ready_strm ;

  assign memc__dma__write_ready26 = bank_fsm[26].write_ready_strm;
  assign memc__dma__read_ready26  = bank_fsm[26].read_ready_strm ;

  assign memc__dma__write_ready27 = bank_fsm[27].write_ready_strm;
  assign memc__dma__read_ready27  = bank_fsm[27].read_ready_strm ;

  assign memc__dma__write_ready28 = bank_fsm[28].write_ready_strm;
  assign memc__dma__read_ready28  = bank_fsm[28].read_ready_strm ;

  assign memc__dma__write_ready29 = bank_fsm[29].write_ready_strm;
  assign memc__dma__read_ready29  = bank_fsm[29].read_ready_strm ;

  assign memc__dma__write_ready30 = bank_fsm[30].write_ready_strm;
  assign memc__dma__read_ready30  = bank_fsm[30].read_ready_strm ;

  assign memc__dma__write_ready31 = bank_fsm[31].write_ready_strm;
  assign memc__dma__read_ready31  = bank_fsm[31].read_ready_strm ;
