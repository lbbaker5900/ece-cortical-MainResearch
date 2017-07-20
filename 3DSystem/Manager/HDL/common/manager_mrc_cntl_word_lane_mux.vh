

  // Extract the word from the interface page line
  // Convert the mgrId of the pointer to a bit mask
      case ( {{chan_select, word_select}} ) // synopsys parallel_case
      {1'd0,6'd0} :
        begin
          out = chan0[ 31:  0] ; 
        end
      {1'd0,6'd1} :
        begin
          out = chan0[ 63: 32] ; 
        end
      {1'd0,6'd2} :
        begin
          out = chan0[ 95: 64] ; 
        end
      {1'd0,6'd3} :
        begin
          out = chan0[127: 96] ; 
        end
      {1'd0,6'd4} :
        begin
          out = chan0[159:128] ; 
        end
      {1'd0,6'd5} :
        begin
          out = chan0[191:160] ; 
        end
      {1'd0,6'd6} :
        begin
          out = chan0[223:192] ; 
        end
      {1'd0,6'd7} :
        begin
          out = chan0[255:224] ; 
        end
      {1'd0,6'd8} :
        begin
          out = chan0[287:256] ; 
        end
      {1'd0,6'd9} :
        begin
          out = chan0[319:288] ; 
        end
      {1'd0,6'd10} :
        begin
          out = chan0[351:320] ; 
        end
      {1'd0,6'd11} :
        begin
          out = chan0[383:352] ; 
        end
      {1'd0,6'd12} :
        begin
          out = chan0[415:384] ; 
        end
      {1'd0,6'd13} :
        begin
          out = chan0[447:416] ; 
        end
      {1'd0,6'd14} :
        begin
          out = chan0[479:448] ; 
        end
      {1'd0,6'd15} :
        begin
          out = chan0[511:480] ; 
        end
      {1'd0,6'd16} :
        begin
          out = chan0[543:512] ; 
        end
      {1'd0,6'd17} :
        begin
          out = chan0[575:544] ; 
        end
      {1'd0,6'd18} :
        begin
          out = chan0[607:576] ; 
        end
      {1'd0,6'd19} :
        begin
          out = chan0[639:608] ; 
        end
      {1'd0,6'd20} :
        begin
          out = chan0[671:640] ; 
        end
      {1'd0,6'd21} :
        begin
          out = chan0[703:672] ; 
        end
      {1'd0,6'd22} :
        begin
          out = chan0[735:704] ; 
        end
      {1'd0,6'd23} :
        begin
          out = chan0[767:736] ; 
        end
      {1'd0,6'd24} :
        begin
          out = chan0[799:768] ; 
        end
      {1'd0,6'd25} :
        begin
          out = chan0[831:800] ; 
        end
      {1'd0,6'd26} :
        begin
          out = chan0[863:832] ; 
        end
      {1'd0,6'd27} :
        begin
          out = chan0[895:864] ; 
        end
      {1'd0,6'd28} :
        begin
          out = chan0[927:896] ; 
        end
      {1'd0,6'd29} :
        begin
          out = chan0[959:928] ; 
        end
      {1'd0,6'd30} :
        begin
          out = chan0[991:960] ; 
        end
      {1'd0,6'd31} :
        begin
          out = chan0[1023:992] ; 
        end
      {1'd0,6'd32} :
        begin
          out = chan0[1055:1024] ; 
        end
      {1'd0,6'd33} :
        begin
          out = chan0[1087:1056] ; 
        end
      {1'd0,6'd34} :
        begin
          out = chan0[1119:1088] ; 
        end
      {1'd0,6'd35} :
        begin
          out = chan0[1151:1120] ; 
        end
      {1'd0,6'd36} :
        begin
          out = chan0[1183:1152] ; 
        end
      {1'd0,6'd37} :
        begin
          out = chan0[1215:1184] ; 
        end
      {1'd0,6'd38} :
        begin
          out = chan0[1247:1216] ; 
        end
      {1'd0,6'd39} :
        begin
          out = chan0[1279:1248] ; 
        end
      {1'd0,6'd40} :
        begin
          out = chan0[1311:1280] ; 
        end
      {1'd0,6'd41} :
        begin
          out = chan0[1343:1312] ; 
        end
      {1'd0,6'd42} :
        begin
          out = chan0[1375:1344] ; 
        end
      {1'd0,6'd43} :
        begin
          out = chan0[1407:1376] ; 
        end
      {1'd0,6'd44} :
        begin
          out = chan0[1439:1408] ; 
        end
      {1'd0,6'd45} :
        begin
          out = chan0[1471:1440] ; 
        end
      {1'd0,6'd46} :
        begin
          out = chan0[1503:1472] ; 
        end
      {1'd0,6'd47} :
        begin
          out = chan0[1535:1504] ; 
        end
      {1'd0,6'd48} :
        begin
          out = chan0[1567:1536] ; 
        end
      {1'd0,6'd49} :
        begin
          out = chan0[1599:1568] ; 
        end
      {1'd0,6'd50} :
        begin
          out = chan0[1631:1600] ; 
        end
      {1'd0,6'd51} :
        begin
          out = chan0[1663:1632] ; 
        end
      {1'd0,6'd52} :
        begin
          out = chan0[1695:1664] ; 
        end
      {1'd0,6'd53} :
        begin
          out = chan0[1727:1696] ; 
        end
      {1'd0,6'd54} :
        begin
          out = chan0[1759:1728] ; 
        end
      {1'd0,6'd55} :
        begin
          out = chan0[1791:1760] ; 
        end
      {1'd0,6'd56} :
        begin
          out = chan0[1823:1792] ; 
        end
      {1'd0,6'd57} :
        begin
          out = chan0[1855:1824] ; 
        end
      {1'd0,6'd58} :
        begin
          out = chan0[1887:1856] ; 
        end
      {1'd0,6'd59} :
        begin
          out = chan0[1919:1888] ; 
        end
      {1'd0,6'd60} :
        begin
          out = chan0[1951:1920] ; 
        end
      {1'd0,6'd61} :
        begin
          out = chan0[1983:1952] ; 
        end
      {1'd0,6'd62} :
        begin
          out = chan0[2015:1984] ; 
        end
      {1'd0,6'd63} :
        begin
          out = chan0[2047:2016] ; 
        end
      {1'd1,6'd0} :
        begin
          out = chan1[ 31:  0] ; 
        end
      {1'd1,6'd1} :
        begin
          out = chan1[ 63: 32] ; 
        end
      {1'd1,6'd2} :
        begin
          out = chan1[ 95: 64] ; 
        end
      {1'd1,6'd3} :
        begin
          out = chan1[127: 96] ; 
        end
      {1'd1,6'd4} :
        begin
          out = chan1[159:128] ; 
        end
      {1'd1,6'd5} :
        begin
          out = chan1[191:160] ; 
        end
      {1'd1,6'd6} :
        begin
          out = chan1[223:192] ; 
        end
      {1'd1,6'd7} :
        begin
          out = chan1[255:224] ; 
        end
      {1'd1,6'd8} :
        begin
          out = chan1[287:256] ; 
        end
      {1'd1,6'd9} :
        begin
          out = chan1[319:288] ; 
        end
      {1'd1,6'd10} :
        begin
          out = chan1[351:320] ; 
        end
      {1'd1,6'd11} :
        begin
          out = chan1[383:352] ; 
        end
      {1'd1,6'd12} :
        begin
          out = chan1[415:384] ; 
        end
      {1'd1,6'd13} :
        begin
          out = chan1[447:416] ; 
        end
      {1'd1,6'd14} :
        begin
          out = chan1[479:448] ; 
        end
      {1'd1,6'd15} :
        begin
          out = chan1[511:480] ; 
        end
      {1'd1,6'd16} :
        begin
          out = chan1[543:512] ; 
        end
      {1'd1,6'd17} :
        begin
          out = chan1[575:544] ; 
        end
      {1'd1,6'd18} :
        begin
          out = chan1[607:576] ; 
        end
      {1'd1,6'd19} :
        begin
          out = chan1[639:608] ; 
        end
      {1'd1,6'd20} :
        begin
          out = chan1[671:640] ; 
        end
      {1'd1,6'd21} :
        begin
          out = chan1[703:672] ; 
        end
      {1'd1,6'd22} :
        begin
          out = chan1[735:704] ; 
        end
      {1'd1,6'd23} :
        begin
          out = chan1[767:736] ; 
        end
      {1'd1,6'd24} :
        begin
          out = chan1[799:768] ; 
        end
      {1'd1,6'd25} :
        begin
          out = chan1[831:800] ; 
        end
      {1'd1,6'd26} :
        begin
          out = chan1[863:832] ; 
        end
      {1'd1,6'd27} :
        begin
          out = chan1[895:864] ; 
        end
      {1'd1,6'd28} :
        begin
          out = chan1[927:896] ; 
        end
      {1'd1,6'd29} :
        begin
          out = chan1[959:928] ; 
        end
      {1'd1,6'd30} :
        begin
          out = chan1[991:960] ; 
        end
      {1'd1,6'd31} :
        begin
          out = chan1[1023:992] ; 
        end
      {1'd1,6'd32} :
        begin
          out = chan1[1055:1024] ; 
        end
      {1'd1,6'd33} :
        begin
          out = chan1[1087:1056] ; 
        end
      {1'd1,6'd34} :
        begin
          out = chan1[1119:1088] ; 
        end
      {1'd1,6'd35} :
        begin
          out = chan1[1151:1120] ; 
        end
      {1'd1,6'd36} :
        begin
          out = chan1[1183:1152] ; 
        end
      {1'd1,6'd37} :
        begin
          out = chan1[1215:1184] ; 
        end
      {1'd1,6'd38} :
        begin
          out = chan1[1247:1216] ; 
        end
      {1'd1,6'd39} :
        begin
          out = chan1[1279:1248] ; 
        end
      {1'd1,6'd40} :
        begin
          out = chan1[1311:1280] ; 
        end
      {1'd1,6'd41} :
        begin
          out = chan1[1343:1312] ; 
        end
      {1'd1,6'd42} :
        begin
          out = chan1[1375:1344] ; 
        end
      {1'd1,6'd43} :
        begin
          out = chan1[1407:1376] ; 
        end
      {1'd1,6'd44} :
        begin
          out = chan1[1439:1408] ; 
        end
      {1'd1,6'd45} :
        begin
          out = chan1[1471:1440] ; 
        end
      {1'd1,6'd46} :
        begin
          out = chan1[1503:1472] ; 
        end
      {1'd1,6'd47} :
        begin
          out = chan1[1535:1504] ; 
        end
      {1'd1,6'd48} :
        begin
          out = chan1[1567:1536] ; 
        end
      {1'd1,6'd49} :
        begin
          out = chan1[1599:1568] ; 
        end
      {1'd1,6'd50} :
        begin
          out = chan1[1631:1600] ; 
        end
      {1'd1,6'd51} :
        begin
          out = chan1[1663:1632] ; 
        end
      {1'd1,6'd52} :
        begin
          out = chan1[1695:1664] ; 
        end
      {1'd1,6'd53} :
        begin
          out = chan1[1727:1696] ; 
        end
      {1'd1,6'd54} :
        begin
          out = chan1[1759:1728] ; 
        end
      {1'd1,6'd55} :
        begin
          out = chan1[1791:1760] ; 
        end
      {1'd1,6'd56} :
        begin
          out = chan1[1823:1792] ; 
        end
      {1'd1,6'd57} :
        begin
          out = chan1[1855:1824] ; 
        end
      {1'd1,6'd58} :
        begin
          out = chan1[1887:1856] ; 
        end
      {1'd1,6'd59} :
        begin
          out = chan1[1919:1888] ; 
        end
      {1'd1,6'd60} :
        begin
          out = chan1[1951:1920] ; 
        end
      {1'd1,6'd61} :
        begin
          out = chan1[1983:1952] ; 
        end
      {1'd1,6'd62} :
        begin
          out = chan1[2015:1984] ; 
        end
      {1'd1,6'd63} :
        begin
          out = chan1[2047:2016] ; 
        end
      default:
        begin
          out = 32'd0 ; 
        end
      endcase
