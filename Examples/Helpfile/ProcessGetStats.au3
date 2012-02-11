Example()

Func Example()
	; 返回当前进程的内存信息.
	Local $aMemory = ProcessGetStats()

	; If $aMemory is an array then display the following details about the process.
	If IsArray($aMemory) Then
		MsgBox(4096, "", "WorkingSetSize: " & $aMemory[0] & @CRLF & _
				"PeakWorkingSetSize: " & $aMemory[1])
	Else
		MsgBox(4096, "", "An error occurred.")
	EndIf
EndFunc   ;==>Example
