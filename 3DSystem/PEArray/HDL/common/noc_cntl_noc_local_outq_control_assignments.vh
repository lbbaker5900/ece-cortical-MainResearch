

  // Convert the dma request address to a bit mask
  always @(*)
    begin
      case(local_destinationPeId)
      2'd0 :
        begin
          local_destinationReqAddr = 4'b0001  ; 
        end
      2'd1 :
        begin
          local_destinationReqAddr = 4'b0010  ; 
        end
      2'd2 :
        begin
          local_destinationReqAddr = 4'b0100  ; 
        end
      2'd3 :
        begin
          local_destinationReqAddr = 4'b1000  ; 
        end
      default:
        begin
          local_destinationReqAddr = 'd0 ; 
        end
      endcase
    end
