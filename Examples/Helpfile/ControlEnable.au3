Run("winver.exe")
$HWND=WinWaitActive('[REGEXPTITLE:.+Windows;REGEXPCLASS:#\d+]','')
If IsHWnd($HWND) Then
	;先禁用
	ControlDisable($HWND, "", "Button1")
	MsgBox(32,$HWND,'系统关于窗口出现咯...我们启用确定按钮试试')
	ControlEnable($HWND, "", "Button1")
Else
	MsgBox(32,"ERROR","貌似没找到窗口嘛...")
EndIf
