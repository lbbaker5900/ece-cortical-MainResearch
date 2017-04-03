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
//
// FIXME : PYTHON
// Must match DescriptorType in dnnCoonectivityAndMemoryAllocation.py python script
// Descriptor Type
typedef enum logic [`MGR_INST_TYPE_RANGE   ] {
                                            MGR_INST_TYPE_NOP       = 0,  // Null
                                            MGR_INST_TYPE_OP        = 1,  // instruction contains PE operations
                                            MGR_INST_TYPE_MR        = 2,  // instruction contains memory read info
                                            MGR_INST_TYPE_MW        = 3   // instruction contains memory read info
                                          } mgr_inst_desc_type;



//----------------------------------------------------------------------------------------------------
`endif

