`ifndef _stack_interface_typedef_vh
`define _stack_interface_typedef_vh


/*****************************************************************

    File name   : stack_interface_typedef.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Jan 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


typedef enum logic [`STACK_DOWN_OOB_INTF_TYPE_RANGE ] {
                                            STD_PACKET_TYPE_SCALAR        = 0,  // Operation may be uniquee per execution lane. Requires a larger WU packet - WIP
                                            STD_PACKET_TYPE_VECTOR        = 1,  // Operation is the same for all lanes. Data type, operation, number of operands etc.
                                            STD_PACKET_TYPE_NA            = {`STACK_DOWN_OOB_INTF_TYPE_SIZE{1'b1}}
                                          } stack_down_oob_type ;



`endif


