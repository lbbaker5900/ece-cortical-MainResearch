/*********************************************************************************************
    File name   : memory_read_proc.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : May 2017
    Email       : lbbaker@ncsu.edu
    
    Description : Captures descriptors between the WU Decoder and memory Read Controller.
                  Tells the manager to send operation to driver
                  FIXME: cant we just tell the driver directly???
*********************************************************************************************/

`include "common.vh"
`include "python_typedef.vh"
`include "manager.vh"
`include "manager_array.vh"

import virtual_interface::*;
import operation::*;

class memory_read_proc;
    
    int       Id               ;  // this manager
    int       mrId             ;  // this MR channel
    mailbox   mrc2mgr_m        ;  // manager told of MR descriptor

    vDesc_T   vDesc            ;  // memory Read descriptor interface

    //----------------------------------------------------------------------------------------------------
    //
    function new (
                  input int               Id         ,
                  input int               mrId       ,
                  input vDesc_T           vDesc      ,
                  input mailbox           mrc2mgr_m  
                    );

        this.Id         = Id         ;
        this.mrId       = mrId       ;
        this.vDesc      = vDesc      ;
        this.mrc2mgr_m  = mrc2mgr_m  ;

    endfunction

    task run (); 

      descriptor  rcvd_desc          ;
      bit         rcvd_desc_complete ;

      bit  [`MGR_WU_OPT_TYPE_RANGE                      ]   payload_tuple_type   ;
      bit  [`MGR_WU_OPT_VALUE_RANGE                     ]   payload_tuple_value  ;

      // grab sent and received NoC packets and place in per manager mailboxes
      fork
        begin
          forever
            begin
              // Observe descriptor interface
              @(vDesc.cb_p);
              if ((vDesc.valid == 1'b1))
                begin
                  // Start of descriptor observed, create new descriptor and start to fill the fields
                  //$display ("@%0t::%s:%0d:: INFO: Manager {%0d} observed descriptor between WU decoder and MR Controller {%0d}", $time, `__FILE__, `__LINE__, this.Id, this.mrId);
                  rcvd_desc          = new() ;
                  rcvd_desc.timeTag  = $time ;
                  rcvd_desc_complete = 0     ;    

                  // keep grabing tuples until we see EOM
                  while(~rcvd_desc_complete)     
                    begin
                      //------------------------------
                      // 
                      if ((vDesc.valid == 1'b1) && (vDesc.cntl == `COMMON_STD_INTF_CNTL_SOM))  // start-of-descriptor
                        begin
                          //$display ("@%0t::%s:%0d:: DEBUG: ", $time, `__FILE__, `__LINE__);
                          for (int i=0; i<`MGR_WU_OPT_PER_INST; i++)
                            begin
                              //$display ("@%0t::%s:%0d:: DEBUG: ", $time, `__FILE__, `__LINE__);
                              rcvd_desc.payload_tuple_type .push_back (vDesc.option_type [i]) ;
                              rcvd_desc.payload_tuple_value.push_back (vDesc.option_value[i]) ;
                            end
                        end
                      else if ((vDesc.valid == 1'b1) && (vDesc.cntl == `COMMON_STD_INTF_CNTL_EOM))  // end-of-descriptor
                        begin
                          //$display ("@%0t::%s:%0d:: DEBUG: ", $time, `__FILE__, `__LINE__);
                          for (int i=0; i<`MGR_WU_OPT_PER_INST; i++)
                            begin
                              //$display ("@%0t::%s:%0d:: DEBUG: ", $time, `__FILE__, `__LINE__);
                              rcvd_desc.payload_tuple_type .push_back (vDesc.option_type [i]) ;
                              rcvd_desc.payload_tuple_value.push_back (vDesc.option_value[i]) ;
                            end
                            rcvd_desc_complete = 1    ;
                            mrc2mgr_m.put(rcvd_desc)  ;  // send descriptor to manager
                            $display ("@%0t::%s:%0d:: INFO: Manager {%0d} observed descriptor EOM between WU decoder and MR Controller {%0d}", $time, `__FILE__, `__LINE__, this.Id, this.mrId);
                            rcvd_desc.displayDesc()   ;
                        end
                      else
                        begin
                          //$display ("@%0t::%s:%0d:: DEBUG: ", $time, `__FILE__, `__LINE__);
                          for (int i=0; i<`MGR_WU_OPT_PER_INST; i++)
                            begin
                              //$display ("@%0t::%s:%0d:: DEBUG: ", $time, `__FILE__, `__LINE__);
                              rcvd_desc.payload_tuple_type .push_back (vDesc.option_type [i]) ;
                              rcvd_desc.payload_tuple_value.push_back (vDesc.option_value[i]) ;
                            end
                        end
                      @(vDesc.cb_p);
                    end  // while
                end  // if ((vDesc.valid == 1'b1))
            end  // forever
        end  
      join_none

      wait fork;
    endtask


endclass
