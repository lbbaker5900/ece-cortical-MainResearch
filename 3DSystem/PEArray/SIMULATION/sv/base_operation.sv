/*********************************************************************************************
    File name   : base_operation.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Nov 2016
    Email       : lbbaker@ncsu.edu
    
    Description : 


    Note: leveraged from https://github.ncsu.edu/ECE-Memory-Controller-IS/ece-diram4-memory-controller

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

`include "TB_streamingOps_cntl.vh"  // might cause an error if this is included in any of the above files

package operation;

    `undef _TB_streamingOps_cntl_vh     // forces this include to occur in the package
    `include "TB_streamingOps_cntl.vh" 


    class base_operation ; 
    
        time                                                timeTag                                                  ;
        int                                                 Id [2]                                                   ; // PE, Lane
        int                                                 tId                                                      ; // transaction number

        // struct members cannot be rand
        pe_stOp_operation                                   stOp_operation                                           ;  // create this from the other fields in the class

        rand logic                                          enableDestinationStream   [`PE_NUM_OF_STREAMS_RANGE ]    ;  // based on operation type this tells the driver what to do with the two operand streams
        rand logic [`STREAMING_OP_CNTL_OPERATION_RANGE ]    OpType                                                   ; 
        rand bit   [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    destinationAddress  [`PE_NUM_OF_STREAMS_RANGE ]          ;  
        rand bit   [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    sourceAddress       [`PE_NUM_OF_STREAMS_RANGE ]          ;  
     
        static logic [`STREAMING_OP_CNTL_OPERATION_RANGE ]  priorOperations[$]; //Queue to hold previous operations
        // an array of operands
        rand bit [`PE_EXEC_LANE_WIDTH_RANGE ]               operands            [`PE_NUM_OF_STREAMS_RANGE ] []       ;
        rand int                                            numberOfOperands                                         ;
        shortreal                                           operandsReal        [`PE_NUM_OF_STREAMS_RANGE ]          ;
        // cant randomize a float, so randomize the FP fields and construct the float
        rand bit                                            operandsSign        [`PE_NUM_OF_STREAMS_RANGE ] []       ;
        rand bit [7:0]                                      operandsExp         [`PE_NUM_OF_STREAMS_RANGE ] []       ;
        rand bit [22:0]                                     operandsSignificand [`PE_NUM_OF_STREAMS_RANGE ] []       ;

        //------------------------------------------------------------------------------------------------------
        // If results are floating point
        shortreal                        result              ; 
        shortreal                        resultHigh          ;  // tolerate a slight differecne in floating point functions
        shortreal                        resultLow           ;
        shortreal                        FpTolerance = 0.001 ;
        

        int i,j,l,m;
     
        function new ();
            this.timeTag = $time ;
        endfunction

        function void pre_randomize();	//1 -> Turns on the constraint, 0-> Turns off the constraint
            this.c_operationType_fpMac.constraint_mode(1);
            this.c_operationType_copyStdToMem.constraint_mode(0);
            this.c_streamSize.constraint_mode(1);
            this.c_operandValues .constraint_mode(1);
        endfunction : pre_randomize
        
        // Restrict address to the PE and Lane portion of local memory
        constraint c_restrictLaneAddress {
            destinationAddress[0] inside {[((Id[0] << `PE_CHIPLET_ADDRESS_WIDTH ) | (Id[1]<<`PE_CHIPLET_LANE_ADDRESS_WIDTH)) : ((Id[0] << `PE_CHIPLET_ADDRESS_WIDTH ) | (Id[1]<<`PE_CHIPLET_LANE_ADDRESS_WIDTH))+1024 ]};
            destinationAddress[1] inside {[0:127 ]};
        }
        constraint c_operationType_fpMac {
            OpType inside {`STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM} ;
            enableDestinationStream[0] == 1 ;
            enableDestinationStream[1] == 0 ;  // FIXME
        }
        constraint c_operationType_copyStdToMem {
            OpType inside {`STREAMING_OP_CNTL_OPERATION_STD_NONE_NOP_TO_MEM  } ;
            enableDestinationStream[0] == 1 ;
            enableDestinationStream[1] == 0 ;
        }
        constraint c_numberOfOperands {
            numberOfOperands inside {[20:100]};
            //numberOfOperands inside {[0:65535]};
        }
        constraint c_streamSize {
            foreach (operands[i]) {
                    operands[i].size == numberOfOperands;
            }
            foreach (operandsExp[i]) {
                    operandsExp[i].size == numberOfOperands; 
            }
            foreach (operandsSignificand[i]) {
                    operandsSignificand[i].size == numberOfOperands; 
            }
            foreach (operandsSign[i]) {
                    operandsSign[i].size == numberOfOperands; 
            }
        }
        // choose reasonable floating point fields
        constraint c_operandValues {
            foreach (operandsExp         [i,j]) {
                    operandsExp[i][j] inside {[128:129]} ;
            }
            foreach (operandsSignificand         [i,j]) {
                    operandsSignificand[i][j] inside {[23'b010_0000_0000_0000_0000_0000:23'b110_0000_0000_0000_0000_0000]} ;
            }
        }
    
        function void post_randomize();
            result = 0.0 ;
            for (int i=0; i<numberOfOperands; i++)
                begin
                    //$display("%t: Stream 0 Operand %d = {%p %p %p}\n", $time, i, operandsSign[0][i], operandsExp[0][i], operandsSignificand[0][i] )          ;
                    //$display("%t: Stream 1 Operand %d = {%p %p %p}\n", $time, i, operandsSign[1][i], operandsExp[1][i], operandsSignificand[1][i] )          ;

                    // calculate expected result
                    operandsReal[0] = $bitstoshortreal({operandsSign[0][i], operandsExp[0][i], operandsSignificand[0][i]});
                    operandsReal[1] = $bitstoshortreal({operandsSign[1][i], operandsExp[1][i], operandsSignificand[1][i]});
                    result          = result + operandsReal[0]*operandsReal[1]   ; 
                    if (result >= 0)
                      begin
                        resultHigh      = (1.0+FpTolerance)*result                   ;
                        resultLow       = (1.0-FpTolerance)*result                   ;
                      end
                    else
                      begin
                        resultLow       = (1.0+FpTolerance)*result                   ;
                        resultHigh      = (1.0-FpTolerance)*result                   ;
                      end
                    //$display("%t: Base_operation result %d: %f, %f <> %f\n", $time, tId, result, resultHigh, resultLow);

                    // generate stimiulus from floating point fields
                    operands[0][i] = {operandsSign[0][i], operandsExp[0][i], operandsSignificand[0][i]};
                    operands[1][i] = {operandsSign[1][i], operandsExp[1][i], operandsSignificand[1][i]};

                    //$display("%t: Stream 0 Operand %d = %h\n", $time, i, operands[0][i]);
                    //$display("%t: Stream 1 Operand %d = %h\n", $time, i, operands[1][i]);
                end
            //$display("%t: Result = %d\n", $time, result)              ;
        endfunction : post_randomize
    
        function create();

        endfunction
    
        function displayOperation();
            $display("%t: Operation ID#%d\n", $time, i, tId);
            $display("Operands : ");
            for (int i=0; i<numberOfOperands-1; i++)
                begin
                    operandsReal[0] = $bitstoshortreal({operands[0][i]});
                    operandsReal[1] = $bitstoshortreal({operands[1][i]});
                    $display("{%f, %f}, ", operandsReal[0], operandsReal[1]);
                end
            operandsReal[0] = $bitstoshortreal(operands[0][numberOfOperands-1]);
            operandsReal[1] = $bitstoshortreal(operands[1][numberOfOperands-1]);
            $display("{%f, %f}\n", operandsReal[0], operandsReal[1]);
            $display("Expected Result = %f\n", result);
        endfunction
    
    endclass

    class stream_operation ; 
    
        time timeTag   ;
        int  tId        ;
     
        bit [`PE_EXEC_LANE_WIDTH_RANGE ] operands        [] ;
        int                              numberOfOperands   ;

        function new ();
            this.timeTag = $time ;
        endfunction
    
    endclass

endpackage




