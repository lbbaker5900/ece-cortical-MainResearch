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
        

    //-------------------------------------------------------------------------
    // HOW MANY?
    integer num_operations = 6;  // fp mac:{std,std}->mem, copy:std->mem, fp mac:{std,mem}->mem

   
    // Use multiple of 3 if we want to see std_std_fpmac_mem, std_na_nop_mem, std_mem_fpmac_mem
    // FIXME: if we use a staring opNum that is remainder, the system hangs. This is likely because the first transaction will be a mem_std_fpmac_mem
    // and it assumes a prior operation has loaded memory, but I still dont like it hanging.
    integer operationNum   = 43*3;  // used to set operation ID
                                   // This will be the tag, so start higher to make the tag distinguishable

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

    vDownstreamStackBusOOB_T    vDownstreamStackBusOOB                            ;  // FIXME OOB interface is a per PE i/f where generator is per lane
    vDownstreamStackBusLane_T   vDownstreamStackBusLane  [`PE_NUM_OF_EXEC_LANES]  ;  // manager communicates will lane generators

    base_operation    sys_operation                              ;  // operation packet containing all data associated with operation
    base_operation    sys_operation_mgr                          ;  // operation packet containing all data associated with operation
    base_operation    sys_operation_oob                          ;  // need to make sure OOB oepration matches lane
    base_operation    sys_operation_lane [`PE_NUM_OF_EXEC_LANES] ;  // copy for each lane

    oob_packet       oob_packet_mgr     ;  // constructed from the sys_operation and sent to the OOB driver
    oob_packet       oob_packet_new     ;  // used in OOB process

    // Keep track of previous command
    base_operation    priorOperations[$]; //Queue to hold previous operations

    function new (
                  input int                   Id                                       , 
                  input mailbox               mgr2oob                                  ,
                  input event                 mgr2oob_ack                              ,
                  input mailbox               mgr2gen          [`PE_NUM_OF_EXEC_LANES] ,
                  input event                 mgr2gen_ack      [`PE_NUM_OF_EXEC_LANES] ,
                  //input event                 new_operation                            ,
                  input event                 final_operation                          ,
                  input vDownstreamStackBusOOB_T     vDownstreamStackBusOOB                          ,
                  input vDownstreamStackBusLane_T    vDownstreamStackBusLane [`PE_NUM_OF_EXEC_LANES] ,
                  input mailbox               mgr2up                                      // send operation to upstream checker
                  //input mailbox               mgr2rfP                                  ,
                  //input event                 mgr2rfP_ack       
                 );

        this.Id                     = Id                 ;
        this.mgr2oob                = mgr2oob            ;
        this.mgr2oob_ack            = mgr2oob_ack        ;
        this.mgr2gen                = mgr2gen            ;
        this.mgr2gen_ack            = mgr2gen_ack        ;
        //this.new_operation          = new_operation      ;
        this.final_operation        = final_operation    ;
        this.vDownstreamStackBusOOB        = vDownstreamStackBusOOB    ;
        this.vDownstreamStackBusLane       = vDownstreamStackBusLane   ;
        this.mgr2up                 = mgr2up             ;
        //this.mgr2rfP                = mgr2rfP            ;
        //this.mgr2rfP_ack            = mgr2rfP_ack        ;

    endfunction

    task run ();
        //$display("@%0t:%s:%0d:LEE: Running manager : {%0d}", $time, `__FILE__, `__LINE__, Id);
        // wait a few cycles before starting
        repeat (20) @(vDownstreamStackBusOOB.cb_test);  

        $display("@%0t:%s:%0d:INFO:Manager {%0d} Running operations:%0d", $time, `__FILE__, `__LINE__, Id, num_operations);
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

                //----------------------------------------------------------------------------------------------------
                // Create an oob_packet and send to OOB driver

                // we need to randomize to update fields such as number of operands based on prior operation. 
                // This randomize takes place in the generator when it sends operations to the driver so we should be the same although the OOB
                // only cares about a subset of the fields e.g. doesnt need operands.
                sys_operation_oob = new sys_operation_mgr ;                                                                                 
                sys_operation_oob.setPriorOperations(priorOperations)   ;  // object may need to know what went before
                assert(sys_operation_oob.randomize()) ;  // A previous randomize in the manager will have set the number of operands and addresses, so everything will be randomized except numberOfOperands and address

                // Keep copy of previous operations as they may influence future operations
                // Note: this is also kept in the sys_operation_mgr as we dont create a new for each transaction
                priorOperations.push_back(sys_operation_mgr)       ;

                // send actual base operation to upstream checker 
                mgr2up.put(sys_operation_mgr)                      ; 

                // create the oob_packet object from the operation
                oob_packet_mgr                    = new                      ;  // create a OOB packet constructed from sys_operation
                oob_packet_mgr.createFromOperation(sys_operation_oob.tId, sys_operation_oob)     ;
                mgr2oob.put(oob_packet_mgr)                                  ;  // oob needs to prepare the PE
                $display("@%0t:%s:%0d:LEE: Manager {%0d} sent oob_packet {%0d} to oob_driver", $time, `__FILE__, `__LINE__, Id, operationNum);

                //  The manager sends OOB packet to oob_driver and the same operation to each generator
                //  The oob_driver will get oob information from the generator in case the generator has made changes to the operation
                //  e.g. perhaps we have different operations per lane
                //
                // so we will not get the ack from the oob or geneators until we have sent both the oob-packet and the operations
                // the oob_driver and generator make sure the OOB WU gets sent before operation data

                //----------------------------------------------------------------------------------------------------
                // Create copies of the base_operation and send to each lane generator 

                // send this to all the lane generators for this PE and wait for acknowledge
                        
                $display("@%0t:%s:%0d:LEE: Manager {%0d} sending operation {%0d} to generators and waiting for ack", $time, `__FILE__, `__LINE__, Id, operationNum);
                // include has mgr2gen and mgr2gen_ack
                `include "TB_manager_send_operation_to_generators.vh"
                wait fork;
                // this should have waited till generator, driver and mem_checker are done 

                // wait till OOB packet is complete before startng next operation
                //@mgr2oob_ack ;
                //wait(mgr2oob_ack.triggered) ;
                //
                
                $display("@%0t:%s:%0d:LEE: Manager {%0d} operation {%0d} acked by generators", $time, `__FILE__, `__LINE__, Id, operationNum);

                operationNum++                                ;
                
            end
        // Wait a little time for the last result to be received by the upstream checker
        repeat (50) @(vDownstreamStackBusOOB.cb_test);  


        -> final_operation;
    endtask
endclass



