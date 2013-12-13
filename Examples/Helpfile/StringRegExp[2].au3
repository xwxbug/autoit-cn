#include <MsgBoxConstants.au3>

; Option 2, single return, php/preg_match() style
Local $aArray = StringRegExp('<test>a</test> <test>b</test> <test>c</Test>', '(?i)<test>(.*?)</test>', 2)
For $i = 0 To UBound($aArray) - 1
	MsgBox($MB_SYSTEMMODAL, "RegExp Test with Option 2 - " & $i, $aArray[$i])
Next
