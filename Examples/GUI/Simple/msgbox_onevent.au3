; A simple custom messagebox that uses the OnEvent mode

#include <GUIConstantsEx.au3>

Opt("GUIOnEventMode", 1)

Global $ExitID

_Main()

Func _Main()
	Local $YesID, $NoID

GUICreate("自定义 Msgbox", 210, 80)

$Label = GUICtrlCreateLabel("请单击一个按钮!", 10, 10)
$YesID  = GUICtrlCreateButton("是", 10, 50, 50, 20)
	GUICtrlSetOnEvent($YesID, "OnYes")
$NoID   = GUICtrlCreateButton("否", 80, 50, 50, 20)
	GUICtrlSetOnEvent($NoID, "OnNo")
$ExitID = GUICtrlCreateButton("退出", 150, 50, 50, 20)
	GUICtrlSetOnEvent($ExitID, "OnExit")

	GUISetOnEvent($GUI_EVENT_CLOSE, "OnExit")

	GUISetState()  ; display the GUI

	While 1
		Sleep(1000)
	WEnd
EndFunc   ;==>_Main

;--------------- Functions ---------------
Func OnYes()
	MsgBox(0,"您单击了:", "是")
EndFunc   ;==>OnYes

Func OnNo()
	MsgBox(0,"您单击了:", "否")
EndFunc   ;==>OnNo

Func OnExit()
	If @GUI_CtrlId = $ExitID Then
		MsgBox(0,"您单击了:", "退出")
	Else
		MsgBox(0,"您单击了:", "关闭")
	EndIf

	Exit
EndFunc   ;==>OnExit
