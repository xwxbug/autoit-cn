WinMove("[active]","",Default, Default, 200,300)	; 只调整活动窗口大小(不移动)

Example(Default, Default)

Func Example($vParam1 = Default, $vParam2 = "第二个参数", $vParam3 = Default)
	If $vParam1 = Default Then $vParam1 = "第一个参数"
	If $vParam3 = Default Then $vParam3 = "第三个参数"

	; 显示结果.
	MsgBox(4096, "参数", "1 = " & $vParam1 & @CRLF & _
			"2 = " & $vParam2 & @CRLF & _
			"3 = " & $vParam3)
EndFunc   ;==>Example
