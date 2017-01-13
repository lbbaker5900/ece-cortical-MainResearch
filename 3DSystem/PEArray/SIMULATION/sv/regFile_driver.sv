/*********************************************************************************************
    File name   : regFile_driver.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Dec 2016
    Email       : lbbaker@ncsu.edu
    
    Description : Drives the register file ports into the streaming Ops controller
                  FIXME : not required once we get the SIMD path working
*********************************************************************************************/

`include "common.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"
`include "pe.vh"
`include "pe_array.vh"
`include "noc_interpe_port_Bitmasks.vh"

`include "TB_streamingOps_cntl.vh"

import virtual_interface::*;
import operation::*;

class regFile_driver;
    
    int       Id [2]        ; // PE, lane
    mailbox   gen2rfP      ;
    event     gen2rfP_ack  ;
    event     finished      ;

    //base_operation sys_operation;
    oob_packet       oob_packet_new ;

    vRegFileScalarDrv2stOpCntl_T  vP_srf ;
    vRegFileLaneDrv2stOpCntl_T    vP_vrf ;

    int i=0,j=0;
    int found = 0;

    function new (
                  input int                             Id[2]         ,
                  input vRegFileScalarDrv2stOpCntl_T    vP_srf        ,
                  input vRegFileLaneDrv2stOpCntl_T      vP_vrf        ,
                  input mailbox                         gen2rfP       ,
                  input event                           gen2rfP_ack ) ;

        this.Id           = Id            ;
        this.vP_srf       = vP_srf        ;
        this.vP_vrf       = vP_vrf        ;
        this.gen2rfP      = gen2rfP       ;
        this.gen2rfP_ack  = gen2rfP_ack   ;
    endfunction

    task run (); 

        //sys_operation=new();

        forever 
            begin
                if ( gen2rfP.num() != 0 )
                    begin
                        //gen2rfP.peek(sys_operation);   //Taking the transaction from the generator mailbox
                        gen2rfP.peek(oob_packet_new);   //Taking the transaction from the oob driver 

                        //----------------------------------------------------------------------------------------------------
                        // Info/Debug
                        $display("@%0t:%s:%0d: INFO: Received Optype from generator : {%0d,%0d} : 0b%0b", $time, `__FILE__, `__LINE__, Id[0], Id[1], oob_packet_new.stOp_operation);
/*
                        case (sys_operation.OpType)
                            `STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM :
                                $display("@%0t INFO:%s:%0d:: Received {STD,STD -> MEM} FP MAC operation from generator: {%0d,%0d} with expected result of %f, %f <> %f : written to address : 0x%6h (0b%24b)", $time, `__FILE__, `__LINE__, Id[0], Id[1], sys_operation.result, sys_operation.resultHigh, sys_operation.resultLow, sys_operation.destinationAddress[0], sys_operation.destinationAddress[0] );
                            `STREAMING_OP_CNTL_OPERATION_STD_NONE_NOP_TO_MEM   :
                                $display("@%0t INFO:%s:%0d:: Received Downstream copy to memory from generator: {%0d,%0d} : written to address : 0x%6h (0b%24b)", $time, `__FILE__, `__LINE__, Id[0], Id[1], sys_operation.destinationAddress[0], sys_operation.destinationAddress[0] );
                            `STREAMING_OP_CNTL_OPERATION_MEM_STD_FP_MAC_TO_MEM :
                                $display("@%0t INFO:%s:%0d:: Received {MEM,STD -> MEM} FP MAC operation from generator: {%0d,%0d} with expected result of %f, %f <> %f : written to address : 0x%6h (0b%24b)", $time, `__FILE__, `__LINE__, Id[0], Id[1], sys_operation.result, sys_operation.resultHigh, sys_operation.resultLow, sys_operation.destinationAddress[0], sys_operation.destinationAddress[0] );
                        endcase

