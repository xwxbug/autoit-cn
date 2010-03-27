#include <Color.au3>

Dim $aColor[3] = [0x80, 0x90, 0xff]

$nColor = _ColorSetRGB( $aColor )
MsgBox( 4096, "AutoIt", " 红=" & Hex($aColor[0],2) & " 绿=" & Hex($aColor[1],2) & " 蓝=" & Hex($aColor[2],2) & @CRLF & _
				"颜色=" & Hex($nColor))
