#include <GUIConstantsEx.au3>
#include <GuiDateTimePicker.au3>

$Debug_DTP = False ; Check ClassName being passed to DTP functions, set to True and use a handle to another control to see it work

_Main()

Func _Main()
	Local $hGUI, $HandleBefore, $hDTP

	; 创建 GUI
	$hGUI = GUICreate("(UDF Created) DateTimePick Destroy", 400, 300)
	$hDTP = _GUICtrlDTP_Create($hGUI, 2, 6, 190)
	GUISetState()

	MsgBox(4160, "Information", "Destroying the Control for Handle: " & $hDTP)
	$HandleBefore = $hDTP
	MsgBox(4160, "Information", "Control Destroyed: " & _GUICtrlDTP_Destroy($hDTP) & @LF & _
			"Handel Before Destroy: " & $HandleBefore & @LF & _
			"Handle After Destroy: " & $hDTP)

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
