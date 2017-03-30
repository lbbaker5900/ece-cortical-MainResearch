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

    // OOB driver needs oob signals and lane signals to send oob packet
    vDownstreamStackBusOOB_T  vDownstreamStackBusOOB                                 ;  // FIXME: OOB is a per PE interface but we have driver objects for all PE/Lanes
    vDownstreamStackBusLane_T vDownstreamStackBusLane [`PE_NUM_OF_EXEC_LANES_RANGE ] ;
    vDownstreamStackBusLane_T tmp_vDownstreamStackBusLane ;


    //----------------------------------------------------------------------------------------------------
    // Misc

    logic      receivedManagerOobPacket     ;
    logic      receivedGeneratorOobPackets  ;

    //----------------------------------------------------------------------------------------------------



    function new (
                  input int                   Id                                           ,
                  input mailbox               mgr2oob                                      ,   
                  input event                 mgr2oob_ack                                  ,
                  input mailbox               gen2oob                                      ,
                  input event                 gen2oob_ack       [`PE_NUM_OF_EXEC_LANES   ] ,
                  input vDownstreamStackBusOOB_T     vDownstreamStackBusOOB                              ,
                  input vDownstreamStackBusLane_T    vDownstreamStackBusLane  [`PE_NUM_OF_EXEC_LANES   ] );

        this.Id                            = Id                    ;
        this.mgr2oob                       = mgr2oob               ;
        this.mgr2oob_ack                   = mgr2oob_ack           ;
        this.gen2oob                       = gen2oob               ;
        this.gen2oob_ack                   = gen2oob_ack           ;
        this.vDownstreamStackBusOOB               = vDownstreamStackBusOOB       ;
        this.vDownstreamStackBusLane              = vDownstreamStackBusLane      ;
        this.receivedManagerOobPacket      = 0                     ;
        this.receivedGeneratorOobPackets   = 0                     ;
    endfunction

    task run();
        //$display("@%0t:%s:%0d: DEBUG: {%0d,%0d} Running OOB driver : ", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
        

        // OOB process will configure the PE (WIP)

        // oob_driver receives an oob_packet from the manager and oob_packets from each generator.
        // All oob_packets need to be received before the oob_command is driven on the STD but.

        //----------------------------------------------------------------------------------------------------
        // readmeh files for pe_cntl stOp control memory
        //
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
        integer  operationNumber = 0 ; // use this to create location in control file and send this as ptr
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

        forever
            begin
                if (( mgr2oob.num() != 0 ) && (receivedManagerOobPacket == 0) )
                    begin
                        mgr2oob.peek(oob_packet_mgr) ;                             //Taking the instruction from the manager 
                        //$display("@%0t%s:%0d:DEBUG:{%0d}: received OOB packet from manager: %0b", $time, `__FILE__, `__LINE__, Id, oob_packet_mgr.stOp_operation );
                        receivedManagerOobPacket      = 1                     ;
                    end
                else if (( gen2oob.num() == `PE_NUM_OF_EXEC_LANES ) && (receivedGeneratorOobPackets == 0) )
                    begin
                        //$display("@%0t%s:%0d:DEBUG: {%0d} received all OOB packets from generators", $time, `__FILE__, `__LINE__, Id);
                        receivedGeneratorOobPackets   = 1                     ;
                    end
                // watch out for infinite loop if commenting out this section of code
                // a forever loop will need an @clk

                //----------------------------------------------------------------------
                // If we have all the oob_packets, drive the STD busA

                if ( (receivedManagerOobPacket == 1) && (receivedGeneratorOobPackets == 1) )
                    begin
                        // The OOB packet from the manager contains PE specific information. Additional lane specific information
                        // comes from the generator. Note: we currently assume we only need PE specific data and things like number of operands and addresses are common.
                        // Note: The PE control will adjust the source and destination addresses to index into the lane area of the local memory
                        mgr2oob.get(oob_packet_mgr)  ;  //Removing the instruction from manager mailbox

                        //--------------------------------------------------------------------------------------------------------
                        // Load the local PE configuration memory

                        //------------------------------------------------------------------------------
                        // Update readmemh files for stOp control memory in pe_cntl before we send WU
                        //   - each new command gets appended to the control
                        //   memory
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
                        $fwrite(stOp_cntl_memory_stOp_operation_File       , $sformatf("@%0d %h\n", operationNumber, oob_packet_mgr.stOp_operation          ));
                                                                                                                                                              
                        $fwrite(stOp_cntl_memory_sourceAddress0_File       , $sformatf("@%0d %h\n", operationNumber, oob_packet_mgr.sourceAddress     [0]   ));
                        $fwrite(stOp_cntl_memory_destinationAddress0_File  , $sformatf("@%0d %h\n", operationNumber, oob_packet_mgr.destinationAddress[0]   ));
                        $fwrite(stOp_cntl_memory_src_data_type0_File       , $sformatf("@%0d %h\n", operationNumber, oob_packet_mgr.src_data_type     [0]   ));
                                                                                                                                                              
                        $fwrite(stOp_cntl_memory_sourceAddress1_File       , $sformatf("@%0d %h\n", operationNumber, oob_packet_mgr.sourceAddress     [1]   ));
                        $fwrite(stOp_cntl_memory_destinationAddress1_File  , $sformatf("@%0d %h\n", operationNumber, oob_packet_mgr.destinationAddress[1]   ));
                        $fwrite(stOp_cntl_memory_src_data_type1_File       , $sformatf("@%0d %h\n", operationNumber, oob_packet_mgr.src_data_type     [1]   ));
                                                                                                                                                              
                        $fwrite(stOp_cntl_memory_numberOfOperands_File     , $sformatf("@%0d %h\n", operationNumber, oob_packet_mgr.numberOfOperands        ));
                        
                        // close
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
                        $display("@%0t:%s:%0d: INFO:{%0d}: Driving WU via OOB with contents of OOB packet from manager : {%0d,%0d}", $time, `__FILE__, `__LINE__, this.Id, oob_packet_mgr.Id[0], oob_packet_mgr.Id[1]);
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

