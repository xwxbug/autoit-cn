;示例1
;获取窗口句柄并使用 WinGetPos 获取窗口矩形
Local $hwnd = WinGetHandle("")
Local $coor = WinGetPos($hwnd)

;建立数据结构
Local $rect = DllStructCreate("int;int;int;int")

;构成 DllCall
DllCall("user32.dll", "int", "GetWindowRect", _
		"hwnd", $hwnd, _
		"ptr",DllStructGetPtr($rect)) ; 使用 DllStructGetPtr 后调用 DllCall

;获取返回的矩形
Local $l = DllStructGetData($rect, 1)
Local $t = DllStructGetData($rect, 2)
Local $r = DllStructGetData($rect, 3)
Local $b = DllStructGetData($rect, 4)

;释放数据结构
$rect = 0

;显示 WinGetPos 的结果和返回的矩形
MsgBox(4096,"Larry 测试 :)","WinGetPos(): (" & $coor[0] & "," & $coor[1] & _
		") (" & $coor[2] + $coor[0] & "," & $coor[3] + $coor[1] & ")" & @CRLF & _
		"GetWindowRect(): (" & $l & "," & $t & ") (" & $r & "," & $b & ")")

;示例2
; DllStructGetPtr 参考项目
Local $a = DllStructCreate("int")
If @error Then
	MsgBox(4096,"","DllStructCreate 错误" & @error);
	Exit
EndIf

$b = DllStructCreate("uint", DllStructGetPtr($a, 1))
If @error Then
	MsgBox(4096,"","DllStructCreate 错误 " & @error);
	Exit
EndIf

Local $c = DllStructCreate("float", DllStructGetPtr($a, 1))
If @error Then
	MsgBox(4096,"","DllStructCreate 错误 " & @error);
	Exit
EndIf

;设置数据
DllStructSetData($a, 1, -1)

;=========================================================
;	显示相同数据的不同类型
;=========================================================
MsgBox(4096, "DllStruct", _
		"int: " & DllStructGetData($a, 1) & @CRLF & _
		"uint: " & DllStructGetData($b, 1) & @CRLF & _
		"float: " & DllStructGetData($c, 1) & @CRLF & _
		"")

; 释放分配的内存
$a = 0
