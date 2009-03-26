Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")
ControlSetText("[CLASS:Notepad]","","[CLASSNN:Edit1]","this one")

; Identify the Notepad window that contains the text "this one" and get a handle to it

; Change into the WinTitleMatchMode that supports classnames and handles
AutoItSetOption("WinTitleMatchMode", 4)

; 得到包括 "this one" 内容的记事本窗口的句柄
$handle = WinGetHandle("classname=Notepad", "this one")
If @error Then
	MsgBox(4096, "错误", "不能找到指定窗口")
Else
	; 发送一些文本到记事本窗口编辑控件.
	ControlSend($handle, "", "Edit1", "AbCdE")
EndIf
