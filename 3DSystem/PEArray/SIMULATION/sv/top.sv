/*********************************************************************************************
    File name   : top.sv
    Author      : Sarvagya
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Aug 2016
    Email       : ssarvag@ncsu.edu
    
    Description : This module is the top level. It contains the connections to and from the 
                  system, memory and probe interface.
*********************************************************************************************/

`timescale 1ns/10ps
`include "common.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"
`include "pe.vh"
`include "pe_array.vh"
`include "noc_interpe_port_Bitmasks.vh"

module top;


    // system clock and reset
    logic reset_poweron       ;
    logic clk    =  0 ;

    always #5ns clk=~clk;

    initial begin
        reset_poweron            = 1;
        #100ns reset_poweron     = 0;
    end

    //----------------------------------------------------------------------------------------------------
    // Instantiate an interface for every pe/lane/stream pair
    //
    //                              pe  lane
    std_pe_lane_ifc    SysLane2PeArray [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES] (.clk_lane            ( clk           ));  // shorthand for [0:63] ....
    std_pe_oob_ifc     SysOob2PeArray  [`PE_ARRAY_NUM_OF_PE]                        (.clk_oob             ( clk           ) ,
                                                                                     .reset_poweron       ( reset_poweron ));  

    //----------------------------------------------------------------------------------------------------
    // Probe interface(s)
    //
    // Write Memory probe
    pe_dma2mem_ifc    Dma2Mem      [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES] (clk);  // shorthand for [0:63] ....


    //----------------------------------------------------------------------------------------------------
    // Processing layer
    //
    pe_array pe_array_inst (
   
         // Downstream Stack bus Interface
         `include "TB_system_stack_bus_downstream_instance_ports.vh"
       
        .clk               ( clk       ),
        .reset_poweron     ( reset_poweron     )
    );


    
    //----------------------------------------------------------------------------------------------------
    // Testbench
    //
        test  ti  (
                   SysLane2PeArray     ,
                   SysOob2PeArray      ,
                   Dma2Mem             ,
                   reset_poweron
                  );

    //----------------------------------------------------------------------------------------------------
    // Probes
    //
    genvar pe, lane;
        generate
           for (pe=0; pe<64; pe=pe+1)
               begin
                   for (lane=0; lane<32; lane=lane+1)
                       begin
                           assign Dma2Mem[pe][lane].dma__memc__write_valid      = pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.dma__memc__write_valid0        ;
                           assign Dma2Mem[pe][lane].dma__memc__write_address    = pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.dma__memc__write_address0      ;
                           assign Dma2Mem[pe][lane].dma__memc__write_data       = pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.dma__memc__write_data0         ;
                           assign Dma2Mem[pe][lane].dma__memc__read_valid       = pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.dma__memc__read_valid0         ;
                           assign Dma2Mem[pe][lane].dma__memc__read_address     = pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.dma__memc__read_address0       ;
                           assign Dma2Mem[pe][lane].dma__memc__read_pause       = pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.dma__memc__read_pause0         ;

                           assign Dma2Mem[pe][lane].memc__dma__write_ready      = pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.memc__dma__write_ready0        ;
                           assign Dma2Mem[pe][lane].memc__dma__read_data        = pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.memc__dma__read_data0          ;
                           assign Dma2Mem[pe][lane].memc__dma__read_data_valid  = pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.memc__dma__read_data_valid0    ;
                           assign Dma2Mem[pe][lane].memc__dma__read_ready       = pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.memc__dma__read_ready0         ;
                       end
               end
        endgenerate

    /*
    dut_probe_dma2mem probe_dma2mem(
             `include "TB_probe_dma2mem_connection.vh" 
                               );
    */
    //----------------------------------------------------------------------------------------------------
 


    //----------------------------------------------------------------------------------------------------
    // Testbench - random forces
    //

    int numOfTypes;
    reg enable_std_stream0 ;
    reg enable_std_stream1 ;
  
    initial
        begin
             numOfTypes = 20;
      
            @(posedge clk);
            `include "test_simd_init.vh"
            @(posedge clk);
            `include "test_std_std_fpmac_to_mem_init_step1.vh"
        end

endmodule : top
