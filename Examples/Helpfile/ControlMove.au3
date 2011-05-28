Run("winver.exe")
$HWND=WinWaitActive('[REGEXPTITLE:.+Windows;REGEXPCLASS:#\d+]','')
If IsHWnd($HWND) Then
	MsgBox(32,$HWND,'系统关于窗口出现咯...我们移动确定按钮试试')
	ControlMove($HWND, "", "Button1",20,40)
Else
	MsgBox(32,"ERROR","貌似没找到窗口嘛...")
EndIf
