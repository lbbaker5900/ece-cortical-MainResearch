

  // Convert the mgrId of the pointer to a bit mask
  always @(*)
    begin
      case(currPtrManager)
      2'd0 :
        begin
          currPtrDestBitMaskAddr = 4'b0001  ; 
        end
      2'd1 :
        begin
          currPtrDestBitMaskAddr = 4'b0010  ; 
        end
      2'd2 :
        begin
          currPtrDestBitMaskAddr = 4'b0100  ; 
        end
      2'd3 :
        begin
          currPtrDestBitMaskAddr = 4'b1000  ; 
        end
      default:
        begin
          currPtrDestBitMaskAddr = 4'd0 ; 
        end
      endcase
    end
