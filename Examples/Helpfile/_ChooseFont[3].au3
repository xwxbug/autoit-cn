#include <Misc.au3>
#include <MsgBoxConstants.au3>

Local $a_font

$a_font = _ChooseFont()

Local $FontName = $a_font[2]
Local $FontSize = $a_font[3]
Local $ColorRef = $a_font[5]
Local $FontWeight = $a_font[4]
Local $Italic = BitAND($a_font[1], 2)
Local $Underline = BitAND($a_font[1], 4)
Local $Strikethru = BitAND($a_font[1], 8)
$a_font = _ChooseFont($FontName, $FontSize, $ColorRef, $FontWeight, $Italic, $Underline, $Strikethru)
If (@error) Then
	MsgBox($MB_SYSTEMMODAL, "", "Error _ChooseFont: " & @error)
Else
	MsgBox($MB_SYSTEMMODAL, "", "Font Name: " & $a_font[2] & @CRLF & "Size: " & $a_font[3] & @CRLF & "Weight: " & $a_font[4] & @CRLF & "COLORREF rgbColors: " & $a_font[5] & @CRLF & "Hex BGR Color: " & $a_font[6] & @CRLF & "Hex RGB Color: " & $a_font[7])
EndIf
