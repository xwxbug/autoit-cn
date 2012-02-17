#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>
#include <Constants.au3>

$Debug_CB = False ; 检查传递给 ComboBox/ComboBoxEx 函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

Global $iMemo

_Main()

Func _Main()
	Local $aRect, $hCombo

	; 创建 GUI
	GUICreate("ComboBox Get Dropped Control Rect", 400, 296)
	$hCombo = GUICtrlCreateCombo("", 2, 2, 396, 296)
	$iMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 添加文件
	_GUICtrlComboBox_BeginUpdate($hCombo)
	_GUICtrlComboBox_AddDir($hCombo, @WindowsDir & "\*.exe")
	_GUICtrlComboBox_EndUpdate($hCombo)

	; 获取控件下拉时的矩形坐标
	$aRect = _GUICtrlComboBox_GetDroppedControlRect($hCombo)

	MemoWrite("X coordinate of the upper left corner ......: " & $aRect[0])
	MemoWrite("Y coordinate of the upper left corner ......: " & $aRect[1])
	MemoWrite("X coordinate of the lower right corner .....: " & $aRect[2])
	MemoWrite("Y coordinate of the lower right corner .....: " & $aRect[3])

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

; 写入一行到 memo 控件
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
