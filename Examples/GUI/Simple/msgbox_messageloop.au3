; A simple custom messagebox that uses the MessageLoop mode

#include <GUIConstantsEx.au3>
#include <Constants.au3>

_Main()

Func _Main()
	Local $YesID, $NoID, $ExitID, $msg

GUICreate("自定义 MsgBox", 210, 80)

	GUICtrlCreateLabel("请单击一个按钮!", 10, 10)
$YesID  = GUICtrlCreateButton("是", 10, 50, 50, 20)
$NoID   = GUICtrlCreateButton("否", 80, 50, 50, 20)
$ExitID = GUICtrlCreateButton("退出", 150, 50, 50, 20)

	GUISetState() ; display the GUI

	Do
		$msg = GUIGetMsg()

		Select
			Case $msg = $YesID
			MsgBox($MB_SYSTEMMODAL,"您单击了:", "是")
			Case $msg = $NoID
			MsgBox($MB_SYSTEMMODAL,"您单击了:", "否")
			Case $msg = $ExitID
			MsgBox($MB_SYSTEMMODAL,"您单击了:", "退出")
			Case $msg = $GUI_EVENT_CLOSE
			MsgBox($MB_SYSTEMMODAL,"您单击了:", "关闭")
		EndSelect
	Until $msg = $GUI_EVENT_CLOSE Or $msg = $ExitID
EndFunc   ;==>_Main
