
`ifdef SYNTHESIS
  // Memory port 0
  assign memc__sram__read_address0  = bank_mem[0].read_address  ;
  assign bank_mem[0].read_data_next = sram__memc__read_data0    ;
  assign memc__sram__write_address0 = bank_mem[0].write_address ;
  assign memc__sram__write_enable0  = bank_mem[0].write_enable  ;
  assign memc__sram__write_data0    = bank_mem[0].write_data    ;

  // Memory port 1
  assign memc__sram__read_address1  = bank_mem[1].read_address  ;
  assign bank_mem[1].read_data_next = sram__memc__read_data1    ;
  assign memc__sram__write_address1 = bank_mem[1].write_address ;
  assign memc__sram__write_enable1  = bank_mem[1].write_enable  ;
  assign memc__sram__write_data1    = bank_mem[1].write_data    ;

  // Memory port 2
  assign memc__sram__read_address2  = bank_mem[2].read_address  ;
  assign bank_mem[2].read_data_next = sram__memc__read_data2    ;
  assign memc__sram__write_address2 = bank_mem[2].write_address ;
  assign memc__sram__write_enable2  = bank_mem[2].write_enable  ;
  assign memc__sram__write_data2    = bank_mem[2].write_data    ;

  // Memory port 3
  assign memc__sram__read_address3  = bank_mem[3].read_address  ;
  assign bank_mem[3].read_data_next = sram__memc__read_data3    ;
  assign memc__sram__write_address3 = bank_mem[3].write_address ;
  assign memc__sram__write_enable3  = bank_mem[3].write_enable  ;
  assign memc__sram__write_data3    = bank_mem[3].write_data    ;

  // Memory port 4
  assign memc__sram__read_address4  = bank_mem[4].read_address  ;
  assign bank_mem[4].read_data_next = sram__memc__read_data4    ;
  assign memc__sram__write_address4 = bank_mem[4].write_address ;
  assign memc__sram__write_enable4  = bank_mem[4].write_enable  ;
  assign memc__sram__write_data4    = bank_mem[4].write_data    ;

  // Memory port 5
  assign memc__sram__read_address5  = bank_mem[5].read_address  ;
  assign bank_mem[5].read_data_next = sram__memc__read_data5    ;
  assign memc__sram__write_address5 = bank_mem[5].write_address ;
  assign memc__sram__write_enable5  = bank_mem[5].write_enable  ;
  assign memc__sram__write_data5    = bank_mem[5].write_data    ;

  // Memory port 6
  assign memc__sram__read_address6  = bank_mem[6].read_address  ;
  assign bank_mem[6].read_data_next = sram__memc__read_data6    ;
  assign memc__sram__write_address6 = bank_mem[6].write_address ;
  assign memc__sram__write_enable6  = bank_mem[6].write_enable  ;
  assign memc__sram__write_data6    = bank_mem[6].write_data    ;

  // Memory port 7
  assign memc__sram__read_address7  = bank_mem[7].read_address  ;
  assign bank_mem[7].read_data_next = sram__memc__read_data7    ;
  assign memc__sram__write_address7 = bank_mem[7].write_address ;
  assign memc__sram__write_enable7  = bank_mem[7].write_enable  ;
  assign memc__sram__write_data7    = bank_mem[7].write_data    ;

  // Memory port 8
  assign memc__sram__read_address8  = bank_mem[8].read_address  ;
  assign bank_mem[8].read_data_next = sram__memc__read_data8    ;
  assign memc__sram__write_address8 = bank_mem[8].write_address ;
  assign memc__sram__write_enable8  = bank_mem[8].write_enable  ;
  assign memc__sram__write_data8    = bank_mem[8].write_data    ;

  // Memory port 9
  assign memc__sram__read_address9  = bank_mem[9].read_address  ;
  assign bank_mem[9].read_data_next = sram__memc__read_data9    ;
  assign memc__sram__write_address9 = bank_mem[9].write_address ;
  assign memc__sram__write_enable9  = bank_mem[9].write_enable  ;
  assign memc__sram__write_data9    = bank_mem[9].write_data    ;

  // Memory port 10
  assign memc__sram__read_address10  = bank_mem[10].read_address  ;
  assign bank_mem[10].read_data_next = sram__memc__read_data10    ;
  assign memc__sram__write_address10 = bank_mem[10].write_address ;
  assign memc__sram__write_enable10  = bank_mem[10].write_enable  ;
  assign memc__sram__write_data10    = bank_mem[10].write_data    ;

  // Memory port 11
  assign memc__sram__read_address11  = bank_mem[11].read_address  ;
  assign bank_mem[11].read_data_next = sram__memc__read_data11    ;
  assign memc__sram__write_address11 = bank_mem[11].write_address ;
  assign memc__sram__write_enable11  = bank_mem[11].write_enable  ;
  assign memc__sram__write_data11    = bank_mem[11].write_data    ;

  // Memory port 12
  assign memc__sram__read_address12  = bank_mem[12].read_address  ;
  assign bank_mem[12].read_data_next = sram__memc__read_data12    ;
  assign memc__sram__write_address12 = bank_mem[12].write_address ;
  assign memc__sram__write_enable12  = bank_mem[12].write_enable  ;
  assign memc__sram__write_data12    = bank_mem[12].write_data    ;

  // Memory port 13
  assign memc__sram__read_address13  = bank_mem[13].read_address  ;
  assign bank_mem[13].read_data_next = sram__memc__read_data13    ;
  assign memc__sram__write_address13 = bank_mem[13].write_address ;
  assign memc__sram__write_enable13  = bank_mem[13].write_enable  ;
  assign memc__sram__write_data13    = bank_mem[13].write_data    ;

  // Memory port 14
  assign memc__sram__read_address14  = bank_mem[14].read_address  ;
  assign bank_mem[14].read_data_next = sram__memc__read_data14    ;
  assign memc__sram__write_address14 = bank_mem[14].write_address ;
  assign memc__sram__write_enable14  = bank_mem[14].write_enable  ;
  assign memc__sram__write_data14    = bank_mem[14].write_data    ;

  // Memory port 15
  assign memc__sram__read_address15  = bank_mem[15].read_address  ;
  assign bank_mem[15].read_data_next = sram__memc__read_data15    ;
  assign memc__sram__write_address15 = bank_mem[15].write_address ;
  assign memc__sram__write_enable15  = bank_mem[15].write_enable  ;
  assign memc__sram__write_data15    = bank_mem[15].write_data    ;

  // Memory port 16
  assign memc__sram__read_address16  = bank_mem[16].read_address  ;
  assign bank_mem[16].read_data_next = sram__memc__read_data16    ;
  assign memc__sram__write_address16 = bank_mem[16].write_address ;
  assign memc__sram__write_enable16  = bank_mem[16].write_enable  ;
  assign memc__sram__write_data16    = bank_mem[16].write_data    ;

  // Memory port 17
  assign memc__sram__read_address17  = bank_mem[17].read_address  ;
  assign bank_mem[17].read_data_next = sram__memc__read_data17    ;
  assign memc__sram__write_address17 = bank_mem[17].write_address ;
  assign memc__sram__write_enable17  = bank_mem[17].write_enable  ;
  assign memc__sram__write_data17    = bank_mem[17].write_data    ;

  // Memory port 18
  assign memc__sram__read_address18  = bank_mem[18].read_address  ;
  assign bank_mem[18].read_data_next = sram__memc__read_data18    ;
  assign memc__sram__write_address18 = bank_mem[18].write_address ;
  assign memc__sram__write_enable18  = bank_mem[18].write_enable  ;
  assign memc__sram__write_data18    = bank_mem[18].write_data    ;

  // Memory port 19
  assign memc__sram__read_address19  = bank_mem[19].read_address  ;
  assign bank_mem[19].read_data_next = sram__memc__read_data19    ;
  assign memc__sram__write_address19 = bank_mem[19].write_address ;
  assign memc__sram__write_enable19  = bank_mem[19].write_enable  ;
  assign memc__sram__write_data19    = bank_mem[19].write_data    ;

  // Memory port 20
  assign memc__sram__read_address20  = bank_mem[20].read_address  ;
  assign bank_mem[20].read_data_next = sram__memc__read_data20    ;
  assign memc__sram__write_address20 = bank_mem[20].write_address ;
  assign memc__sram__write_enable20  = bank_mem[20].write_enable  ;
  assign memc__sram__write_data20    = bank_mem[20].write_data    ;

  // Memory port 21
  assign memc__sram__read_address21  = bank_mem[21].read_address  ;
  assign bank_mem[21].read_data_next = sram__memc__read_data21    ;
  assign memc__sram__write_address21 = bank_mem[21].write_address ;
  assign memc__sram__write_enable21  = bank_mem[21].write_enable  ;
  assign memc__sram__write_data21    = bank_mem[21].write_data    ;

  // Memory port 22
  assign memc__sram__read_address22  = bank_mem[22].read_address  ;
  assign bank_mem[22].read_data_next = sram__memc__read_data22    ;
  assign memc__sram__write_address22 = bank_mem[22].write_address ;
  assign memc__sram__write_enable22  = bank_mem[22].write_enable  ;
  assign memc__sram__write_data22    = bank_mem[22].write_data    ;

  // Memory port 23
  assign memc__sram__read_address23  = bank_mem[23].read_address  ;
  assign bank_mem[23].read_data_next = sram__memc__read_data23    ;
  assign memc__sram__write_address23 = bank_mem[23].write_address ;
  assign memc__sram__write_enable23  = bank_mem[23].write_enable  ;
  assign memc__sram__write_data23    = bank_mem[23].write_data    ;

  // Memory port 24
  assign memc__sram__read_address24  = bank_mem[24].read_address  ;
  assign bank_mem[24].read_data_next = sram__memc__read_data24    ;
  assign memc__sram__write_address24 = bank_mem[24].write_address ;
  assign memc__sram__write_enable24  = bank_mem[24].write_enable  ;
  assign memc__sram__write_data24    = bank_mem[24].write_data    ;

  // Memory port 25
  assign memc__sram__read_address25  = bank_mem[25].read_address  ;
  assign bank_mem[25].read_data_next = sram__memc__read_data25    ;
  assign memc__sram__write_address25 = bank_mem[25].write_address ;
  assign memc__sram__write_enable25  = bank_mem[25].write_enable  ;
  assign memc__sram__write_data25    = bank_mem[25].write_data    ;

  // Memory port 26
  assign memc__sram__read_address26  = bank_mem[26].read_address  ;
  assign bank_mem[26].read_data_next = sram__memc__read_data26    ;
  assign memc__sram__write_address26 = bank_mem[26].write_address ;
  assign memc__sram__write_enable26  = bank_mem[26].write_enable  ;
  assign memc__sram__write_data26    = bank_mem[26].write_data    ;

  // Memory port 27
  assign memc__sram__read_address27  = bank_mem[27].read_address  ;
  assign bank_mem[27].read_data_next = sram__memc__read_data27    ;
  assign memc__sram__write_address27 = bank_mem[27].write_address ;
  assign memc__sram__write_enable27  = bank_mem[27].write_enable  ;
  assign memc__sram__write_data27    = bank_mem[27].write_data    ;

  // Memory port 28
  assign memc__sram__read_address28  = bank_mem[28].read_address  ;
  assign bank_mem[28].read_data_next = sram__memc__read_data28    ;
  assign memc__sram__write_address28 = bank_mem[28].write_address ;
  assign memc__sram__write_enable28  = bank_mem[28].write_enable  ;
  assign memc__sram__write_data28    = bank_mem[28].write_data    ;

  // Memory port 29
  assign memc__sram__read_address29  = bank_mem[29].read_address  ;
  assign bank_mem[29].read_data_next = sram__memc__read_data29    ;
  assign memc__sram__write_address29 = bank_mem[29].write_address ;
  assign memc__sram__write_enable29  = bank_mem[29].write_enable  ;
  assign memc__sram__write_data29    = bank_mem[29].write_data    ;

  // Memory port 30
  assign memc__sram__read_address30  = bank_mem[30].read_address  ;
  assign bank_mem[30].read_data_next = sram__memc__read_data30    ;
  assign memc__sram__write_address30 = bank_mem[30].write_address ;
  assign memc__sram__write_enable30  = bank_mem[30].write_enable  ;
  assign memc__sram__write_data30    = bank_mem[30].write_data    ;

  // Memory port 31
  assign memc__sram__read_address31  = bank_mem[31].read_address  ;
  assign bank_mem[31].read_data_next = sram__memc__read_data31    ;
  assign memc__sram__write_address31 = bank_mem[31].write_address ;
  assign memc__sram__write_enable31  = bank_mem[31].write_enable  ;
  assign memc__sram__write_data31    = bank_mem[31].write_data    ;

`endif