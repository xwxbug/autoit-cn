#include <Color.au3>

$nColor = 0x8090ff

$aColor = _ColorGetRGB( $nColor )
MsgBox( 4096, "AutoIt", "ÑÕÉ«Îª=" & Hex($nColor) & @CRLF & " ºì=" & Hex($aColor[0],2) & " ÂÌ=" & Hex($aColor[1],2) & " À¶=" & Hex($aColor[2],2))
