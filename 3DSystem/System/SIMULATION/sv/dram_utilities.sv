/*********************************************************************************************
    File name   : dram_utilities.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Aug 2017
    Email       : lbbaker@ncsu.edu
    
    Description : DRAM Utilities.

                  For example, reads the manager_<y>_<x>_layer<n>_group_<g>_AllGroupMemory.txt file and preloads the 
                  memory locations from the operand data in an operation provided by the manager.

*********************************************************************************************/

`include "common.vh"
`include "stack_interface.vh"
`include "stack_interface_typedef.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"
`include "pe.vh"
`include "pe_array.vh"
`include "manager.vh"
`include "pe_cntl.vh"
`include "noc_interpe_port_Bitmasks.vh"

`include "TB_streamingOps_cntl.vh"  // might cause an error if this is included in any of the above files


import virtual_interface::*;
import operation::*;

package dram_utils;

  import virtual_interface::*;

  class dram_utilities;

    int               Id                              ; 
                                                                   
    mailbox           mgr2dramInit                    ;
    event             dramInit2mgr_ack                ; 

    operation::base_operation    sys_operation        ; 

    string                      allGroupFileName      ;

    vDiRamCfg_T                 vDramCfgIfc  [`MGR_DRAM_NUM_CHANNELS] ;

    //----------------------------------------------------------------------------------------------------
    // Misc

    int        fileDesc      ;
    string     fileLine      ;
    byte       char          ;
    bit        found         ;
    int        idxs     [64] ;  // delineate up to 32 operands for each stream
    int        idx           ;
    string     address [64]  ;  // extract the chan/bank/page/word for each lane
    string     cbpw [4]      ;
    string     tmp_str       ;
    


    //----------------------------------------------------------------------------------------------------



    function new (
                  input int                          Id 
                  );

        this.Id                            =   Id  ;
    endfunction

    task loadDramFromAllGroupFile ( input         string                        allGroupFileName                           ,
                                    input         operation::base_operation     sys_operation_data [`PE_NUM_OF_EXEC_LANES] ,
                                    input         vDiRamCfg_T                   vDramCfgIfc        [`MGR_DRAM_NUM_CHANNELS]        
                                          );
      logic [`MGR_DRAM_BANK_ADDRESS_RANGE       ]  config_bank_addr ;
      logic [`MGR_DRAM_PAGE_ADDRESS_RANGE       ]  config_row_addr  ;
      `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
      logic [`MGR_DRAM_ADDRESS_LINE_FIELD_RANGE ]  config_line_addr ;
      `endif
      logic                                        config_burst     ;
      logic [`MGR_MMC_TO_MRC_WORD_ADDRESS_RANGE  ] config_word      ;
      logic                                        config_load      ;

      int lineNum ;
      int count   ;

      for (int i=0; i<`MGR_DRAM_NUM_CHANNELS; i++)
        begin
          vDramCfgIfc[i].config_bank_addr  =  'd0 ;
          vDramCfgIfc[i].config_row_addr   =  'd0 ;
          vDramCfgIfc[i].config_line_addr  =  'd0 ;
          vDramCfgIfc[i].config_burst      =  'd0 ;
          vDramCfgIfc[i].config_word       =  'd0 ;
          vDramCfgIfc[i].config_load       =  'd0 ;
        end

      // File format (without the //)

      //                                              |    Target Cell {z,y,x}   0,  0,  0      |    Target Cell {z,y,x}   1,  0,  0      |    Target Cell {z,y,x}   2,  0,  0      |    Target Cell {z,y,x}   3,  0,  0      |    Target Cell {z,y,x}   4,  0,  0      |    Target Cell {z,y,x}   5,  0,  0      |    Target Cell {z,y,x}   6,  0,  0      |    Target Cell {z,y,x}   7,  0,  0      |    Target Cell {z,y,x}   8,  0,  0      |    Target Cell {z,y,x}   9,  0,  0      |    Target Cell {z,y,x}  10,  0,  0      |    Target Cell {z,y,x}  11,  0,  0      |    Target Cell {z,y,x}  12,  0,  0      |    Target Cell {z,y,x}  13,  0,  0      |    Target Cell {z,y,x}  14,  0,  0      |    Target Cell {z,y,x}  15,  0,  0      |    Target Cell {z,y,x}  16,  0,  0      |    Target Cell {z,y,x}  17,  0,  0      |    Target Cell {z,y,x}  18,  0,  0      |    Target Cell {z,y,x}  19,  0,  0      |    Target Cell {z,y,x}  20,  0,  0      |    Target Cell {z,y,x}  21,  0,  0      |    Target Cell {z,y,x}  22,  0,  0      |    Target Cell {z,y,x}  23,  0,  0      |    Target Cell {z,y,x}  24,  0,  0      |    Target Cell {z,y,x}  25,  0,  0      |    Target Cell {z,y,x}  26,  0,  0      |    Target Cell {z,y,x}  27,  0,  0      |    Target Cell {z,y,x}  28,  0,  0      |    Target Cell {z,y,x}  29,  0,  0      |    Target Cell {z,y,x}  30,  0,  0      |    Target Cell {z,y,x}  31,  0,  0      |
      //                                              |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |
      //                                              |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |
      //                                              |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |
      //                                              |   0,  0 :    0       12    7     16     |   0,  0 :    1       12    7     16     |   0,  0 :    0       12    7     17     |   0,  0 :    1       12    7     17     |   0,  0 :    0       12    7     18     |   0,  0 :    1       12    7     18     |   0,  0 :    0       12    7     19     |   0,  0 :    1       12    7     19     |   0,  0 :    0       12    7     20     |   0,  0 :    1       12    7     20     |   0,  0 :    0       12    7     21     |   0,  0 :    1       12    7     21     |   0,  0 :    0       12    7     22     |   0,  0 :    1       12    7     22     |   0,  0 :    0       12    7     23     |   0,  0 :    1       12    7     23     |   0,  0 :    0       12    7     24     |   0,  0 :    1       12    7     24     |   0,  0 :    0       12    7     25     |   0,  0 :    1       12    7     25     |   0,  0 :    0       12    7     26     |   0,  0 :    1       12    7     26     |   0,  0 :    0       12    7     27     |   0,  0 :    1       12    7     27     |   0,  0 :    0       12    7     28     |   0,  0 :    1       12    7     28     |   0,  0 :    0       12    7     29     |   0,  0 :    1       12    7     29     |   0,  0 :    0       12    7     30     |   0,  0 :    1       12    7     30     |   0,  0 :    0       12    7     31     |   0,  0 :    1       12    7     31     |
      //                                              |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |
      // source cell   |     ROI Local memory         |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |
      // Z   Y   X     | Channel  Bank  Page  Word    |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |
      //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      // 0   0   0  *  |    0       0     0     0     |              1       2     9     0      |              1       2     9     1      |              1       2     9     2      |              1       2     9     3      |              1       2     9     4      |              1       2     9     5      |              1       2     9     6      |              1       2     9     7      |              1       2     9     8      |              1       2     9     9      |              1       2     9     10     |              1       2     9     11     |              1       2     9     12     |              1       2     9     13     |              1       2     9     14     |              1       2     9     15     |              1       2     9     16     |              1       2     9     17     |              1       2     9     18     |              1       2     9     19     |              1       2     9     20     |              1       2     9     21     |              1       2     9     22     |              1       2     9     23     |              1       2     9     24     |              1       2     9     25     |              1       2     9     26     |              1       2     9     27     |              1       2     9     28     |              1       2     9     29     |              1       2     9     30     |              1       2     9     31     | 
      // 1   0   0  *  |    1       0     0     0     |              1       2     9     32     |              1       2     9     33     |              1       2     9     34     |              1       2     9     35     |              1       2     9     36     |              1       2     9     37     |              1       2     9     38     |              1       2     9     39     |              1       2     9     40     |              1       2     9     41     |              1       2     9     42     |              1       2     9     43     |              1       2     9     44     |              1       2     9     45     |              1       2     9     46     |              1       2     9     47     |              1       2     9     48     |              1       2     9     49     |              1       2     9     50     |              1       2     9     51     |              1       2     9     52     |              1       2     9     53     |              1       2     9     54     |              1       2     9     55     |              1       2     9     56     |              1       2     9     57     |              1       2     9     58     |              1       2     9     59     |              1       2     9     60     |              1       2     9     61     |              1       2     9     62     |              1       2     9     63     | 

      $display("@%0t :%s:%0d:INFO: Loading DRAM from AllGroup file %s for manager {%0d}", $time, `__FILE__, `__LINE__, allGroupFileName, Id);

      fileDesc = $fopen (allGroupFileName, "r");
      if (fileDesc == 0) 
        begin
          $display("@%0t :%s:%0d:ERROR: file open error opening : %s", $time, `__FILE__, `__LINE__, allGroupFileName);
          $finish;
      end

      
      found = 0;
      lineNum = 0;
      count   = 0;

      while (!$feof(fileDesc)) 
        begin
   
          // first find the "---------------------"
          while (found == 0)
            begin
              void'($fgetc (fileDesc)); 
              if (char == `COMMON_ASCII_HIPHON )
                begin
                  void'($fgets (fileLine, fileDesc)); 
                  found = 1;
                end
              else
                begin
                  void'($fgets (fileLine, fileDesc)); 
                end
              /* seemed to work but then didnt ???
              void'($fgets (fileLine, fileDesc)); 
              if (fileLine.substr(0,0).compare("-") != 0) 
                begin
                  $display("@%0t :%s:%0d:INFO: Manager {%0d} : Found - in fileLine: %s", $time, `__FILE__, `__LINE__, Id, fileLine);
                  found = 1;
                end
              */
            end

          void'($fgets (fileLine, fileDesc)); 
          //$display("@%0t :%s:%0d:INFO: Manager {%0d} : fileLine: %s", $time, `__FILE__, `__LINE__, Id, fileLine);

          // find the index of the "|" delineators
          idx = 0;
          for (int i=0; i<fileLine.len(); i++)
            begin
              if (fileLine.substr(i,i) == 'ha)
                begin
                  break;
                end
              else if (fileLine.substr(i,i) == "|")
                begin
                  idxs[idx] = i ;
                  //$display("@%0t :%s:%0d:INFO: %d ", $time, `__FILE__, `__LINE__, i);
                  idx++;
                end
            end

          //$display("@%0t :%s:%0d:INFO: Manager {%0d} : Num of | %d ", $time, `__FILE__, `__LINE__, Id, idx);
/*
          void'($fgets (fileLine, fileDesc)); 
          void'($sscanf(fileLine, "%s  %s  %s  %s  %s ", a,b,c,d,e));
          $display("@%0t :%s:%0d:INFO: %s %s %s %s %s", $time, `__FILE__, `__LINE__, a,b,c,d,e);
*/
          count  = 0;

          //$display("@%0t :%s:%0d:INFO: Loading DRAM from AllGroup file %s for manager {%0d}", $time, `__FILE__, `__LINE__, allGroupFileName, Id);
          for (int i=0; i<idx-1; i++)
            begin
              tmp_str = fileLine.substr(idxs[i]+1, idxs[i+1]-1);
              void'($sscanf(tmp_str, "%s %s %s %s ", cbpw[0], cbpw[1], cbpw[2], cbpw[3]));
              $display("@%0t :%s:%0d:INFO: Manager {%0d} : %d: %h %h %h %h ", $time, `__FILE__, `__LINE__, Id, i, cbpw[0].atoi(), cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi());

              vDramCfgIfc[cbpw[0].atoi()].config_bank_addr  =  cbpw[1].atoi() ;
              vDramCfgIfc[cbpw[0].atoi()].config_row_addr   =  cbpw[2].atoi() ;
              vDramCfgIfc[cbpw[0].atoi()].config_line_addr  =  cbpw[3].atoi() ;
              vDramCfgIfc[cbpw[0].atoi()].config_burst      =  (cbpw[3].atoi() > 63) ;
              vDramCfgIfc[cbpw[0].atoi()].config_word       =  cbpw[3].atoi()%64 ;

              if (i == 0)
                begin
                  vDramCfgIfc[cbpw[0].atoi()].config_data       =  sys_operation_data[i].operands[0][count];
                  //$display("@%0t :%s:%0d:INFO: Manager {%0d} : %d: %h %h %h %h : %h ", $time, `__FILE__, `__LINE__, Id, i, cbpw[0].atoi(), cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi(), sys_operation_data[i].operands[0][count]);
                end
              else
                begin
                  vDramCfgIfc[cbpw[0].atoi()].config_data       =  sys_operation_data[i-1].operands[1][count];
                  //$display("@%0t :%s:%0d:INFO: Manager {%0d} : %d: %h %h %h %h : %h ", $time, `__FILE__, `__LINE__, Id, i, cbpw[0].atoi(), cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi(), sys_operation_data[i-1].operands[1][count]);
                end
             
              vDramCfgIfc[cbpw[0].atoi()].config_load       =  'd0 ;
              #0.01  vDramCfgIfc[cbpw[0].atoi()].config_load       =  'd0 ;
              #0.01  vDramCfgIfc[cbpw[0].atoi()].config_load       =  'd1 ;
              #0.01  vDramCfgIfc[cbpw[0].atoi()].config_load       =  'd0 ;
            end
          //while (transaction[0] < sys_operation[0].numberOfOperands)
          //vDownstreamStackBusLane[0].cb_test.std__pe__lane_sys_data        <= sys_operation[0].operands[transaction[0]]  ;
          count ++;
          if (count == sys_operation_data[0].numberOfOperands)
            begin
              count = 0;
            end
          lineNum++;
      
        end

      $fclose(fileDesc);

    endtask

    task run();
    endtask


  endclass


endpackage

