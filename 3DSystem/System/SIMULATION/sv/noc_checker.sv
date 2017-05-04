/*********************************************************************************************
    File name   : noc_checker.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : May 2017
    Email       : lbbaker@ncsu.edu
    
    Description : Predicts and checks for packets sent to and from NoC
                   - receives sent packets from each manager and predicts packets received by other managers
                   - receives received packets from each manager and compares against prediction
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

`include "mgr_noc_cntl.vh"
`include "manager.vh"
`include "manager_array.vh"

import virtual_interface::*;
import operation::*;

class noc_checker;
    
    mailbox   mgr2noc_p  [`MGR_ARRAY_NUM_OF_MGR]  ;  // system told this packet was sent
    mailbox   noc2mgr_p  [`MGR_ARRAY_NUM_OF_MGR]  ;  // system told this packet was received

    vLocalToNoC_T     vLocalToNoC          [`MGR_ARRAY_NUM_OF_MGR]      ;
    vLocalFromNoC_T   vLocalFromNoC        [`MGR_ARRAY_NUM_OF_MGR]      ;
    //vLocalToNoC_T     tmp_vLocalToNoC                                   ;  // to avoid dereference *&^%$@ SV virtual interface &^%$# bs
    //vLocalFromNoC_T   tmp_vLocalFromNoC                                 ;

    //----------------------------------------------------------------------------------------------------
    //
    function new (
                  input vLocalToNoC_T           vLocalToNoC   [`MGR_ARRAY_NUM_OF_MGR] ,
                  input vLocalFromNoC_T         vLocalFromNoC [`MGR_ARRAY_NUM_OF_MGR] 
                  //input mailbox                 mgr2noc_p     [`MGR_ARRAY_NUM_OF_MGR] ,
                  //input mailbox                 noc2mgr_p     [`MGR_ARRAY_NUM_OF_MGR]
                    );

        this.vLocalToNoC      = vLocalToNoC    ;
        this.vLocalFromNoC    = vLocalFromNoC  ;

        //this.mgr2noc_p        = mgr2noc_p      ;
        //this.noc2mgr_p        = noc2mgr_p      ;
        for (int m=0; m<`MGR_ARRAY_NUM_OF_MGR; m++)
          begin
            this.mgr2noc_p [m] = new() ;
            this.noc2mgr_p [m] = new() ;
          end
    endfunction

    task run (); 

      local_noc_packet local_noc_pkt_sent  [`MGR_ARRAY_NUM_OF_MGR] ;
      local_noc_packet local_noc_pkt_rcvd  [`MGR_ARRAY_NUM_OF_MGR] ;
      local_noc_packet local_noc_pkt_sent_from_mbx  ;
      local_noc_packet local_noc_pkt_rcvd_from_mbx  ;

      // grab sent and received NoC packets and place in per manager mailboxes
      fork
        `include "TB_system_local_toNoc_checker_packet_grab.vh"
      join_none
      fork
        `include "TB_system_local_fromNoc_checker_packet_grab.vh"
      join_none

      // Take packets from the per manager mailbox and check against the to NoC mailbox
      fork
        begin
          forever
            begin
              @(vLocalFromNoC[0].cb_p);
              for (int m=0; m<`MGR_ARRAY_NUM_OF_MGR; m++) 
                begin
                  if (noc2mgr_p[m].num() != 0)
                    begin
                      if (mgr2noc_p[m].num() == 0)
                        begin
                          $display ("@%0t::%s:%0d:: ERROR: Expected packet queue empty for manager {%0d}", $time, `__FILE__, `__LINE__, m);
                        end
                      noc2mgr_p[m].get(local_noc_pkt_rcvd_from_mbx);
                      // the packet has to be there, so loop thru all current packets and ERROR if not found
                      for (int msg=0; msg<mgr2noc_p[m].num(); msg++) 
                        begin
                          mgr2noc_p[m].get(local_noc_pkt_sent_from_mbx);
                          if (local_noc_pkt_sent_from_mbx.header_source != local_noc_pkt_rcvd_from_mbx.header_source)
                            begin
                              // put unmatched packet back in mailbox
                              mgr2noc_p[m].put(local_noc_pkt_sent_from_mbx);
                            end
                          else
                            begin
                              $display ("@%0t::%s:%0d:: INFO: Received expected packet to manager {%0d} from {%0d}", $time, `__FILE__, `__LINE__, m, local_noc_pkt_sent_from_mbx.header_source);
                              break;
                              // FIXME : Display transit time
                            end
                        end
                    end
                end
            end
        end
      join_none

      wait fork;
/*
      fork
        for (int m=0; m<`MGR_ARRAY_NUM_OF_MGR; m++) 
          begin
            forever 
              begin
                // Observe NoC packets sent from manager m
                automatic int lm = m;
                @(vLocalToNoC[lm].cb_p);
                //$display ("@%0t::%s:%0d:: INFO: Check if Packet being sent from {%d}", $time, `__FILE__, `__LINE__, lm);
                if ((vLocalToNoC[lm].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[lm].locl__noc__dp_cntl == 2'b01))
                  begin
                    $display ("@%0t::%s:%0d:: INFO: Packet being sent from {%d}", $time, `__FILE__, `__LINE__, m);
                    local_noc_pkt_sent [lm] = new();
                    local_noc_pkt_sent [lm].header_destination_address  = vLocalToNoC[lm].locl__noc__dp_data     ;
                    local_noc_pkt_sent [lm].header_source               = lm                                     ;
                    local_noc_pkt_sent [lm].header_address_type         = vLocalToNoC[lm].locl__noc__dp_desttype ;
                    local_noc_pkt_sent [lm].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                    // determine all destination and place packet in their mailbox
                    for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                      begin
                        if (local_noc_pkt_sent [lm].header_destination_address[dm] == 1'b1)
                          begin
                            $display ("@%0t::%s:%0d:: INFO: Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, lm, dm);
                            mgr2noc_p [dm].put(local_noc_pkt_sent [lm]);
                          end
                      end
                  end
              end
          end
      join_none
*/
/*
 // worked
      forever 
        begin
          @(vLocalToNoC[0].cb_p);
          for (int m=0; m<`MGR_ARRAY_NUM_OF_MGR; m++) 
          //foreach (vLocalToNoC[m])
            begin
              // Observe NoC packets sent from manager m
              //automatic int m = m;
              //$display ("@%0t::%s:%0d:: INFO: Check if Packet being sent from {%0d}", $time, `__FILE__, `__LINE__, m);
              if ((vLocalToNoC[m].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[m].locl__noc__dp_cntl == 2'b01))
                begin
                  $display ("@%0t::%s:%0d:: INFO: Packet being sent from {%0d}", $time, `__FILE__, `__LINE__, m);
                  local_noc_pkt_sent [m] = new();
                  local_noc_pkt_sent [m].header_destination_address  = vLocalToNoC[m].locl__noc__dp_data     ;
                  local_noc_pkt_sent [m].header_source               = m                                     ;
                  local_noc_pkt_sent [m].header_address_type         = vLocalToNoC[m].locl__noc__dp_desttype ;
                  local_noc_pkt_sent [m].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                  // determine all destination and place packet in their mailbox
                  for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                    begin
                      if (local_noc_pkt_sent [m].header_destination_address[dm] == 1'b1)
                        begin
                          $display ("@%0t::%s:%0d:: INFO: Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, m, dm);
                          mgr2noc_p [dm].put(local_noc_pkt_sent [m]);
                        end
                    end
                end
          end
        end
*/
/*
      fork
        begin
          forever
            begin
              // Observe NoC packets sent from manager m
              //automatic int lm = m;
              @(vLocalToNoC[63].cb_p);
              //$display ("@%0t::%s:%0d:: INFO: Check if Packet being sent from {%0d}", $time, `__FILE__, `__LINE__, m);
              if ((vLocalToNoC[63].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[63].locl__noc__dp_cntl == 2'b01))
                begin
                  $display ("@%0t::%s:%0d:: INFO: Packet being sent from {%0d}", $time, `__FILE__, `__LINE__, 63);
                  local_noc_pkt_sent [63] = new();
                  local_noc_pkt_sent [63].header_destination_address  = vLocalToNoC[63].locl__noc__dp_data     ;
                  local_noc_pkt_sent [63].header_source               = 63                                     ;
                  local_noc_pkt_sent [63].header_address_type         = vLocalToNoC[63].locl__noc__dp_desttype ;
                  local_noc_pkt_sent [63].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                  // determine all destination and place packet in their mailbox
                  for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                    begin
                      if (local_noc_pkt_sent [63].header_destination_address[dm] == 1'b1)
                        begin
                          $display ("@%0t::%s:%0d:: INFO: Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 63, dm);
                          mgr2noc_p [dm].put(local_noc_pkt_sent [63]);
                        end
                    end
                end
            end
        end
        begin
          forever
            begin
              // Observe NoC packets sent from manager m
              //automatic int lm = m;
              @(vLocalToNoC[61].cb_p);
              //$display ("@%0t::%s:%0d:: INFO: Check if Packet being sent from {%d}", $time, `__FILE__, `__LINE__, m);
              if ((vLocalToNoC[61].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[61].locl__noc__dp_cntl == 2'b01))
                begin
                  $display ("@%0t::%s:%0d:: INFO: Packet being sent from {%0d}", $time, `__FILE__, `__LINE__, 61);
                  local_noc_pkt_sent [61] = new();
                  local_noc_pkt_sent [61].header_destination_address  = vLocalToNoC[61].locl__noc__dp_data     ;
                  local_noc_pkt_sent [61].header_source               = 61                                     ;
                  local_noc_pkt_sent [61].header_address_type         = vLocalToNoC[61].locl__noc__dp_desttype ;
                  local_noc_pkt_sent [61].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                  // determine all destination and place packet in their mailbox
                  for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                    begin
                      if (local_noc_pkt_sent [61].header_destination_address[dm] == 1'b1)
                        begin
                          $display ("@%0t::%s:%0d:: INFO: Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 61, dm);
                          mgr2noc_p [dm].put(local_noc_pkt_sent [61]);
                        end
                    end
                end
            end
        end
      join_none
*/
 
