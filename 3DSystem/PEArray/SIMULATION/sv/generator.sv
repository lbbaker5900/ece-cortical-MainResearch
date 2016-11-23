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

        
    integer num_operations = 1;
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

    vSys2PeArray_T vSys2PeArray [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES] ;

    base_operation    sys_operation     ;  // operation packet containing all data associated with operation
    base_operation    sys_operation_gen ;  // operation packet containing all data associated with operation

    function new (
                  input int                   Id[2]             , 
                  input mailbox               gen2drv           ,
                  input event                 gen2drv_ack       ,
                  input event                 new_operation     ,
                  input event                 final_operation   ,
                  input vSys2PeArray_T vSys2PeArray[`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES]
                 );

        this.Id                = Id                 ;
        this.gen2drv           = gen2drv            ;
        this.gen2drv_ack       = gen2drv_ack        ;
        this.new_operation     = new_operation      ;
        this.final_operation   = final_operation    ;
        this.vSys2PeArray      = vSys2PeArray       ;

    endfunction

    task run ();
        //$display("@%0t LEE: Running generator : {%0d,%0d}\n", $time,Id[0], Id[1]);
        // wait a few cycles before starting
        repeat (20) @(vSys2PeArray[Id[0]][Id[1]].cb_test);  
        //$display("@%0t LEE: TEST: {%0d,%0d}\n", $time,Id[0], Id[1]);

        sys_operation_gen = new ();

        repeat (num_operations)                 //Number of transactions to be generated
            begin
                sys_operation = new () ;
                //assert (sys_operation_gen.randomize() );
                sys_operation_gen.randomize() ;
                
                if (sys_operation_gen.OpType == `STREAMING_OP_CNTL_OPERATION_STD_NONE_NOP_TO_MEM )   // NOP
                    begin
                        $display("@%0t LEE: Generating NOP operation: {%0d,%0d}\n", $time,Id[0], Id[1]);
                        sys_operation_gen.create();
                        sys_operation.OpType  =  sys_operation_gen.OpType ;
                        sys_operation.id      = operationNum              ;
                        operationNum++                                    ;
                        gen2drv.put(sys_operation)                        ;
                    end 
                else if(sys_operation_gen.OpType == `STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM )   // NOP
                    begin
                        $display("@%0t LEE: Generating FP MAC operation: {%0d,%0d}\n", $time,Id[0], Id[1]);
                        sys_operation_gen.create();
                        sys_operation.OpType            = sys_operation_gen.OpType            ;
                        sys_operation.id                = operationNum                        ;
                        sys_operation.operandsReal      = sys_operation_gen.operandsReal      ;
                        sys_operation.numberOfOperands  = sys_operation_gen.numberOfOperands  ;
                        sys_operation.operands          = sys_operation_gen.operands          ;
                        sys_operation.result            = sys_operation_gen.result            ;
                        operationNum++                                ;
                        //$display("@%0t LEE: Generating FP MAC operation: {%0d,%0d} with expected result of %f\n", $time,Id[0], Id[1], sys_operation.result);
                        gen2drv.put(sys_operation)                    ;
                    end
                
                // now wait for driver to take our sequence of operations
                //sys_operation.displayOperation();
                @gen2drv_ack;
            end
           
        -> final_operation;
    endtask
endclass



