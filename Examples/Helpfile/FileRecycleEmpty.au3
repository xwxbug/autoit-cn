;清空C盘回收站中的内容
If MsgBox(36,"注意!!","如果您的回收站中有重要内容,请不要运行本例子,确认清空吗?")=6 Then
	FileRecycleEmpty("C:\")
EndIf