/*
      for (int m=0; m<`MGR_ARRAY_NUM_OF_MGR; m++) 
      //foreach (vLocalToNoC[m])
        begin
          fork
            forever 
                begin
                  // Observe NoC packets sent from manager m
                  //automatic int lm = m;
                  @(vLocalToNoC[m].cb_p);
                  //$display ("@%0t::%s:%0d:: INFO: Check if Packet being sent from {%d}", $time, `__FILE__, `__LINE__, m);
                  if ((vLocalToNoC[m].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[m].locl__noc__dp_cntl == 2'b01))
                    begin
                      $display ("@%0t::%s:%0d:: INFO: Packet being sent from {%d}", $time, `__FILE__, `__LINE__, m);
                      local_noc_pkt_sent [m] = new();
                      local_noc_pkt_sent [m].header_destination_address  = vLocalToNoC[m].locl__noc__dp_data     ;
                      local_noc_pkt_sent [m].header_source               = m                                     ;
                      local_noc_pkt_sent [m].header_address_type         = vLocalToNoC[m].locl__noc__dp_desttype ;
                      local_noc_pkt_sent [m].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                      // determine all destination and place packet in their mailbox
                      for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                        begin
                          if (local_noc_pkt_sent [m].header_destination_address[dm] == 1'b1)
                            begin
                              $display ("@%0t::%s:%0d:: INFO: Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, m, dm);
                              mgr2noc_p [dm].put(local_noc_pkt_sent [m]);
                            end
                        end
                    end
                end
          join_none
        end
*/




                // fork a process for each manager
                // Wait for a valid upstream packet, collect the data then look for each sys_operation from the lane generator to compare the expected result
 
/*               //
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
*/
    endtask


endclass
