

  // Convert the dma request address to a bit mask
  always @(*)
    begin
      case(local_destinationPeId)
      6'd0 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000000000000000000000001  ; 
        end
      6'd1 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000000000000000000000010  ; 
        end
      6'd2 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000000000000000000000100  ; 
        end
      6'd3 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000000000000000000001000  ; 
        end
      6'd4 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000000000000000000010000  ; 
        end
      6'd5 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000000000000000000100000  ; 
        end
      6'd6 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000000000000000001000000  ; 
        end
      6'd7 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000000000000000010000000  ; 
        end
      6'd8 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000000000000000100000000  ; 
        end
      6'd9 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000000000000001000000000  ; 
        end
      6'd10 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000000000000010000000000  ; 
        end
      6'd11 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000000000000100000000000  ; 
        end
      6'd12 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000000000001000000000000  ; 
        end
      6'd13 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000000000010000000000000  ; 
        end
      6'd14 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000000000100000000000000  ; 
        end
      6'd15 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000000001000000000000000  ; 
        end
      6'd16 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000000010000000000000000  ; 
        end
      6'd17 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000000100000000000000000  ; 
        end
      6'd18 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000001000000000000000000  ; 
        end
      6'd19 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000010000000000000000000  ; 
        end
      6'd20 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000000100000000000000000000  ; 
        end
      6'd21 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000001000000000000000000000  ; 
        end
      6'd22 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000010000000000000000000000  ; 
        end
      6'd23 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000000100000000000000000000000  ; 
        end
      6'd24 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000001000000000000000000000000  ; 
        end
      6'd25 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000010000000000000000000000000  ; 
        end
      6'd26 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000000100000000000000000000000000  ; 
        end
      6'd27 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000001000000000000000000000000000  ; 
        end
      6'd28 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000010000000000000000000000000000  ; 
        end
      6'd29 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000000100000000000000000000000000000  ; 
        end
      6'd30 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000001000000000000000000000000000000  ; 
        end
      6'd31 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000010000000000000000000000000000000  ; 
        end
      6'd32 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000000100000000000000000000000000000000  ; 
        end
      6'd33 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000001000000000000000000000000000000000  ; 
        end
      6'd34 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000010000000000000000000000000000000000  ; 
        end
      6'd35 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000000100000000000000000000000000000000000  ; 
        end
      6'd36 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000001000000000000000000000000000000000000  ; 
        end
      6'd37 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000010000000000000000000000000000000000000  ; 
        end
      6'd38 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000000100000000000000000000000000000000000000  ; 
        end
      6'd39 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000001000000000000000000000000000000000000000  ; 
        end
      6'd40 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000010000000000000000000000000000000000000000  ; 
        end
      6'd41 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000000100000000000000000000000000000000000000000  ; 
        end
      6'd42 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000001000000000000000000000000000000000000000000  ; 
        end
      6'd43 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000010000000000000000000000000000000000000000000  ; 
        end
      6'd44 :
        begin
          local_destinationReqAddr = 64'b0000000000000000000100000000000000000000000000000000000000000000  ; 
        end
      6'd45 :
        begin
          local_destinationReqAddr = 64'b0000000000000000001000000000000000000000000000000000000000000000  ; 
        end
      6'd46 :
        begin
          local_destinationReqAddr = 64'b0000000000000000010000000000000000000000000000000000000000000000  ; 
        end
      6'd47 :
        begin
          local_destinationReqAddr = 64'b0000000000000000100000000000000000000000000000000000000000000000  ; 
        end
      6'd48 :
        begin
          local_destinationReqAddr = 64'b0000000000000001000000000000000000000000000000000000000000000000  ; 
        end
      6'd49 :
        begin
          local_destinationReqAddr = 64'b0000000000000010000000000000000000000000000000000000000000000000  ; 
        end
      6'd50 :
        begin
          local_destinationReqAddr = 64'b0000000000000100000000000000000000000000000000000000000000000000  ; 
        end
      6'd51 :
        begin
          local_destinationReqAddr = 64'b0000000000001000000000000000000000000000000000000000000000000000  ; 
        end
      6'd52 :
        begin
          local_destinationReqAddr = 64'b0000000000010000000000000000000000000000000000000000000000000000  ; 
        end
      6'd53 :
        begin
          local_destinationReqAddr = 64'b0000000000100000000000000000000000000000000000000000000000000000  ; 
        end
      6'd54 :
        begin
          local_destinationReqAddr = 64'b0000000001000000000000000000000000000000000000000000000000000000  ; 
        end
      6'd55 :
        begin
          local_destinationReqAddr = 64'b0000000010000000000000000000000000000000000000000000000000000000  ; 
        end
      6'd56 :
        begin
          local_destinationReqAddr = 64'b0000000100000000000000000000000000000000000000000000000000000000  ; 
        end
      6'd57 :
        begin
          local_destinationReqAddr = 64'b0000001000000000000000000000000000000000000000000000000000000000  ; 
        end
      6'd58 :
        begin
          local_destinationReqAddr = 64'b0000010000000000000000000000000000000000000000000000000000000000  ; 
        end
      6'd59 :
        begin
          local_destinationReqAddr = 64'b0000100000000000000000000000000000000000000000000000000000000000  ; 
        end
      6'd60 :
        begin
          local_destinationReqAddr = 64'b0001000000000000000000000000000000000000000000000000000000000000  ; 
        end
      6'd61 :
        begin
          local_destinationReqAddr = 64'b0010000000000000000000000000000000000000000000000000000000000000  ; 
        end
      6'd62 :
        begin
          local_destinationReqAddr = 64'b0100000000000000000000000000000000000000000000000000000000000000  ; 
        end
      6'd63 :
        begin
          local_destinationReqAddr = 64'b1000000000000000000000000000000000000000000000000000000000000000  ; 
        end
      default:
        begin
          local_destinationReqAddr = 'd0 ; 
        end
      endcase
    end
