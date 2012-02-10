Local $t = FileGetTime(@WindowsDir & "\notepad.exe", 1)

If Not @error Then
	Local $yyyymd = $t[0] & "/" & $t[1] & "/" & $t[2]
	MsgBox(4096, "notepad.exe 创建日期:", $yyyymd)
EndIf
