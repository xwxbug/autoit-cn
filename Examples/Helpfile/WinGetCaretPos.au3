$a = WinGetCaretPos()
If Not @error Then 
	ToolTip("第一个插入符坐标", $a[0], $a[1])
	MouseMove($a[0],$a[1])
EndIf
sleep(2000)

$b = _CaretPos()
If Not @error Then 
	ToolTip("第二个插入符坐标", $b[0], $b[1])
	MouseMove($b[0],$b[1])
EndIf

sleep(2000)

; More reliable method to get caret coords in MDI text editors.
Func _CaretPos()
	Local $x_adjust =  5
	Local $y_adjust = 40

	Opt("CaretCoordMode", 0)              ;relative mode
	Local $c = WinGetCaretPos()           ;relative caret coords
	Local $w = WinGetPos("")              ;window's coords
	Local $f = ControlGetFocus("","")     ;text region "handle"
	Local $e = ControlGetPos("", "", $f)  ;text region coords

	Local $t[2]
	If IsArray($c) and IsArray($w) and IsArray($e) Then
		$t[0] = $c[0] + $w[0] + $e[0] + $x_adjust
		$t[1] = $c[1] + $w[1] + $e[1] + $y_adjust
		Return $t     ;absolute screen coords of caret cursor
	Else
		SetError(1)
	EndIf
EndFunc
