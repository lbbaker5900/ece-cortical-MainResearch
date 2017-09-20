

  // Set bit in rs1 for each enabled lane
  // In this case, '1' means one active lane. We accommodate no active lanes but not sure that will ever be used
      6'd32 :
        begin
          execLanesActive = 32'b11111111111111111111111111111111  ; 
        end
      6'd31 :
        begin
          execLanesActive = 32'b01111111111111111111111111111111  ; 
        end
      6'd30 :
        begin
          execLanesActive = 32'b00111111111111111111111111111111  ; 
        end
      6'd29 :
        begin
          execLanesActive = 32'b00011111111111111111111111111111  ; 
        end
      6'd28 :
        begin
          execLanesActive = 32'b00001111111111111111111111111111  ; 
        end
      6'd27 :
        begin
          execLanesActive = 32'b00000111111111111111111111111111  ; 
        end
      6'd26 :
        begin
          execLanesActive = 32'b00000011111111111111111111111111  ; 
        end
      6'd25 :
        begin
          execLanesActive = 32'b00000001111111111111111111111111  ; 
        end
      6'd24 :
        begin
          execLanesActive = 32'b00000000111111111111111111111111  ; 
        end
      6'd23 :
        begin
          execLanesActive = 32'b00000000011111111111111111111111  ; 
        end
      6'd22 :
        begin
          execLanesActive = 32'b00000000001111111111111111111111  ; 
        end
      6'd21 :
        begin
          execLanesActive = 32'b00000000000111111111111111111111  ; 
        end
      6'd20 :
        begin
          execLanesActive = 32'b00000000000011111111111111111111  ; 
        end
      6'd19 :
        begin
          execLanesActive = 32'b00000000000001111111111111111111  ; 
        end
      6'd18 :
        begin
          execLanesActive = 32'b00000000000000111111111111111111  ; 
        end
      6'd17 :
        begin
          execLanesActive = 32'b00000000000000011111111111111111  ; 
        end
      6'd16 :
        begin
          execLanesActive = 32'b00000000000000001111111111111111  ; 
        end
      6'd15 :
        begin
          execLanesActive = 32'b00000000000000000111111111111111  ; 
        end
      6'd14 :
        begin
          execLanesActive = 32'b00000000000000000011111111111111  ; 
        end
      6'd13 :
        begin
          execLanesActive = 32'b00000000000000000001111111111111  ; 
        end
      6'd12 :
        begin
          execLanesActive = 32'b00000000000000000000111111111111  ; 
        end
      6'd11 :
        begin
          execLanesActive = 32'b00000000000000000000011111111111  ; 
        end
      6'd10 :
        begin
          execLanesActive = 32'b00000000000000000000001111111111  ; 
        end
      6'd9 :
        begin
          execLanesActive = 32'b00000000000000000000000111111111  ; 
        end
      6'd8 :
        begin
          execLanesActive = 32'b00000000000000000000000011111111  ; 
        end
      6'd7 :
        begin
          execLanesActive = 32'b00000000000000000000000001111111  ; 
        end
      6'd6 :
        begin
          execLanesActive = 32'b00000000000000000000000000111111  ; 
        end
      6'd5 :
        begin
          execLanesActive = 32'b00000000000000000000000000011111  ; 
        end
      6'd4 :
        begin
          execLanesActive = 32'b00000000000000000000000000001111  ; 
        end
      6'd3 :
        begin
          execLanesActive = 32'b00000000000000000000000000000111  ; 
        end
      6'd2 :
        begin
          execLanesActive = 32'b00000000000000000000000000000011  ; 
        end
      6'd1 :
        begin
          execLanesActive = 32'b00000000000000000000000000000001  ; 
        end