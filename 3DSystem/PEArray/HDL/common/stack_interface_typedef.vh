`ifndef _stack_interface_typedef_vh
`define _stack_interface_typedef_vh


/*****************************************************************

    File name   : stack_interface_typedef.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Jan 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


//----------------------------------------------------------------------------------------------------
// Downstream

typedef enum logic [`STACK_DOWN_OOB_INTF_TYPE_RANGE ] {
                                            STD_PACKET_OOB_TYPE_SCALAR        = 0,  // Operation may be uniquee per execution lane. Requires a larger WU packet - WIP
                                            STD_PACKET_OOB_TYPE_VECTOR        = 1,  // Operation is the same for all lanes. Data type, operation, number of operands etc.
                                            STD_PACKET_OOB_TYPE_PE_OP_CMD     = 2,  // Operation is the same for all lanes. Data type, operation, number of operands etc.
                                            STD_PACKET_OOB_TYPE_NA            = {`STACK_DOWN_OOB_INTF_TYPE_WIDTH{1'b1}}
                                          } stack_down_oob_type ;

// FIXME : set to {optionType=stOp, stOp_values},{optionType=simdOp, simd_values} from python/DNNconnectivity/dnnConnectivityAndMemoryAllocation.py
// Currently not used. Couldnt figure out how to add multiple types into another type

typedef enum logic [`STACK_DOWN_OOB_INTF_DATA_RANGE ] {
                                            STD_PACKET_OOB_DATA_PE_OP_CMD     = {{8'd2, 8'd6},{8'd1, 8'd5}}, // {{val, option},{{val, option}}
                                            STD_PACKET_OOB_DATA_NA            = {`STACK_DOWN_OOB_INTF_TYPE_SIZE {1'b0}}
                                          } stack_down_oob_data ;


// Options for : {val, option}
typedef enum logic [`STACK_DOWN_OOB_INTF_OPTION_SIZE -1:0 ] {
                                            STD_PACKET_OOB_OPT_NOP               = 8'hFF,
                                            STD_PACKET_OOB_OPT_TAG               = 8'd4,
                                            STD_PACKET_OOB_OPT_STOP_CMD          = 8'd5,
                                            STD_PACKET_OOB_OPT_SIMD_RELU_CMD     = 8'd6  // doesnt work `STACK_DOWN_OOB_INTF_OPTION_SIZE 'd6
                                          } stack_down_oob_option ;

//----------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------
// Upstream

typedef enum logic [`STACK_UP_INTF_TYPE_RANGE ] {
                                            STU_PACKET_TYPE_DATA          = 0,  // Operation may be uniquee per execution lane. Requires a larger WU packet - WIP
                                            STU_PACKET_TYPE_CONTROL       = 1,  // Operation is the same for all lanes. Data type, operation, number of operands etc.
                                            STU_PACKET_TYPE_NA            = {`STACK_UP_INTF_TYPE_WIDTH{1'b1}}
                                          } stack_up_type ;





//----------------------------------------------------------------------------------------------------
`endif

