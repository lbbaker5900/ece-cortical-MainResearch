/*********************************************************************************************
    File name   : driver.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Nov 2016
    Email       : lbbaker@ncsu.edu
    
    Description : This file contains the driver, i.e. it takes the operation from the generator
                  and drives it through the stack interface. 
                  It also performs the function
                  of tracking the ready signal to the system from the PE.
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

class driver;
    int       Id [2]                   ; // PE, Lane, Stream
    mailbox   gen2drv                  ;
    event     gen2drv_ack              ;
    event     new_operation            ;

    mailbox   drv2lane         []      ;  // create a mailbox for each stream driver
    int       transaction      []      ;
    logic     streamEnabled    []      ;  // used to enable the stream driver process

    // observe memory interface to check result
    // FIXME: may go away once SIMD and result path is working
    mailbox   drv2memP         ;
    event     drv2memP_ack     ;

    base_operation   sys_operation      ;
//    oob_packet       oob_packet_gen     ;  // constructed from the sys_operation and sent to the OOB process 
//    oob_packet       oob_packet_new     ;  // used in OOB process
    stream_operation tmp_strm_operation ;
    stream_operation strm_operation [] ;

    event strm_ack [`PE_NUM_OF_STREAMS  ]  ;

    // FIXME : doesnt need all interfaces
    vDownstreamStackBusOOB_T  vDownstreamStackBusOOB  ;  // FIXME: OOB is a per PE interface but we have driver objects for all PE/Lanes
    vDownstreamStackBusLane_T vDownstreamStackBusLane [`PE_NUM_OF_STREAMS] ;

    function new (
                  input int                  Id[2]              ,
                  input mailbox              gen2drv            ,                  //Retrieving mailboxes and virtual system interface.
                  input event                gen2drv_ack        ,
                  input event                new_operation      ,
                  input vDownstreamStackBusOOB_T    vDownstreamStackBusOOB    ,
                  input vDownstreamStackBusLane_T   vDownstreamStackBusLane [`PE_NUM_OF_STREAMS] ,
                  input mailbox              drv2memP           ,
                  input event                drv2memP_ack       );

        this.Id                  = Id                         ;
        this.gen2drv             = gen2drv                    ;
        this.gen2drv_ack         = gen2drv_ack                ;
        this.new_operation       = new_operation              ;
        this.vDownstreamStackBusOOB     = vDownstreamStackBusOOB            ;
        this.vDownstreamStackBusLane    = vDownstreamStackBusLane           ;
        this.drv2memP            = drv2memP                   ;
        this.drv2memP_ack        = drv2memP_ack               ;
        this.drv2lane            = new[`PE_NUM_OF_STREAMS  ]  ;
        for (int i=0; i<drv2lane.size(); i++)
            begin
                this.drv2lane[i]            = new             ;
            end
        this.strm_operation      = new[`PE_NUM_OF_STREAMS  ]  ;
        this.transaction         = new[`PE_NUM_OF_STREAMS  ]  ;
        this.streamEnabled       = new[`PE_NUM_OF_STREAMS  ]  ;
        //for (int i=0; i<transaction.size(); i++)
        //    begin
        //        this.transaction[i]   = new(0)                ;
        //    end
    endfunction

    task run();
        //$display("@%0t:%s:%0d:DEBUG:{%0d,%0d} Running driver ", $time, `__FILE__, `__LINE__, Id[0], Id[1]);

        // Spawn 4 processes:
        // - first receives operations from the generator and splits it into two stream operations
        // - an OOB process will configure the PE (WIP)
        // - the other two look for the stream operation from the first process and drive it onto there corresponding stream 
        forever
            begin
                // take the transaction from the generator, splits it into two streams and sends a stream operation to both the processes
                // and send the sys_operation to the OOB process
                @(vDownstreamStackBusLane[0].cb_test);
                //$display("@%0t:%s:%0d:DEBUG {%0d,%0d} Check mailbox", $time, `__FILE__, `__LINE__, Id[0], Id[1] );
                if ( gen2drv.num() != 0 )
                    begin
                        $display("@%0t:%s:%0d:DEBUG {%0d,%0d} received system trans from generator with %0d in queue", $time, `__FILE__, `__LINE__, Id[0], Id[1], gen2drv.num() );
                        gen2drv.peek(sys_operation);                                                //Taking the instruction from generator 
                        //$display("@%0t:%s:%0d:DEBUG {%0d} ", $time, `__FILE__, `__LINE__, sys_operation.id);
                        //$display("@%0t:%s:%0d:DEBUG {%0d} ", $time, `__FILE__, `__LINE__, strm_operation[1].id);
                        // Test if this lane is utilized
                        if (Id[1] < sys_operation.numberOfLanes) 
                          begin
                            $display("@%0t:%s:%0d:DEBUG {%0d,%0d} Lane is being utilized", $time, `__FILE__, `__LINE__, Id[0], Id[1] );
                            
                            //----------------------------------------------------------------------------------------------------
                            // prime the memory checker
                            
                            // put operations into golden mailbox
                            drv2memP.put(sys_operation) ;  //Putting the instruction into the golden model mailbox                                              
                            $display("@%0t:%s:%0d:DEBUG:{%0d,%0d} Send operation to mem_checker with expected result of %f, %f <> %f", $time, `__FILE__, `__LINE__, Id[0], Id[1], sys_operation.result, sys_operation.resultHigh, sys_operation.resultLow, );
                            sys_operation.displayOperation();
                            
                            gen2drv.get(sys_operation)  ;  //Removing the instruction from generator mailbox
                            `ifdef TB_DRIVES_STACK_DOWN_DATA
                              //----------------------------------------------------------------------------------------------------
                              // Start driving the operand
                            
                              
                              // create stream objects and send to mailboxes for processes driving downstream stream stack bus
                              // Note: the processes havent started yet
                            
                              // Default is streams are disabled.
                              streamEnabled[0] =  0;
                              streamEnabled[1] =  0;
                              for (int i=0; i<sys_operation.stOp_operation.numberOfSrcStreams; i++)
                                  begin
                                      if (sys_operation.pe_stOp_stream_src [i] == PE_STOP_SRC_IS_STD ) 
                                          begin
                                              // enable the stream process
                                              streamEnabled[i]                      = 1                                                              ;
                                              tmp_strm_operation                    = new                                                            ;
                                              tmp_strm_operation.tId                = sys_operation.tId                                              ;
                                              tmp_strm_operation.operands           = new[sys_operation.numberOfOperands](sys_operation.operands[i]) ;
                                              tmp_strm_operation.numberOfOperands   = sys_operation.numberOfOperands                                 ;
                                              //tmp_strm_operation.operands         = sys_operation.operands[i]                                      ;
                                              drv2lane[i].put(tmp_strm_operation)                                                                    ;
                                              $display("@%0t:%s:%0d:DEBUG:{%0d,%0d} Passed to stream driver %0d", $time, `__FILE__, `__LINE__, Id[0], Id[1], i );
                                          end
                                      else
                                          begin
                                              // disable the stream process. Process will spawn but then finish immediately
                                              $display("@%0t:%s:%0d:DEBUG:{%0d,%0d} Disabled stream driver %0d", $time, `__FILE__, `__LINE__, Id[0], Id[1], i );
                                              streamEnabled[i] = 0 ;
                                              //sys_operation.displayOperation();
                                          end
                                  end
                            
                              // DEBUG
                              //streamEnabled[0] = (sys_operation.pe_stOp_stream_src [0] == PE_STOP_SRC_IS_STD ) ? 1 : 0;
                              //streamEnabled[1] = (sys_operation.pe_stOp_stream_src [1] == PE_STOP_SRC_IS_STD ) ? 1 : 0;
                              // DEBUG END
                              $display("@%0t:%s:%0d:DEBUG {%0d,%0d} Passed to stream drivers with enables {%0d,%0d}", $time, `__FILE__, `__LINE__, Id[0], Id[1], streamEnabled[0], streamEnabled[1]);
                            `endif
                                                
                            //----------------------------------------------------------------------------------------------------
                            // Operand data is in the stream mailboxes
                            // 
                            // Now start three processes:
                            //     a) waiting for the memory checkers
                            //     b) waiting for the stream drivers
                            // all have to complete
                            
                            //----------------------------------------------------------------------------------------------------
                            // Processes
                            
                            fork
                                //----------------------------------------------------------------------------------------------------
                                // Start waiting for mem_checker
                            
                                begin:wait_for_memory_checker
                                    $display("@%0t:%s:%0d:DEBUG: {%0d,%0d} waiting for mem_checker", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
                                    @drv2memP_ack               ;  // mem_checker only ack's once memory access(s) are complete, good or bad.
                                    $display("@%0t:%s:%0d:DEBUG: {%0d,%0d} received mem_checker ack", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
                                end
                                 
                                `ifdef TB_DRIVES_STACK_DOWN_DATA
                                  //----------------------------------------------------------------------------------------------------
                                  // Wait for streams that are driving
                                  // FIXME - not sure we need these two processes
                                  begin
                                      $display("@%0t:%s:%0d:DEBUG: {%0d,%0d} waiting for stream %0d", $time, `__FILE__, `__LINE__, Id[0], Id[1], 0 );
                                      if (streamEnabled[0])
                                          wait(strm_ack[0].triggered);
                                      //@(strm_ack[0]);
                                      $display("@%0t :%s:%0d:DEBUG: {%0d,%0d} stream %0d complete", $time, `__FILE__, `__LINE__, Id[0], Id[1], 0 );
                                  end
                                  begin
                                      $display("@%0t:%s:%0d:DEBUG: {%0d,%0d} waiting for stream %0d", $time, `__FILE__, `__LINE__, Id[0], Id[1], 1 );
                                      if (streamEnabled[1])
                                          wait(strm_ack[1].triggered);
                                      //@(strm_ack[1]);
                                      $display("@%0t :%s:%0d:DEBUG: {%0d,%0d} stream %0d complete", $time, `__FILE__, `__LINE__, Id[0], Id[1], 1 );
                                  end
                            
                                //----------------------------------------------------------------------------------------------------
                                // Stream 0
                            
                                // FIXME : should use generate for the two following processes, but need to separate streams into separate interfaces so they can be indexed
                                // dont think a generate can be put inside a class or task
                                begin
                                    transaction[0] = 0 ;
                                    while ((transaction[0] == 0) && (streamEnabled[0] == 1))
                                        begin
                                            $display("@%0t:%s:%0d:DEBUG:{%0d,%0d} Running stream 0 process while loop", $time, `__FILE__, `__LINE__, Id[0], Id[1] );
                                            if ( drv2lane[0].num() != 0 )
                                                begin
                                                    drv2lane[0].peek(strm_operation[0]);                                                //Taking the instruction from generator 
                                                    $display("@%0t:%s:%0d:DEBUG:{%0d,%0d} Received stream 0 operation", $time, `__FILE__, `__LINE__, Id[0], Id[1] );
                                                    while (transaction[0] < strm_operation[0].numberOfOperands)
                                                        begin
                                                            @(vDownstreamStackBusLane[0].cb_test);
                                                        
                                                            if (vDownstreamStackBusLane[0].pe__std__lane_strm_ready) 
                                                                begin
                                                                    //$display("@%0t:%s:%0d:DEBUG: {%d,%d} Drive stream 0 valid", $time, `__FILE__, `__LINE__, Id[0], Id[1] );
                                                                    vDownstreamStackBusLane[0].cb_test.std__pe__lane_strm_data_valid  <= 1  ;
                                                                    vDownstreamStackBusLane[0].cb_test.std__pe__lane_strm_cntl        <= ((transaction[0] == 0) && (transaction[0] == (strm_operation[0].numberOfOperands-1))) ?  `COMMON_STD_INTF_CNTL_SOM_EOM     :
                                                                                                                                ( transaction[0] == 0                                                               ) ?  `COMMON_STD_INTF_CNTL_SOM         :
                                                                                                                                ( transaction[0] == (strm_operation[0].numberOfOperands-1)                          ) ?  `COMMON_STD_INTF_CNTL_EOM         :
                                                                                                                                                                                                                         `COMMON_STD_INTF_CNTL_MOM         ;
                                                                    //if ((Id[0]==0)&&(Id[1]==0))
                                                                    //$display("%s:%0d:DEBUG: operand%d , %h", `__FILE__, `__LINE__, transaction[0], strm_operation[0].operands[transaction[0]] ) ;
                                                                    vDownstreamStackBusLane[0].cb_test.std__pe__lane_strm_data        <= strm_operation[0].operands[transaction[0]]  ;
                                                                    
                                                                    transaction[0] = transaction[0] + 1;
                                                                    
                                                                end
                                                            else
                                                                begin
                                                                    //$display("@%0t:%s:%0d:DEBUG: {%d,%d} stream 0 flow controlled", $time, `__FILE__, `__LINE__, Id[0], Id[1] );
                                                                    vDownstreamStackBusLane[0].cb_test.std__pe__lane_strm_data_valid  <= 0  ;
                                                                    vDownstreamStackBusLane[0].cb_test.std__pe__lane_strm_cntl        <= 0  ;         //Passing the instruction to the system interface
                                                                    vDownstreamStackBusLane[0].cb_test.std__pe__lane_strm_data        <= 0  ;
                                                                end
                                                        end  //while (transaction[0] < strm_operation[0].numberOfOperands)
                                                        @(vDownstreamStackBusLane[0].cb_test);
                                                        vDownstreamStackBusLane[0].cb_test.std__pe__lane_strm_data_valid  <= 0  ;
                            
                                                end  //if ( drv2lane[0].num() != 0 )
                                            else
                                                // while we are waiting for the strm_operation, quiesce the bus
                                                begin 
                                                    @(vDownstreamStackBusLane[0].cb_test);
                                                    vDownstreamStackBusLane[0].cb_test.std__pe__lane_strm_data_valid  <= 0  ;
                                                end   //if ( drv2lane[0].num() != 0 )
                               
                                            drv2lane[0].get(strm_operation[0])  ;  //Removing the instruction from generator mailbox
                                                    
                                            // processed sequence, acknowledge generator for new sequence
                                            if (streamEnabled[0])  // FIXME: it is enabled if it is here
                                                begin
                                                    // only send message if stream did something
                                                    $display("@%0t:%s:%0d:INFO:{%0d,%0d} Completed driving stream 0 sequence", $time, `__FILE__, `__LINE__, Id[0], Id[1] );
                                                end
                                            ->strm_ack[0];
                                        end  // while (transaction[0] == 0) 
                                    $display("@%0t:%s:%0d:INFO:{%0d,%0d} Completed stream 0 process", $time, `__FILE__, `__LINE__, Id[0], Id[1] );
                                end
                            
                                //----------------------------------------------------------------------------------------------------
                                // Stream 1
                            
                                // FIXME : should use generate for the two following processes, but need to separate streams into separate interfaces so they can be indexed
                                // dont think a generate can be put inside a class or task
                                begin
                                    transaction[1] = 0 ;
                                    while ((transaction[1] == 0) && (streamEnabled[1] == 1))
                                        begin
                                            $display("@%0t:%s:%0d:DEBUG:{%0d,%0d} Running stream 1 process while loop", $time, `__FILE__, `__LINE__, Id[0], Id[1] );
                                            if ( drv2lane[1].num() != 0 )
                                                begin
                                                    drv2lane[1].peek(strm_operation[1]);                                                //Taking the instruction from generator 
                                                    $display("@%0t:%s:%0d:DEBUG:{%0d,%0d} Received stream 1 operation", $time, `__FILE__, `__LINE__, Id[0], Id[1] );
                                                    while (transaction[1] < strm_operation[1].numberOfOperands)
                                                        begin
                                                            @(vDownstreamStackBusLane[1].cb_test);
                                                        
                                                            if (vDownstreamStackBusLane[1].pe__std__lane_strm_ready) 
                                                                begin
                                                                    //$display("@%0t:%s:%0d:DEBUG: {%d,%d} Drive stream 1 valid", $time, `__FILE__, `__LINE__, Id[0], Id[1] );
                                                                    vDownstreamStackBusLane[1].cb_test.std__pe__lane_strm_data_valid  <= 1  ;
                                                                    vDownstreamStackBusLane[1].cb_test.std__pe__lane_strm_cntl        <= ((transaction[1] == 0) && (transaction[1] == (strm_operation[1].numberOfOperands-1))) ?  `COMMON_STD_INTF_CNTL_SOM_EOM     :
                                                                                                                                ( transaction[1] == 0                                                               ) ?  `COMMON_STD_INTF_CNTL_SOM         :
                                                                                                                                ( transaction[1] == (strm_operation[1].numberOfOperands-1)                          ) ?  `COMMON_STD_INTF_CNTL_EOM         :
                                                                                                                                                                                                                         `COMMON_STD_INTF_CNTL_MOM         ;
                                                                    //if ((Id[0]==0)&&(Id[1]==0))
                                                                    //    $display("%s:%0d:DEBUG: operand%d , %h", `__FILE__, `__LINE__, transaction[1], strm_operation[1].operands[transaction[1]] ) ;
                                                                    vDownstreamStackBusLane[1].cb_test.std__pe__lane_strm_data        <= strm_operation[1].operands[transaction[1]]  ;
                                                                    
                                                                    transaction[1] = transaction[1] + 1;
                                                                    
                                                                end
                                                            else
                                                                begin
                                                                    //$display("@%0t:%s:%0d:DEBUG: {%d,%d} stream 1 flow controlled", $time, `__FILE__, `__LINE__, Id[0], Id[1] );
                                                                    vDownstreamStackBusLane[1].cb_test.std__pe__lane_strm_data_valid  <= 0  ;
                                                                    vDownstreamStackBusLane[1].cb_test.std__pe__lane_strm_cntl        <= 0  ;         //Passing the instruction to the system interface
                                                                    vDownstreamStackBusLane[1].cb_test.std__pe__lane_strm_data        <= 0  ;
                                                                end
                                                        end  //while (transaction[1] < strm_operation[1].numberOfOperands)
                                                        @(vDownstreamStackBusLane[1].cb_test);
                                                        vDownstreamStackBusLane[1].cb_test.std__pe__lane_strm_data_valid  <= 0  ;
                                                end  //if ( drv2lane[1].num() != 0 )
                                            else
                                                // while we are waiting for the strm_operation, quiesce the bus
                                                begin 
                                                    @(vDownstreamStackBusLane[1].cb_test);
                                                    vDownstreamStackBusLane[1].cb_test.std__pe__lane_strm_data_valid  <= 0  ;
                                                end   //if ( drv2lane[1].num() != 0 )
                               
                                            drv2lane[1].get(strm_operation[1])  ;  //Removing the instruction from generator mailbox
                                                    
                                            // processed sequence, acknowledge generator for new sequence
                                            if (streamEnabled[1])  // FIXME: it is enabled if it is here
                                                begin
                                                    // only send message if stream did something
                                                    $display("@%0t:%s:%0d:INFO:{%0d,%0d} Completed driving stream 1 sequence", $time, `__FILE__, `__LINE__, Id[0], Id[1] );
                                                end
                                            ->strm_ack[1];
                                        end  // while (transaction[1] == 0) 
                                    $display("@%0t:%s:%0d:INFO:{%0d,%0d} Completed stream 1 process", $time, `__FILE__, `__LINE__, Id[0], Id[1] );
                                end
                            `endif
                            join_none
                            wait fork;
                            
                            `ifdef TB_DRIVES_STACK_DOWN_DATA
                              $display("@%0t:%s:%0d:INFO:{%0d,%0d} Completed driving streams and memory check, send ack to generator", $time, `__FILE__, `__LINE__, Id[0], Id[1] );
                            `else
                              $display("@%0t:%s:%0d:INFO:{%0d,%0d} Completed Memory check , send ack to generator", $time, `__FILE__, `__LINE__, Id[0], Id[1] );
                            `endif
                            $display("@%0t:%s:%0d:DEBUG {%0d,%0d} Lane is being utilized, requests in queue %0d", $time, `__FILE__, `__LINE__, Id[0], Id[1], gen2drv.num() );
                          end
                        else
                          begin
                            $display("@%0t:%s:%0d:DEBUG {%0d,%0d} Lane is not being utilized", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
                            gen2drv.get(sys_operation)  ;  //Removing the instruction from generator mailbox
                          end
                        -> gen2drv_ack;
                    end  // if ( gen2drv.num() != 0 )
            end  // forever



    endtask

    task run_req();                                        //This task checks the busy signal and asserts/desserts the request signal.
        repeat (20)                                        //If busy is high, then request should remain low and if busy is low then request goes high.
            begin
                vDownstreamStackBusLane[0].cb_test.std__pe__lane_strm_data_valid  <= 0  ;
                vDownstreamStackBusLane[1].cb_test.std__pe__lane_strm_data_valid  <= 0  ;
                @(vDownstreamStackBusLane[0].cb_test);
            end
    endtask

endclass
