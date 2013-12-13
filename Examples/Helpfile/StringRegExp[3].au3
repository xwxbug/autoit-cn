#include <MsgBoxConstants.au3>

; Option 3, global return, old AutoIt style
Local $aArray = StringRegExp('<test>a</test> <test>b</test> <test>c</Test>', '(?i)<test>(.*?)</test>', 3)
For $i = 0 To UBound($aArray) - 1
	MsgBox($MB_SYSTEMMODAL, "RegExp Test with Option 3 - " & $i, $aArray[$i])
Next