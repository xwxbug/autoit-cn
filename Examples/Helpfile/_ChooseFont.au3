#include <Misc.au3>

Local $a_font

; Example 1
$a_font = _ChooseFont("Arial", 8)
If (@error) Then
	MsgBox(0, "", "错误 _ChooseFont: " & @error)
Else
	MsgBox(0, "", "字体名称: " & $a_font[2] & @LF & "大小: " & $a_font[3] & @LF & "字形: " & $a_font[4] & @LF & "COLORREF rgbColors: " & $a_font[5] & @LF & "Hex BGR 颜色: " & $a_font[6] & @LF & "Hex RGB 颜色: " & $a_font[7])
EndIf

; Example 2
$a_font = _ChooseFont()
If (@error) Then
	MsgBox(0, "", "错误 _ChooseFont: " & @error)
	Exit
Else
	MsgBox(0, "", "字体名称: " & $a_font[2] & @LF & "大小: " & $a_font[3] & @LF & "字形: " & $a_font[4] & @LF & "COLORREF rgbColors: " & $a_font[5] & @LF & "Hex BGR 颜色: " & $a_font[6] & @LF & "Hex RGB 颜色: " & $a_font[7])
EndIf

; Example 3
Local $FontName = $a_font[2]
Local $FontSize = $a_font[3]
Local $ColorRef = $a_font[5]
Local $FontWeight = $a_font[4]
Local $Italic = BitAND($a_font[1], 2)
Local $Underline = BitAND($a_font[1], 4)
Local $Strikethru = BitAND($a_font[1], 8)
$a_font = _ChooseFont($FontName, $FontSize, $ColorRef, $FontWeight, $Italic, $Underline, $Strikethru)
If (@error) Then
	MsgBox(0, "", "错误 _ChooseFont: " & @error)
Else
	MsgBox(0, "", "字体名称: " & $a_font[2] & @LF & "大小: " & $a_font[3] & @LF & "字形: " & $a_font[4] & @LF & "COLORREF rgbColors: " & $a_font[5] & @LF & "Hex BGR 颜色: " & $a_font[6] & @LF & "Hex RGB 颜色: " & $a_font[7])
EndIf
