Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")
ControlSetText("[CLASS:Notepad]","","[CLASSNN:Edit1]","this one")


AutoItSetOption("WinTitleMatchMode", 4)

; 得到包括 "this one" 内容的记事本窗口的句柄
$handle = WinGetHandle("classname=Notepad", "this one")
If @error Then
	MsgBox(4096, "错误", "不能找到指定窗口")
Else
	; 发送一些文本到记事本窗口编辑控件.
	ControlSend($handle, "", "Edit1", "AbCdE")
EndIf
