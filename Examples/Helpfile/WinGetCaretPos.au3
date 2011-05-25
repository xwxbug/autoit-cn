Local $a = WinGetCaretPos()
If Not @error Then 
	ToolTip("第一个插入符坐标", $a[0], $a[1])
	MouseMove($a[0],$a[1])
EndIf
Sleep(2000)

Local $b = _CaretPos()
If Not @error Then 
	ToolTip("第二个插入符坐标", $b[0], $b[1])
	MouseMove($b[0],$b[1])
EndIf

Sleep(2000)

; 得到 MDI 文本编辑器的一些可靠方法.
Func _CaretPos()
	Local $x_adjust = 5
	Local $y_adjust = 40

	Opt("CaretCoordMode", 0)              ;相对模式
	Local $c = WinGetCaretPos()           ;相对插入符坐标
	Local $w = WinGetPos("")              ;窗口坐标
	Local $f = ControlGetFocus("","")     ;文本区域 "句柄"
	Local $e = ControlGetPos("", "", $f)  ;文本区域坐标

	Local $t[2]
	If IsArray($c) And IsArray($w) And IsArray($e) Then
		$t[0] = $c[0] + $w[0] + $e[0] + $x_adjust
		$t[1] = $c[1] + $w[1] + $e[1] + $y_adjust
		Return $t     ;当前光标的绝对屏幕坐标
	Else
		SetError(1)
	EndIf
EndFunc   ;==>_CaretPos
