/*********************************************************************************************
    File name   : upstream_checker.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    Email       : lbbaker@ncsu.edu
    
    Description : Checks for writes to memory
*********************************************************************************************/

`include "common.vh"
`include "stack_interface.vh"
`include "simd_upstream_intf.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"
`include "pe.vh"
`include "pe_array.vh"
`include "noc_interpe_port_Bitmasks.vh"

import virtual_interface::*;
import operation::*;

class upstream_checker;
    
    int       Id         ; // PE
    mailbox   mgr2up      ;
    mailbox   gen2up      ;
    event     finished      ;

    base_operation sys_operation_mgr;
    base_operation sys_operation_gen;

    vUpstreamStackBus_T     vUpstreamStackBus ;

    //----------------------------------------------------------------------------------------------------
    //
    int transactionCount ;

    int      i=0,j=0         ;
    logic    lastCycle = 0   ;

    function new (
                  input int                     Id                ,
                  input vUpstreamStackBus_T     vUpstreamStackBus ,
                  input mailbox                 mgr2up            ,
                  input mailbox                 gen2up     
                    );

        this.Id                = Id                 ;
        this.vUpstreamStackBus = vUpstreamStackBus  ;
        this.gen2up           = gen2up              ;
        this.mgr2up           = mgr2up              ;
    endfunction

    task run (); 

        int transactionCount = 0 ;
        reg [`STACK_UP_INTF_DATA_RANGE ]       upstream_data                                 ;
        reg [`PE_EXEC_LANE_WIDTH_RANGE ]       upstream_packet_data [`PE_NUM_OF_EXEC_LANES ] ; 

        int tag    ;  // we need to match the tag of the upstream data with the tag from the manager and generator
        bit tagFound = 0;

        forever 
            begin
                // Wait for a valid upstream packet, collect the data then look for each sys_operation from the lane generator to compare the expected result
                @(vUpstreamStackBus.cb_mgr);
                if ( vUpstreamStackBus.pe__stu__valid )
                    begin
                      upstream_data = vUpstreamStackBus.pe__stu__data ;
                      transactionCount += 1 ;

                      // count cycles
                      if ( vUpstreamStackBus.pe__stu__cntl == `COMMON_STD_INTF_CNTL_SOM )
                       begin
                         tag = vUpstreamStackBus.pe__stu__oob_data ;
                         //$display ("@%0t::%s:%0d:: INFO:UPSTREAM_CHECKER :: Packet received {%d} : tag = %d", $time, `__FILE__, `__LINE__, this.Id, tag);
                       end
                      else if (( vUpstreamStackBus.pe__stu__cntl == `COMMON_STD_INTF_CNTL_SOM_EOM ) || ( vUpstreamStackBus.pe__stu__cntl == `COMMON_STD_INTF_CNTL_EOM ))
                       begin
                         tag = vUpstreamStackBus.pe__stu__oob_data ;
                         // check size of packet
                         lastCycle = 1 ;
                         if (transactionCount != `SIMD_TO_STI_NUM_OF_TRANSFERS )
                           begin
                             $display ("@%0t:%s:%0d:ERROR:UPSTREAM_CHECKER :: incorrect upstream packet size for {%d}: expected %f, observed %f", $time, `__FILE__, `__LINE__, this.Id, `SIMD_TO_STI_NUM_OF_TRANSFERS, transactionCount);
                           end
                       end
                       
                      // demux upstream stack bus to each lane result
                      case  (transactionCount )
                        `include "TB_upstream_stack_bus_lane_extraction.vh"
                      endcase 

                      if (lastCycle)
                        begin
                          // check contents
                          $display ("@%0t::%s:%0d:: INFO:UPSTREAM_CHECKER :: Cycle Data for {%d} : %p", $time, `__FILE__, `__LINE__, this,Id, upstream_packet_data);
                          lastCycle = 0;
                          transactionCount = 0 ;

                        // Now get base operation from manager operation mailbox
                        // and generator expected data from generator mailbox
                        if ( mgr2up.num() == 0 )
                          begin
                            $display ("@%0t:%s:%0d:ERROR:UPSTREAM_CHECKER :: No operation in manager mailbox for {%d}", $time, `__FILE__, `__LINE__, this.Id);
                          end
                        else
                          begin

                            for (int mp=0; mp<mgr2up.num(); mp++)
                              begin

                                // search available operations that match tag. If it doesnt match, put the operation back in the mailbox
                                while (~tagFound )
                                
                                  begin

                                    mgr2up.get(sys_operation_mgr) ;  //Taking the instruction from the manager 
                                    if (tag == sys_operation_mgr.tId)
                                      begin 
                                        tagFound = 1 ;
                                      end 
                                    else
                                      // not the correct tag so put at the back of the mailbox
                                      begin 
                                        mgr2up.put(sys_operation_mgr) ;  
                                      end 

                                  end // while

                              end  // for

                            if (~tagFound)
                              begin
                                $display ("@%0t:%s:%0d:ERROR:UPSTREAM_CHECKER :: No operation in manager for {%d} mailbox matches tag {%d} from upstream", $time, `__FILE__, `__LINE__, this.Id, tag);
                              end  // if

                          end

                        // found manager operation matching the tag, now find the generator operations

                        for (int lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
                          begin
                            if ( gen2up.num() == 0 )
                              begin
                                $display ("@%0t:%s:%0d:ERROR:UPSTREAM_CHECKER :: Not enough operations in generator mailbox for {%d} : received %d, expected %d", $time, `__FILE__, `__LINE__, this.Id, lane+1, `PE_NUM_OF_EXEC_LANES);
                              end
                            else
                              begin
                                // search available operations that match tag. If it doesnt match, put the operation back in the mailbox
                                tagFound = 0;
                                for (int gp=0; gp<gen2up.num(); gp++)
                                  begin
                                    while (~tagFound )
                                      begin
                               
                                        gen2up.get(sys_operation_gen) ;  //Taking the instruction from the manager 
                                        if (tag == sys_operation_gen.tId)
                                          begin 
                                            tagFound = 1 ;
                                          end 
                                        else
                                          // not the correct tag so put at the back of the mailbox
                                          begin 
                                            gen2up.put(sys_operation_gen) ;  
                                          end 
                                      end // while
                                  end  // if
                                
                                if (tagFound)
                                  begin
                                   if (($bitstoshortreal(upstream_packet_data[sys_operation_gen.Id[1]]) < sys_operation_gen.resultLow) || ($bitstoshortreal(upstream_packet_data[sys_operation_gen.Id[1]]) > sys_operation_gen.resultHigh))
                                     begin
                                         $display ("@%0t:%s:%0d:ERROR:UPSTREAM_CHECKER :: incorrect result data for {%0d,%0d}: expected %f, observed %f", $time, `__FILE__, `__LINE__, 
                                                                                this.Id, sys_operation_gen.Id[1], sys_operation_gen.result, $bitstoshortreal(upstream_packet_data[sys_operation_gen.Id[1]]));
                                     end
                                   else 
                                     begin
                                       $display ("@%0t::%s:%0d::PASS:UPSTREAM :: Correct result in upstream packet for {%0d,%0d} : Hex : %h, FP : %f", $time, `__FILE__, `__LINE__, 
                                                                                this.Id, sys_operation_gen.Id[1], sys_operation_gen.result, $bitstoshortreal(upstream_packet_data[sys_operation_gen.Id[1]]));
                                     end
                                  end  // if tagFound
                                else  // tag not found
                                  begin
                                    $display ("@%0t:%s:%0d:ERROR:UPSTREAM_CHECKER :: No operation in manager for {%d} mailbox matches tag {%d} from upstream", $time, `__FILE__, `__LINE__, this.Id, tag);
                                  end
                                
                              end //else
                          end
                        end
                    end
            end
    endtask


endclass
