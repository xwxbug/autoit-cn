If ProcessExists("notepad.exe") Then ; Check if the Notepad process is running.
	MsgBox(4096, "例子", "记事本确实在运行.")
Else
	MsgBox(4096, "例子", "记事本没有在运行.")
EndIf
