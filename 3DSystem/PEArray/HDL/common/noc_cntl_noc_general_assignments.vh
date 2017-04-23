

  // Convert the peId to a bit mask
  always @(*)
    begin
      case(peId)
      6'd0 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000000000000000000000001  ; 
        end
      6'd1 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000000000000000000000010  ; 
        end
      6'd2 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000000000000000000000100  ; 
        end
      6'd3 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000000000000000000001000  ; 
        end
      6'd4 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000000000000000000010000  ; 
        end
      6'd5 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000000000000000000100000  ; 
        end
      6'd6 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000000000000000001000000  ; 
        end
      6'd7 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000000000000000010000000  ; 
        end
      6'd8 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000000000000000100000000  ; 
        end
      6'd9 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000000000000001000000000  ; 
        end
      6'd10 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000000000000010000000000  ; 
        end
      6'd11 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000000000000100000000000  ; 
        end
      6'd12 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000000000001000000000000  ; 
        end
      6'd13 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000000000010000000000000  ; 
        end
      6'd14 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000000000100000000000000  ; 
        end
      6'd15 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000000001000000000000000  ; 
        end
      6'd16 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000000010000000000000000  ; 
        end
      6'd17 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000000100000000000000000  ; 
        end
      6'd18 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000001000000000000000000  ; 
        end
      6'd19 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000010000000000000000000  ; 
        end
      6'd20 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000000100000000000000000000  ; 
        end
      6'd21 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000001000000000000000000000  ; 
        end
      6'd22 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000010000000000000000000000  ; 
        end
      6'd23 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000000100000000000000000000000  ; 
        end
      6'd24 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000001000000000000000000000000  ; 
        end
      6'd25 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000010000000000000000000000000  ; 
        end
      6'd26 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000000100000000000000000000000000  ; 
        end
      6'd27 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000001000000000000000000000000000  ; 
        end
      6'd28 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000010000000000000000000000000000  ; 
        end
      6'd29 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000000100000000000000000000000000000  ; 
        end
      6'd30 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000001000000000000000000000000000000  ; 
        end
      6'd31 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000010000000000000000000000000000000  ; 
        end
      6'd32 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000000100000000000000000000000000000000  ; 
        end
      6'd33 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000001000000000000000000000000000000000  ; 
        end
      6'd34 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000010000000000000000000000000000000000  ; 
        end
      6'd35 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000000100000000000000000000000000000000000  ; 
        end
      6'd36 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000001000000000000000000000000000000000000  ; 
        end
      6'd37 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000010000000000000000000000000000000000000  ; 
        end
      6'd38 :
        begin
          thisPeBitMask = 64'b0000000000000000000000000100000000000000000000000000000000000000  ; 
        end
      6'd39 :
        begin
          thisPeBitMask = 64'b0000000000000000000000001000000000000000000000000000000000000000  ; 
        end
      6'd40 :
        begin
          thisPeBitMask = 64'b0000000000000000000000010000000000000000000000000000000000000000  ; 
        end
      6'd41 :
        begin
          thisPeBitMask = 64'b0000000000000000000000100000000000000000000000000000000000000000  ; 
        end
      6'd42 :
        begin
          thisPeBitMask = 64'b0000000000000000000001000000000000000000000000000000000000000000  ; 
        end
      6'd43 :
        begin
          thisPeBitMask = 64'b0000000000000000000010000000000000000000000000000000000000000000  ; 
        end
      6'd44 :
        begin
          thisPeBitMask = 64'b0000000000000000000100000000000000000000000000000000000000000000  ; 
        end
      6'd45 :
        begin
          thisPeBitMask = 64'b0000000000000000001000000000000000000000000000000000000000000000  ; 
        end
      6'd46 :
        begin
          thisPeBitMask = 64'b0000000000000000010000000000000000000000000000000000000000000000  ; 
        end
      6'd47 :
        begin
          thisPeBitMask = 64'b0000000000000000100000000000000000000000000000000000000000000000  ; 
        end
      6'd48 :
        begin
          thisPeBitMask = 64'b0000000000000001000000000000000000000000000000000000000000000000  ; 
        end
      6'd49 :
        begin
          thisPeBitMask = 64'b0000000000000010000000000000000000000000000000000000000000000000  ; 
        end
      6'd50 :
        begin
          thisPeBitMask = 64'b0000000000000100000000000000000000000000000000000000000000000000  ; 
        end
      6'd51 :
        begin
          thisPeBitMask = 64'b0000000000001000000000000000000000000000000000000000000000000000  ; 
        end
      6'd52 :
        begin
          thisPeBitMask = 64'b0000000000010000000000000000000000000000000000000000000000000000  ; 
        end
      6'd53 :
        begin
          thisPeBitMask = 64'b0000000000100000000000000000000000000000000000000000000000000000  ; 
        end
      6'd54 :
        begin
          thisPeBitMask = 64'b0000000001000000000000000000000000000000000000000000000000000000  ; 
        end
      6'd55 :
        begin
          thisPeBitMask = 64'b0000000010000000000000000000000000000000000000000000000000000000  ; 
        end
      6'd56 :
        begin
          thisPeBitMask = 64'b0000000100000000000000000000000000000000000000000000000000000000  ; 
        end
      6'd57 :
        begin
          thisPeBitMask = 64'b0000001000000000000000000000000000000000000000000000000000000000  ; 
        end
      6'd58 :
        begin
          thisPeBitMask = 64'b0000010000000000000000000000000000000000000000000000000000000000  ; 
        end
      6'd59 :
        begin
          thisPeBitMask = 64'b0000100000000000000000000000000000000000000000000000000000000000  ; 
        end
      6'd60 :
        begin
          thisPeBitMask = 64'b0001000000000000000000000000000000000000000000000000000000000000  ; 
        end
      6'd61 :
        begin
          thisPeBitMask = 64'b0010000000000000000000000000000000000000000000000000000000000000  ; 
        end
      6'd62 :
        begin
          thisPeBitMask = 64'b0100000000000000000000000000000000000000000000000000000000000000  ; 
        end
      6'd63 :
        begin
          thisPeBitMask = 64'b1000000000000000000000000000000000000000000000000000000000000000  ; 
        end
      default:
        begin
          thisPeBitMask = 'd0 ; 
        end
      endcase
    end

    wire  port0_localInqReq          ; // Request from an input port after being gated with local bitMask
    reg   port0_localInqPriority     ; // Indicate whether packet is Control or Data
    reg   port0_localInqAck          ; // accept request from input port
    reg   port0_localInqEnable       ; // Indicate when input q is able to take data
    wire  port1_localInqReq          ; // Request from an input port after being gated with local bitMask
    reg   port1_localInqPriority     ; // Indicate whether packet is Control or Data
    reg   port1_localInqAck          ; // accept request from input port
    reg   port1_localInqEnable       ; // Indicate when input q is able to take data
    wire  port2_localInqReq          ; // Request from an input port after being gated with local bitMask
    reg   port2_localInqPriority     ; // Indicate whether packet is Control or Data
    reg   port2_localInqAck          ; // accept request from input port
    reg   port2_localInqEnable       ; // Indicate when input q is able to take data
    wire  port3_localInqReq          ; // Request from an input port after being gated with local bitMask
    reg   port3_localInqPriority     ; // Indicate whether packet is Control or Data
    reg   port3_localInqAck          ; // accept request from input port
    reg   port3_localInqEnable       ; // Indicate when input q is able to take data

    //------------------------------------------------
    //wire                            local_OutqReq     ;
    //reg                             local_OutqAck     ;
    //reg                             local_OutqEnable  ;
    //wire                            port1_OutqReq     ;
    //reg                             port1_OutqAck     ;
    //reg                             port1_OutqEnable  ;
    //wire                            port2_OutqReq     ;
    //reg                             port2_OutqAck     ;
    //reg                             port2_OutqEnable  ;
    //wire                            port3_OutqReq     ;
    //reg                             port3_OutqAck     ;
    //reg                             port3_OutqEnable  ;
  reg  local_port0_OutqAck   ;  // the local input queue is actually an output for the port input controllers
  wire local_port0_OutqReady ;  // so ck the request from the port input controller
  reg  local_port1_OutqAck   ;  // the local input queue is actually an output for the port input controllers
  wire local_port1_OutqReady ;  // so ck the request from the port input controller
  reg  local_port2_OutqAck   ;  // the local input queue is actually an output for the port input controllers
  wire local_port2_OutqReady ;  // so ck the request from the port input controller
  reg  local_port3_OutqAck   ;  // the local input queue is actually an output for the port input controllers
  wire local_port3_OutqReady ;  // so ck the request from the port input controller