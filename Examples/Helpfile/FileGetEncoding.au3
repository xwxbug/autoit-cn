Local $iEncoding = FileGetEncoding(@ScriptFullPath) ; Retrieve the file encoding of the running script.
If @error Then
	MsgBox(4096, "错误", "不能获取文件编码.")
Else
	MsgBox(4096, "FileGetEncoding", "The value returned was: " & $iEncoding) ; The value returned for this example should be 0 or ANSI.
EndIf
