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



//------------------------------------------------------------------------------------------------------
// Package

package operation;

    `undef _TB_streamingOps_cntl_vh     // forces this include to occur in the package
    `include "TB_streamingOps_cntl.vh" 


    //------------------------------------------------------------------------------------------------------
    // Class

    class base_operation ; 
    
        time                                                timeTag                                                  ;
        int                                                 Id [2]                                                   ; // PE, Lane
        int                                                 tId                                                      ; // transaction number

        //------------------------------------------------------------------------------------------------------
        // This struct contains the fields neccessary to form the stOp opcode
        // note: struct members cannot be rand, so fields outside this struct will be randomized and then applied to the struct fields
        rand pe_stOp_operation                                   stOp_operation                                                ;  // create this from the other fields in the class

        rand PE_DATA_TYPE                                        pe_stOp_stream_src_data_type   [`PE_NUM_OF_STREAMS_RANGE ]    ;
        rand PE_DATA_TYPE                                        pe_stOp_stream_dest_data_type  [`PE_NUM_OF_STREAMS_RANGE ]    ;

        rand PE_STOP_DEST                                        pe_stOp_stream_dest            [`PE_NUM_OF_STREAMS_RANGE ]    ;
        rand PE_STOP_SRC                                         pe_stOp_stream_src             [`PE_NUM_OF_STREAMS_RANGE ]    ;


        //------------------------------------------------------------------------------------------------------
        // Fields used to drive regFile inputs to the PE streamingOps_cntl module

        rand logic [`STREAMING_OP_CNTL_OPERATION_RANGE        ]   OpType                                            ; 
        rand logic [`STREAMING_OP_CNTL_OPERATION_OPCODE_RANGE ]   OpCode                                            ; 
        rand bit   [`PE_ARRAY_CHIPLET_ADDRESS_RANGE           ]   destinationAddress  [`PE_NUM_OF_STREAMS_RANGE ]   ;  
        rand bit   [`PE_ARRAY_CHIPLET_ADDRESS_RANGE           ]   sourceAddress       [`PE_NUM_OF_STREAMS_RANGE ]   ;  
     

        // Keep track of previous command
        // Assumes all operations are copies of a seed and this seed knows what has been generated previously
        base_operation                                      priorOperations[$]               ; // Queue to hold previous operations. empty except seed object
        base_operation                                      priorOperation                   ; // Queue to hold previous operations. empty except seed object
        int                                                 priorOperationNumberOfOperands   ;  // SV wont let me reference priorOperations as it might be null, so only reference priorOperations in post_randomize

        //------------------------------------------------------------------------------------------------------
        // These fields are used to aid with SV checkers, drivers and generators

        rand logic                                          enableDestinationStream   [`PE_NUM_OF_STREAMS_RANGE ]    ;  // the destination address is used
                                                                                                                        // can be used to enabled memory related checkers such as memory range checks
        rand logic                                          memoryAccessesLocalized                                  ;  // all memory accesses are restricted to lanes local memory allocation

        //------------------------------------------------------------------------------------------------------
        // Data to be transmitted down the stack bus

        // an array of operands that will be driven onto the stack bus, these words may be formed from other fields such as floating point operands
        rand bit [`PE_EXEC_LANE_WIDTH_RANGE ]               operands            [`PE_NUM_OF_STREAMS_RANGE ] []       ;
        rand int                                            numberOfOperands                                         ;

        // fields used by floating point operations
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
        

        //------------------------------------------------------------------------------------------------------
        // DEBUG
        



        int i,j,l,m;
     
        function new ();
                    this.timeTag = $time ;
        endfunction

        //------------------------------------------------------------------------------------------------------
        // Pre randomize

        function void pre_randomize();	//1 -> Turns on the constraint, 0-> Turns off the constraint
            // operations
            this.c_operationType_definedOrder .constraint_mode(1) ;
            this.c_operationType_all          .constraint_mode(0) ;
            this.c_operationType_fpMac        .constraint_mode(0) ;
            this.c_operationType_copyStdToMem .constraint_mode(0) ;
            //
            this.c_streamSize.constraint_mode(1)                 ;
            this.c_operandValues.constraint_mode(1)              ;
            this.c_memoryLocalized.constraint_mode(1)            ;
        endfunction : pre_randomize
        


        //------------------------------------------------------------------------------------------------------
        // Constraints

        constraint c_order {
            // we have some operation order dependencies. Dont perform a "from memory" operation unless there has been a "to memory" copy operation.
            solve    OpType             before    numberOfOperands                 ;
            solve    OpType             before    operandsSign                     ;
            solve    OpType             before    operandsExp                      ;
            solve    OpType             before    operandsSignificand              ;
            solve    OpType             before    OpCode                           ;
            solve    OpType             before    enableDestinationStream[0]       ;
            solve    OpType             before    enableDestinationStream[1]       ;  
            solve    OpType             before    pe_stOp_stream_dest[0]           ;
            solve    OpType             before    pe_stOp_stream_dest[1]           ;
            solve    OpType             before    pe_stOp_stream_src[0]            ;
            solve    OpType             before    pe_stOp_stream_src[1]            ;
            solve    OpType             before    pe_stOp_stream_src_data_type[0]  ;  
            solve    OpType             before    pe_stOp_stream_src_data_type[1]  ;  
            solve    OpType             before    pe_stOp_stream_dest_data_type[0] ;  
            solve    OpType             before    pe_stOp_stream_dest_data_type[1] ;  
            solve    OpType             before    destinationAddress               ;  
            solve    OpType             before    sourceAddress                    ;  
        }


        //----------------------------------------------------------------------------------------------------
        // Operation

        constraint c_operationType_definedOrder {

            (tId == 0) -> { OpType inside {`STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM  }};
            (tId == 1) -> { OpType inside {`STREAMING_OP_CNTL_OPERATION_STD_NONE_NOP_TO_MEM    }};
            (tId >= 2) -> { OpType inside {`STREAMING_OP_CNTL_OPERATION_MEM_STD_FP_MAC_TO_MEM  }};
        }

        constraint c_operationType_all {

                    OpType inside {`STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM, `STREAMING_OP_CNTL_OPERATION_STD_NONE_NOP_TO_MEM, `STREAMING_OP_CNTL_OPERATION_MEM_STD_FP_MAC_TO_MEM} ;
                    //OpCode inside {`STREAMING_OP_CNTL_OPERATION_FP_MAC               , `STREAMING_OP_CNTL_OPERATION_NOP                , `STREAMING_OP_CNTL_OPERATION_FP_MAC               } ;
        }

        constraint c_operationType_fpMac {
            OpType inside {`STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM } ;

            //OpCode inside {`STREAMING_OP_CNTL_OPERATION_FP_MAC                } ;
        }

        constraint c_operationType_copyStdToMem {
            OpType inside {`STREAMING_OP_CNTL_OPERATION_STD_NONE_NOP_TO_MEM  } ;

            //OpCode inside {`STREAMING_OP_CNTL_OPERATION_NOP                  } ;
        }

        //----------------------------------------------------------------------------------------------------
        // Fields based on operation

        constraint c_operationType_fields {

            (OpType == `STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM ) ->
                {
                    OpCode                               == `STREAMING_OP_CNTL_OPERATION_FP_MAC   ;
                    enableDestinationStream       [0]    == 1                                     ;  // destination address 0 is the location where result is written
                    enableDestinationStream       [1]    == 0                                     ;  
                    pe_stOp_stream_src            [0]    == PE_STOP_SRC_IS_STD                    ;
                    pe_stOp_stream_src            [1]    == PE_STOP_SRC_IS_STD                    ;
                    pe_stOp_stream_dest           [0]    == PE_STOP_DEST_IS_MEMORY                ;
                    pe_stOp_stream_dest           [1]    == PE_STOP_DEST_IS_NA                    ;
                    pe_stOp_stream_src_data_type  [0]    == PE_DATA_TYPE_WORD                     ;  
                    pe_stOp_stream_src_data_type  [1]    == PE_DATA_TYPE_WORD                     ;  
                    pe_stOp_stream_dest_data_type [0]    == PE_DATA_TYPE_WORD                     ;  
                    pe_stOp_stream_dest_data_type [1]    == PE_DATA_TYPE_NA                       ;  
                }
            (OpType == `STREAMING_OP_CNTL_OPERATION_STD_NONE_NOP_TO_MEM  ) ->
                {
                    OpCode                                == `STREAMING_OP_CNTL_OPERATION_NOP      ;
                    enableDestinationStream       [0]     == 1                                     ;  // destination address 0 is starting point for memory transfer from stack bus
                    enableDestinationStream       [1]     == 0                                     ;
                    pe_stOp_stream_src            [0]     == PE_STOP_SRC_IS_STD                    ;
                    pe_stOp_stream_src            [1]     == PE_STOP_SRC_IS_NA                     ;
                    pe_stOp_stream_dest           [0]     == PE_STOP_DEST_IS_MEMORY                ;
                    pe_stOp_stream_dest           [1]     == PE_STOP_DEST_IS_NA                    ;
                    pe_stOp_stream_src_data_type  [0]     == PE_DATA_TYPE_WORD                     ;  
                    pe_stOp_stream_src_data_type  [1]     == PE_DATA_TYPE_NA                       ;  
                    pe_stOp_stream_dest_data_type [0]     == PE_DATA_TYPE_WORD                     ;  
                    pe_stOp_stream_dest_data_type [1]     == PE_DATA_TYPE_NA                       ;  
                }
            (OpType == `STREAMING_OP_CNTL_OPERATION_MEM_STD_FP_MAC_TO_MEM ) ->
                {
                    OpCode                                == `STREAMING_OP_CNTL_OPERATION_FP_MAC   ;
                    enableDestinationStream       [0]     == 1                                     ;  // destination address 0 is starting point for memory transfer from stack bus
                    enableDestinationStream       [1]     == 0                                     ;
                    pe_stOp_stream_src            [0]     == PE_STOP_SRC_IS_MEMORY                 ;
                    pe_stOp_stream_src            [1]     == PE_STOP_SRC_IS_STD                    ;
                    pe_stOp_stream_dest           [0]     == PE_STOP_DEST_IS_MEMORY                ;
                    pe_stOp_stream_dest           [1]     == PE_STOP_DEST_IS_NA                    ;
                    pe_stOp_stream_src_data_type  [0]     == PE_DATA_TYPE_WORD                     ;  
                    pe_stOp_stream_src_data_type  [1]     == PE_DATA_TYPE_WORD                     ;  
                    pe_stOp_stream_dest_data_type [0]     == PE_DATA_TYPE_WORD                     ;  
                    pe_stOp_stream_dest_data_type [1]     == PE_DATA_TYPE_NA                       ;  
                }
        }

        //----------------------------------------------------------------------------------------------------
        // SIZE

        constraint c_numberOfOperands {
            // set number of operands same as memCopy in previous operation
            if (OpType == `STREAMING_OP_CNTL_OPERATION_MEM_STD_FP_MAC_TO_MEM ) {
                numberOfOperands == priorOperationNumberOfOperands;
            } else {
                //numberOfOperands inside {50};
                numberOfOperands inside {[200:500]};
                //numberOfOperands inside {[0:65535]};
            }
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

        //----------------------------------------------------------------------------------------------------
        // Address

        // Restrict address to the PE and Lane portion of local memory
        constraint c_restrictLaneAddress {

            destinationAddress[0] inside {[((Id[0] << `PE_CHIPLET_ADDRESS_WIDTH ) | (Id[1]<<`PE_CHIPLET_LANE_ADDRESS_WIDTH)) : ((Id[0] << `PE_CHIPLET_ADDRESS_WIDTH ) | (Id[1]<<`PE_CHIPLET_LANE_ADDRESS_WIDTH))+1024 ]};
            destinationAddress[1] inside {[0:127 ]};
        }

        constraint c_memoryLocalized {
            memoryAccessesLocalized  == 1 ;  
        }

        //----------------------------------------------------------------------------------------------------

        //----------------------------------------------------------------------------------------------------
        // Operands

        constraint c_operandValues {

            // choose reasonable floating point fields
            foreach (operandsExp         [i,j]) {
                    operandsExp[i][j] inside {[128:129]} ;
            }
            foreach (operandsSignificand         [i,j]) {
                    operandsSignificand[i][j] inside {[23'b010_0000_0000_0000_0000_0000:23'b110_0000_0000_0000_0000_0000]} ;
            }
        }

    
        //------------------------------------------------------------------------------------------------------
        // Post randomize

        function void post_randomize();
            result = 0.0 ;

            //------------------------------------------------------------------------------------------------------
            // Need to use prior operation if current operation uses memory for its operand

            // if previous operation is a copy to memory, then next operation will use that memory
            if (OpType == `STREAMING_OP_CNTL_OPERATION_MEM_STD_FP_MAC_TO_MEM ) 
                begin
                    sourceAddress[0] = this.priorOperations [$].destinationAddress[0] ;
                    //$display("@%0t:%s:%0d: LEE:base_operation.sv: {%0d,%0d} :  Prior destination address: %h \n", $time, `__FILE__, `__LINE__, Id[0], Id[1], this.priorOperations [$].destinationAddress[0]);
                end

            // if current operation has an operand coming from memory, we assume prior operation was a memCpy so use the prior operations zero operand to allow expected values to be calculated
            if (OpType == `STREAMING_OP_CNTL_OPERATION_MEM_STD_FP_MAC_TO_MEM ) 
                begin
                     //$display("@%0t:%s:%0d: LEE:base_operation.sv: {%0d,%0d} : Number of operands: curr = %d, prior = %d \n", $time, `__FILE__, `__LINE__, Id[0], Id[1], numberOfOperands, priorOperations [$].numberOfOperands );
                     // assume previous operation copied the stream0 to memory
                     for (int i=0; i<numberOfOperands; i++)
                         begin
                             // stack downstream uses stream 1 during mem_std_fp_mac_mem
                             //$display("@%0t:%s:%0d: LEE:base_operation.sv: {%0d,%0d} : operand: %d \n", $time, `__FILE__, `__LINE__, Id[0], Id[1], i);
                             //$display("@%0t:%s:%0d: LEE:base_operation.sv: {%0d,%0d} : operand: %d = %f\n", $time, `__FILE__, `__LINE__, Id[0], Id[1], i, operandsExp  [1][i]);
                             //$display("@%0t:%s:%0d: LEE:base_operation.sv: {%0d,%0d} : prior operand: %d = %f\n", $time, `__FILE__, `__LINE__, Id[0], Id[1], i, this.priorOperations[$].operandsExp  [0][i]);
                             operandsSign        [0][i]    = this.priorOperations [$].operandsSign        [0][i]  ;
                             operandsExp         [0][i]    = this.priorOperations [$].operandsExp         [0][i]  ;
                             operandsSignificand [0][i]    = this.priorOperations [$].operandsSignificand [0][i]  ;
                         end
                end


            //------------------------------------------------------------------------------------------------------


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

            //----------------------------------------------------------------------------------------------------
            // create regFile stOp_operation for streamingOps_cntl using constrained fields

            case (OpCode)
                `STREAMING_OP_CNTL_OPERATION_FP_MAC  :
                    begin
                        stOp_operation.numberOfDestStreams  = 1                       ;
                        stOp_operation.numberOfSrcStreams   = 2                       ;
                        stOp_operation.opcode               = PE_STOP_IS_FP_MAC       ;
                    end
                `STREAMING_OP_CNTL_OPERATION_NOP     :
                    begin
                        stOp_operation.numberOfDestStreams  = 1                       ;
                        stOp_operation.numberOfSrcStreams   = 1                       ;  // FIXME: should use both streams for memory copy. In which case memory width needs to be 64 bits to keep up
                        stOp_operation.opcode               = PE_STOP_IS_NOP          ;
                    end
/*
                default:
                    begin
                        stOp_operation.numberOfDestStreams  = 1                       ;
                        stOp_operation.numberOfSrcStreams   = 2                       ;
                        stOp_operation.opcode               = PE_STOP_IS_FP_MAC       ;
                    end
*/
            endcase
            stOp_operation.stream1_destination  = pe_stOp_stream_dest [1]    ;
            stOp_operation.stream0_destination  = pe_stOp_stream_dest [0]    ;
            stOp_operation.stream1_source       = pe_stOp_stream_src  [1]    ;
            stOp_operation.stream0_source       = pe_stOp_stream_src  [0]    ;
            //----------------------------------------------------------------------------------------------------

            // Keep copy of previous operations as they will influence future operations e.g. copy to memory influence o[erations getting operands from memory
            // This is only valid for our seed operation object and all only the seed operation object has its randomize method executed.
            priorOperation                             = new this           ;  // copy this and put in prior queue
            priorOperations.push_back(priorOperation)                       ;  
            priorOperationNumberOfOperands             =   numberOfOperands ;
          
            // DEBUG
/*
            if ((Id[0] == 0) && (Id[1] == 0))
                begin
                    for (int i=0; i<priorOperations.size; i++)
                        begin
                            $display("@%0t:%s:%0d: LEE:base_operation.sv: Operation %2d sent: {%0d,%0d} : %b: \n", $time, `__FILE__, `__LINE__, tId, Id[0], Id[1], priorOperations[i].stOp_operation );
                            this.displayOperation();
                        end
                end
*/

        

        endfunction : post_randomize
    

        //------------------------------------------------------------------------------------------------------
        // Methods

        function create();

        endfunction
    
        function displayOperation();
            $display("@%0t :%s:%0d:INFO:base_operation.sv: {PE,Lane} = {%2d,%2d}", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
            $display("@%0t :%s:%0d:INFO:base_operation.sv:{%0d,%0d}: stOp_operation : %b", $time, `__FILE__, `__LINE__, Id[0], Id[1], stOp_operation);
            $display("@%0t :%s:%0d:INFO:base_operation.sv:{%0d,%0d}: src{0,1},dest{0,1} : {%3b,%3b,%3b,%3b}", $time, `__FILE__, `__LINE__, Id[0], Id[1], pe_stOp_stream_src[0], pe_stOp_stream_src[1], pe_stOp_stream_dest[0], pe_stOp_stream_dest[1]);
            $display("@%0t :%s:%0d:INFO:base_operation.sv:{%0d,%0d}:      Source Address: {%h,%h}", $time, `__FILE__, `__LINE__, Id[0], Id[1], sourceAddress[0], sourceAddress[1]);
            $display("@%0t :%s:%0d:INFO:base_operation.sv:{%0d,%0d}: Destination Address: {%h,%h}", $time, `__FILE__, `__LINE__, Id[0], Id[1], destinationAddress[0], destinationAddress[1]);
            $display("@%0t :%s:%0d:INFO:base_operation.sv:{%0d,%0d}: Enable Destination: {%b,%b}", $time, `__FILE__, `__LINE__, Id[0], Id[1], enableDestinationStream[0], enableDestinationStream[1]);
            for (int i=0; i<numberOfOperands-1; i++)
                begin
                    operandsReal[0] = $bitstoshortreal({operands[0][i]});
                    operandsReal[1] = $bitstoshortreal({operands[1][i]});
                    $display("@%0t :%s:%0d:INFO:base_operation.sv:{%0d,%0d}: Operand %3d {%f, %f}, ", $time, `__FILE__, `__LINE__, Id[0], Id[1], i, operandsReal[0], operandsReal[1]);
                end
            $display("@%0t :%s:%0d:INFO:base_operation.sv:{%0d,%0d}: Result %f ", $time, `__FILE__, `__LINE__, Id[0], Id[1], result);

        endfunction
    
    endclass

    //------------------------------------------------------------------------------------------------------
    // Class

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




