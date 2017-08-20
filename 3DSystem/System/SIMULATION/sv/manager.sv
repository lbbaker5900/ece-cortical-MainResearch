/*********************************************************************************************
    File name   : manager.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Jan 2017
    Email       : lbbaker@ncsu.edu
    
    Description : This file contains the work-unit manager.
                  Take a work unit, configures the PE and initiates memory accesses to provide operands and return results back to memory.
                  There is a manager for each PE.
                  
                  
*********************************************************************************************/

`define VERBOSE0
`define VERBOSE1
`define VERBOSE2
`define VERBOSE3
`define VERBOSE4
`define VERBOSE5

`include "common.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"
`include "pe.vh"
`include "pe_array.vh"
`include "noc_interpe_port_Bitmasks.vh"

`include "python_typedef.vh"
`include "manager_array.vh"
`include "manager_array.vh"

`include "dram_utilities.sv"

import virtual_interface::*;
import operation::*;
import dram_utils::*;

class manager;

    //----------------------------------------------------------------------------------------------------
    //  Manager sends base operation to OOB driver

    mailbox mgr2oob                                   ;
    event   mgr2oob_ack                               ;

    //----------------------------------------------------------------------------------------------------
    //  Manager sends base operation to generator

    mailbox mgr2gen          [`PE_NUM_OF_EXEC_LANES]  ;  // manager communicates will lane generators 
    event   mgr2gen_ack      [`PE_NUM_OF_EXEC_LANES]  ;  // manager communicates will lane generators 


    //----------------------------------------------------------------------------------------------------
    //  Manager sends base operation to Upstream checker

    mailbox mgr2up                                   ;

    //----------------------------------------------------------------------------------------------------

    event   new_operation                             ;
    event   final_operation                           ;
    int     Id                                        ; // PE

    // Drive regFile interface
    // FIXME : should this be in the driver??
    // FIXME: may go away once SIMD and result path is working
    mailbox   mgr2rfP         ;
    event     mgr2rfP_ack     ;
        

    //----------------------------------------------------------------------------------------------------
    //  Misc

    vDiRamCfg_T                 vDramCfgIfc  [`MGR_DRAM_NUM_CHANNELS]  ;
    dram_utils::dram_utilities  dram_utils   ;

    string     fileName          ;
    descriptor  descriptorObjs [$][4]  ;
    typedef descriptor  descObjs [$][4]  ;  // dont seem to be allowed to explicitly declare an array of objects as an output of a task

    //-------------------------------------------------------------------------
    // HOW MANY?
    integer num_operations = 6;  // fp mac:{std,std}->mem, copy:std->mem, fp mac:{std,mem}->mem

   
    // Use multiple of 3 if we want to see std_std_fpmac_mem, std_na_nop_mem, std_mem_fpmac_mem
    // FIXME: if we use a staring opNum that is remainder, the system hangs. This is likely because the first transaction will be a mem_std_fpmac_mem
    // and it assumes a prior operation has loaded memory, but I still dont like it hanging.
    integer operationNum   = 43*3;  // used to set operation ID
                                   // This will be the tag, so start higher to make the tag distinguishable

    integer WU_num   = 0;  // used to identify files

    //variable to define the timeout in 'wrapup()' task in environment.sv
    integer transaction_timeout = 3000;
    integer timeout_option = 2; 

    //-------------------------------------------------------------------------
    // Downstream Interfaces

    vDownstreamStackBusOOB_T    vDownstreamStackBusOOB                            ;  // FIXME OOB interface is a per PE i/f where generator is per lane
    vDownstreamStackBusLane_T   vDownstreamStackBusLane  [`PE_NUM_OF_EXEC_LANES] [`PE_NUM_OF_STREAMS]  ;  // manager communicates will lane generators

    //----------------------------------------------------------------------------------------------------
    // Observed WU Decoder to OOB Command
    mailbox           wud2mgr_m           ;

    //----------------------------------------------------------------------------------------------------
    // WU Decoder to Memory Read Interfaces
    //vWudToMrc_T       vWudToMrcIfc        [`MGR_NUM_OF_STREAMS] ; 
    vDesc_T           vWudToMrcIfc        [`MGR_NUM_OF_STREAMS] ; 
    mailbox           mrc2mgr_m           [`MGR_NUM_OF_STREAMS] ; 
    descriptor        mrc_desc            [`MGR_NUM_OF_STREAMS] ; 

    base_operation    sys_operation                              ;  // operation packet containing all data associated with operation
    base_operation    sys_operation_mgr                          ;  // operation packet containing all data associated with operation
    base_operation    sys_operation_oob                          ;  // need to make sure OOB oepration matches lane
    base_operation    sys_operation_lane     [`PE_NUM_OF_EXEC_LANES] ;  // copy for each lane
    base_operation    sys_operation_lane_gen [`PE_NUM_OF_EXEC_LANES] ;  // sent to each lane

    oob_packet       oob_packet_mgr     ;  // constructed from the sys_operation and sent to the OOB driver
    oob_packet       oob_packet_new     ;  // used in OOB process

    // Keep track of previous command
    base_operation    priorOperations[$]; //Queue to hold previous operations

    function new (
                  input int                          Id                                                                     , 
                  input mailbox                      mgr2oob                                                                ,
                  input event                        mgr2oob_ack                                                            ,
                  input mailbox                      mgr2gen                 [`PE_NUM_OF_EXEC_LANES]                        ,
                  input event                        mgr2gen_ack             [`PE_NUM_OF_EXEC_LANES]                        ,
                  input event                        final_operation                                                        ,
                  input vDownstreamStackBusOOB_T     vDownstreamStackBusOOB                                                 ,
                  input vDownstreamStackBusLane_T    vDownstreamStackBusLane [`PE_NUM_OF_EXEC_LANES] [`PE_NUM_OF_STREAMS]   ,
                  input mailbox                      mgr2up                                                                 , // send operation to upstream checker
                  input vDesc_T                      vWudToMrcIfc                                    [`MGR_NUM_OF_STREAMS ] ,
                  input mailbox                      mrc2mgr_m                                       [`MGR_NUM_OF_STREAMS ] ,
                  input mailbox                      wud2mgr_m                                                              ,
                  input vDiRamCfg_T                  vDramCfgIfc             [`MGR_DRAM_NUM_CHANNELS]                                               
                 );

        this.Id                        = Id                      ;
        this.mgr2oob                   = mgr2oob                 ;
        this.mgr2oob_ack               = mgr2oob_ack             ;
        this.mgr2gen                   = mgr2gen                 ;
        this.mgr2gen_ack               = mgr2gen_ack             ;
        //this.new_operation           = new_operation           ;
        this.final_operation           = final_operation         ;
        this.vDownstreamStackBusOOB    = vDownstreamStackBusOOB  ;
        this.vDownstreamStackBusLane   = vDownstreamStackBusLane ;
        this.mgr2up                    = mgr2up                  ;
        this.vWudToMrcIfc              = vWudToMrcIfc            ;
        this.mrc2mgr_m                 = mrc2mgr_m               ;
        this.wud2mgr_m                 = wud2mgr_m               ;
        this.dram_utils                = new (Id )               ;
        this.vDramCfgIfc               = vDramCfgIfc             ;

    endfunction

    localparam MGR_ARRAY_XY = $sqrt(`MGR_ARRAY_NUM_OF_MGR) ;

    task run ();
        //$display("@%0t:%s:%0d:INFO: Running manager : {%0d}", $time, `__FILE__, `__LINE__, Id);
        // wait a few cycles before starting

        //----------------------------------------------------------------------------------------------------
        // WU Decoder to Downstream OOB Controller
        // - inform manager of OOB command
        wud_to_oob_cmd                               rcvd_wud_to_oob_cmd ; 
        bit   [`MGR_STD_OOB_TAG_RANGE         ]      rcvd_tag            ;
        bit   [`MGR_NUM_LANES_RANGE           ]      rcvd_num_lanes      ;
        bit   [`MGR_WU_OPT_VALUE_RANGE        ]      rcvd_stOp_cmd       ;
        bit   [`MGR_WU_OPT_VALUE_RANGE        ]      rcvd_simd_cmd       ;
        //genvar lane; 

        repeat (20) @(vDownstreamStackBusOOB.cb_test);  

        //----------------------------------------------------------------------------------------------------
        // Extract Work Unit information
        // - operation
        // - operand read descriptors
        // - operand write descriptor
        //
        //

        fileName  =    $sformatf("./configFiles/manager_%0d_%0d_layer1_WUs.txt", Id/MGR_ARRAY_XY, Id%MGR_ARRAY_XY );

        this.loadWuFile ( descriptorObjs , fileName ) ;
        //descriptorObjs[0][0].displayDesc();
        //descriptorObjs[0][1].displayDesc();
        //descriptorObjs[0][2].displayDesc();
        //descriptorObjs[0][3].displayDesc();
        $display("@%0t:%s:%0d:INFO:Manager {%0d} Extracted %0d instructions from WU file", $time, `__FILE__, `__LINE__, Id, $size(descriptorObjs));

        $display("@%0t:%s:%0d:INFO:Manager {%0d} Running %0d operations", $time, `__FILE__, `__LINE__, Id, num_operations);
        repeat (num_operations)                 //Number of transactions to be generated
            begin

                //----------------------------------------------------------------------------------------------------
                // Create the operation and send to OOB driver and lane driver

                // A WU Decoder command to OOB Downstream controller initiates the operation
                `ifdef TB_ENABLE_WUD_INITIATE_OP
                    wait ( wud2mgr_m.num() != 0 ) 
                    wud2mgr_m.get(rcvd_wud_to_oob_cmd);
                    $display("@%0t:%s:%0d:INFO: Manager {%0d} received WUD Downstream OOB Command from WUD\'s", $time, `__FILE__, `__LINE__, Id);
                    rcvd_wud_to_oob_cmd.display();
               `endif

                // A request to both Memory Read controllers will initiate an operation
                `ifdef TB_ENABLE_MEM_CNTL_INITIATE_OP
                    wait (( mrc2mgr_m[0].num() != 0 ) && ( mrc2mgr_m[1].num() != 0 ));
                    mrc2mgr_m[0].get(mrc_desc[0]);
                    mrc2mgr_m[1].get(mrc_desc[1]);
                    $display("@%0t:%s:%0d:INFO: Manager {%0d} received Memory Descriptor from MRC\'s", $time, `__FILE__, `__LINE__, Id);
                `endif

                // Create a base operation and send the generator which will then spawn further operations for each lane.
                // The generator will maintain operation type and number of operands for all lanes but will randomize operands.
                sys_operation_mgr        =  new ()  ;  // seed operation object.  Generators will copy this and then re-create different operand values
                sys_operation_mgr.Id[0]  =  Id      ;  // Id in manager is only PE
                sys_operation_mgr.Id[1]  =  0       ;  // set to lane 0 to avoid error in randomize

                // FIXME: currently the operation class decides what type of operation based on transaction ID
                sys_operation_mgr.c_operationType_definedOrder .constraint_mode(0) ;
                sys_operation_mgr.c_operationType_all          .constraint_mode(0) ;
                sys_operation_mgr.c_operationType_fpMac        .constraint_mode(1) ;
                sys_operation_mgr.c_operationType_copyStdToMem .constraint_mode(0) ;
                //
                sys_operation_mgr.c_streamSize.constraint_mode(1)                 ;
                sys_operation_mgr.c_operandValues.constraint_mode(1)              ;
                sys_operation_mgr.c_memoryLocalized.constraint_mode(1)            ;
                sys_operation_mgr.tId      = operationNum             ;
                //
                // create new operation
                assert(sys_operation_mgr.randomize()) ;

                //----------------------------------------------------------------------------------------------------
                // Create an oob_packet and send to OOB driver
                //
                // FIXME: Not sure why I created an operation object for oob
                // I think we can just :
                //   oob_packet_mgr.createFromOperation(sys_operation_mgr.tId, sys_operation_mgr)     ;

                // we need to randomize to update fields such as number of operands based on prior operation. 
                // This randomize takes place in the generator when it sends operations to the driver so we should be the same although the OOB
                // only cares about a subset of the fields e.g. doesnt need operands.
                sys_operation_oob = new sys_operation_mgr ;                                                                                 
                //
                sys_operation_oob.setPriorOperations(priorOperations)   ;  // object may need to know what went before
                sys_operation_oob.c_operationType_definedOrder .constraint_mode(0) ;
                sys_operation_oob.c_operationType_all          .constraint_mode(0) ;
                sys_operation_oob.c_operationType_fpMac        .constraint_mode(1) ;
                sys_operation_oob.c_operationType_copyStdToMem .constraint_mode(0) ;
                //
                sys_operation_oob.c_streamSize.constraint_mode(1)                 ;
                sys_operation_oob.c_operandValues.constraint_mode(1)              ;
                sys_operation_oob.c_memoryLocalized.constraint_mode(1)            ;
                //
                assert(sys_operation_oob.randomize()) ;  // A previous randomize in the manager will have set the number of operands and addresses, so everything will be randomized except numberOfOperands and address

                // Keep copy of previous operations as they may influence future operations
                // Note: this is also kept in the sys_operation_mgr as we dont create a new for each transaction
                priorOperations.push_back(sys_operation_mgr)       ;


                // Create duplicates of the operation and randomize the operands
                // operands
                for (int lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane=lane+1)
                  begin
                    // Making sure we create new operand arrays using a deep copy method doesnt seem to be neccessary, but do it anyway (flaky SV)    
                    //sys_operation_lane[0] = new sys_operation_mgr ;                                                                               
                    // base_operation deep copy also reseeds RNG                                                                                      
                    sys_operation_lane[lane] = sys_operation_mgr.copy() ; // deep copy creates new operand arrays                                      
                    // The copy copies RNG so need to reseed otherwise we will create the same contents for each lane                                 
                    // sys_operation_lane[0].srandom($urandom)       ; // done by deep copy routine                                                 
                    sys_operation_lane[lane].Id[1]  =  lane      ;  // set lane for address generation                                                  
                                                                                                                                                      
                    sys_operation_lane_gen[lane]             =  new sys_operation_lane[lane]  ;  // seed object. Dont use directly as all lanes will use the same operation
                    //sys_operation_lane_gen.setPriorOperations(priorOperations)   ;  // object may need to know what went before
                   
                    sys_operation_lane_gen[lane].c_operationType_definedOrder .constraint_mode(0) ;
                    sys_operation_lane_gen[lane].c_operationType_all          .constraint_mode(0) ;
                    sys_operation_lane_gen[lane].c_operationType_fpMac        .constraint_mode(1) ;
                    sys_operation_lane_gen[lane].c_operationType_copyStdToMem .constraint_mode(0) ;
                    //
                    sys_operation_lane_gen[lane].c_streamSize.constraint_mode(1)                 ;
                    sys_operation_lane_gen[lane].c_operandValues.constraint_mode(1)              ;
                    sys_operation_lane_gen[lane].c_memoryLocalized.constraint_mode(1)            ;
                    //
                    assert(sys_operation_lane_gen[lane].randomize()) ;  // A previous randomize in the manager will have set the number of operands and addresses, so everything will be randomized except numberOfOperands and address
                  end

                if (`MGR_ARRAY_NUM_OF_MGR < 5)
                  begin
                    fileName  =    $sformatf("./configFiles/manager_%0d_%0d_layer1_group_%0d_AllGroupMemory.txt", Id/MGR_ARRAY_XY, Id%MGR_ARRAY_XY, WU_num );
                    dram_utils.loadDramFromAllGroupFile( .allGroupFileName    ( fileName              ), 
                                                         .sys_operation_data  ( sys_operation_lane_gen),
                                                         .vDramCfgIfc         ( vDramCfgIfc           ) 
                                                             );
                  end


                // send actual base operation to upstream checker 
                mgr2up.put(sys_operation_mgr)                      ; 

                //---------------------------------------------------------------------------------------------------------------
                // create the oob_packet object from the operation
                oob_packet_mgr                    = new                      ;  // create a OOB packet constructed from sys_operation
                oob_packet_mgr.createFromOperation(sys_operation_oob.tId, sys_operation_oob)     ;
                oob_packet_mgr.stOp_optionPtr     = rcvd_wud_to_oob_cmd.stOp_cmd;
                oob_packet_mgr.simd_optionPtr     = rcvd_wud_to_oob_cmd.simd_cmd;
                mgr2oob.put(oob_packet_mgr)                                  ;  // oob needs to prepare the PE
                $display("@%0t:%s:%0d:INFO: Manager {%0d} sent oob_packet {%0d} to oob_driver", $time, `__FILE__, `__LINE__, Id, operationNum);

                //  The manager sends OOB packet to oob_driver and the same operation to each generator
                //  The oob_driver will get oob information from the generator in case the generator has made changes to the operation
                //  e.g. perhaps we have different operations per lane
                //
                // so we will not get the ack from the oob or geneators until we have sent both the oob-packet and the operations
                // the oob_driver and generator make sure the OOB WU gets sent before operation data

                //----------------------------------------------------------------------------------------------------
                // Create copies of the base_operation and send to each lane generator 

                // send this to all the lane generators for this PE and wait for acknowledge
                        
                $display("@%0t:%s:%0d:INFO: Manager {%0d} sending operation {%0d} to generators and waiting for ack", $time, `__FILE__, `__LINE__, Id, operationNum);
                // include has mgr2gen and mgr2gen_ack
                // Note: couldnt get this to work with a for loop, so used python
                `include "TB_manager_send_operation_to_generators.vh"
                wait fork;
                // this should have waited till generator, driver and mem_checker are done 

                // wait till OOB packet is complete before startng next operation
                //@mgr2oob_ack ;
                //wait(mgr2oob_ack.triggered) ;
                //
                
                $display("@%0t:%s:%0d:INFO: Manager {%0d} operation {%0d} acked by generators", $time, `__FILE__, `__LINE__, Id, operationNum);

                operationNum++   ;
                WU_num++         ;
                
            end
        // Wait a little time for the last result to be received by the upstream checker
        repeat (50) @(vDownstreamStackBusOOB.cb_test);  


        -> final_operation;
    endtask

    //------------------------------------------------------------------------------------------------------------------------------------------------------
    //------------------------------------------------------------------------------------------------------------------------------------------------------
    // File Utilities
    task loadWuFile ( //output        descriptors  descriptorObjs [4]     ,
                      output        descObjs        dObjs  ,
                      input         string       fileName      
                                          );
      
      // Each instruction will contain four descriptors
      descriptor  descriptorWU [4]  ;
      // The task will return an array of instructions each with 4 descriptors
      descriptor  wuDescriptorArray [$][4]  ;

      // Information extracted from WU file
      int        simd_operation    ;
      int        stOp_operation    ;
      int        numOfLanes        ;
      int        numOfArg0Operands ;
      int        numOfArg1Operands ;
      string     wuFile            ;

      string  fileLine ;
      int     fileDesc ;
      int     lineNum  ;
      int     count    ;
      bit     found    ;
      bit     firstTimeThru    ;
      bit     valid    ;
      int     idxs [3] ;
      int     idx      ;
      // The WU instructions are initially strings
      string  descriptors [4] ;  // op, rd0, rd1, wr

      string     tmp_str           ;
      int        descType          ;
      int        tuple_option      ;
      int        tuple_value       ;
      string     tuple_option_str  ;
      string     tuple_value_str   ;
      int        tupleNum          ;

      // File format (without the //)

      // # 
      // 1, 1, 5: 1, 6: 1, 0, 2  ****  1, 2, 2: 0, 3: 0, 4: 20, 7: 0_000, 0, 2  ****  1, 2, 2: 1, 3: 1, 4: 20, 7: 0_001, 0, 2  ****  1, 3, 1: 2, 3: 1, 4: 20, 7: 0_002, 0, 2  

      //$display("\n@%0t :%s:%0d:INFO: Loading WUs from Group file %s for manager {%0d}\n", $time, `__FILE__, `__LINE__, fileName, Id);

      fileDesc = $fopen (fileName, "r");
      if (fileDesc == 0) 
        begin
          $display("@%0t :%s:%0d:ERROR: file open error opening : %s", $time, `__FILE__, `__LINE__, fileName);
          $finish;
      end
      
      found = 0;
      firstTimeThru = 1;
      lineNum = 0;
      count   = 0;

      while (!$feof(fileDesc)) 
        begin
   
          // Useful ASCII Codes
          // , = 0x2C
          // # = 0x23
          // : = 0x3A
          // ; = 0x3B
          // / = 0x2F

          // Remove the header lines. e.g. "#"
          while (found == 0)
            begin
              void'($fgets (fileLine, fileDesc)); 
              if (fileLine.substr(0,0).compare("#") != 0) 
                begin
                  found = 1;
                  //$display("@%0t :%s:%0d:INFO: %s : %s : %h", $time, `__FILE__, `__LINE__, fileLine, fileLine.substr(0,0), fileLine.substr(0,0));
                end
            end

          if (($fgetc(fileDesc) > 'h7F))  // last line doesnt appear valid
            begin
              break;
            end
          // First line alerady read while getting rid of header
          if (!firstTimeThru)
            begin
              void'($fgets (fileLine, fileDesc)); 
            end

          firstTimeThru = 0;
          //$display("\n@%0t :%s:%0d:INFO: Manager {%0d} : WU file line: %s ", $time, `__FILE__, `__LINE__, Id, fileLine);
          // find the index of the "****" delineators
          idx = 0;
          for (int i=0; i<fileLine.len(); i++)
            begin
              if (fileLine.substr(i+4,i+4) == `COMMON_ASCII_LF )
                begin
                  break;
                end
              else if (fileLine.substr(i,i+3) == "****")
                begin
                  idxs[idx] = i ;
                  //$display("@%0t :%s:%0d:INFO: %d ", $time, `__FILE__, `__LINE__, i);
                  idx++;
                end
            end

          //$display("@%0t :%s:%0d:INFO: Manager {%0d} : Num of **** %d ", $time, `__FILE__, `__LINE__, Id, idx);
          count  = 0;

          descriptors[0] = fileLine.substr(0, idxs[0]-1);
          descriptors[1] = fileLine.substr(idxs[0]+4, idxs[1]-1);
          descriptors[2] = fileLine.substr(idxs[1]+4, idxs[2]-1);
          // last descriptor is to end of line
          descriptors[3] = fileLine.substr(idxs[2]+4, fileLine.len()-2);
          //$display("@%0t :%s:%0d:INFO: %s ", $time, `__FILE__, `__LINE__, descriptors[0]);
          //$display("@%0t :%s:%0d:INFO: %s ", $time, `__FILE__, `__LINE__, descriptors[1]);
          //$display("@%0t :%s:%0d:INFO: %s ", $time, `__FILE__, `__LINE__, descriptors[2]);
          //$display("@%0t :%s:%0d:INFO: %s ", $time, `__FILE__, `__LINE__, descriptors[3]);
          lineNum++;
      
          // Separate option tuples
          for (int i=0; i<4; i++)
            begin
              descriptorWU [i] = new() ;
            end

          for (int d=0; d<$size(descriptors); d++)
            begin
              //$display("@%0t :%s:%0d:INFO: Processing Descriptor : %s ", $time, `__FILE__, `__LINE__, descriptors[d]);
              tupleNum = 0;
              idx = 0;
              for (int i=0; i<descriptors[d].len(); i++)
                begin
                  // tuple 0 is SOD
                  if ((descriptors[d].getc(i) == `COMMON_ASCII_COMMA ) && (tupleNum != 0)) // ","
                    begin
                      tmp_str = descriptors[d].substr(idx,i-1) ;
                      //$display("@%0t :%s:%0d:INFO: Tuple = %s ", $time, `__FILE__, `__LINE__, tmp_str);
                      if (tupleNum == 1) // single value operation 
                        begin
                          valid = 1;  // this single tuple will not have a colon
                          void'($sscanf(tmp_str, "%s", tmp_str));  // remove leading space because atohex() will stop on first non-digit
                          descType = tmp_str.atohex();
                          case (descType)
                            PY_WU_INST_DESC_TYPE_OP :
                              begin
                                descriptorWU[d].descType = descType ;
                                //$display("@%0t :%s:%0d:INFO: Desc %0d, Tuple %0d = Operation Descriptor", $time, `__FILE__, `__LINE__, d, tupleNum);
                              end
                            PY_WU_INST_DESC_TYPE_MR :
                              begin
                                descriptorWU[d].descType = descType ;
                                //$display("@%0t :%s:%0d:INFO: Desc %0d, Tuple %0d = Memory Read Descriptor", $time, `__FILE__, `__LINE__, d, tupleNum);
                              end
                            PY_WU_INST_DESC_TYPE_MW :
                              begin
                                descriptorWU[d].descType = descType ;
                                //$display("@%0t :%s:%0d:INFO: Desc %0d, Tuple %0d = Memory Write Descriptor", $time, `__FILE__, `__LINE__, d, tupleNum);
                              end
                            default :
                              begin
                                //$display("@%0t :%s:%0d:ERROR: unknown Descriptor : %s : %0d : %0d", $time, `__FILE__, `__LINE__, tmp_str, PY_WU_INST_DESC_TYPE_OP, tmp_str.atohex());
                              end
                          endcase
                        end
                      else
                        begin
                          // all tuples after first will have 2 values
                          valid = 0;  // look for colon
                          for (int j=0; j<tmp_str.len(); j++)
                            begin
                              if (tmp_str.getc(j) == `COMMON_ASCII_COLON)
                                begin
                                  tuple_option_str = tmp_str.substr(0,j-1) ;
                                  tuple_value_str  = tmp_str.substr(j+1, $size(tmp_str)-1) ;
                                  void'($sscanf(tuple_option_str , "%s", tuple_option_str ));  // remove leading space because atohex() will stop on first non-digit
                                  void'($sscanf(tuple_value_str  , "%s", tuple_value_str  ));  // remove leading space because atohex() will stop on first non-digit
                                  tuple_option = tuple_option_str.atohex();
                                  tuple_value  = tuple_value_str.atohex() ;
                                  if ((tuple_option == PY_WU_INST_OPT_TYPE_NUM_OF_ARG0_OPERANDS) || (tuple_option == PY_WU_INST_OPT_TYPE_NUM_OF_ARG1_OPERANDS) || (tuple_option == PY_WU_INST_OPT_TYPE_MEMORY))
                                    begin
                                      tmp_str =  $sformatf("%6h", tuple_value);
                                      descriptorWU[d].payload_tuple_type .push_back (tuple_option);
                                      descriptorWU[d].payload_tuple_value.push_back (tmp_str.substr(0,1).atohex());
                                      descriptorWU[d].payload_tuple_type.push_back  (tmp_str.substr(2,3).atohex());
                                      descriptorWU[d].payload_tuple_value.push_back (tmp_str.substr(4,5).atohex());
                                      //$display("@%0t :%s:%0d:INFO: Desc %0d, Tuple %0d = {%2h:%6h} ", $time, `__FILE__, `__LINE__, d, tupleNum, tuple_option, tuple_value);
                                    end
                                  else
                                    begin
                                      descriptorWU[d].payload_tuple_type .push_back (tuple_option);
                                      descriptorWU[d].payload_tuple_value.push_back (tuple_value );
                                      //$display("@%0t :%s:%0d:INFO: Desc %0d, Tuple %0d = {%2h:%2h} ", $time, `__FILE__, `__LINE__, d, tupleNum, tuple_option, tuple_value);
                                    end
                                  
                                  case (tuple_option)
                                    PY_WU_INST_OPT_TYPE_SRC                 :
                                      begin
                                      end
                                    PY_WU_INST_OPT_TYPE_TGT                 :
                                      begin
                                        
                                      end
                                    PY_WU_INST_OPT_TYPE_TXFER               :
                                      begin
                                        
                                      end
                                    PY_WU_INST_OPT_TYPE_NUM_OF_LANES        :
                                      begin
                                        
                                      end
                                    PY_WU_INST_OPT_TYPE_STOP                :
                                      begin
                                        
                                      end
                                    PY_WU_INST_OPT_TYPE_SIMDOP              :
                                      begin
                                        
                                      end
                                    PY_WU_INST_OPT_TYPE_MEMORY              :
                                      begin
                                        
                                      end
                                    PY_WU_INST_OPT_TYPE_NUM_OF_ARG0_OPERANDS:
                                      begin
                                        
                                      end
                                    PY_WU_INST_OPT_TYPE_NUM_OF_ARG1_OPERANDS:
                                      begin
                                        
                                      end
                                  endcase

                                  valid = 1;
                                end
                            end
                        end
                      if (valid == 0)  // a single value tuple will be the end
                        begin
                          break;
                        end
                      idx = i+1 ;
                      tupleNum ++;
                    end
                  else if ((descriptors[d].getc(i) == `COMMON_ASCII_COMMA ))
                    begin
                      idx = i+1 ;
                      tupleNum ++;
                    end
                end
            end
            wuDescriptorArray.push_back(descriptorWU);
        end

      $fclose(fileDesc);
      dObjs = wuDescriptorArray;
    endtask

endclass



