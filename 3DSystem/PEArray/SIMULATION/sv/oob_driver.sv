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
    vSysOob2PeArray_T  vSysOob2PeArray                                 ;  // FIXME: OOB is a per PE interface but we have driver objects for all PE/Lanes
    vSysLane2PeArray_T vSysLane2PeArray [`PE_NUM_OF_EXEC_LANES_RANGE ] ;
    vSysLane2PeArray_T tmp_vSysLane2PeArray ;


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
                  input vSysOob2PeArray_T     vSysOob2PeArray                              ,
                  input vSysLane2PeArray_T    vSysLane2PeArray  [`PE_NUM_OF_EXEC_LANES   ] );

        this.Id                            = Id                    ;
        this.mgr2oob                       = mgr2oob               ;
        this.mgr2oob_ack                   = mgr2oob_ack           ;
        this.gen2oob                       = gen2oob               ;
        this.gen2oob_ack                   = gen2oob_ack           ;
        this.vSysOob2PeArray               = vSysOob2PeArray       ;
        this.vSysLane2PeArray              = vSysLane2PeArray      ;
        this.receivedManagerOobPacket      = 0                     ;
        this.receivedGeneratorOobPackets   = 0                     ;
    endfunction

    task run();
        //$display("@%0t:%s:%0d: DEBUG: {%0d,%0d} Running OOB driver : ", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
        

        // OOB process will configure the PE (WIP)

        // oob_driver receives an oob_packet from the manager and oob_packets from each generator.
        // All oob_packets need to be received before the oob_command is driven on the STD but.

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
                            mgr2oob.get(oob_packet_mgr)  ;  //Removing the instruction from manager mailbox
                            $display("@%0t:%s:%0d: INFO:{%0d}: Driving WU via OOB with contents of OOB packet from manager : {%0d,%0d}", $time, `__FILE__, `__LINE__, Id, oob_packet_mgr.Id[0], oob_packet_mgr.Id[1]);
                            oob_packet_mgr.displayPacket();

                            vSysOob2PeArray.cb_test.std__pe__oob_valid        <= 1  ;  // FIXME: temporary drive OOB to non-X
                            vSysOob2PeArray.cb_test.std__pe__oob_cntl         <= `COMMON_STD_INTF_CNTL_SOM_EOM  ;  
                            vSysOob2PeArray.cb_test.sys__pe__allSynchronized  <= 1  ;

                            for (int lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
                                begin
                                    gen2oob.get(oob_packet_gen)  ;  // Removing the instruction from manager mailbox
                                    gen2oob.put(oob_packet_gen)  ;  // we need each packet later
                                    //$display("@%0t:%s:%0d: DEBUG:{%0d}: Driving OOB Lane with contents of OOB packet from generator : {%0d,%0d}", $time, `__FILE__, `__LINE__, Id, oob_packet_gen.Id[0], oob_packet_gen.Id[1]);
                                    //oob_packet_mgr.displayPacket();
                                    tmp_vSysLane2PeArray = vSysLane2PeArray[oob_packet_gen.Id[1]];

                                    tmp_vSysLane2PeArray.cb_test.std__pe__lane_strm0_data_valid  <= 1  ;
                                    tmp_vSysLane2PeArray.cb_test.std__pe__lane_strm0_cntl        <= `COMMON_STD_INTF_CNTL_SOM_EOM  ;         //Passing the instruction to the system interface
                                    tmp_vSysLane2PeArray.cb_test.std__pe__lane_strm0_data        <= 32'hdead_beef  ;
                                    tmp_vSysLane2PeArray.cb_test.std__pe__lane_strm0_data_mask   <= 0  ;
                                    tmp_vSysLane2PeArray.cb_test.std__pe__lane_strm1_data_valid  <= 1  ;
                                    tmp_vSysLane2PeArray.cb_test.std__pe__lane_strm1_cntl        <= `COMMON_STD_INTF_CNTL_SOM_EOM  ;         //Passing the instruction to the system interface
                                    tmp_vSysLane2PeArray.cb_test.std__pe__lane_strm1_data        <= 32'hbabe_cafe  ;
                                    tmp_vSysLane2PeArray.cb_test.std__pe__lane_strm1_data_mask   <= 0  ;

                                end
      

                            // Now quiesce the STD bus by deasserting valid
                            @(vSysOob2PeArray.cb_test);

                            vSysOob2PeArray.cb_test.std__pe__oob_valid        <= 0  ;  // FIXME: temporary drive OOB to non-X
                            for (int lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
                                begin
                                    gen2oob.get(oob_packet_gen)  ;  //Removing the instruction from manager mailbox
                                    //fork
                                        tmp_vSysLane2PeArray = vSysLane2PeArray[oob_packet_gen.Id[1]];
                                        tmp_vSysLane2PeArray.cb_test.std__pe__lane_strm0_data_valid  <= 0  ;
                                        tmp_vSysLane2PeArray.cb_test.std__pe__lane_strm1_data_valid  <= 0  ;
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
                            $display("@%0t:%s:%0d:INFO: {%d} Completed driving OOB", $time, `__FILE__, `__LINE__, Id );
                        end
                    else
                        //----------------------------------------------------------------------
                        // make sure we dont have a zero delay loop
                        begin
                            @(vSysOob2PeArray.cb_test);
                            vSysOob2PeArray.cb_test.std__pe__oob_valid        <= 0  ;  // driver.sv takes care of stream valids
                        end

                end  // forever
    endtask


endclass