/*
                            if (vDownstreamStackBusOOB.pe__std__oob_ready) 
                              begin
                              vDownstreamStackBusOOB.cb_test.std__pe__oob_valid        <= 1  ;
                              oob_sent = 1;
                              end
                            else
                              begin
                                // cb_dut or cb_test dont work for inputs/observed signals
                                //$display("@%0t:%s:%0d: INFO:{%0d}: Not ready for OOB from manager : {%0d,%0d}. rdy = %d", $time, `__FILE__, `__LINE__, this.Id, oob_packet_mgr.Id[0], oob_packet_mgr.Id[1], vDownstreamStackBusOOB.pe__std__oob_ready );
                                vDownstreamStackBusOOB.cb_test.std__pe__oob_valid        <= 0  ;
                              end
*/
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
                            oob_value  [1] = oob_packet_mgr.numberOfLanes-1    ;  // for number of lanes, 0 - 1, 31 = 32 e.g. we only want to use 5 bits to set number of lanes and we assume at least one lane is active
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
                                    tmp_vDownstreamStackBusLane = vDownstreamStackBusLane[oob_packet_gen.Id[1]];
                                    tmp_vDownstreamStackBusLane.cb_test.std__pe__lane_strm0_data_valid  <= 0  ;
                                    tmp_vDownstreamStackBusLane.cb_test.std__pe__lane_strm1_data_valid  <= 0  ;
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
                        operationNumber += 1 ;
                        $display("@%0t:%s:%0d:INFO: {%0d} Completed driving OOB", $time, `__FILE__, `__LINE__, this.Id );
                    end
                else
                    //----------------------------------------------------------------------
                    // make sure we dont have a zero delay loop
                    begin
                        @(vDownstreamStackBusOOB.cb_test);
                        vDownstreamStackBusOOB.cb_test.std__pe__oob_valid        <= 0  ;  // driver.sv takes care of stream valids
                    end

            end  // forever
    endtask


endclass
