//---------------------------------------------------------------------------
// Copyright 2016 Tezzaron Semiconductor
//    All Rights Reserved
//    This file includes the confidential information of Tezzaron Semiconductor.
//    The receiver of this confidential information shall not disclose it
//    to any third party and shall protect its confidentiality.
//---------------------------------------------------------------------------
//   Warranty:
//   Use all material in this file at your own risk. 
//   Tezzaron Semiconductor makes no claims about any material
//   contained in this file.
//---------------------------------------------------------------------------
// Rev 0.91
//---------------------------------------------------------------------------
parameter DEBUG_ON = 0; // Turn on Debug messages by making this '1'
parameter PROT_CHK_OFF = 0; // Turn off Protocol Checker by making this '1'

parameter STOP_ON_ERROR = 0; // Default: 0 means doesn't stop simulation when
                             //          encounters ERROR.
                             // For any integer 1 or more will be counted for
                             // each occurence of ERROR and after those many counts,
                             // the simulation stops.

parameter STOP_ON_FATAL = 0; // Default: 1 means stops simulation when encounters FATAL.
                             //          0 means Doesn't stop even encounters FATAL.

typedef enum integer {PAGE_CLOSE, PAGE_OPEN, PAGE_REFRESH, CACHE_READ, CACHE_WRITE} fsm_state_e;

//---------------------------------------------------------------------------
// Checker Clock Count details, for Burst Length = 8 or BL_8 mode
//---------------------------------------------------------------------------
localparam  tCRCR8 =  8; // Cycles, Minimum Cache Read  to Cache Read
localparam  tCRCW8 =  8; // Cycles, Minimum Cache Read  to Cache Write
localparam  tCRPC8 =  9; // Cycles, Minimum Cache Read  to Page Close
localparam  tCWCR8 = 10; // Cycles, Minimum Cache Write to Cache Read
localparam  tCWCW8 =  8; // Cycles, Minimum Cache Write to Cache Write
localparam  tCWPC8 = 11; // Cycles, Minimum Cache Write to Page Close

//---------------------------------------------------------------------------
// Checker Clock Count details, for Burst Length = 2 or BL_2 mode
//---------------------------------------------------------------------------
localparam  tCRCR2 =  2; // Cycles, Minimum Cache Read  to Cache Read
localparam  tCRCW2 =  2; // Cycles, Minimum Cache Read  to Cache Write
localparam  tCRPC2 =  3; // Cycles, Minimum Cache Read  to Page Close
localparam  tCWCR2 =  4; // Cycles, Minimum Cache Write to Cache Read
localparam  tCWCW2 =  2; // Cycles, Minimum Cache Write to Cache Write
localparam  tCWPC2 =  5; // Cycles, Minimum Cache Write to Page Close

//---------------------------------------------------------------------------
// Checker timing details, General (independent of any mode)
//---------------------------------------------------------------------------
localparam tPOPO = 19.0ns; // Minimum Page Open    to Page Open
localparam tPOPC =  9.0ns; // Minimum Page Open    to Page Close
localparam tPCPO = 10.0ns; // Minimum Page Close   to Page Open
localparam tPCPR = 10.0ns; // Minimum Page Close   to Page Refresh
localparam tPRPO = 19.0ns; // Minimum Page Refresh to Page Open
localparam tPRPR = 19.0ns; // Minimum Page Refresh to Page Refresh

//---------------------------------------------------------------------------
// Checker timing details for Aligned BL_2 or BL_8 modes
//---------------------------------------------------------------------------
localparam  tPOCWA =  3.0ns;     // Minimum Page Open to Cache Write
localparam  tPOCRA =  3.0ns;     // Minimum Page Open to Cache Read

//---------------------------------------------------------------------------
// Checker timing details for Unaligned BL_2 mode
//---------------------------------------------------------------------------
localparam  tPOCWU =  9.0ns;     // Minimum Page Open to Cache Write
localparam  tPOCRU =  9.0ns;     // Minimum Page Open to Cache Read

//---------------------------------------------------------------------------
// Checker timing details for Adjacency bank checks
//---------------------------------------------------------------------------
localparam tadjPOPC =  9.0ns;
localparam tadjPOPR =  9.0ns;
localparam tadjPOPO =  9.0ns;

localparam tadjPCPO = 10.0ns;
localparam tadjPCPR = 10.0ns;
localparam tadjPCPC = 10.0ns;

localparam tadjPRPC = 19.0ns;
localparam tadjPRPO = 19.0ns;
localparam tadjPRPR = 19.0ns;

//==============================================================================
//                                  THE END
//==============================================================================
