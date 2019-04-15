/*********************************************************************************************
    File name   : dram_checker.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Jan 2017
    Email       : lbbaker@ncsu.edu
    
    Description : This file contains the dram checker which checks the contents of the dram after all WUs are complete.
                  Should be run during environment wrap_up
                  
                  
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

`include "python_typedef.vh"
`include "manager_array.vh"
`include "manager_array.vh"

`include "dram_utilities.sv"

import virtual_interface::*;
import operation::*;
import dram_utils::*;


class dram_checker;

    //----------------------------------------------------------------------------------------------------
    //  Manager sends base operation to DRAM checker

    mailbox gen2dramck                                   ;

    //----------------------------------------------------------------------------------------------------

    event   new_operation                             ;
    int     Id                                        ; // PE

    //----------------------------------------------------------------------------------------------------
    //  Misc

    event                       env2dramck                             ;  // environment tells main memory checker to start once the test is complete
    event                       dramck2env                             ;  // environment gets ack from main memory checker once memory check is complete

    vDiRamCfg_T                 vDramCfgIfc  [`MGR_DRAM_NUM_CHANNELS]  ;
    vIntDiRam_T                 vIntDramIfc  [`MGR_DRAM_NUM_CHANNELS]  ;
    dram_utils::dram_utilities  dram_utils   ;

    string              fileName          ;

    //-------------------------------------------------------------------------

   
    //----------------------------------------------------------------------------------------------------
    descriptor        mrc_desc            [`MGR_NUM_OF_STREAMS] ; 

    base_operation    sys_operation                              ;  // operation packet containing all data associated with operation

    function new (
                  input int                          Id                                                                     , 
                  input event                        env2dramck                                                             ,
                  input event                        dramck2env                                                             ,
                  input mailbox                      gen2dramck                                                             ,
                  input vDiRamCfg_T                  vDramCfgIfc             [`MGR_DRAM_NUM_CHANNELS]                       ,                        
                  input vIntDiRam_T                  vIntDramIfc             [`MGR_DRAM_NUM_CHANNELS]                       
                 );

        this.Id                        = Id                      ;
        this.env2dramck                = env2dramck              ;
        this.dramck2env                = dramck2env              ;
        this.gen2dramck                = gen2dramck              ;
        this.dram_utils                = new (Id )               ;
        this.vDramCfgIfc               = vDramCfgIfc             ;
        this.vIntDramIfc               = vIntDramIfc             ;

    endfunction

    localparam MGR_ARRAY_XY = $sqrt(`MGR_ARRAY_NUM_OF_MGR) ;

    task run ();


      //----------------------------------------------------------------------------------------------------
      // Extract Work Unit information
      // - operation
      // - operand read descriptors
      // - operand write descriptor
      //
      //

      while ( gen2dramck.num() != 0 )
        begin

          gen2dramck.get(sys_operation)  ;  //Removing the instruction from generator mailbox
          $display("@%0t:%s:%0d:INFO:Manager {%0d} reading resulting cell activation %f in DRAM for WU %0d, lane %0d", $time, `__FILE__, `__LINE__, Id, sys_operation.result, sys_operation.seqId, sys_operation.Id[1]);

          fileName  =    $sformatf("./configFiles/manager_%0d_%0d_layer1_group_%0d_AllGroupMemory.txt", Id/MGR_ARRAY_XY, Id%MGR_ARRAY_XY, sys_operation.seqId);
         
          $display("@%0t:%s:%0d:INFO:Manager {%0d} Before", $time, `__FILE__, `__LINE__, Id);
          for (int lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
            begin
              //sys_operation_lane_gen[lane].displayOperation();
            end
          dram_utils.readDramResultFromAllGroupFile ( .allGroupFileName    ( fileName              ), 
                                                      .sys_operation       ( sys_operation         ),
                                                      .vDramCfgIfc         ( vDramCfgIfc           ) 
                                                    );

        end
            


    endtask

endclass



