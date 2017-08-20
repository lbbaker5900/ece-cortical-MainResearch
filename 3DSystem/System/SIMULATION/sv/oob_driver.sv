/*********************************************************************************************
    File name   : oob_driver.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Jan 2017
    Email       : lbbaker@ncsu.edu
    
    Description : This file contains the oob driver.
                  It takes the operation from the manager and generators and drives it through the stack interface.
                  The oob driver accesses all lanes so it will wait for the manager operation and each generator operation before driving the bus.
                  We need generator info because the generator randomizes the address for each lane.
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

class oob_driver;

    int       Id                                             ; // oob is per PE
                                                           
    mailbox   mgr2oob                                        ;
    event     mgr2oob_ack                                    ;

    mailbox   gen2oob                                        ;  // all generators put oob_packet in the same single mailbox
    event     gen2oob_ack [`PE_NUM_OF_EXEC_LANES_RANGE ]     ;  // but each generator gets its own ack


    oob_packet       oob_packet_mgr     ;  // from manager
    oob_packet       oob_packet_gen     ;  // from generator

    //----------------------------------------------------------------------------------------------------
    // OOB driver needs oob signals and lane signals to send oob packet
    vDownstreamStackBusOOB_T  vDownstreamStackBusOOB                                                          ;  // FIXME: OOB is a per PE interface but we have driver objects for all PE/Lanes
    vDownstreamStackBusLane_T vDownstreamStackBusLane     [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS] ;
    vDownstreamStackBusLane_T tmp_vDownstreamStackBusLane                                [`PE_NUM_OF_STREAMS] ;

    //----------------------------------------------------------------------------------------------------
    // WU Decoder to OOB Downstream Interfaces
    vWudToOob_T       vWudToOobIfc        ;
    mailbox           wud2mgr_m           ;  // WU Decoder has generated OOB Downstream request to Downstream OOB Controller


    //----------------------------------------------------------------------------------------------------
    // Misc

    logic      receivedManagerOobPacket     ;
    logic      receivedGeneratorOobPackets  ;

    //----------------------------------------------------------------------------------------------------



    function new (
                  input int                          Id                                                                      ,
                  input mailbox                      mgr2oob                                                                 ,   
                  input event                        mgr2oob_ack                                                             ,
                  input mailbox                      gen2oob                                                                 ,
                  input event                        gen2oob_ack              [`PE_NUM_OF_EXEC_LANES ]                       ,
                  input vDownstreamStackBusOOB_T     vDownstreamStackBusOOB                                                  ,
                  input vDownstreamStackBusLane_T    vDownstreamStackBusLane  [`PE_NUM_OF_EXEC_LANES ] [`PE_NUM_OF_STREAMS]  ,
                  input vWudToOob_T                  vWudToOobIfc                                                            ,
                  input mailbox                      wud2mgr_m             
                  );

        this.Id                            =   Id                      ;
        this.mgr2oob                       =   mgr2oob                 ;
        this.mgr2oob_ack                   =   mgr2oob_ack             ;
        this.gen2oob                       =   gen2oob                 ;
        this.gen2oob_ack                   =   gen2oob_ack             ;
        this.vDownstreamStackBusOOB        =   vDownstreamStackBusOOB  ;
        this.vDownstreamStackBusLane       =   vDownstreamStackBusLane ;
        this.receivedManagerOobPacket      =   0                       ;
        this.receivedGeneratorOobPackets   =   0                       ;
        this.vWudToOobIfc                  =   vWudToOobIfc            ;
        this.wud2mgr_m                     =   wud2mgr_m               ;
    endfunction

    task run();
        //$display("@%0t:%s:%0d: DEBUG: {%0d,%0d} Running OOB driver : ", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
        
        // OOB process will configure the PE (WIP)

        // oob_driver receives an oob_packet from the manager and oob_packets from each generator.
        // All oob_packets need to be received before the oob_command is driven on the STD but.

        //----------------------------------------------------------------------------------------------------
        // WU Decoder to Downstream OOB Controller
        //
        wud_to_oob_cmd                               rcvd_wud_to_oob_cmd ;  // grab any WU Decoder commands
        bit   [`MGR_STD_OOB_TAG_RANGE         ]      rcvd_tag            ;
        bit   [`MGR_NUM_LANES_RANGE           ]      rcvd_num_lanes      ;
        bit   [`MGR_WU_OPT_VALUE_RANGE        ]      rcvd_stOp_cmd       ;
        bit   [`MGR_WU_OPT_VALUE_RANGE        ]      rcvd_simd_cmd       ;
     

        //----------------------------------------------------------------------------------------------------
        // readmeh files for pe_cntl stOp control memory
        //
        // Aggregate memories for stOp and simd control
        integer stOp_cntl_memory_pe_cntl_stOp_File         ;
        integer stOp_cntl_memory_pe_cntl_simd_File         ;
        //bit [`PE_CNTL_STOP_OPTION_AGGREGATE_MEMORY_RANGE  ]  pe_cntl_stOp_memory_data ;

        // we originally created separate files for each field, now create an aggregate memory
        integer stOp_cntl_memory_stOp_operation_File       ;
        integer stOp_cntl_memory_sourceAddress0_File       ;
        integer stOp_cntl_memory_destinationAddress0_File  ;
        integer stOp_cntl_memory_src_data_type0_File       ;
        integer stOp_cntl_memory_dest_data_type0_File      ;
        integer stOp_cntl_memory_sourceAddress1_File       ;
        integer stOp_cntl_memory_destinationAddress1_File  ;
        integer stOp_cntl_memory_src_data_type1_File       ;
        integer stOp_cntl_memory_dest_data_type1_File      ;
        integer stOp_cntl_memory_numberOfOperands_File     ;

        string  fileNameStr ;
        integer fileNameInt ;

        bit      oob_sent            ;
        integer  operationNumber = 1 ; // use this to create location in control file and send this as ptr
        reg  [`STACK_DOWN_OOB_INTF_OPTION_SIZE-1:0 ]    oob_option [`STACK_DOWN_OOB_INTF_TUPLES_PER_CYCLE ] ;
        reg  [`STACK_DOWN_OOB_INTF_VALUE_SIZE-1:0  ]    oob_value  [`STACK_DOWN_OOB_INTF_TUPLES_PER_CYCLE ] ;
        stack_down_oob_option  tmp_oob_option  ;

        //------------------------------------------------------------------------------
        // Initially create readmemh files for stOp control memory in pe_cntl before we send WU
        //   - we only need one file for the PE as the memory is shared across all lanes
        //
        /*
        fileNameStr = $sformatf("%0d", this.Id[0]);
        fileNameStr = {"./inputFiles/pe", string'(this.Id[0]), "_stOp_cntl_memory_stOp_operation.dat"};
        fileNameStr = {"./inputFiles/pe", $sformatf("%0d",this.Id[0]), "_stOp_cntl_memory_stOp_operation.dat"};
        fileNameInt       =   $fopen(fileNameStr  , "w+"    );  // w+ ~ truncate or 
        $fclose(fileNameInt);
        */

        // Here we initially create the file, later we'll open for append
        stOp_cntl_memory_pe_cntl_stOp_File         =   $fopen($sformatf("./inputFiles/pe%0d_pe_cntl_stOp_memory.dat"     , this.Id), "w"    );
        stOp_cntl_memory_pe_cntl_simd_File         =   $fopen($sformatf("./inputFiles/pe%0d_pe_cntl_simd_memory.dat"     , this.Id), "w"    );
        
        stOp_cntl_memory_stOp_operation_File       =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_stOp_operation.dat"     , this.Id), "w"    );
        
        stOp_cntl_memory_sourceAddress0_File       =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_sourceAddress0.dat"     , this.Id), "w"    );
        stOp_cntl_memory_destinationAddress0_File  =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_destinationAddress0.dat", this.Id), "w"    );
        stOp_cntl_memory_src_data_type0_File       =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_src_data_type0.dat"     , this.Id), "w"    );
        stOp_cntl_memory_dest_data_type0_File      =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_dest_data_type0.dat"    , this.Id), "w"    );
                                             
        stOp_cntl_memory_sourceAddress1_File       =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_sourceAddress1.dat"     , this.Id), "w"    );
        stOp_cntl_memory_destinationAddress1_File  =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_destinationAddress1.dat", this.Id), "w"    );
        stOp_cntl_memory_src_data_type1_File       =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_src_data_type1.dat"     , this.Id), "w"    );
        stOp_cntl_memory_dest_data_type1_File      =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_dest_data_type1.dat"    , this.Id), "w"    );
                                             
        stOp_cntl_memory_numberOfOperands_File     =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_numberOfOperands.dat"   , this.Id), "w"    );
        
        // close
        // Aggregate Memory
        $fclose(stOp_cntl_memory_pe_cntl_stOp_File       );
        $fclose(stOp_cntl_memory_pe_cntl_simd_File       );

        // Individual memory
        $fclose(stOp_cntl_memory_stOp_operation_File       );
                                                           
        $fclose(stOp_cntl_memory_sourceAddress0_File       );
        $fclose(stOp_cntl_memory_destinationAddress0_File  );
        $fclose(stOp_cntl_memory_src_data_type0_File       );
                                                           
        $fclose(stOp_cntl_memory_sourceAddress1_File       );
        $fclose(stOp_cntl_memory_destinationAddress1_File  );
        $fclose(stOp_cntl_memory_src_data_type1_File       );
                                                           
        $fclose(stOp_cntl_memory_numberOfOperands_File     );

        //------------------------------------------------------------------------------
        // We can send two option,value tuples per OOB cycle

        // Spawn processes for:
        //  - receive operation from the manager and construct the stOp command memory in pe_cntl
        //  - receive operations from all the generators
        //  - wait for operations to be received then send OOB packet
        //  - observe and grab transactions between WU Decoder and OOB Downstream controller and send stOp_optionPtr to manager
        //    Note: The manager will add the stOp and simd option ptrs to the operation and return to oob_driver
        //
        fork

          //------------------------------------------------------------------------------------------------------------------------------------------------------
          // Proc a) Wait for manager packet
          begin
            forever
              begin
                if (( mgr2oob.num() != 0 ) && (receivedManagerOobPacket == 0) )
                  begin
                      mgr2oob.peek(oob_packet_mgr) ;                             //Taking the instruction from the manager 
                      //$display("@%0t%s:%0d:DEBUG:{%0d}: received OOB packet from manager: %0b", $time, `__FILE__, `__LINE__, Id, oob_packet_mgr.stOp_operation );
                      receivedManagerOobPacket      = 1                     ;
                  end
                @(vDownstreamStackBusOOB.cb_test);
              end  // forever
          end
          //------------------------------------------------------------------------------------------------------------------------------------------------------

          //------------------------------------------------------------------------------------------------------------------------------------------------------
          // Proc b) Wait for generator packets
          begin
            forever
              begin
                if (( gen2oob.num() == `PE_NUM_OF_EXEC_LANES ) && (receivedGeneratorOobPackets == 0) )
                  begin
                      //$display("@%0t%s:%0d:DEBUG: {%0d} received all OOB packets from generators", $time, `__FILE__, `__LINE__, Id);
                      receivedGeneratorOobPackets   = 1                     ;
                  end
                // watch out for infinite loop if commenting out this section of code
                // a forever loop will need an @clk
                @(vDownstreamStackBusOOB.cb_test);
              end  // forever
          end
          //------------------------------------------------------------------------------------------------------------------------------------------------------
         
          //------------------------------------------------------------------------------------------------------------------------------------------------------
          // Proc c) Wait for proc (a) and (b) then send OOB packet
          begin
            forever
              begin
                //----------------------------------------------------------------------
                // If we have all the oob_packets, drive the STD busA
               
                // Note: Only wait for manager to provide OOB packet
                //if ( (receivedManagerOobPacket == 1) && (receivedGeneratorOobPackets == 1) )
                if (receivedManagerOobPacket == 1) 
                  begin
                    // The OOB packet from the manager contains PE specific information. Additional lane specific information
                    // comes from the generator. Note: we currently assume we only need PE specific data and things like number of operands and addresses are common.
                    // Note: The PE control will adjust the source and destination addresses to index into the lane area of the local memory
                    mgr2oob.get(oob_packet_mgr)  ;  //Removing the instruction from manager mailbox
               
                    //--------------------------------------------------------------------------------------------------------
                    // Load the local PE configuration memory
               
                    //------------------------------------------------------------------------------
                    // Update readmemh files for stOp control memory in pe_cntl before we send WU
                    //   - each new command gets placed into pe_cntl memry based on pointer in OP descriptor
                    //   - pointer comes from manager oob_packet (which used the content of the wud_to_oob command provided by the oob_driver
                    //     e.g. manager merged pointer from wud_to_oob command into the operation packet
                    // Aggregate Memory
                    stOp_cntl_memory_pe_cntl_stOp_File         =   $fopen($sformatf("./inputFiles/pe%0d_pe_cntl_stOp_memory.dat"     , this.Id), "w"    );
                    stOp_cntl_memory_pe_cntl_simd_File         =   $fopen($sformatf("./inputFiles/pe%0d_pe_cntl_simd_memory.dat"     , this.Id), "w"    );

                    // Individual memory
                    stOp_cntl_memory_stOp_operation_File       =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_stOp_operation.dat"     , this.Id), "a"    );
                    
                    stOp_cntl_memory_sourceAddress0_File       =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_sourceAddress0.dat"     , this.Id), "a"    );
                    stOp_cntl_memory_destinationAddress0_File  =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_destinationAddress0.dat", this.Id), "a"    );
                    stOp_cntl_memory_src_data_type0_File       =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_src_data_type0.dat"     , this.Id), "a"    );
                    stOp_cntl_memory_dest_data_type0_File      =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_dest_data_type0.dat"    , this.Id), "a"    );
                                                         
                    stOp_cntl_memory_sourceAddress1_File       =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_sourceAddress1.dat"     , this.Id), "a"    );
                    stOp_cntl_memory_destinationAddress1_File  =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_destinationAddress1.dat", this.Id), "a"    );
                    stOp_cntl_memory_src_data_type1_File       =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_src_data_type1.dat"     , this.Id), "a"    );
                    stOp_cntl_memory_dest_data_type1_File      =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_dest_data_type1.dat"    , this.Id), "a"    );
                                                         
                    stOp_cntl_memory_numberOfOperands_File     =   $fopen($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_numberOfOperands.dat"   , this.Id), "a"    );
                    
                    // Write to only location 0x1 as this pointer address is hard-coded in stack_interface_typedef.vh
                    //--------------------------------------------------------------------------------------------
                    // Aggregate Memory
                    $display("@%0t:%s:%0d: INFO:{%0d}: Loading pe_cntl stOp : {%0d,%0d}", $time, `__FILE__, `__LINE__, this.Id, oob_packet_mgr.Id[0], oob_packet_mgr.Id[1]);
                    $fwrite(stOp_cntl_memory_pe_cntl_stOp_File         , $sformatf("@%0d %h\n", oob_packet_mgr.stOp_optionPtr, {oob_packet_mgr.stOp_operation       , 
                                                                                                                                oob_packet_mgr.sourceAddress     [0], 
                                                                                                                                oob_packet_mgr.destinationAddress[0],
                                                                                                                                oob_packet_mgr.src_data_type     [0],
                                                                                                                                oob_packet_mgr.dest_data_type    [0],
                                                                                                                                oob_packet_mgr.sourceAddress     [1],
                                                                                                                                oob_packet_mgr.destinationAddress[1],
                                                                                                                                oob_packet_mgr.src_data_type     [1],
                                                                                                                                oob_packet_mgr.dest_data_type    [1],
                                                                                                                                oob_packet_mgr.numberOfOperands     }));

                    //

                    //--------------------------------------------------------------------------------------------
                    // Individual memory
                    $fwrite(stOp_cntl_memory_stOp_operation_File       , $sformatf("@%0d %h\n", oob_packet_mgr.stOp_optionPtr, oob_packet_mgr.stOp_operation          ));
                                                                                                                                                          
                    $fwrite(stOp_cntl_memory_sourceAddress0_File       , $sformatf("@%0d %h\n", oob_packet_mgr.stOp_optionPtr, oob_packet_mgr.sourceAddress     [0]   ));
                    $fwrite(stOp_cntl_memory_destinationAddress0_File  , $sformatf("@%0d %h\n", oob_packet_mgr.stOp_optionPtr, oob_packet_mgr.destinationAddress[0]   ));
                    $fwrite(stOp_cntl_memory_src_data_type0_File       , $sformatf("@%0d %h\n", oob_packet_mgr.stOp_optionPtr, oob_packet_mgr.src_data_type     [0]   ));
                                                                                                                                                          
                    $fwrite(stOp_cntl_memory_sourceAddress1_File       , $sformatf("@%0d %h\n", oob_packet_mgr.stOp_optionPtr, oob_packet_mgr.sourceAddress     [1]   ));
                    $fwrite(stOp_cntl_memory_destinationAddress1_File  , $sformatf("@%0d %h\n", oob_packet_mgr.stOp_optionPtr, oob_packet_mgr.destinationAddress[1]   ));
                    $fwrite(stOp_cntl_memory_src_data_type1_File       , $sformatf("@%0d %h\n", oob_packet_mgr.stOp_optionPtr, oob_packet_mgr.src_data_type     [1]   ));
                                                                                                                                                          
                    $fwrite(stOp_cntl_memory_numberOfOperands_File     , $sformatf("@%0d %h\n", oob_packet_mgr.stOp_optionPtr, oob_packet_mgr.numberOfOperands        ));
                    
                    // close
                    // Aggregate Memory
                    $fclose(stOp_cntl_memory_pe_cntl_stOp_File       );
                    $fclose(stOp_cntl_memory_pe_cntl_simd_File       );
                    
                    // Individual memory
                    $fclose(stOp_cntl_memory_stOp_operation_File       );
                                                                       
                    $fclose(stOp_cntl_memory_sourceAddress0_File       );
                    $fclose(stOp_cntl_memory_destinationAddress0_File  );
                    $fclose(stOp_cntl_memory_src_data_type0_File       );
                                                                       
                    $fclose(stOp_cntl_memory_sourceAddress1_File       );
                    $fclose(stOp_cntl_memory_destinationAddress1_File  );
                    $fclose(stOp_cntl_memory_src_data_type1_File       );
                                                                       
                    $fclose(stOp_cntl_memory_numberOfOperands_File     );
               
                    // end of readmem creation
                    //--------------------------------------------------------------------------------------------
               
                    //--------------------------------------------------------------------------------------------
                    $display("@%0t:%s:%0d: INFO:{%0d}: Driving WU via OOB with contents of OOB packet from manager : {%0d}", $time, `__FILE__, `__LINE__, this.Id, oob_packet_mgr.Id[0], oob_packet_mgr.Id[1]);
                    oob_packet_mgr.displayPacket();
               
                    oob_sent = 0 ;
                    while (~oob_sent)
                      begin
                        @(vDownstreamStackBusOOB.cb_test);
               
                        // Check if the PE can accept a new operation
                        while (~vDownstreamStackBusOOB.pe__std__oob_ready) 
                          begin
                            vDownstreamStackBusOOB.cb_test.std__pe__oob_valid        <= 0  ;
                            @(vDownstreamStackBusOOB.cb_test);
                          end
               
                        vDownstreamStackBusOOB.cb_test.std__pe__oob_valid        <= 1  ;
               
                        //----------------------------------------------------------------------------------------------------
                        // set operation and pointer
                        tmp_oob_option = STD_PACKET_OOB_OPT_STOP_CMD            ;
                        oob_option [0] = tmp_oob_option  ;
                        oob_value  [0] = operationNumber ;
                        tmp_oob_option = STD_PACKET_OOB_OPT_SIMD_RELU_CMD            ;
                        oob_option [1] = tmp_oob_option  ;
                        oob_value  [1] = operationNumber ;
                        // drive but these are conditioned on valid
                        //vDownstreamStackBusOOB.cb_test.sys__pe__allSynchronized  <= 1 ;
                        vDownstreamStackBusOOB.cb_test.std__pe__oob_cntl         <= `COMMON_STD_INTF_CNTL_SOM      ;  
                        vDownstreamStackBusOOB.cb_test.std__pe__oob_type         <= STD_PACKET_OOB_TYPE_PE_OP_CMD  ;
                        vDownstreamStackBusOOB.cb_test.std__pe__oob_data         <= {oob_value[1], oob_option[1],oob_value[0], oob_option[0]};
               
                        @(vDownstreamStackBusOOB.cb_test);
                        //----------------------------------------------------------------------------------------------------
                        // set tag
                        tmp_oob_option = STD_PACKET_OOB_OPT_TAG            ;
                        oob_option [0] = tmp_oob_option  ;
                        oob_value  [0] = oob_packet_mgr.tag ;
                        tmp_oob_option = STD_PACKET_OOB_OPT_NUM_LANES      ;
                        oob_option [1] = tmp_oob_option  ;
                        oob_value  [1] = oob_packet_mgr.numberOfLanes    ;  // for number of lanes, this will be 6-bits wide to accommodate 32. Note: previously used 5 bits
                        // drive but these are conditioned on valid
                        //vDownstreamStackBusOOB.cb_test.sys__pe__allSynchronized  <= 1 ;
                        vDownstreamStackBusOOB.cb_test.std__pe__oob_cntl         <= `COMMON_STD_INTF_CNTL_EOM      ;  
                        vDownstreamStackBusOOB.cb_test.std__pe__oob_type         <= STD_PACKET_OOB_TYPE_PE_OP_CMD  ;
                        vDownstreamStackBusOOB.cb_test.std__pe__oob_data         <= {oob_value[1], oob_option[1],oob_value[0], oob_option[0]};
               
                        oob_sent = 1;
               
               
                        // right now all PE configuration is passed to the PE over the OOB using {option, value} tuples
                        // So we assume the source and destination addresses are the same but offset into the lane memory
                        // If we need to handle cases where we need lane specific address, number of operands etc. we will pass that data over the lane interface
                        for (int lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
                          begin
                            // The oob_packet from the generator contains lane specific information that might need to get driven down the lane bus
                            gen2oob.get(oob_packet_gen)  ;  // Removing the instruction from manager mailbox
                            gen2oob.put(oob_packet_gen)  ;  // we need each packet later
                            //$display("@%0t:%s:%0d: DEBUG:{%0d}: Driving OOB Lane with contents of OOB packet from generator : {%0d,%0d}", $time, `__FILE__, `__LINE__, this.Id, oob_packet_gen.Id[0], oob_packet_gen.Id[1]);
                            //oob_packet_mgr.displayPacket();
                            /*
                            tmp_vDownstreamStackBusLane = vDownstreamStackBusLane[oob_packet_gen.Id[1]];
                    
                            tmp_vDownstreamStackBusLane.cb_test.std__pe__lane_strm0_data_valid  <= 1  ;
                            tmp_vDownstreamStackBusLane.cb_test.std__pe__lane_strm0_cntl        <= `COMMON_STD_INTF_CNTL_SOM_EOM  ;         //Passing the instruction to the system interface
                            tmp_vDownstreamStackBusLane.cb_test.std__pe__lane_strm0_data        <= 32'hdead_beef  ;
                            tmp_vDownstreamStackBusLane.cb_test.std__pe__lane_strm0_data_mask   <= 0  ;
                            tmp_vDownstreamStackBusLane.cb_test.std__pe__lane_strm1_data_valid  <= 1  ;
                            tmp_vDownstreamStackBusLane.cb_test.std__pe__lane_strm1_cntl        <= `COMMON_STD_INTF_CNTL_SOM_EOM  ;         //Passing the instruction to the system interface
                            tmp_vDownstreamStackBusLane.cb_test.std__pe__lane_strm1_data        <= 32'hbabe_cafe  ;
                            tmp_vDownstreamStackBusLane.cb_test.std__pe__lane_strm1_data_mask   <= 0  ;
                            */
                          end
                      end  // while ~oob_sent
               
                    // Now quiesce the STD bus by deasserting valid
                    @(vDownstreamStackBusOOB.cb_test);
               
                    vDownstreamStackBusOOB.cb_test.std__pe__oob_valid        <= 0  ;  // FIXME: temporary drive OOB to non-X
                    vDownstreamStackBusOOB.cb_test.std__pe__oob_type         <= STD_PACKET_OOB_TYPE_NA  ;
                    vDownstreamStackBusOOB.cb_test.std__pe__oob_data         <= STD_PACKET_OOB_DATA_NA  ;
                    for (int lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
                      begin
                        // right now we dont drive the lane interface in the oob_driver so just remove the oob_packet from the generator
                        gen2oob.get(oob_packet_gen)  ;  //Removing the instruction from manager mailbox
                        //fork
                        for (int strm=0; strm<`PE_NUM_OF_STREAMS; strm++)
                          begin
                            tmp_vDownstreamStackBusLane[strm] = vDownstreamStackBusLane[oob_packet_gen.Id[1]][strm];
                            tmp_vDownstreamStackBusLane[strm].cb_test.std__pe__lane_strm_data_valid  <= 0  ;
                          end
                        //join_none
                      end
               
                    //----------------------------------------------------------------------
                    // Ack manager and generators
               
                    // Ack manager
                    -> mgr2oob_ack;
                    receivedManagerOobPacket      = 0                     ;
               
                    // Ack generator(s)
                    for (int i=0; i<`PE_NUM_OF_EXEC_LANES; i++)
                      begin
                        -> gen2oob_ack[i];
                      end
                    receivedGeneratorOobPackets   = 0                     ;
                    //operationNumber += 1 ;
                    $display("@%0t:%s:%0d:INFO: {%0d} Completed driving OOB", $time, `__FILE__, `__LINE__, this.Id );

                  end  // if ( (receivedManagerOobPacket == 1) && (receivedGeneratorOobPackets == 1) )
                else
                  //----------------------------------------------------------------------
                  // make sure we dont have a zero delay loop
                  begin
                    @(vDownstreamStackBusOOB.cb_test);
                    vDownstreamStackBusOOB.cb_test.std__pe__oob_valid        <= 0  ;  // driver.sv takes care of stream valids
                  end  // else
              end  // forever
          end

          //------------------------------------------------------------------------------------------------------------------------------------------------------
          // Proc d) Grab commands between WU Decoder OOB Downstream Controller
          begin
            forever
              begin
                // Observe descriptor interface
                @(vWudToOobIfc.cb_p);
                if ((vWudToOobIfc.valid == 1'b1))
                  begin
                    // Start of descriptor observed, create new descriptor and start to fill the fields
                    $display ("@%0t::%s:%0d:: INFO: Manager {%0d} observed command between WU decoder and OOB Controller", $time, `__FILE__, `__LINE__, this.Id);
                    rcvd_wud_to_oob_cmd          =   new(this.Id)           ;  
                    rcvd_wud_to_oob_cmd.timeTag  =   $time                  ;
                    rcvd_tag                     =   vWudToOobIfc.tag       ;
                    rcvd_num_lanes               =   vWudToOobIfc.num_lanes ;
                    rcvd_stOp_cmd                =   vWudToOobIfc.stOp_cmd  ;
                    rcvd_simd_cmd                =   vWudToOobIfc.simd_cmd  ;
                    rcvd_wud_to_oob_cmd.create( rcvd_tag, rcvd_num_lanes, rcvd_stOp_cmd, rcvd_simd_cmd);
                    rcvd_wud_to_oob_cmd.display();          
                    if ((vWudToOobIfc.valid == 1'b1) && (vWudToOobIfc.cntl != `COMMON_STD_INTF_CNTL_SOM_EOM))  // not single cycle
                      begin
                        $display ("@%0t:%s:%0d:ERROR::Manager {%0d} Non single cycle command between WU Decoder and Downstream OOB Controller", $time, `__FILE__, `__LINE__, this.Id);
                      end
                    wud2mgr_m.put(rcvd_wud_to_oob_cmd)  ;  // Inform manager
                  end  // if ((vWudToOobIfc.valid == 1'b1))
              end  // forever
          end
          //------------------------------------------------------------------------------------------------------------------------------------------------------

          //------------------------------------------------------------------------------------------------------------------------------------------------------
        join_none
    endtask


endclass
