#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Sample scriptusing @NumParams macro
	Test_Numparams(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14)
EndFunc   ;==>Example

Func Test_Numparams($v1 = 0, $v2 = 0, $v3 = 0, $v4 = 0, $v5 = 0, $v6 = 0, $v7 = 0, $v8 = 0, $v9 = 0, _
		$v10 = 0, $v11 = 0, $v12 = 0, $v13 = 0, $v14 = 0, $v15 = 0, $v16 = 0, $v17 = 0, $v18 = 0, $v19 = 0)
	#forceref $v1, $v2, $v3, $v4, $v5, $v6, $v7, $v8, $v9, $v10, $v11, $v12, $v13, $v14, $v15, $v16, $v17, $v18, $v19
	Local $sVal = ""
	For $i = 1 To @NumParams
		$sVal &= Eval("v" & $i) & " "
	Next
	MsgBox($MB_SYSTEMMODAL, "", "@NumParams = " & @NumParams & @CRLF & @CRLF & $sVal)
EndFunc   ;==>Test_Numparams
