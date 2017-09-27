

  // Convert the sys__mgr__mgrId to a bit mask
  // This bitMask is used to determine if any incoming NoC packets are addressing the local port
  always @(*)
    begin
      case(sys__mgr__mgrId)
      2'd0 :
        begin
          thisMgrBitMask = 4'b0001  ; 
        end
      2'd1 :
        begin
          thisMgrBitMask = 4'b0010  ; 
        end
      2'd2 :
        begin
          thisMgrBitMask = 4'b0100  ; 
        end
      2'd3 :
        begin
          thisMgrBitMask = 4'b1000  ; 
        end
      default:
        begin
          thisMgrBitMask = 'd0 ; 
        end
      endcase
    end
