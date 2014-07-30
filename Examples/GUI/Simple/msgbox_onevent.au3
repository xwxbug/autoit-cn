; A simple custom messagebox that uses the OnEvent mode

#include <Constants.au3>
#include <GUIConstantsEx.au3>

Opt("GUIOnEventMode", 1)

Global $g_idExit

_Main()

Func _Main()
	Local $idYes, $idNo

	GUICreate("自定义 MsgBox", 210, 80)

	GUICtrlCreateLabel("请单击一个按钮!", 10, 10)
	$idYes  = GUICtrlCreateButton("是", 10, 50, 50, 20)
	GUICtrlSetOnEvent($idYes, "OnYes")
	$idNo   = GUICtrlCreateButton("否", 80, 50, 50, 20)
	GUICtrlSetOnEvent($idNo, "OnNo")
	$g_idExit = GUICtrlCreateButton("退出", 150, 50, 50, 20)
	GUICtrlSetOnEvent($g_idExit, "OnExit")

	GUISetOnEvent($GUI_EVENT_CLOSE, "OnExit")

	GUISetState() ; display the GUI

	While 1
		Sleep(1000)
	WEnd
EndFunc   ;==>_Main

; --------------- Functions ---------------
Func OnYes()
	MsgBox($MB_SYSTEMMODAL,"您单击了:", "是")
EndFunc   ;==>OnYes

Func OnNo()
	MsgBox($MB_SYSTEMMODAL,"您单击了:", "否")
EndFunc   ;==>OnNo

Func OnExit()
	If @GUI_CtrlId = $g_idExit Then
		MsgBox($MB_SYSTEMMODAL,"您单击了:", "退出")
	Else
		MsgBox($MB_SYSTEMMODAL,"您单击了:", "关闭")
	EndIf

	Exit
EndFunc   ;==>OnExit
