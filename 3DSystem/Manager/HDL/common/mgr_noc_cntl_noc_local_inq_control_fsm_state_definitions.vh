
//------------------------------------------------
// MGR_NOC_CONT_LOCAL_INQ_CNTL_LOCAL_INPUT_QUEUE_CONTROL_STATE width
//------------------------------------------------
`define MGR_NOC_CONT_LOCAL_INQ_CNTL_STATE_MSB            12
`define MGR_NOC_CONT_LOCAL_INQ_CNTL_STATE_LSB            0
`define MGR_NOC_CONT_LOCAL_INQ_CNTL_STATE_SIZE           (`MGR_NOC_CONT_LOCAL_INQ_CNTL_STATE_MSB - `MGR_NOC_CONT_LOCAL_INQ_CNTL_STATE_LSB +1)
`define MGR_NOC_CONT_LOCAL_INQ_CNTL_STATE_RANGE           `MGR_NOC_CONT_LOCAL_INQ_CNTL_STATE_MSB : `MGR_NOC_CONT_LOCAL_INQ_CNTL_STATE_LSB

//------------------------------------------------------------------------------------------------
//------------------------------------------------
// MGR_NOC_CONT_LOCAL_INQ_CNTL state machine states
//------------------------------------------------

`define MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT        13'd1
`define MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER0            13'd2
`define MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP0                13'd4
`define MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD0       13'd8
`define MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER1            13'd16
`define MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP1                13'd32
`define MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD1       13'd64
`define MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER2            13'd128
`define MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP2                13'd256
`define MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD2       13'd512
`define MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER3            13'd1024
`define MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP3                13'd2048
`define MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD3       13'd4096