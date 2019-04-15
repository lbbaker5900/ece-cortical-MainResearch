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
`include "manager_array.vh"
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

    localparam MGR_ARRAY_XY = $sqrt(`MGR_ARRAY_NUM_OF_MGR) ;



    //----------------------------------------------------------------------------------------------------



    function new (
                  input int           Id 
                  );

        this.Id    =   Id  ;
    endfunction

    task loadDramFromAllGroupFile ( input         string                        allGroupFileName                           ,
                                    input         operation::base_operation     sys_operation_data [`PE_NUM_OF_EXEC_LANES] ,
                                    input         vDiRamCfg_T                   vDramCfgIfc        [`MGR_DRAM_NUM_CHANNELS]        
                                          );
      int        fileDesc      ;
      string     fileLine      ;
      byte       char          ;
      int        idxs     [64] ;  // delineate up to 32 operands for each stream
      int        idx           ;
      string     address [64]  ;  // extract the chan/bank/page/word for each lane
      string     tmp_str       ;
    
      logic [`MGR_DRAM_BANK_ADDRESS_RANGE       ]  config_bank_addr ;
      logic [`MGR_DRAM_PAGE_ADDRESS_RANGE       ]  config_row_addr  ;
      logic [`MGR_DRAM_WORD_ADDRESS_RANGE       ]  config_word_addr ;
      logic                                        config_load      ;
      logic [31:0]                                 config_data      ;

      int lineNum ;
      int count   ;
      bit found   ;
      string     cbpw [4]      ;

      for (int i=0; i<`MGR_DRAM_NUM_CHANNELS; i++)
        begin
          vDramCfgIfc[i].config_bank_addr  =  'd0 ;
          vDramCfgIfc[i].config_row_addr   =  'd0 ;
          vDramCfgIfc[i].config_word_addr  =  'd0 ;
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
              char = $fgetc (fileDesc); 
              if (char == `COMMON_ASCII_HIPHON )
                begin
                  void'($fgets (fileLine, fileDesc)); 
                  found = 1;
                end
              else
                begin
                  void'($fgets (fileLine, fileDesc)); 
                end
              //$display("@%0t :%s:%0d:INFO: Manager {%0d} : Not Found - in fileLine: %s", $time, `__FILE__, `__LINE__, Id, fileLine);
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
          //$display("@%0t :%s:%0d:INFO: Manager {%0d} : line# %0d, fileLine: %s", $time, `__FILE__, `__LINE__, Id, lineNum, fileLine);

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
          $display("@%0t :%s:%0d:INFO: Loading DRAM from AllGroup file %s for manager {%0d}", $time, `__FILE__, `__LINE__, allGroupFileName, Id);
*/
          for (int i=0; i<idx-1; i++)
            begin
              tmp_str = fileLine.substr(idxs[i]+1, idxs[i+1]-1);
              void'($sscanf(tmp_str, "%s %s %s %s ", cbpw[0], cbpw[1], cbpw[2], cbpw[3]));
              //$display("@%0t :%s:%0d:INFO: Manager {%0d} : %0d: %4h %4h %4h ", $time, `__FILE__, `__LINE__, Id, i, cbpw[0].atoi(), cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi());

              //vDramCfgIfc[cbpw[0].atoi()].config_bank_addr  =  cbpw[1].atoi() ;
              //vDramCfgIfc[cbpw[0].atoi()].config_row_addr   =  cbpw[2].atoi() ;
              //vDramCfgIfc[cbpw[0].atoi()].config_word_addr  =  cbpw[3].atoi() ;

              // ROI is Arg0
              
              if (i == 0)
                begin
                  //vDramCfgIfc[cbpw[0].atoi()].config_data       =  sys_operation_data[i].operands[0][count];
                  config_data       =  sys_operation_data[i].operands[0][count];
                  //$display("@%0t :%s:%0d:INFO: Manager {%0d} : %0d: %h %h %h %h : %h ", $time, `__FILE__, `__LINE__, Id, i, cbpw[0].atoi(), cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi(), sys_operation_data[i].operands[0][count]);
                end
              // Arg1
              else
                begin
                  //vDramCfgIfc[cbpw[0].atoi()].config_data       =  sys_operation_data[i-1].operands[1][count];
                  config_data       =  sys_operation_data[i-1].operands[1][count];
                  //$display("@%0t :%s:%0d:INFO: Manager {%0d} : %0d: %h %h %h %h : %h ", $time, `__FILE__, `__LINE__, Id, i, cbpw[0].atoi(), cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi(), sys_operation_data[i-1].operands[1][count]);
                end
              
             
              vDramCfgIfc[cbpw[0].atoi()].config_load       =  'd0 ;
              //#0.01  vDramCfgIfc[cbpw[0].atoi()].config_load       =  'd0 ;
              //#0.01  vDramCfgIfc[cbpw[0].atoi()].config_load       =  'd1 ;
              //#0.01  vDramCfgIfc[cbpw[0].atoi()].config_load       =  'd0 ;
              //
              
              case (cbpw[0].atoi())
                0:
                  begin
                    if (cbpw[0].atoi() == 0)
                      begin
                        if(vDramCfgIfc[0].entryStatusDram(Id, 0, cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi()) == 0)
                          begin
                            `ifdef TB_VERBOSITY_HIGH
                              $display("@%0t :%s:%0d:INFO: Manager {%0d} : %0d, %h : New value loaded at %0d: %h %h %h %h = %h ", $time, `__FILE__, `__LINE__, Id, vDramCfgIfc[0].entryStatusDram(Id, 0, cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi()), vDramCfgIfc[0].readDram(Id, 0, cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi()), 0, cbpw[0].atoi(), cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi(), config_data);
                            `endif
                            vDramCfgIfc[0].loadDram(Id, 0, cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi(), config_data);
                          end
                        else
                          begin
                            `ifdef TB_VERBOSITY_HIGH
                              $display("@%0t :%s:%0d:INFO: Manager {%0d} : Pre-existing value found at %0d: %h %h %h = %h", $time, `__FILE__, `__LINE__, Id, 0, cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi(), vDramCfgIfc[0].readDram(Id, 0, cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi()));
                            `endif
                            if (i == 0)
                              begin
                                // Replicate ROI existing value across all lanes
                                for (int l=0; l<`PE_NUM_OF_EXEC_LANES; l++)
                                  begin
                                    sys_operation_data[l].updateOperandsFromBits(0, count, vDramCfgIfc[0].readDram(Id, 0, cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi()));
                                  end
                              end
                            else
                              begin
                                sys_operation_data[i-1].updateOperandsFromBits(1, count, vDramCfgIfc[0].readDram(Id, 0, cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi()));
                              end
                          end
                      end
                  end
                1:
                  begin
                    if (cbpw[0].atoi() == 1)
                      begin
                        if(vDramCfgIfc[1].entryStatusDram(Id, 1, cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi()) == 0)
                          begin
                            `ifdef TB_VERBOSITY_HIGH
                              $display("@%0t :%s:%0d:INFO: Manager {%0d} : %0d, %h : New value loaded at %0d: %h %h %h %h = %h ", $time, `__FILE__, `__LINE__, Id, vDramCfgIfc[1].entryStatusDram(Id, 1, cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi()), vDramCfgIfc[1].readDram(Id, 1, cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi()), 0, cbpw[0].atoi(), cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi(), config_data);
                            `endif
                            vDramCfgIfc[1].loadDram(Id, 1, cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi(), config_data);
                          end
                        else
                          begin
                            `ifdef TB_VERBOSITY_HIGH
                              $display("@%0t :%s:%0d:INFO: Manager {%0d} : Pre-existing value found at %0d: %h %h %h = %h ", $time, `__FILE__, `__LINE__, Id, 1, cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi(), vDramCfgIfc[1].readDram(Id, 1, cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi()));
                            `endif
                            if (i == 0)
                              begin
                                // Replicate ROI existing value across all lanes
                                for (int l=0; l<`PE_NUM_OF_EXEC_LANES; l++)
                                  begin
                                    sys_operation_data[l].updateOperandsFromBits(0, count, vDramCfgIfc[1].readDram(Id, 1, cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi()));
                                  end
                              end
                            else
                              begin
                                sys_operation_data[i-1].updateOperandsFromBits(1, count, vDramCfgIfc[1].readDram(Id, 1, cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi()));
                              end
                          end
                      end
                  end
              endcase
              

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

      for (int i=0; i<`PE_NUM_OF_EXEC_LANES; i++)
        begin
          // recalculate in case memory had pre-existing values
          sys_operation_data[i].calculateResult();
        end


    endtask

    task readDramResultFromAllGroupFile ( input         string                        allGroupFileName                           ,
                                          input         operation::base_operation     sys_operation                              ,
                                          input         vDiRamCfg_T                   vDramCfgIfc        [`MGR_DRAM_NUM_CHANNELS]        
                                        );

      int        fileDesc      ;
      string     fileLine      ;
      byte       char          ;
      int        idxs     [64] ;  // delineate up to 32 operands for each stream
      int        idx           ;
      string     address [64]  ;  // extract the chan/bank/page/word for each lane
      string     tmp_str       ;
    
      logic [`MGR_DRAM_BANK_ADDRESS_RANGE       ]  config_bank_addr ;
      logic [`MGR_DRAM_PAGE_ADDRESS_RANGE       ]  config_row_addr  ;
      logic [`MGR_DRAM_WORD_ADDRESS_RANGE       ]  config_word_addr ;
      logic                                        config_load      ;
      logic [31:0]                                 config_data      ;

      int lineNum ;
      bit found   ;
      bit compare_complete ;
      string     cbpw [7]      ;
      bit laneInWuFile   ;  // the generator sends a operation for each lane but only the lanes in the WU file are executed
                              // so if the lane ID is greater than the available lanes, cancel the check

      int manager_X ;
      int manager_Y ;


      for (int i=0; i<`MGR_DRAM_NUM_CHANNELS; i++)
        begin
          vDramCfgIfc[i].config_bank_addr  =  'd0 ;
          vDramCfgIfc[i].config_row_addr   =  'd0 ;
          vDramCfgIfc[i].config_word_addr  =  'd0 ;
          vDramCfgIfc[i].config_load       =  'd0 ;
        end

      // File format (without the //)
      // Need to account for destination address row
      //
      //                                              |    Target Cell {z,y,x}  16,  6, 20      |    Target Cell {z,y,x}  17,  6, 20      |    Target Cell {z,y,x}  18,  6, 20      |    Target Cell {z,y,x}  19,  6, 20      |    Target Cell {z,y,x}  20,  6, 20      |    Target Cell {z,y,x}  21,  6, 20      |    Target Cell {z,y,x}  22,  6, 20      |    Target Cell {z,y,x}  23,  6, 20      |    Target Cell {z,y,x}  24,  6, 20      |    Target Cell {z,y,x}  25,  6, 20      |    Target Cell {z,y,x}  26,  6, 20      |    Target Cell {z,y,x}  27,  6, 20      |    Target Cell {z,y,x}  28,  6, 20      |    Target Cell {z,y,x}  29,  6, 20      |    Target Cell {z,y,x}  30,  6, 20      |    Target Cell {z,y,x}  31,  6, 20      |    Target Cell {z,y,x}  32,  6, 20      |    Target Cell {z,y,x}  33,  6, 20      |    Target Cell {z,y,x}  34,  6, 20      |    Target Cell {z,y,x}  35,  6, 20      |    Target Cell {z,y,x}  36,  6, 20      |    Target Cell {z,y,x}  37,  6, 20      |    Target Cell {z,y,x}  38,  6, 20      |    Target Cell {z,y,x}  39,  6, 20      |    Target Cell {z,y,x}  40,  6, 20      |    Target Cell {z,y,x}  41,  6, 20      |    Target Cell {z,y,x}  42,  6, 20      |    Target Cell {z,y,x}  43,  6, 20      |    Target Cell {z,y,x}  44,  6, 20      |    Target Cell {z,y,x}  45,  6, 20      |    Target Cell {z,y,x}  46,  6, 20      |    Target Cell {z,y,x}  47,  6, 20      |
      //                                              |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |
      //                                              |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |           Destination(s)                |
      //                                              |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |  Manager  Channel  Bank  Page  Word     |
      //                                              |   0,  0 :    1       28    4    100     |   0,  0 :    0       28    4    101     |   0,  0 :    1       28    4    101     |   0,  0 :    0       28    4    102     |   0,  0 :    1       28    4    102     |   0,  0 :    0       28    4    103     |   0,  0 :    1       28    4    103     |   0,  0 :    0       28    4    104     |   0,  0 :    1       28    4    104     |   0,  0 :    0       28    4    105     |   0,  0 :    1       28    4    105     |   0,  0 :    0       28    4    106     |   0,  0 :    1       28    4    106     |   0,  0 :    0       28    4    107     |   0,  0 :    1       28    4    107     |   0,  0 :    0       28    4    108     |   0,  0 :    1       28    4    108     |   0,  0 :    0       28    4    109     |   0,  0 :    1       28    4    109     |   0,  0 :    0       28    4    110     |   0,  0 :    1       28    4    110     |   0,  0 :    0       28    4    111     |   0,  0 :    1       28    4    111     |   0,  0 :    0       28    4    112     |   0,  0 :    1       28    4    112     |   0,  0 :    0       28    4    113     |   0,  0 :    1       28    4    113     |   0,  0 :    0       28    4    114     |   0,  0 :    1       28    4    114     |   0,  0 :    0       28    4    115     |   0,  0 :    1       28    4    115     |   0,  0 :    0       28    4    116     |
      //                                              |   0,  1 :    1       8     2    127     |   0,  1 :    0       10    2     0      |   0,  1 :    1       10    2     0      |   0,  1 :    0       10    2     1      |   0,  1 :    1       10    2     1      |   0,  1 :    0       10    2     2      |   0,  1 :    1       10    2     2      |   0,  1 :    0       10    2     3      |   0,  1 :    1       10    2     3      |   0,  1 :    0       10    2     4      |   0,  1 :    1       10    2     4      |   0,  1 :    0       10    2     5      |   0,  1 :    1       10    2     5      |   0,  1 :    0       10    2     6      |   0,  1 :    1       10    2     6      |   0,  1 :    0       10    2     7      |   0,  1 :    1       10    2     7      |   0,  1 :    0       10    2     8      |   0,  1 :    1       10    2     8      |   0,  1 :    0       10    2     9      |   0,  1 :    1       10    2     9      |   0,  1 :    0       10    2     10     |   0,  1 :    1       10    2     10     |   0,  1 :    0       10    2     11     |   0,  1 :    1       10    2     11     |   0,  1 :    0       10    2     12     |   0,  1 :    1       10    2     12     |   0,  1 :    0       10    2     13     |   0,  1 :    1       10    2     13     |   0,  1 :    0       10    2     14     |   0,  1 :    1       10    2     14     |   0,  1 :    0       10    2     15     |
      //                                              |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |                                         |
      // source cell   |     ROI Local memory         |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |                 Kernel Memory           |
      // Z   Y   X     | Channel  Bank  Page  Word    |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |           Channel  Bank  Page  Word     |
      //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      // 0  12  40     |    0       0     0     0     |              0       12    5     0      |              0       12    5     1      |              0       12    5     2      |              0       12    5     3      |              0       12    5     4      |              0       12    5     5      |              0       12    5     6      |              0       12    5     7      |              0       12    5     8      |              0       12    5     9      |              0       12    5     10     |              0       12    5     11     |              0       12    5     12     |              0       12    5     13     |              0       12    5     14     |              0       12    5     15     |              0       12    5     16     |              0       12    5     17     |              0       12    5     18     |              0       12    5     19     |              0       12    5     20     |              0       12    5     21     |              0       12    5     22     |              0       12    5     23     |              0       12    5     24     |              0       12    5     25     |              0       12    5     26     |              0       12    5     27     |              0       12    5     28     |              0       12    5     29     |              0       12    5     30     |              0       12    5     31     | 
      // 1  12  40     |    1       0     0     0     |              0       12    5     32     |              0       12    5     33     |              0       12    5     34     |              0       12    5     35     |              0       12    5     36     |              0       12    5     37     |              0       12    5     38     |              0       12    5     39     |              0       12    5     40     |              0       12    5     41     |              0       12    5     42     |              0       12    5     43     |              0       12    5     44     |              0       12    5     45     |              0       12    5     46     |              0       12    5     47     |              0       12    5     48     |              0       12    5     49     |              0       12    5     50     |              0       12    5     51     |              0       12    5     52     |              0       12    5     53     |              0       12    5     54     |              0       12    5     55     |              0       12    5     56     |              0       12    5     57     |              0       12    5     58     |              0       12    5     59     |              0       12    5     60     |              0       12    5     61     |              0       12    5     62     |              0       12    5     63     | 
      // 2  12  40     |    0       0     0     1     |              0       12    5     64     |              0       12    5     65     |              0       12    5     66     |              0       12    5     67     |              0       12    5     68     |              0       12    5     69     |              0       12    5     70     |              0       12    5     71     |              0       12    5     72     |              0       12    5     73     |              0       12    5     74     |              0       12    5     75     |              0       12    5     76     |              0       12    5     77     |              0       12    5     78     |              0       12    5     79     |              0       12    5     80     |              0       12    5     81     |              0       12    5     82     |              0       12    5     83     |              0       12    5     84     |              0       12    5     85     |              0       12    5     86     |              0       12    5     87     |              0       12    5     88     |              0       12    5     89     |              0       12    5     90     |              0       12    5     91     |              0       12    5     92     |              0       12    5     93     |              0       12    5     94     |              0       12    5     95     | 


      $display("@%0t :%s:%0d:INFO: reading result from DRAM using AllGroup file %s for manager {%0d(%0d)}, lane %0d ", $time, `__FILE__, `__LINE__, allGroupFileName, Id, sys_operation.Id[0], sys_operation.Id[1]);

      fileDesc = $fopen (allGroupFileName, "r");
      if (fileDesc == 0) 
        begin
          $display("@%0t :%s:%0d:ERROR: file open error opening : %s", $time, `__FILE__, `__LINE__, allGroupFileName);
          $finish;
      end

      
      found   = 0;
      lineNum = 0;
      compare_complete = 0;

      while (!$feof(fileDesc) && !compare_complete) 
        begin
   
          // first find the manager line "//     | Manager ....."
          while (found == 0)
            begin

              void'($fgets (fileLine, fileDesc)); 
              //$display("@%0t :%s:%0d:INFO: Manager {%0d} : line# %0d, fileLine: %s", $time, `__FILE__, `__LINE__, Id, lineNum, fileLine);
              
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

              // Find the line with "Destination"
              tmp_str = fileLine.substr(idxs[1]+1, idxs[1+1]-1);
              void'($sscanf(tmp_str, "%s ", tmp_str));  // remove spaces
              //$display("@%0t :%s:%0d:INFO: %s ", $time, `__FILE__, `__LINE__, tmp_str);
              if (tmp_str.substr(0,10) == "Destination")
                begin
                  found = 1;
                  //$display("@%0t :%s:%0d:INFO: %s ", $time, `__FILE__, `__LINE__, tmp_str);
                  // remove the next line
                  void'($fgets (fileLine, fileDesc)); 

                end
              lineNum ++;
            end

          // check manager ID
          found = 0;
          while (found == 0)
            begin
              // get the line with destination addresses
              void'($fgets (fileLine, fileDesc)); 
              //$display("@%0t :%s:%0d:INFO: Manager {%0d} : line# %0d, fileLine: %s", $time, `__FILE__, `__LINE__, Id, lineNum, fileLine);
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

              // idx should equal the number of lanes +1
              if ((idx-1) <= sys_operation.Id[1])
                begin
                  laneInWuFile = 0;
                  found = 1;
                end
              else
                begin
                  laneInWuFile = 1;
                end

              /*
              for (int i=0; i<idx; i++)
                begin
                  $display("@%0t :%s:%0d:INFO:INDEXES %0d %0d ", $time, `__FILE__, `__LINE__, i, idxs[i]);
                end
              */

              tmp_str = fileLine.substr(idxs[sys_operation.Id[1]]+1, idxs[sys_operation.Id[1]+1]-1);
              /*
              $display("@%0t :%s:%0d:INFO: Manager {%0d} : idx=%0d, id[1]=%0d, tmp_str=%s", $time, `__FILE__, `__LINE__, Id, 
                                                                                           idx, sys_operation.Id[1], tmp_str);
              */
              void'($sscanf(tmp_str, "%s %s %s %s %s %s %s ",cbpw[5], cbpw[6], cbpw[7], cbpw[0], cbpw[1], cbpw[2], cbpw[3]));
              /*
              $display("@%0t :%s:%0d:INFO: Manager {%0d} : %s %s %s %s %s %s %s", $time, `__FILE__, `__LINE__, Id, 
                                                                                           cbpw[5].substr(0,cbpw[5].len()-2),
                                                                                           cbpw[6],
                                                                                           cbpw[7],
                                                                                           cbpw[0],
                                                                                           cbpw[1],
                                                                                           cbpw[2],
                                                                                           cbpw[3]);
              */
              if ((Id/MGR_ARRAY_XY == cbpw[5].substr(0,cbpw[5].len()-2).atoi()) && (Id%MGR_ARRAY_XY == cbpw[6].atoi())) 
                begin
                  found = 1;
                end

              lineNum ++;
            end

          if (laneInWuFile == 1)
            begin
              case (cbpw[0].atoi())
                0:
                  begin
                    config_data = vDramCfgIfc[0].readDram(Id, 0, cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi());
                  end
                1:
                  begin
                    config_data = vDramCfgIfc[1].readDram(Id, 1, cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi());
                  end
              endcase
            
              $display("@%0t :%s:%0d:INFO: Manager {%0d} : Main memory check result %f (%h) is stored at : %h %h %h %h = %h ", $time, `__FILE__, `__LINE__, Id, sys_operation.result, $shortrealtobits(sys_operation.result), cbpw[0].atoi(), cbpw[1].atoi(), cbpw[2].atoi(), cbpw[3].atoi(), config_data);
            
              if (($bitstoshortreal(config_data) < sys_operation.resultLow) || ($bitstoshortreal(config_data) > sys_operation.resultHigh))
                begin
                    $display ("@%0t:%s:%0d:ERROR:MAIN_MEMORY_CHECK :: incorrect result data in main memory for {%0d,%0d}, WU %0d : expected %f (%h), observed %f (%h)", $time, `__FILE__, `__LINE__, 
                                                           this.Id, sys_operation.Id[1], sys_operation.seqId, sys_operation.result, $shortrealtobits(sys_operation.result), $bitstoshortreal(config_data), config_data);
                end
              else 
                begin
                  $display ("@%0t::%s:%0d::PASS:MAIN_MEMORY_CHECK :: Correct result in main memory for {%0d,%0d}, WU %0d  : Hex : expected=%h, stored=%h, FP : %f", $time, `__FILE__, `__LINE__, 
                                                           this.Id, sys_operation.Id[1], sys_operation.seqId, $shortrealtobits(sys_operation.result), config_data, $bitstoshortreal(config_data));
                end

            end

          compare_complete = 1;

        end

      $fclose(fileDesc);


    endtask

//    task run();
//
//    endtask


  endclass


endpackage

