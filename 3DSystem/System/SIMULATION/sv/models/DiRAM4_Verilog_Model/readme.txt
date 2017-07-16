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


File Descriptions:
------------------
diram4.sv                                -- DiRAM4 Model
diram4_params.svh                        -- file of parameters used by the model
diram4_ram_params.svh                    -- header file for protocol checker and
                                            ram timing constraints from data-sheet.
diram4_memory.txt.sample_BL2             -- Sample BL2 memory init file
diram4_memory.txt.sample_BL8             -- Sample BL8 memory init file
readme.txt                               -- instructions for using the model


Memory Allocation:
------------------
The memory is implemented as an associative array in SystemVerilog.
Each entry in the associative array holds a burst length of eight data.


Burst Length Options:
---------------------
The model supports a burst length of two or eight.
The default burst length is two, which may be changed by overriding the BL parameter.


Defining the channel clock phases:
----------------------------------
The Dual Single Data Rate (DSDR) interface carries an even channel and an odd channel.
The channels use opposite edges of the interface clock.
The even channel uses the rising edge of CK, and the odd channel using the falling edge.
The channel clocks are half frequency clocks that are 90 degrees out of phase from each other.
The phase of the channel clock determines how the channel commands are interpreted.
To change the default channel clock phase, use a compiler directive to invert the clocks.
For example:

   Simulator    Command Line
   ---------    ------------
   ModelSim     vlog +define+INVERT_CHNL_CLK diram4.sv
   NC-Verilog   ncverilog +define+INVERT_CHNL_CLK diram4.sv   
   VCS          vcs +define+INVERT_CHNL_CLK diram4.sv   


Loading initial memory value from a file
----------------------------------------
In order to load the memory with some initial value from a file, please follow
the following procedure:
1) Change the parameter DO_MEM_INIT from 0 to 1 in the module instantiation.
2) Change the parameter MEM_INIT_FILE from "diram4_memory.txt"
   to your actual memory initialization file name in the module instantiation.
   You may also change these parameters from your testbench file using defparam statements.
   Example:
      defparam your_diram4_model_instance.DO_MEM_INIT = 1;
      defparam your_diram4_model_instance.MEM_INIT_FILE = "your_init_mem_file.txt";
   Please note that these are compile time selections.

   To create a memory_init file follow the format given in the accompanied
   (a) diram4_memory.txt.sample_BL_2 or
   (b) diram4_memory.txt.sample_BL_8
   This file should be available in the current working directory
   from where the simulation is being run.

Alternately, pass the plusarg "+DIRAM4_LOAD_MEM_FILE=your_init_mem_file.txt "
in your simulation command and the file will be read.


Integrated Protocol Checker for timing requirements
---------------------------------------------------
The model comes with an integrated checker that ensures time gaps between commands
do not violate the minimum constraints as specified in the data-sheet. This protocol 
checker is active (turned on) by default. This can be de-activated (turned off) by
simulator command line argument, +DIRAM4_PROT_CHK_OFF.

The Protocol Checker reports two types of violations, ERROR and FATAL.
It checks for timing violations for back to back commands to the same
bank as well as adjacent busy banks.

[1] FATAL is reported when illegal sequence of commands are seen at the interface.
The default behavior is the simulation will be stopped by the Checker when
FATAL violations are detected. However, if you want to continue simulation
in spite of FATAL violation, recompile the model with "STOP_ON_FATAL = 0;"
in the diram4_ram_params.svh file.

[2] ERROR is reported when a legal sequence of commands are detected at the
interface violating the minimum timing or clock cycle constraints as given
in the data-sheet. The default behavior is that the simulation will not stop
even if ERRORs are detected. However, in order to stop simulation after N (integer)
number of ERRORs, recompile the model with "STOP_ON_ERROR = N;"
in the diram4_ram_params.svh file.


Training of DiRAM4 ports:
-------------------------
DiRAM4 input ports can be trained for net delays and phase alignment.
At the same time the model also generates training pattern at its output
ports in order to train the input ports of the host device (or a testbench
in simulation mode) connected to the DiRAM4.

In order to enable training use the plusarg "+DIRAM4_TRAINING_MODE" in the
command line.  

Upon invocation of training mode, the following training algorithm occurs:
1) The "host device" sends training pattern to the DiRAM4 on each of its 
input ports.
2) The DiRAM4 model detects the training pattern and properly accounts for 
skew among the inputs. Then the model will output the training pattern on 
each of the DiRAM4 outputs.
3) The host device can then align its own inputs using the training pattern.
Once done, the host device stops sending the training pattern on the DiRAM4
input ports.
4) The DiRAM4 model detects the loss of the training pattern and stops
sending the training pattern on its output ports, thus entering command
processing mode.
5) The host device can then detect the loss of the training pattern, thus
indicating it too can enter command processing mode.

NOTE:
[1] If set for training mode, the five steps shown above must be completed in
order for the DiRAM4 model to perform normal command processing.
[2] Training mode simulation is disabled by default.
[3] The training pattern is a 16-bit binary 1110_1000_1001_1010 (0xE89A) code,
proprietary to Tezzaron Semiconductor.
[4] The input skews are limited to a clock period (1000pS).

