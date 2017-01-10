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


import virtual_interface::*;
import operation::*;

class manager;

    mailbox mgr2oob                                   ;
    event   mgr2oob_ack                               ;
    mailbox mgr2gen          [`PE_NUM_OF_EXEC_LANES]  ;  // manager communicates will lane generators 
    event   mgr2gen_ack      [`PE_NUM_OF_EXEC_LANES]  ;  // manager communicates will lane generators 
    event   new_operation                             ;
    event   final_operation                           ;
    int     Id                                        ; // PE

    // Drive regFile interface
    // FIXME : should this be in the driver??
    // FIXME: may go away once SIMD and result path is working
    mailbox   mgr2rfP         ;
    event     mgr2rfP_ack     ;
        

    //-------------------------------------------------------------------------
    // HOW MANY?
    integer num_operations = 3;  // fp mac:{std,std}->mem, copy:std->mem, fp mac:{std,mem}->mem


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

    vSysOob2PeArray_T    vSysOob2PeArray                            ;  // FIXME OOB interface is a per PE i/f where generator is per lane
    vSysLane2PeArray_T   vSysLane2PeArray  [`PE_NUM_OF_EXEC_LANES]  ;  // manager communicates will lane generators

    base_operation    sys_operation      ;  // operation packet containing all data associated with operation
    base_operation    sys_operation_mgr  ;  // operation packet containing all data associated with operation
    base_operation    sys_operation_lane ;  // copy for each lane

    // Keep track of previous command
    base_operation    priorOperations[$]; //Queue to hold previous operations

    function new (
                  input int                   Id                                       , 
                  input mailbox               mgr2gen          [`PE_NUM_OF_EXEC_LANES] ,
                  input event                 mgr2gen_ack      [`PE_NUM_OF_EXEC_LANES] ,
                  //input event                 new_operation                            ,
                  //input event                 final_operation                          ,
                  input vSysOob2PeArray_T     vSysOob2PeArray                          ,
                  input vSysLane2PeArray_T    vSysLane2PeArray [`PE_NUM_OF_EXEC_LANES] 
                  //input mailbox               mgr2rfP                                  ,
                  //input event                 mgr2rfP_ack       
                 );

        this.Id                = Id                 ;
        this.mgr2gen           = mgr2gen            ;
        this.mgr2gen_ack       = mgr2gen_ack        ;
        //this.new_operation     = new_operation      ;
        //this.final_operation   = final_operation    ;
        this.vSysOob2PeArray   = vSysOob2PeArray    ;
        this.vSysLane2PeArray  = vSysLane2PeArray   ;
        //this.mgr2rfP           = mgr2rfP            ;
        //this.mgr2rfP_ack       = mgr2rfP_ack        ;

    endfunction

    task run ();
        //$display("@%0t:%s:%0d:LEE: Running manager : {%0d}\n", $time, `__FILE__, `__LINE__, Id);
        // wait a few cycles before starting
        repeat (20) @(vSysOob2PeArray.cb_test);  

        repeat (num_operations)                 //Number of transactions to be generated
            begin
                // Create a base operation and send the generator which will then spawn further operations for each lane.
                // The generator will maintain operation type and number of operands for all lanes but will randomize operands.
                sys_operation_mgr        =  new ()  ;  // seed operation object.  Generators will copy this and then re-create different operand values
                sys_operation_mgr.Id[0]  =  Id      ;  // Id in manager is only PE
                sys_operation_mgr.Id[1]  =  0       ;  // set to lane 0 to avoid error in randomize

                // FIXME: currently the operation class decides what type of operation based on transaction ID
                sys_operation_mgr.tId      = operationNum             ;

                // create new operation
                assert(sys_operation_mgr.randomize()) ;

                // Keep copy of previous operations as they may influence future operations
                // Note: this is also kept in the sys_operation_mgr as we dont create a new for each transaction
                priorOperations.push_back(sys_operation_mgr)       ;

                // send this to all the lane generators for this PE
                for (int lane=0; lane < `PE_NUM_OF_EXEC_LANES; lane++)
                    begin
                        sys_operation_lane = new sys_operation_mgr ;
                        sys_operation_lane.Id[1]  =  lane      ;  // set lane for address generation
                        // Send to driver
                        //$display("@%0t:%s:%0d:LEE: sys_operation_mgr : {%0d,%0d}:%h\n", $time, `__FILE__, `__LINE__, Id, lane, sys_operation_mgr);
                        mgr2gen[lane].put(sys_operation_lane)                    ;
                        // now wait for generator
                        //sys_operation.displayOperation();
                        //@mgr2gen_ack[lane];
                    
                    end
                operationNum++                                ;

/*  FIXME: will manager will set lane regFiles as this is an OOB operation
                if (sys_operation_gen.OpType == `STREAMING_OP_CNTL_OPERATION_STD_NONE_NOP_TO_MEM )   // NOP
                    begin
                        $display("@%0t :%s:%0d: INFO: Generating NOP transfer to memory operation: {%0d,%0d}\n", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
                        sys_operation_gen.create();
                        sys_operation = new sys_operation_gen ;  // create new operation and copy sys_operation_gen

                        operationNum++                                ;
                        //$display("@%0t LEE: Setting regFile interface to stOp Controller driver: {%0d,%0d}\n", $time,Id[0], Id[1]);
                        mgr2rfP.put(sys_operation)                    ;
                        @mgr2rfP_ack                                  ;  // wait for regFile inputs to be driven
                        //$display("@%0t:%s:%0d: LEE:generator.sv: Generating STD to memory copy operation to driver: {%0d,%0d} : starting at address %h: \n", $time, `__FILE__, `__LINE__, Id[0], Id[1], sys_operation.destinationAddress[0] );
                    end 

                else if(sys_operation_gen.OpType == `STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM )   // NOP
                    begin
                        $display("@%0t:%s:%0d: : INFO: Generating FP MAC operation: {%0d,%0d}\n", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
                        sys_operation_gen.create();
                        sys_operation = new sys_operation_gen ;  // create new operation and copy sys_operation_gen

                        operationNum++                                ;
                        //$display("@%0t LEE: Setting regFile interface to stOp Controller driver: {%0d,%0d}\n", $time,Id[0], Id[1]);
                        mgr2rfP.put(sys_operation)                    ;
                        @mgr2rfP_ack                                  ;  // wait for regFile inputs to be driven
                        //$display("@%0t:%s:%0d: LEE:generator.sv: Generating FP MAC operation to driver: {%0d,%0d} with expected result of %f, %f <> %f : written to address : 0x%6h (0b%24b)\n", $time, `__FILE__, `__LINE__, Id[0], Id[1], sys_operation.result, sys_operation.resultHigh, sys_operation.resultLow, sys_operation.destinationAddress[0], sys_operation.destinationAddress[0] );
                    end
                
                else if(sys_operation_gen.OpType == `STREAMING_OP_CNTL_OPERATION_MEM_STD_FP_MAC_TO_MEM )  
                    begin
                        $display("@%0t:%s:%0d: : INFO: Generating FP MAC operation: {%0d,%0d}\n", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
                        sys_operation_gen.create();
                        sys_operation = new sys_operation_gen ;  // create new operation and copy sys_operation_gen

                        operationNum++                                ;
                        //$display("@%0t LEE: Setting regFile interface to stOp Controller driver: {%0d,%0d}\n", $time,Id[0], Id[1]);
                        mgr2rfP.put(sys_operation)                    ;
                        @mgr2rfP_ack                                  ;  // wait for regFile inputs to be driven
                        //$display("@%0t:%s:%0d: LEE:generator.sv: Generating FP MAC operation to driver: {%0d,%0d} with expected result of %f, %f <> %f : written to address : 0x%6h (0b%24b)\n", $time, `__FILE__, `__LINE__, Id[0], Id[1], sys_operation.result, sys_operation.resultHigh, sys_operation.resultLow, sys_operation.destinationAddress[0], sys_operation.destinationAddress[0] );
                    end
*/
                
                
            end
           
        //-> final_operation;
    endtask
endclass