*/

                        //----------------------------------------------------------------------------------------------------
                        // If enabled, ensure all memory accesses are local and within block allocated to lane
                        for (int stream=0; stream<`PE_NUM_OF_STREAMS; stream++)
                          begin
                              // Make sure address is local to PE
                              if (oob_packet_new.destinationAddress[stream][`PE_CHIPLET_ADDR_BITS_RANGE] != Id[0])
                                begin
                                  $display("@%0t:%s:%0d:ERROR:: {%0d,%0d} : Stream %d Destination address not within this PE\'s local memory : %h", $time, `__FILE__, `__LINE__, Id[0], Id[1], stream, oob_packet_new.destinationAddress[stream][`PE_CHIPLET_ADDR_BITS_RANGE] );
                                end
                              if (oob_packet_new.destinationAddress[stream][`PE_CHIPLET_LANE_ADDR_BITS_RANGE] != Id[1])
                                begin
                                  $display("@%0t:%s:%0d:ERROR:: {%0d,%0d} : Stream %d Destination address not within this PE\'s local lane address space: %h", $time, `__FILE__, `__LINE__, Id[0], Id[1], stream, oob_packet_new.destinationAddress[stream][`PE_CHIPLET_LANE_ADDR_BITS_RANGE] );
                                end
                          end
                        
                        //----------------------------------------------------------------------------------------------------
                        // Set register inputs to streamingOps_cntl

                        // Now address is constrained in the base_operation to be within a PE and lane portion of local memory
                        vP_vrf.cb_out.r130          <= oob_packet_new.sourceAddress[0]                     ;
                        vP_vrf.cb_out.r131          <= oob_packet_new.sourceAddress[1]                     ;
                        vP_vrf.cb_out.r132[19:16]   <= oob_packet_new.src_data_type [0]     ;  // type (bit, nibble, byte, word)
                        vP_vrf.cb_out.r132[15: 0]   <= oob_packet_new.numberOfOperands                     ;  // num of types - for dma
                        vP_vrf.cb_out.r133[19:16]   <= oob_packet_new.src_data_type [1]     ;  // type (bit, nibble, byte, word)
                        vP_vrf.cb_out.r133[15: 0]   <= oob_packet_new.numberOfOperands                     ;
                        vP_vrf.cb_out.r134          <= oob_packet_new.destinationAddress[0]                ;
                        vP_vrf.cb_out.r135          <= oob_packet_new.destinationAddress[1]                ;
                        vP_srf.cb_out.rs0[0]        <= 1'b1                                               ;
                        // drive packed struct directly onto regFile register input for streamingOps_cntl
                        vP_srf.cb_out.rs0[31:1]     <= oob_packet_new.stOp_operation                       ;  // `STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM ;
                        vP_srf.cb_out.rs1           <= {32{1'b1}};

                        // struct contents debug
                        //$display("@%0t LEE:regFile driver: struct size = %d ", $time, $bits(oob_packet_new.stOp_operation));
                        //$display("@%0t LEE:regFile driver: struct %b : %b ", $time, oob_packet_new.stOp_operation, `STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM);
                        //$display("@%0t LEE:regFile driver: struct %b : %b ", $time, oob_packet_new.stOp_operation, `STREAMING_OP_CNTL_OPERATION_STD_NONE_NOP_TO_MEM  );


                        //----------------------------------------------------------------------------------------------------
                        // Acknowledge regFile outputs are set
                        
                        // FIXME: 
                        //repeat(10) @(vP_vrf.cb_out);

                        gen2rfP.get(oob_packet_new);   //Remove the transaction from the driver mailbox

                        // DEBUG
/*
                        $display("@%0t:%s:%0d:LEE:DEBUG:{%0d,%0d}", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
                        if ((Id[0]  == 63) && (Id[1] == 31))
                            sys_operation.displayOperation();
*/
                        -> gen2rfP_ack;
                        $display ("@%0t:%s:%0d:INFO: Operation driven for {%02d,%02d}", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
 
                        //----------------------------------------------------------------------------------------------------
                        // Wait for  streamingOps_cntl to be complete the deassert enable ( rs0[0]=0 )
                        wait(vP_srf.cb_out.complete);
                        $display ("@%0t:%s:%0d:INFO: streamingOps_cntl complete for {%02d,%02d}", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
                        vP_srf.cb_out.rs0[0]        <= 1'b0                                               ;
                        wait(~vP_srf.cb_out.complete);
      
                    end
                else
                    begin
                         @(vP_vrf.cb_out);
                    end
 
            end
    endtask


endclass
