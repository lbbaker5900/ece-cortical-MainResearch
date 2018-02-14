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
        int count;  // general use
        int numberOfActiveLanes;
        bit foundError = 0;  // flag if at least one entry is in error
        bit foundGoodPacket = 0;  

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
                     $display ("@%0t::%s:%0d:: INFO:UPSTREAM_CHECKER :: Packet start received {%0d} : tag = %d", $time, `__FILE__, `__LINE__, this.Id, tag);
                   end
                  else if (( vUpstreamStackBus.pe__stu__cntl == `COMMON_STD_INTF_CNTL_SOM_EOM ) || ( vUpstreamStackBus.pe__stu__cntl == `COMMON_STD_INTF_CNTL_EOM ))
                   begin
                     $display ("@%0t::%s:%0d:: INFO:UPSTREAM_CHECKER :: Packet end received {%0d} : tag = %d", $time, `__FILE__, `__LINE__, this.Id, tag);
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
                      tagFound        = 0;
                      foundError      = 0;
                      foundGoodPacket = 0;  
                      // check contents
                      $display ("@%0t::%s:%0d:: INFO:UPSTREAM_CHECKER :: Cycle Data for {%d} : %p", $time, `__FILE__, `__LINE__, this.Id, upstream_packet_data);
                      lastCycle = 0;
                      transactionCount = 0 ;

                    // Now get base operation from manager operation mailbox
                    // and generator expected data from generator mailbox
                    if ( mgr2up.num() == 0 )
                      begin
                        // when running netlist, we might not have control over instruction generation in the wu_memory modules, so just output warnings
                        // e.g. Manager obj may only send 8 messages to upstream checker but RTL produces 9 instructions
                        `ifdef TB_USES_MANAGER_GATE_NETLIST
                          $display ("@%0t:%s:%0d:INFO:UPSTREAM_CHECKER :: No operation in manager mailbox for {%0d}", $time, `__FILE__, `__LINE__, this.Id);
                        `else
                          $display ("@%0t:%s:%0d:ERROR:UPSTREAM_CHECKER :: No operation in manager mailbox for {%0d}", $time, `__FILE__, `__LINE__, this.Id);
                        `endif
                      end
                    else
                      begin

                        $display ("@%0t:%s:%0d:INFO:UPSTREAM_CHECKER :: Find operation in manager {%0d} mailbox for tag {%0d}. mailbox has %0d entries", $time, `__FILE__, `__LINE__, this.Id, tag, mgr2up.num());
                        for (int mp=0; mp<mgr2up.num(); mp++)
                          begin
                            count = 0;

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

                                count++;
                                //$display ("@%0t:%s:%0d:INFO:UPSTREAM_CHECKER :: {%0d} : Tag found = %0d, mgr2up.num = %0d, count = %0d", $time, `__FILE__, `__LINE__, this.Id, tagFound, mgr2up.num(), count);
                                if (~tagFound && (count == mgr2up.num()))
                                  begin
                                    //$display ("@%0t:%s:%0d:ERROR:UPSTREAM_CHECKER :: {%0d} : Tag not found and checked all manager operations, mp = %0d, mgr2up.num = %0d, count = %0d", $time, `__FILE__, `__LINE__, this.Id, mp, mgr2up.num(), count);
                                    break;
                                  end
                              end // while

                          end  // for

                        if (~tagFound)
                          begin
                            $display ("@%0t:%s:%0d:ERROR:UPSTREAM_CHECKER :: No operation in manager for {%0d} mailbox matches tag {%0d} from upstream", $time, `__FILE__, `__LINE__, this.Id, tag);
                          end  // if

                      end

                    // found manager operation matching the tag, now find the generator operations
                    $display ("@%0t:%s:%0d:INFO:UPSTREAM_CHECKER :: Found operation in manager {%0d} mailbox for tag {%0d}. mailbox has %0d entries", $time, `__FILE__, `__LINE__, this.Id, tag, mgr2up.num());

                    for (int lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
                      begin
                        if ( gen2up.num() == 0 )
                          begin
                            // when running netlist, we might not have control over instruction generation in the wu_memory modules, so just output warnings
                            // e.g. Manager obj may only send 8 messages to upstream checker but RTL produces 9 instructions
                            `ifdef TB_USES_MANAGER_GATE_NETLIST
                              $display ("@%0t:%s:%0d:INFO:UPSTREAM_CHECKER :: Not enough operations in generator mailbox for {%0d} : received %0d, expected %0d", $time, `__FILE__, `__LINE__, this.Id, lane+1, `PE_NUM_OF_EXEC_LANES);
                            `else
                              $display ("@%0t:%s:%0d:ERROR:UPSTREAM_CHECKER :: Not enough operations in generator mailbox for {%0d} : received %0d, expected %0d", $time, `__FILE__, `__LINE__, this.Id, lane+1, `PE_NUM_OF_EXEC_LANES);
                            `endif
                          end
                        else
                          begin
                            // search available operations that match tag. If it doesnt match, put the operation back in the mailbox
                            tagFound = 0;
                            for (int gp=0; gp<gen2up.num(); gp++)
                              begin
                                count = 0;
                                while (~tagFound )
                                  begin
                                    //$display ("@%0t:%s:%0d:INFO:UPSTREAM_CHECKER :: {%0d} : Tag found = %0d, gen2up.num = %0d, count = %0d", $time, `__FILE__, `__LINE__, this.Id, tagFound, gen2up.num(), count);
                                    gen2up.get(sys_operation_gen) ;  //Taking the instruction from the manager 
                                    if (tag == sys_operation_gen.tId)
                                      begin 
                                        tagFound = 1 ;
                                        numberOfActiveLanes = sys_operation_gen.numberOfLanes  ; 
                                      end 
                                    else
                                      // not the correct tag so put at the back of the mailbox
                                      begin 
                                        gen2up.put(sys_operation_gen) ;  
                                      end  
                                    count++;
                                    //$display ("@%0t:%s:%0d:INFO:UPSTREAM_CHECKER :: {%0d} : Tag found = %0d, gen2up.num = %0d, count = %0d", $time, `__FILE__, `__LINE__, this.Id, tagFound, gen2up.num(), count);
                                    if (~tagFound && (count == gen2up.num()))
                                      begin
                                        //$display ("@%0t:%s:%0d:ERROR:UPSTREAM_CHECKER :: {%0d} : Tag not found and checked all operations, gp = %0d, gen2up.num = %0d, count = %0d", $time, `__FILE__, `__LINE__, this.Id, gp, gen2up.num(), count);
                                        break;
                                      end
                                  end // while
                              end  // for
                            
                            $display ("@%0t:%s:%0d:INFO:UPSTREAM_CHECKER :: Tag found = %0d", $time, `__FILE__, `__LINE__, tagFound);
                            if (tagFound)
                              begin
                               if (lane < numberOfActiveLanes )
                                 begin
                                   if (($bitstoshortreal(upstream_packet_data[sys_operation_gen.Id[1]]) < sys_operation_gen.resultLow) || ($bitstoshortreal(upstream_packet_data[sys_operation_gen.Id[1]]) > sys_operation_gen.resultHigh))
                                     begin
                                         $display ("@%0t:%s:%0d:ERROR:UPSTREAM_CHECKER :: incorrect result data for {%0d,%0d}: expected %f, observed %f", $time, `__FILE__, `__LINE__, 
                                                                                this.Id, sys_operation_gen.Id[1], sys_operation_gen.result, $bitstoshortreal(upstream_packet_data[sys_operation_gen.Id[1]]));
                                         foundError = 1;
                                     end
                                   else 
                                     begin
                                       $display ("@%0t::%s:%0d::PASS:UPSTREAM :: Correct result in upstream packet for {%0d,%0d} : Hex : %h, FP : %f", $time, `__FILE__, `__LINE__, 
                                                                                this.Id, sys_operation_gen.Id[1], sys_operation_gen.result, $bitstoshortreal(upstream_packet_data[sys_operation_gen.Id[1]]));
                                     end
                                 end
                                foundGoodPacket = ~foundError ;
                              end  // if tagFound
                            else  // tag not found
                              begin
                                `ifdef TB_USES_MANAGER_GATE_NETLIST
                                  $display ("@%0t:%s:%0d:INFO:UPSTREAM_CHECKER :: No operation in manager for {%0d} mailbox matches tag {%0d} from upstream", $time, `__FILE__, `__LINE__, this.Id, tag);
                                `else
                                  $display ("@%0t:%s:%0d:ERROR:UPSTREAM_CHECKER :: No operation in manager for {%0d} mailbox matches tag {%0d} from upstream", $time, `__FILE__, `__LINE__, this.Id, tag);
                                `endif
                              end
                            
                          end //else
                      end // for (int lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)

                      if (foundError)
                        begin
                          $display ("@%0t:%s:%0d:ERROR:UPSTREAM_CHECKER :: {%0d} : An incorrect entry was observed in tag {%0d}", $time, `__FILE__, `__LINE__, this.Id, tag);
                        end
                      if (foundGoodPacket)
                        begin
                          $display ("@%0t:%s:%0d:INFO:UPSTREAM_CHECKER :: {%0d} : A good upstream packet with tag {%0d} was observed", $time, `__FILE__, `__LINE__, this.Id, tag);
                        end

                    end  // if (lastCycle)
                end  // if ( vUpstreamStackBus.pe__stu__valid )
            end  // forever
    endtask


endclass
