/*********************************************************************************************
    File name   : generator.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Nov 2016
    Email       : lbbaker@ncsu.edu
    
    Description : This file contains the operation generator for the PE.
                  It can generate X types of instructions, which it passes to the driver via
                  a mailbox
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


import virtual_interface::*;
import operation::*;

class generator;

    //----------------------------------------------------------------------------------------------------
    // generator gets the seed operation from the manager
    mailbox mgr2gen          ;
    event   mgr2gen_ack      ;

    //----------------------------------------------------------------------------------------------------
    // generator randomizes addresses and sends changes to OOB
    mailbox gen2oob          ;
    event   gen2oob_ack      ;

    //----------------------------------------------------------------------------------------------------
    // send lane data to driver to drive stack bus
    mailbox gen2drv          ;
    event   gen2drv_ack      ;

    //----------------------------------------------------------------------------------------------------
    // send lane data to dram checker to check dram contents at the end of the
    // test to drive stack bus
    mailbox gen2dramck          ;

    //----------------------------------------------------------------------------------------------------
    //  Generator sends operation to Upstream checker for value check

    mailbox gen2up                                   ;

    //----------------------------------------------------------------------------------------------------
    event   new_operation    ;
    int     Id [2]           ; // PE, Lane

    //----------------------------------------------------------------------------------------------------
    // Generator sends packet to regFile driver so each regFile lane can drive the streamingOps_cntl signals
    // Drive regFile interface
    mailbox   gen2rfP         ;
    event     gen2rfP_ack     ;
        

    //----------------------------------------------------------------------------------------------------
    // Give each operationan ID
    integer operationNum   = 0;  // used to set operation ID



    //----------------------------------------------------------------------------------------------------
    // Interfaces

    vDownstreamStackBusOOB_T    vDownstreamStackBusOOB  ;  // FIXME OOB interface is a per PE i/f where generator is per lane
    vDownstreamStackBusLane_T   vDownstreamStackBusLane [`PE_NUM_OF_STREAMS] ;

    //----------------------------------------------------------------------------------------------------
    // Operation objects

    base_operation    sys_operation     ;  // operation packet containing all data associated with operation
    base_operation    sys_operation_mgr ;  // seed operation packet from manager
    base_operation    sys_operation_gen ;  // operation packet modified from manager operation for this lane
    oob_packet        oob_packet_new    ;

    // Keep track of previous command
    base_operation    priorOperations[$]               ; //Queue to hold previous operations
    base_operation    priorOperation                   ; // operation object copy of previous operations
    int               priorOperationNumberOfOperands   ;  // SV wont let me reference priorOperations as it might be null, so only reference priorOperations in post_randomize

    base_operation    lane_op                          ; 

    //----------------------------------------------------------------------------------------------------
    // 

    function new (
    input int                          Id                        [ 2]                  , 
    input mailbox                      mgr2gen                                         , 
    input event                        mgr2gen_ack                                     , 
    input mailbox                      gen2drv                                         , 
    input event                        gen2drv_ack                                     , 
    input mailbox                      gen2oob                                         , 
    input event                        gen2oob_ack                                     , 
    input mailbox                      gen2dramck                                      , 
    input event                        new_operation                                   , 
    input vDownstreamStackBusOOB_T     vDownstreamStackBusOOB                          , 
    input vDownstreamStackBusLane_T    vDownstreamStackBusLane   [ `PE_NUM_OF_STREAMS] , 
    input mailbox                      gen2rfP                                         , 
    input event                        gen2rfP_ack                                     , 
    input mailbox                      gen2up                                           
                 );

        this.Id                      = Id                      ; 
        this.mgr2gen                 = mgr2gen                 ; 
        this.mgr2gen_ack             = mgr2gen_ack             ; 
        this.gen2drv                 = gen2drv                 ; 
        this.gen2drv_ack             = gen2drv_ack             ; 
        this.gen2oob                 = gen2oob                 ; 
        this.gen2oob_ack             = gen2oob_ack             ; 
        this.gen2dramck              = gen2dramck              ; 
        this.new_operation           = new_operation           ; 
        this.vDownstreamStackBusOOB  = vDownstreamStackBusOOB  ; 
        this.vDownstreamStackBusLane = vDownstreamStackBusLane ; 
        this.gen2rfP                 = gen2rfP                 ; 
        this.gen2rfP_ack             = gen2rfP_ack             ; 
        this.gen2up                  = gen2up                  ; 

    endfunction

    //----------------------------------------------------------------------------------------------------
    // RUN

    task run ();
        //$display("@%0t:%s:%0d: INFO: Running generator : {%0d,%0d}", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
        // wait a few cycles before starting

        sys_operation_gen        =  new ()  ;  // copy of operation gcreated in manager, Generator re-creates different operand values
        sys_operation_gen.Id     =  Id      ;  // randomize needs to know which PE and lane

        repeat (20) @(vDownstreamStackBusOOB.cb_test);  

        forever
            begin
                @(vDownstreamStackBusOOB.cb_test);  
                if ( mgr2gen.num() != 0 )
                    begin
                        mgr2gen.peek(sys_operation_gen);   //Taking the instruction from the manager
                        mgr2gen.get(sys_operation_gen)  ;  //Removing the instruction from manager mailbox
                        $display("@%0t:%s:%0d:INFO:Received operation from manager: {%0d,%0d}:%h", $time, `__FILE__, `__LINE__, Id[0], Id[1], sys_operation_gen);
                        
                        // Create a base operation and all operation sent to driver will be copies of this
                        // This allows us to keep track of what has been generated
                     
                        //sys_operation_gen             =  new sys_operation_mgr  ;  // seed object. Dont use directly as all lanes will use the same operation
                        sys_operation_gen.setPriorOperations(priorOperations)   ;  // object may need to know what went before

/*
                        // DEBUG
                        $display("@%0t:%s:%0d:INFO:DEBUG:{%0d,%0d}", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
                        sys_operation_gen.displayOperation(`__FILE__, `__LINE__);

                        if ((Id[0]  == 63) && (Id[1] == 0) && (priorOperations.size > 0))
                            priorOperations[$].displayOperation();
                        else if ((Id[0]  == 63) && (Id[1] == 0))
                            $display("@%0t:%s:%0d:INFO:DEBUG:No prior operation:{%0d,%0d}", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
*/
/*
                        // randomize again to create operand values
                        sys_operation_gen.c_operationType_definedOrder .constraint_mode(0) ;
                        sys_operation_gen.c_operationType_all          .constraint_mode(0) ;
                        sys_operation_gen.c_operationType_fpMac        .constraint_mode(1) ;
                        sys_operation_gen.c_operationType_copyStdToMem .constraint_mode(0) ;
                        //
                        sys_operation_gen.c_streamSize.constraint_mode(1)                 ;
                        sys_operation_gen.c_operandValues.constraint_mode(1)              ;
                        sys_operation_gen.c_memoryLocalized.constraint_mode(1)            ;
                        //
                        assert(sys_operation_gen.randomize()) ;  // A previous randomize in the manager will have set the number of operands and addresses, so everything will be randomized except numberOfOperands and address
*/
                       
                        
                        if (sys_operation_gen.OpType == `STREAMING_OP_CNTL_OPERATION_STD_NONE_NOP_TO_MEM )   // NOP
                            begin
                                $display("@%0t :%s:%0d: INFO: Generating NOP transfer to memory operation: {%0d,%0d}", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
                            end 
                        else if(sys_operation_gen.OpType == `STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM )   // NOP
                            begin
                                $display("@%0t:%s:%0d: : INFO: Generating FP MAC operation: {%0d,%0d}", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
                            end
                        
                        else if(sys_operation_gen.OpType == `STREAMING_OP_CNTL_OPERATION_MEM_STD_FP_MAC_TO_MEM )  
                            begin
                                $display("@%0t:%s:%0d: : INFO: Generating FP MAC operation: {%0d,%0d}", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
                            end

                        sys_operation_gen.create();
                        sys_operation = new sys_operation_gen ;  // create new operation and copy sys_operation_gen
                        oob_packet_new = new                                 ;
                        oob_packet_new.createFromOperation(0, sys_operation) ;

                        gen2oob.put(oob_packet_new)                          ;
                        // Why wait
                        //@gen2oob_ack                                         ;  // wait for OOB

                        //----------------------------------------------------------------------------------------------------
                        // Configure streamingCntl

                        // FIXME: wont be needed once STD OOB is complete

                        gen2rfP.put(oob_packet_new)                          ;  // OOB WU packet has been driven, now set regFile inputs
                        wait(gen2rfP_ack.triggered)                          ;  // wait for regFile inputs to be driven
                        $display("@%0t:%s:%0d:INFO:{%0d,%0d} regFile driven", $time, `__FILE__, `__LINE__, Id[0], Id[1]);

                        //----------------------------------------------------------------------------------------------------
/*
                        $display("@%0t:%s:%0d:INFO:DEBUG:{%0d,%0d}", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
                        //if ((Id[0]  == 63) && (Id[1] == 0) )
                        sys_operation.displayOperationFoo(`__FILE__, `__LINE__);
*/

                        sys_operation.clearPriors();  // avoid nested pointers as we dont need here
                        priorOperations.push_back(sys_operation)                       ;  

                        // send actual operation with expected result to upstream checker 
                        $display("@%0t:%s:%0d:INFO:{%0d,%0d} Send operation to upstream checker", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
                        gen2up.put(sys_operation)                      ; 

                        //----------------------------------------------------------------------------------------------------
                        // Stack Downstream Bus drive

                        // Send operands to PE/Lanes

                        // Send to driver
                        $display("@%0t:%s:%0d:INFO:{%0d,%0d} Send operation to driver", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
                        `ifdef TB_VERBOSITY_HIGH
                          sys_operation.displayOperation();
                        `endif
                        gen2drv.put(sys_operation)                    ;

                        // Send operation to memory result checker
                        lane_op        =  new ();
                        lane_op = sys_operation.copy() ; // deep copy creates new operand arrays                                      
                        //lane_op.lane   = Id[1]     ; // tell result checker which lane this operation was sent to
                        gen2dramck.put(lane_op)                    ;

                        // now wait for driver to take our sequence of operations
                        //sys_operation.displayOperation();
                        //@gen2drv_ack;
                        $display("@%0t:%s:%0d:INFO:{%0d,%0d} Wait for driver ack", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
                        wait(gen2drv_ack.triggered);
                        $display("@%0t:%s:%0d:INFO:{%0d,%0d} Driver has acked", $time, `__FILE__, `__LINE__, Id[0], Id[1]);


                        //----------------------------------------------------------------------------------------------------
                        // Keep copy of previous operations as they may influence future operations
                        priorOperations.push_back(sys_operation)       ;  // FIXME: do we need a queue in the base_operation??

                        //----------------------------------------------------------------------------------------------------
                        // Acknowledge manager that operation is complete
                        -> mgr2gen_ack;
                        $display("@%0t:%s:%0d:INFO:{%0d,%0d} Generator acked manager", $time, `__FILE__, `__LINE__, Id[0], Id[1]);

                    end // if ( mgr2gen.num() != 0 )
            end  // forever
                

    endtask
endclass



