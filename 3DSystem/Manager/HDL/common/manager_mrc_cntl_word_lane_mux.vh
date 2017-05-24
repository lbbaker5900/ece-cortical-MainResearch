

  // Extract the word from the interface page line
  // Convert the mgrId of the pointer to a bit mask
      case ( select ) // synopsys parallel_case
      6'd0 :
        begin
          out = in[ 31:  0] ; 
        end
      6'd1 :
        begin
          out = in[ 63: 32] ; 
        end
      6'd2 :
        begin
          out = in[ 95: 64] ; 
        end
      6'd3 :
        begin
          out = in[127: 96] ; 
        end
      6'd4 :
        begin
          out = in[159:128] ; 
        end
      6'd5 :
        begin
          out = in[191:160] ; 
        end
      6'd6 :
        begin
          out = in[223:192] ; 
        end
      6'd7 :
        begin
          out = in[255:224] ; 
        end
      6'd8 :
        begin
          out = in[287:256] ; 
        end
      6'd9 :
        begin
          out = in[319:288] ; 
        end
      6'd10 :
        begin
          out = in[351:320] ; 
        end
      6'd11 :
        begin
          out = in[383:352] ; 
        end
      6'd12 :
        begin
          out = in[415:384] ; 
        end
      6'd13 :
        begin
          out = in[447:416] ; 
        end
      6'd14 :
        begin
          out = in[479:448] ; 
        end
      6'd15 :
        begin
          out = in[511:480] ; 
        end
      6'd16 :
        begin
          out = in[543:512] ; 
        end
      6'd17 :
        begin
          out = in[575:544] ; 
        end
      6'd18 :
        begin
          out = in[607:576] ; 
        end
      6'd19 :
        begin
          out = in[639:608] ; 
        end
      6'd20 :
        begin
          out = in[671:640] ; 
        end
      6'd21 :
        begin
          out = in[703:672] ; 
        end
      6'd22 :
        begin
          out = in[735:704] ; 
        end
      6'd23 :
        begin
          out = in[767:736] ; 
        end
      6'd24 :
        begin
          out = in[799:768] ; 
        end
      6'd25 :
        begin
          out = in[831:800] ; 
        end
      6'd26 :
        begin
          out = in[863:832] ; 
        end
      6'd27 :
        begin
          out = in[895:864] ; 
        end
      6'd28 :
        begin
          out = in[927:896] ; 
        end
      6'd29 :
        begin
          out = in[959:928] ; 
        end
      6'd30 :
        begin
          out = in[991:960] ; 
        end
      6'd31 :
        begin
          out = in[1023:992] ; 
        end
      6'd32 :
        begin
          out = in[1055:1024] ; 
        end
      6'd33 :
        begin
          out = in[1087:1056] ; 
        end
      6'd34 :
        begin
          out = in[1119:1088] ; 
        end
      6'd35 :
        begin
          out = in[1151:1120] ; 
        end
      6'd36 :
        begin
          out = in[1183:1152] ; 
        end
      6'd37 :
        begin
          out = in[1215:1184] ; 
        end
      6'd38 :
        begin
          out = in[1247:1216] ; 
        end
      6'd39 :
        begin
          out = in[1279:1248] ; 
        end
      6'd40 :
        begin
          out = in[1311:1280] ; 
        end
      6'd41 :
        begin
          out = in[1343:1312] ; 
        end
      6'd42 :
        begin
          out = in[1375:1344] ; 
        end
      6'd43 :
        begin
          out = in[1407:1376] ; 
        end
      6'd44 :
        begin
          out = in[1439:1408] ; 
        end
      6'd45 :
        begin
          out = in[1471:1440] ; 
        end
      6'd46 :
        begin
          out = in[1503:1472] ; 
        end
      6'd47 :
        begin
          out = in[1535:1504] ; 
        end
      6'd48 :
        begin
          out = in[1567:1536] ; 
        end
      6'd49 :
        begin
          out = in[1599:1568] ; 
        end
      6'd50 :
        begin
          out = in[1631:1600] ; 
        end
      6'd51 :
        begin
          out = in[1663:1632] ; 
        end
      6'd52 :
        begin
          out = in[1695:1664] ; 
        end
      6'd53 :
        begin
          out = in[1727:1696] ; 
        end
      6'd54 :
        begin
          out = in[1759:1728] ; 
        end
      6'd55 :
        begin
          out = in[1791:1760] ; 
        end
      6'd56 :
        begin
          out = in[1823:1792] ; 
        end
      6'd57 :
        begin
          out = in[1855:1824] ; 
        end
      6'd58 :
        begin
          out = in[1887:1856] ; 
        end
      6'd59 :
        begin
          out = in[1919:1888] ; 
        end
      6'd60 :
        begin
          out = in[1951:1920] ; 
        end
      6'd61 :
        begin
          out = in[1983:1952] ; 
        end
      6'd62 :
        begin
          out = in[2015:1984] ; 
        end
      6'd63 :
        begin
          out = in[2047:2016] ; 
        end
      default:
        begin
          out = 32'd0 ; 
        end
      endcase
