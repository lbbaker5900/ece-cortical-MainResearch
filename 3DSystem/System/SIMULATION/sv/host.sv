/*********************************************************************************************
    File name   : host.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Nov 2018
    Email       : lbbaker@ncsu.edu
    
    Description : 
                   
                   
*********************************************************************************************/

`include "common.vh"
`include "stack_interface.vh"
`include "simd_upstream_intf.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"
`include "pe.vh"
`include "pe_array.vh"
`include "noc_interpe_port_Bitmasks.vh"

`include "mgr_noc_cntl.vh"
`include "manager.vh"
`include "manager_array.vh"

import virtual_interface::*;
import operation::*;

class host_driver_checker;
    
    vExtToNoC_T     vExtToNoC          [`MGR_ARRAY_NUM_OF_MGR]      ;
    vExtFromNoC_T   vExtFromNoC        [`MGR_ARRAY_NUM_OF_MGR]      ;

    //----------------------------------------------------------------------------------------------------
    // Misc

    int        i             ;
    string     fileName      ;
    int        fileDesc      ;
    string     fileLine      ;
    byte       char          ;
    bit        found         ;

    bit [`MGR_INSTRUCTION_ADDRESS_RANGE              ]    memory_address    ;
    bit [`MGR_INSTRUCTION_MEMORY_AGGREGATE_MEM_RANGE ]    memory_data       ;
    bit [`MGR_NOC_EXTERNAL_DATA_RANGE                ]    noc_cyc_data      ;

    bit [`COMMON_STD_INTF_CNTL_RANGE                 ]    noc_cntl          ; 
    bit [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE         ]    noc_type          ; 
    bit [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE        ]    noc_ptype         ; 
    bit [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE           ]    noc_desttype      ; 
    bit                                                   noc_pvalid        ; 
    bit [`MGR_MGR_ID_BITMASK_RANGE                   ]    noc_bitMask       ;
    bit [`MGR_ARRAY_HOST_ID_RANGE                    ]    noc_src           ; 

    bit [`MGR_NOC_CONT_EXTERNAL_DATA_RANGE           ]    noc_data          ; 

    //----------------------------------------------------------------------------------------------------
    //
    function new (
                  input vExtToNoC_T           vExtToNoC      [`MGR_ARRAY_NUM_OF_MGR] ,
                  input vExtFromNoC_T         vExtFromNoC    [`MGR_ARRAY_NUM_OF_MGR] 
                    );

      this.vExtToNoC      = vExtToNoC      ;
      this.vExtFromNoC    = vExtFromNoC    ;

      i = `MGR_WU_MEMORY_INIT_ID  ;

    endfunction


    task init (); 

      vExtFromNoC[0].noc__mgr__port_valid = 0;
      vExtFromNoC[0].noc__mgr__port_cntl  = 0;
      vExtFromNoC[0].noc__mgr__port_data  = 0;

      vExtToNoC[0].noc__mgr__port_fc      = 0;

    endtask

    task run (); 

      bit  [`MGR_WU_OPT_TYPE_RANGE                      ]   payload_tuple_type       [`MGR_ARRAY_NUM_OF_MGR]    ;
      bit  [`MGR_WU_EXTD_OPT_VALUE_RANGE                ]   payload_tuple_extd_value [`MGR_ARRAY_NUM_OF_MGR]    ;
      bit [`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD_RANGE ]   payload_data             [`MGR_ARRAY_NUM_OF_MGR]    ;
      bit matched ;  // found matching sent packet

      int lineNum ;
      int count   ;
      int pkt_count   ;
      int sent_instructions   ;
      string entry  ;

      found = 0;
      lineNum = 0;
      count   = 0;
      pkt_count   = 0;
      sent_instructions = 0  ;
      noc_bitMask  = {63'd0, 1'b1}    ;

      fileName  =  $sformatf("foo.dat");
      fileName  =  $sformatf("foo2.dat");

      while(vExtFromNoC[0].reset_poweron)
        begin
          @(vExtFromNoC[0].cb_p);
        end
      repeat (20) @(vExtFromNoC[0].cb_p);

      for (int mgr=0; mgr<1; mgr=mgr+1)
      //for (int mgr=0; mgr<`MGR_ARRAY_NUM_OF_MGR; mgr=mgr+1)
        begin
          fileName  =  $sformatf("./inputFiles/manager_%0d_layer1_instruction_readmem.dat", mgr);
          fileDesc  =  $fopen (fileName, "r");
          if (fileDesc == 0) 
            begin
              $display("@%0t :%s:%0d:ERROR: file open error opening : %s", $time, `__FILE__, `__LINE__, fileName);
              $finish;
          end
          noc_bitMask  = 64'd0;
          noc_bitMask[mgr]  = 1'b1 ;
          while (!$feof(fileDesc)) 
            begin
              noc_cntl       = 2'b10 ; 
              noc_type       = `MGR_NOC_CONT_TYPE_INSTRUCTION      ; 
              noc_ptype      = `MGR_NOC_CONT_PAYLOAD_TYPE_NOP             ; 
              noc_desttype   = `MGR_NOC_CONT_DESTINATION_ADDR_TYPE_BITMASK ; 
              noc_pvalid     = 1'b1 ; 
          
              // Create header
              noc_data [`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE       ] = noc_bitMask  ; 
              noc_data [`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE               ] = 'd`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP  ; 
              noc_data [`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE  ] = 'd`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_MCAST_BITFIELD ; 
              // Remember to account for 2x2 or 8x8
              noc_data [`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE              ] = 'd`MGR_ARRAY_HOST_ID ;
              while(vExtFromNoC[0].mgr__noc__port_fc)
                begin
                  @(vExtFromNoC[0].cb_p);
                end
              @(vExtFromNoC[0].cb_p);
              vExtFromNoC[0].noc__mgr__port_valid = 1;
              vExtFromNoC[0].noc__mgr__port_cntl  = 2'b01;
              vExtFromNoC[0].noc__mgr__port_data  = noc_data ;
          
              // Data cycles
              for (int cyc=0; cyc<8; cyc++)
                begin
                  @(vExtFromNoC[0].cb_p);
                  void'($fgets(entry, fileDesc)); 
                  void'($sscanf(entry, "@%x %x", memory_address, memory_data));
                  vExtFromNoC[0].noc__mgr__port_valid = 1;
                  if ((count+1) == `MGR_WU_MEMORY_INIT_ENTRIES)
                    begin
                      sent_instructions = 1;
                      vExtFromNoC[0].noc__mgr__port_cntl  = 2'b10;
                    end
                  else if (cyc == 7)
                    begin
                      vExtFromNoC[0].noc__mgr__port_cntl  = 2'b10;
                    end
                  else
                    begin
                      vExtFromNoC[0].noc__mgr__port_cntl  = 2'b00;
                    end
                  noc_data [`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAYLOAD_VALID_RANGE  ] = 'd`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAYLOAD_VALID_BOTH  ;
                  noc_data [`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAYLOAD_TYPE_RANGE   ] = 'd`MGR_NOC_CONT_PAYLOAD_TYPE_DATA             ; 
                  if (pkt_count == 0)
                    begin
                      noc_data [`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PACKET_TYPE_RANGE    ] = 'd`MGR_NOC_CONT_TYPE_INSTRUCTION_SOD ; 
                    end
                  else if (count < `MGR_WU_MEMORY_INIT_ENTRIES-8)
                    begin
                      noc_data [`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PACKET_TYPE_RANGE    ] = 'd`MGR_NOC_CONT_TYPE_INSTRUCTION; 
                    end
                  else 
                    begin
                      noc_data [`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PACKET_TYPE_RANGE    ] = 'd`MGR_NOC_CONT_TYPE_INSTRUCTION_EOD ; 
                    end

                  noc_data [`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORDS_RANGE           ] = memory_data ; 
                  vExtFromNoC[0].noc__mgr__port_data  = noc_data ;
                  //void'($fgets(entry, fileDesc)); 
                  //void'($sscanf(entry, "@%x %x", memory_address, memory_data));
                  count++;
                  if ((count) == `MGR_WU_MEMORY_INIT_ENTRIES)
                    begin
                      break;
                    end
                end
              pkt_count++;
              if (sent_instructions == 1)
                begin
                  @(vExtFromNoC[0].cb_p);
                  vExtFromNoC[0].noc__mgr__port_valid = 0;
                  break;
                end
              /*
              @(vExtFromNoC[0].cb_p);
              vExtFromNoC[0].noc__mgr__port_valid = 1;
              vExtFromNoC[0].noc__mgr__port_cntl  = 2'b10;
              noc_data [`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORDS_RANGE           ] = memory_data ; 
              vExtFromNoC[0].noc__mgr__port_data  = noc_data ;
              */
              @(vExtFromNoC[0].cb_p);
              vExtFromNoC[0].noc__mgr__port_valid = 0;
              //void'($fgets(entry, fileDesc)); 
              //void'($sscanf(entry, "@%x %x", memory_address, memory_data));
              
          
              //void'($fgets(entry, fileDesc)); 
              //void'($sscanf(entry, "@%x %x", memory_address, memory_data));
              //$display("ERROR:LEE:readmem file contents : %s  : Addr:%h, Data:%h", memFile, memory_address, memory_data);
              //
              //mem[memory_address] = memory_data ;
            end
          $fclose(fileDesc);
        end
   

    endtask


endclass
