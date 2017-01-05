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

    mailbox gen2drv          ;
    event   gen2drv_ack      ;
    event   new_operation    ;
    event   final_operation  ;
    int     Id [2]           ; // PE, Lane

    // Drive regFile interface
    // FIXME : should this be in the driver??
    // FIXME: may go away once SIMD and result path is working
    mailbox   gen2rfP         ;
    event     gen2rfP_ack     ;
        
    integer num_operations = 2;
    integer operationNum   = 0;  // used to set operation ID

    //variable to define the timeout in 'wrapup()' task in environment.sv
    integer transaction_timeout = 3000;
    integer timeout_option = 2; 
    //-------------------------------------------------------------------------
    // System random traffic variables
    int dist_type = 13;
    integer systemEventSeed = 166;  // Initial seed, random functions regenerate seed
    real systemEventMean = 47;  // mean
    real systemEventStddev = 13;  // standard deviation
    integer systemEventDeltaTime = 5;  // next time for event as integer
    //-------------------------------------------------------------------------

    vSysOob2PeArray_T    vSysOob2PeArray  ;  // FIXME OOB interface is a per PE i/f where generator is per lane
    vSysLane2PeArray_T   vSysLane2PeArray ;

    base_operation    sys_operation     ;  // operation packet containing all data associated with operation
    base_operation    sys_operation_gen ;  // operation packet containing all data associated with operation

    function new (
                  input int                   Id[2]             , 
                  input mailbox               gen2drv           ,
                  input event                 gen2drv_ack       ,
                  input event                 new_operation     ,
                  input event                 final_operation   ,
                  input vSysOob2PeArray_T     vSysOob2PeArray   ,
                  input vSysLane2PeArray_T    vSysLane2PeArray  ,
                  input mailbox               gen2rfP           ,
                  input event                 gen2rfP_ack       
                 );

        this.Id                = Id                 ;
        this.gen2drv           = gen2drv            ;
        this.gen2drv_ack       = gen2drv_ack        ;
        this.new_operation     = new_operation      ;
        this.final_operation   = final_operation    ;
        this.vSysOob2PeArray   = vSysOob2PeArray    ;
        this.vSysLane2PeArray  = vSysLane2PeArray   ;
        this.gen2rfP           = gen2rfP            ;
        this.gen2rfP_ack       = gen2rfP_ack        ;

    endfunction

    task run ();
        //$display("@%0t LEE: Running generator : {%0d,%0d}\n", $time,Id[0], Id[1]);
        // wait a few cycles before starting
        repeat (20) @(vSysLane2PeArray.cb_test);  
        //$display("@%0t LEE: TEST: {%0d,%0d}\n", $time,Id[0], Id[1]);

        sys_operation_gen = new ();
        sys_operation_gen.Id = Id;  // randomize needs to know which PE and lane

        repeat (num_operations)                 //Number of transactions to be generated
            begin
                //assert (sys_operation_gen.randomize() );
                sys_operation_gen.randomize() ;
                sys_operation_gen.tId      = operationNum             ;
                
                if (sys_operation_gen.OpType == `STREAMING_OP_CNTL_OPERATION_STD_NONE_NOP_TO_MEM )   // NOP
                    begin
                        $display("@%0t : INFO: Generating NOP transfer to memory operation: {%0d,%0d}\n", $time,Id[0], Id[1]);
                        sys_operation_gen.create();
                        sys_operation = new sys_operation_gen ;

                        operationNum++                                ;
                        //$display("@%0t LEE: Setting regFile interface to stOp Controller driver: {%0d,%0d}\n", $time,Id[0], Id[1]);
                        gen2rfP.put(sys_operation)                    ;
                        @gen2rfP_ack                                  ;  // wait for regFile inputs to be driven
                        //$display("@%0t LEE:generator.sv: Generating FP MAC operation to driver: {%0d,%0d} with expected result of %f, %f <> %f : written to address : 0x%6h (0b%24b)\n", $time,Id[0], Id[1], sys_operation.result, sys_operation.resultHigh, sys_operation.resultLow, sys_operation.destinationAddress[0], sys_operation.destinationAddress[0] );
                        gen2drv.put(sys_operation)                    ;
                    end 
                else if(sys_operation_gen.OpType == `STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM )   // NOP
                    begin
                        $display("@%0t : INFO: Generating FP MAC operation: {%0d,%0d}\n", $time,Id[0], Id[1]);
                        sys_operation_gen.create();
                        sys_operation = new sys_operation_gen ;  // copy sys_operation_gen

                        operationNum++                                ;
                        //$display("@%0t LEE: Setting regFile interface to stOp Controller driver: {%0d,%0d}\n", $time,Id[0], Id[1]);
                        gen2rfP.put(sys_operation)                    ;
                        @gen2rfP_ack                                  ;  // wait for regFile inputs to be driven
                        //$display("@%0t LEE:generator.sv: Generating FP MAC operation to driver: {%0d,%0d} with expected result of %f, %f <> %f : written to address : 0x%6h (0b%24b)\n", $time,Id[0], Id[1], sys_operation.result, sys_operation.resultHigh, sys_operation.resultLow, sys_operation.destinationAddress[0], sys_operation.destinationAddress[0] );
                        gen2drv.put(sys_operation)                    ;
                    end
                
                // now wait for driver to take our sequence of operations
                //sys_operation.displayOperation();
                @gen2drv_ack;
            end
           
        //-> final_operation;
    endtask
endclass



