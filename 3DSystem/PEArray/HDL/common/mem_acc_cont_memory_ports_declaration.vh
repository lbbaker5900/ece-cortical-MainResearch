
`ifdef SYNTHESIS
            // Memory port 0
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address0  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data0     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address0 ;
  output                                       memc__sram__write_enable0  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data0    ;

            // Memory port 1
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address1  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data1     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address1 ;
  output                                       memc__sram__write_enable1  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data1    ;

            // Memory port 2
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address2  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data2     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address2 ;
  output                                       memc__sram__write_enable2  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data2    ;

            // Memory port 3
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address3  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data3     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address3 ;
  output                                       memc__sram__write_enable3  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data3    ;

            // Memory port 4
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address4  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data4     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address4 ;
  output                                       memc__sram__write_enable4  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data4    ;

            // Memory port 5
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address5  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data5     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address5 ;
  output                                       memc__sram__write_enable5  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data5    ;

            // Memory port 6
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address6  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data6     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address6 ;
  output                                       memc__sram__write_enable6  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data6    ;

            // Memory port 7
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address7  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data7     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address7 ;
  output                                       memc__sram__write_enable7  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data7    ;

            // Memory port 8
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address8  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data8     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address8 ;
  output                                       memc__sram__write_enable8  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data8    ;

            // Memory port 9
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address9  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data9     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address9 ;
  output                                       memc__sram__write_enable9  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data9    ;

            // Memory port 10
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address10  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data10     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address10 ;
  output                                       memc__sram__write_enable10  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data10    ;

            // Memory port 11
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address11  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data11     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address11 ;
  output                                       memc__sram__write_enable11  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data11    ;

            // Memory port 12
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address12  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data12     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address12 ;
  output                                       memc__sram__write_enable12  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data12    ;

            // Memory port 13
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address13  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data13     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address13 ;
  output                                       memc__sram__write_enable13  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data13    ;

            // Memory port 14
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address14  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data14     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address14 ;
  output                                       memc__sram__write_enable14  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data14    ;

            // Memory port 15
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address15  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data15     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address15 ;
  output                                       memc__sram__write_enable15  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data15    ;

            // Memory port 16
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address16  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data16     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address16 ;
  output                                       memc__sram__write_enable16  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data16    ;

            // Memory port 17
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address17  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data17     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address17 ;
  output                                       memc__sram__write_enable17  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data17    ;

            // Memory port 18
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address18  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data18     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address18 ;
  output                                       memc__sram__write_enable18  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data18    ;

            // Memory port 19
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address19  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data19     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address19 ;
  output                                       memc__sram__write_enable19  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data19    ;

            // Memory port 20
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address20  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data20     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address20 ;
  output                                       memc__sram__write_enable20  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data20    ;

            // Memory port 21
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address21  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data21     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address21 ;
  output                                       memc__sram__write_enable21  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data21    ;

            // Memory port 22
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address22  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data22     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address22 ;
  output                                       memc__sram__write_enable22  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data22    ;

            // Memory port 23
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address23  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data23     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address23 ;
  output                                       memc__sram__write_enable23  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data23    ;

            // Memory port 24
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address24  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data24     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address24 ;
  output                                       memc__sram__write_enable24  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data24    ;

            // Memory port 25
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address25  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data25     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address25 ;
  output                                       memc__sram__write_enable25  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data25    ;

            // Memory port 26
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address26  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data26     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address26 ;
  output                                       memc__sram__write_enable26  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data26    ;

            // Memory port 27
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address27  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data27     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address27 ;
  output                                       memc__sram__write_enable27  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data27    ;

            // Memory port 28
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address28  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data28     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address28 ;
  output                                       memc__sram__write_enable28  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data28    ;

            // Memory port 29
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address29  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data29     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address29 ;
  output                                       memc__sram__write_enable29  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data29    ;

            // Memory port 30
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address30  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data30     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address30 ;
  output                                       memc__sram__write_enable30  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data30    ;

            // Memory port 31
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address31  ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data31     ;
  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address31 ;
  output                                       memc__sram__write_enable31  ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data31    ;

`endif