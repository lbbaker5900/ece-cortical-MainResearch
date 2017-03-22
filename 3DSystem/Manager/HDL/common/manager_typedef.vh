`ifndef _manager_typedef_vh
`define _manager_typedef_vh


/*****************************************************************

    File name   : manager_typedef.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


//----------------------------------------------------------------------------------------------------
// Instruction Fields

// Descriptor Type
typedef enum logic [`MGR_INST_TYPE_RANGE   ] {
                                            MGR_INST_TYPE_NOP       = 0,  // Null
                                            MGR_INST_TYPE_MR        = 1,  // instruction contains memory read info
                                            MGR_INST_TYPE_MW        = 2,  // instruction contains memory read info
                                            MGR_INST_TYPE_OP        = 3,  // instruction contains PE operations
                                          } mgr_inst_desc_type;



//----------------------------------------------------------------------------------------------------
`endif

