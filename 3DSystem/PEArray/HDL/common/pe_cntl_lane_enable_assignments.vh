

  // Set bit in rs1 for each enabled lane
  // In this case, '0' means one active lane e.g. always at least one active
      5'd31 :
        begin
          execLanesActive = 32'b11111111111111111111111111111111  ; 
        end
      5'd30 :
        begin
          execLanesActive = 32'b01111111111111111111111111111111  ; 
        end
      5'd29 :
        begin
          execLanesActive = 32'b00111111111111111111111111111111  ; 
        end
      5'd28 :
        begin
          execLanesActive = 32'b00011111111111111111111111111111  ; 
        end
      5'd27 :
        begin
          execLanesActive = 32'b00001111111111111111111111111111  ; 
        end
      5'd26 :
        begin
          execLanesActive = 32'b00000111111111111111111111111111  ; 
        end
      5'd25 :
        begin
          execLanesActive = 32'b00000011111111111111111111111111  ; 
        end
      5'd24 :
        begin
          execLanesActive = 32'b00000001111111111111111111111111  ; 
        end
      5'd23 :
        begin
          execLanesActive = 32'b00000000111111111111111111111111  ; 
        end
      5'd22 :
        begin
          execLanesActive = 32'b00000000011111111111111111111111  ; 
        end
      5'd21 :
        begin
          execLanesActive = 32'b00000000001111111111111111111111  ; 
        end
      5'd20 :
        begin
          execLanesActive = 32'b00000000000111111111111111111111  ; 
        end
      5'd19 :
        begin
          execLanesActive = 32'b00000000000011111111111111111111  ; 
        end
      5'd18 :
        begin
          execLanesActive = 32'b00000000000001111111111111111111  ; 
        end
      5'd17 :
        begin
          execLanesActive = 32'b00000000000000111111111111111111  ; 
        end
      5'd16 :
        begin
          execLanesActive = 32'b00000000000000011111111111111111  ; 
        end
      5'd15 :
        begin
          execLanesActive = 32'b00000000000000001111111111111111  ; 
        end
      5'd14 :
        begin
          execLanesActive = 32'b00000000000000000111111111111111  ; 
        end
      5'd13 :
        begin
          execLanesActive = 32'b00000000000000000011111111111111  ; 
        end
      5'd12 :
        begin
          execLanesActive = 32'b00000000000000000001111111111111  ; 
        end
      5'd11 :
        begin
          execLanesActive = 32'b00000000000000000000111111111111  ; 
        end
      5'd10 :
        begin
          execLanesActive = 32'b00000000000000000000011111111111  ; 
        end
      5'd9 :
        begin
          execLanesActive = 32'b00000000000000000000001111111111  ; 
        end
      5'd8 :
        begin
          execLanesActive = 32'b00000000000000000000000111111111  ; 
        end
      5'd7 :
        begin
          execLanesActive = 32'b00000000000000000000000011111111  ; 
        end
      5'd6 :
        begin
          execLanesActive = 32'b00000000000000000000000001111111  ; 
        end
      5'd5 :
        begin
          execLanesActive = 32'b00000000000000000000000000111111  ; 
        end
      5'd4 :
        begin
          execLanesActive = 32'b00000000000000000000000000011111  ; 
        end
      5'd3 :
        begin
          execLanesActive = 32'b00000000000000000000000000001111  ; 
        end
      5'd2 :
        begin
          execLanesActive = 32'b00000000000000000000000000000111  ; 
        end
      5'd1 :
        begin
          execLanesActive = 32'b00000000000000000000000000000011  ; 
        end
      5'd0 :
        begin
          execLanesActive = 32'b00000000000000000000000000000001  ; 
        end