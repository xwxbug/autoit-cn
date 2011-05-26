#include <Color.au3>

Dim $aColor[3] = [0x80, 0x90, 0xff]

$nColor = _ColorSetRGB( $aColor )
MsgBox( 4096, "AutoIt", " ºì=" & Hex($aColor[0],2) & " ÂÌ=" & Hex($aColor[1],2) & " À¶=" & Hex($aColor[2],2) & @CRLF & _
				"ÑÕÉ«=" & Hex($nColor))
