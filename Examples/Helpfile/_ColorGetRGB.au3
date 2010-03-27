#include <Color.au3>

$nColor = 0x8090ff

$aColor = _ColorGetRGB( $nColor )
MsgBox( 4096, "AutoIt", "颜色为=" & Hex($nColor) & @CRLF & " 红=" & Hex($aColor[0],2) & " 绿=" & Hex($aColor[1],2) & " 蓝=" & Hex($aColor[2],2))
