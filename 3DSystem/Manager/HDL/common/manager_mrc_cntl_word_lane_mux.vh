

  // Extract the word from the page line
  // Convert the mgrId of the pointer to a bit mask
      case ( select ) // synopsys parallel_case
      5'd0 :
        begin
          out = in[ 31:  0] ; 
        end
      5'd1 :
        begin
          out = in[ 63: 32] ; 
        end
      5'd2 :
        begin
          out = in[ 95: 64] ; 
        end
      5'd3 :
        begin
          out = in[127: 96] ; 
        end
      5'd4 :
        begin
          out = in[159:128] ; 
        end
      5'd5 :
        begin
          out = in[191:160] ; 
        end
      5'd6 :
        begin
          out = in[223:192] ; 
        end
      5'd7 :
        begin
          out = in[255:224] ; 
        end
      5'd8 :
        begin
          out = in[287:256] ; 
        end
      5'd9 :
        begin
          out = in[319:288] ; 
        end
      5'd10 :
        begin
          out = in[351:320] ; 
        end
      5'd11 :
        begin
          out = in[383:352] ; 
        end
      5'd12 :
        begin
          out = in[415:384] ; 
        end
      5'd13 :
        begin
          out = in[447:416] ; 
        end
      5'd14 :
        begin
          out = in[479:448] ; 
        end
      5'd15 :
        begin
          out = in[511:480] ; 
        end
      5'd16 :
        begin
          out = in[543:512] ; 
        end
      5'd17 :
        begin
          out = in[575:544] ; 
        end
      5'd18 :
        begin
          out = in[607:576] ; 
        end
      5'd19 :
        begin
          out = in[639:608] ; 
        end
      5'd20 :
        begin
          out = in[671:640] ; 
        end
      5'd21 :
        begin
          out = in[703:672] ; 
        end
      5'd22 :
        begin
          out = in[735:704] ; 
        end
      5'd23 :
        begin
          out = in[767:736] ; 
        end
      5'd24 :
        begin
          out = in[799:768] ; 
        end
      5'd25 :
        begin
          out = in[831:800] ; 
        end
      5'd26 :
        begin
          out = in[863:832] ; 
        end
      5'd27 :
        begin
          out = in[895:864] ; 
        end
      5'd28 :
        begin
          out = in[927:896] ; 
        end
      5'd29 :
        begin
          out = in[959:928] ; 
        end
      5'd30 :
        begin
          out = in[991:960] ; 
        end
      5'd31 :
        begin
          out = in[1023:992] ; 
        end
      default:
        begin
          out = 32'd0 ; 
        end
      endcase
