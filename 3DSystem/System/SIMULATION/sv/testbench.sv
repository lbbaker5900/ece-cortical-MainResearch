/*********************************************************************************************
    File name   : testbench.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Nov 2016
    Email       : lbbaker@ncsu.edu
    
    Description : This class passes virtual interfaces to environment, eventually to driver
                  and scoreboard. It also calls the required functions of the environment.

                  Note: leveraged from https://github.ncsu.edu/ECE-Memory-Controller-IS/ece-diram4-memory-controller

*********************************************************************************************/
`timescale 1ns/10ps
`include "environment.sv"

program automatic test (
        // array of interfaces, one for each pe/lane/stream
        st_gen_ifc                               GenStackBus              [`PE_ARRAY_NUM_OF_PE]                        ,
        std_oob_ifc                              DownstreamStackBusOOB    [`PE_ARRAY_NUM_OF_PE]                        ,
        std_lane_ifc                             DownstreamStackBusLane   [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES] ,
        stu_ifc                                  UpstreamStackBus         [`PE_ARRAY_NUM_OF_PE]                        ,

        // probe interfaces
        locl_to_noc_ifc                          LocalToNocIfc            [`MGR_ARRAY_NUM_OF_MGR]                      ,
        locl_from_noc_ifc                        LocalFromNocIfc          [`MGR_ARRAY_NUM_OF_MGR]                      ,

        pe_dma2mem_ifc                           Dma2Mem                  [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES] ,
        regFileScalar2stOpCntl_ifc               RegFileScalar2StOpCntl   [`PE_ARRAY_NUM_OF_PE]                        ,
        regFileLane2stOpCntl_ifc                 RegFileLane2StOpCntl     [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES] ,
        loadStore2memCntl_ifc                    LoadStore2memCntl        [`PE_ARRAY_NUM_OF_PE]                        ,
        
        input logic reset
        );

    Environment env;

    initial begin
        env = new ( GenStackBus            , 
                    DownstreamStackBusOOB  , 
                    DownstreamStackBusLane , 
                    UpstreamStackBus       , 
                    LocalToNocIfc          , 
                    LocalFromNocIfc        , 
                    Dma2Mem                , 
                    RegFileScalar2StOpCntl , 
                    RegFileLane2StOpCntl   , 
                    LoadStore2memCntl      );
        env.build();
        env.run();
        env.wrap_up();

	$finish;
    end
endprogram // test
