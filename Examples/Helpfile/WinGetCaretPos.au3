Local $aCaretPos = WinGetCaretPos()
If Not @error Then
	ToolTip("第一个种方式", $aCaretPos[0], $aCaretPos[1])
EndIf
Sleep(2000)

$aCaretPos = _WinGetCaretPos()
If Not @error Then
	ToolTip("第二种方式", $aCaretPos[0], $aCaretPos[1])
EndIf
Sleep(2000)

; 得到 MDI 文本编辑器的一些可靠方法.
Func _WinGetCaretPos()
	Local $iXAdjust = 5
	Local $iYAdjust = 40

	Local $iOpt = Opt("CaretCoordMode", 0)         ;相对模式
	Local $aGetCaretPos = WinGetCaretPos()         ;相对插入符坐标
	Local $aGetPos = WinGetPos("[ACTIVE]")         ;窗口坐标
	Local $sControl = ControlGetFocus("[ACTIVE]")  ;文本区域 "句柄"
	Local $aControlPos = ControlGetPos("[ACTIVE]", "", $sControl)  ;文本区域坐标
	$iOpt = Opt("CaretCoordMode", $iOpt) ; Reset "CaretCoordMode" to the previous option.

	Local $aReturn[2] = [0, 0] ; Create an array to store the x, y position.
	If IsArray($aGetCaretPos) And IsArray($aGetPos) And IsArray($aControlPos) Then
		$aReturn[0] = $aGetCaretPos[0] + $aGetPos[0] + $aControlPos[0] + $iXAdjust
		$aReturn[1] = $aGetCaretPos[1] + $aGetPos[1] + $aControlPos[1] + $iYAdjust
		Return $aReturn ; Return the array.
	Else
		Return SetError(1, 0, $aReturn) ; Return the array and set @error to 1.
	EndIf
EndFunc   ;==>_WinGetCaretPos
