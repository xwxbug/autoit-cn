
; 创建回调函数
$handle = DLLCallbackRegister ("_EnumWindowsProc", "int", "hwnd;lparam")     

; 调用 EnumWindows
DllCall("user32.dll", "int", "EnumWindows", "ptr", DllCallbackGetPtr($handle), "lparam", 10)

; 删除回调函数
DllCallbackFree($handle)

; 回调函数
Func _EnumWindowsProc($hWnd, $lParam)
	If WinGetTitle($hWnd) <> "" And BitAnd(WinGetState($hWnd), 2) Then
		$res = MsgBox(1, WinGetTitle($hWnd), "$hWnd=" & $hWnd & @CRLF & "lParam=" & $lParam & @CRLF & "$hWnd(type)=" & VarGetType($hWnd))
		If $res = 2 Then Return 0	; "取消"被点击, 返回 0 并停止枚举
	EndIf
	Return 1	; 返回 1 继续枚举
EndFunc
