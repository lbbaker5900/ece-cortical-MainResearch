




  // DMA port 0
  input                                         dma__memc__write_valid0 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address0 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data0 ;
  output                                        memc__dma__write_ready0 ;
  input                                         dma__memc__read_valid0 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address0 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data0 ;
  output                                        memc__dma__read_data_valid0 ;
  output                                        memc__dma__read_ready0 ;
  input                                         dma__memc__read_pause0 ;

  // DMA port 1
  input                                         dma__memc__write_valid1 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address1 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data1 ;
  output                                        memc__dma__write_ready1 ;
  input                                         dma__memc__read_valid1 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address1 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data1 ;
  output                                        memc__dma__read_data_valid1 ;
  output                                        memc__dma__read_ready1 ;
  input                                         dma__memc__read_pause1 ;

  // DMA port 2
  input                                         dma__memc__write_valid2 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address2 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data2 ;
  output                                        memc__dma__write_ready2 ;
  input                                         dma__memc__read_valid2 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address2 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data2 ;
  output                                        memc__dma__read_data_valid2 ;
  output                                        memc__dma__read_ready2 ;
  input                                         dma__memc__read_pause2 ;

  // DMA port 3
  input                                         dma__memc__write_valid3 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address3 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data3 ;
  output                                        memc__dma__write_ready3 ;
  input                                         dma__memc__read_valid3 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address3 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data3 ;
  output                                        memc__dma__read_data_valid3 ;
  output                                        memc__dma__read_ready3 ;
  input                                         dma__memc__read_pause3 ;

  // DMA port 4
  input                                         dma__memc__write_valid4 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address4 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data4 ;
  output                                        memc__dma__write_ready4 ;
  input                                         dma__memc__read_valid4 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address4 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data4 ;
  output                                        memc__dma__read_data_valid4 ;
  output                                        memc__dma__read_ready4 ;
  input                                         dma__memc__read_pause4 ;

  // DMA port 5
  input                                         dma__memc__write_valid5 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address5 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data5 ;
  output                                        memc__dma__write_ready5 ;
  input                                         dma__memc__read_valid5 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address5 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data5 ;
  output                                        memc__dma__read_data_valid5 ;
  output                                        memc__dma__read_ready5 ;
  input                                         dma__memc__read_pause5 ;

  // DMA port 6
  input                                         dma__memc__write_valid6 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address6 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data6 ;
  output                                        memc__dma__write_ready6 ;
  input                                         dma__memc__read_valid6 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address6 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data6 ;
  output                                        memc__dma__read_data_valid6 ;
  output                                        memc__dma__read_ready6 ;
  input                                         dma__memc__read_pause6 ;

  // DMA port 7
  input                                         dma__memc__write_valid7 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address7 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data7 ;
  output                                        memc__dma__write_ready7 ;
  input                                         dma__memc__read_valid7 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address7 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data7 ;
  output                                        memc__dma__read_data_valid7 ;
  output                                        memc__dma__read_ready7 ;
  input                                         dma__memc__read_pause7 ;

  // DMA port 8
  input                                         dma__memc__write_valid8 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address8 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data8 ;
  output                                        memc__dma__write_ready8 ;
  input                                         dma__memc__read_valid8 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address8 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data8 ;
  output                                        memc__dma__read_data_valid8 ;
  output                                        memc__dma__read_ready8 ;
  input                                         dma__memc__read_pause8 ;

  // DMA port 9
  input                                         dma__memc__write_valid9 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address9 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data9 ;
  output                                        memc__dma__write_ready9 ;
  input                                         dma__memc__read_valid9 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address9 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data9 ;
  output                                        memc__dma__read_data_valid9 ;
  output                                        memc__dma__read_ready9 ;
  input                                         dma__memc__read_pause9 ;

  // DMA port 10
  input                                         dma__memc__write_valid10 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address10 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data10 ;
  output                                        memc__dma__write_ready10 ;
  input                                         dma__memc__read_valid10 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address10 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data10 ;
  output                                        memc__dma__read_data_valid10 ;
  output                                        memc__dma__read_ready10 ;
  input                                         dma__memc__read_pause10 ;

  // DMA port 11
  input                                         dma__memc__write_valid11 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address11 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data11 ;
  output                                        memc__dma__write_ready11 ;
  input                                         dma__memc__read_valid11 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address11 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data11 ;
  output                                        memc__dma__read_data_valid11 ;
  output                                        memc__dma__read_ready11 ;
  input                                         dma__memc__read_pause11 ;

  // DMA port 12
  input                                         dma__memc__write_valid12 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address12 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data12 ;
  output                                        memc__dma__write_ready12 ;
  input                                         dma__memc__read_valid12 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address12 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data12 ;
  output                                        memc__dma__read_data_valid12 ;
  output                                        memc__dma__read_ready12 ;
  input                                         dma__memc__read_pause12 ;

  // DMA port 13
  input                                         dma__memc__write_valid13 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address13 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data13 ;
  output                                        memc__dma__write_ready13 ;
  input                                         dma__memc__read_valid13 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address13 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data13 ;
  output                                        memc__dma__read_data_valid13 ;
  output                                        memc__dma__read_ready13 ;
  input                                         dma__memc__read_pause13 ;

  // DMA port 14
  input                                         dma__memc__write_valid14 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address14 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data14 ;
  output                                        memc__dma__write_ready14 ;
  input                                         dma__memc__read_valid14 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address14 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data14 ;
  output                                        memc__dma__read_data_valid14 ;
  output                                        memc__dma__read_ready14 ;
  input                                         dma__memc__read_pause14 ;

  // DMA port 15
  input                                         dma__memc__write_valid15 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address15 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data15 ;
  output                                        memc__dma__write_ready15 ;
  input                                         dma__memc__read_valid15 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address15 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data15 ;
  output                                        memc__dma__read_data_valid15 ;
  output                                        memc__dma__read_ready15 ;
  input                                         dma__memc__read_pause15 ;

  // DMA port 16
  input                                         dma__memc__write_valid16 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address16 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data16 ;
  output                                        memc__dma__write_ready16 ;
  input                                         dma__memc__read_valid16 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address16 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data16 ;
  output                                        memc__dma__read_data_valid16 ;
  output                                        memc__dma__read_ready16 ;
  input                                         dma__memc__read_pause16 ;

  // DMA port 17
  input                                         dma__memc__write_valid17 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address17 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data17 ;
  output                                        memc__dma__write_ready17 ;
  input                                         dma__memc__read_valid17 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address17 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data17 ;
  output                                        memc__dma__read_data_valid17 ;
  output                                        memc__dma__read_ready17 ;
  input                                         dma__memc__read_pause17 ;

  // DMA port 18
  input                                         dma__memc__write_valid18 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address18 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data18 ;
  output                                        memc__dma__write_ready18 ;
  input                                         dma__memc__read_valid18 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address18 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data18 ;
  output                                        memc__dma__read_data_valid18 ;
  output                                        memc__dma__read_ready18 ;
  input                                         dma__memc__read_pause18 ;

  // DMA port 19
  input                                         dma__memc__write_valid19 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address19 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data19 ;
  output                                        memc__dma__write_ready19 ;
  input                                         dma__memc__read_valid19 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address19 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data19 ;
  output                                        memc__dma__read_data_valid19 ;
  output                                        memc__dma__read_ready19 ;
  input                                         dma__memc__read_pause19 ;

  // DMA port 20
  input                                         dma__memc__write_valid20 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address20 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data20 ;
  output                                        memc__dma__write_ready20 ;
  input                                         dma__memc__read_valid20 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address20 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data20 ;
  output                                        memc__dma__read_data_valid20 ;
  output                                        memc__dma__read_ready20 ;
  input                                         dma__memc__read_pause20 ;

  // DMA port 21
  input                                         dma__memc__write_valid21 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address21 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data21 ;
  output                                        memc__dma__write_ready21 ;
  input                                         dma__memc__read_valid21 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address21 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data21 ;
  output                                        memc__dma__read_data_valid21 ;
  output                                        memc__dma__read_ready21 ;
  input                                         dma__memc__read_pause21 ;

  // DMA port 22
  input                                         dma__memc__write_valid22 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address22 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data22 ;
  output                                        memc__dma__write_ready22 ;
  input                                         dma__memc__read_valid22 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address22 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data22 ;
  output                                        memc__dma__read_data_valid22 ;
  output                                        memc__dma__read_ready22 ;
  input                                         dma__memc__read_pause22 ;

  // DMA port 23
  input                                         dma__memc__write_valid23 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address23 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data23 ;
  output                                        memc__dma__write_ready23 ;
  input                                         dma__memc__read_valid23 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address23 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data23 ;
  output                                        memc__dma__read_data_valid23 ;
  output                                        memc__dma__read_ready23 ;
  input                                         dma__memc__read_pause23 ;

  // DMA port 24
  input                                         dma__memc__write_valid24 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address24 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data24 ;
  output                                        memc__dma__write_ready24 ;
  input                                         dma__memc__read_valid24 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address24 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data24 ;
  output                                        memc__dma__read_data_valid24 ;
  output                                        memc__dma__read_ready24 ;
  input                                         dma__memc__read_pause24 ;

  // DMA port 25
  input                                         dma__memc__write_valid25 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address25 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data25 ;
  output                                        memc__dma__write_ready25 ;
  input                                         dma__memc__read_valid25 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address25 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data25 ;
  output                                        memc__dma__read_data_valid25 ;
  output                                        memc__dma__read_ready25 ;
  input                                         dma__memc__read_pause25 ;

  // DMA port 26
  input                                         dma__memc__write_valid26 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address26 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data26 ;
  output                                        memc__dma__write_ready26 ;
  input                                         dma__memc__read_valid26 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address26 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data26 ;
  output                                        memc__dma__read_data_valid26 ;
  output                                        memc__dma__read_ready26 ;
  input                                         dma__memc__read_pause26 ;

  // DMA port 27
  input                                         dma__memc__write_valid27 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address27 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data27 ;
  output                                        memc__dma__write_ready27 ;
  input                                         dma__memc__read_valid27 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address27 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data27 ;
  output                                        memc__dma__read_data_valid27 ;
  output                                        memc__dma__read_ready27 ;
  input                                         dma__memc__read_pause27 ;

  // DMA port 28
  input                                         dma__memc__write_valid28 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address28 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data28 ;
  output                                        memc__dma__write_ready28 ;
  input                                         dma__memc__read_valid28 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address28 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data28 ;
  output                                        memc__dma__read_data_valid28 ;
  output                                        memc__dma__read_ready28 ;
  input                                         dma__memc__read_pause28 ;

  // DMA port 29
  input                                         dma__memc__write_valid29 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address29 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data29 ;
  output                                        memc__dma__write_ready29 ;
  input                                         dma__memc__read_valid29 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address29 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data29 ;
  output                                        memc__dma__read_data_valid29 ;
  output                                        memc__dma__read_ready29 ;
  input                                         dma__memc__read_pause29 ;

  // DMA port 30
  input                                         dma__memc__write_valid30 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address30 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data30 ;
  output                                        memc__dma__write_ready30 ;
  input                                         dma__memc__read_valid30 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address30 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data30 ;
  output                                        memc__dma__read_data_valid30 ;
  output                                        memc__dma__read_ready30 ;
  input                                         dma__memc__read_pause30 ;

  // DMA port 31
  input                                         dma__memc__write_valid31 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address31 ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data31 ;
  output                                        memc__dma__write_ready31 ;
  input                                         dma__memc__read_valid31 ;
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address31 ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data31 ;
  output                                        memc__dma__read_data_valid31 ;
  output                                        memc__dma__read_ready31 ;
  input                                         dma__memc__read_pause31 ;
