; A simple custom messagebox that uses the MessageLoop mode

#include <Constants.au3>
#include <GUIConstantsEx.au3>

_Main()

Func _Main()
	Local $idYes, $idNo, $idExit, $iMsg

	GUICreate("自定义 MsgBox", 210, 80)

	GUICtrlCreateLabel("请单击一个按钮!", 10, 10)
	$idYes = GUICtrlCreateButton("是", 10, 50, 50, 20)
	$idNo = GUICtrlCreateButton("否", 80, 50, 50, 20)
	$idExit = GUICtrlCreateButton("退出", 150, 50, 50, 20)

	GUISetState() ; display the GUI

	Do
		$iMsg = GUIGetMsg()

		Select
			Case $iMsg = $idYes
			MsgBox($MB_SYSTEMMODAL,"您单击了:", "是")
			Case $iMsg = $idNo
			MsgBox($MB_SYSTEMMODAL,"您单击了:", "否")
			Case $iMsg = $idExit
			MsgBox($MB_SYSTEMMODAL,"您单击了:", "退出")
			Case $iMsg = $GUI_EVENT_CLOSE
			MsgBox($MB_SYSTEMMODAL,"您单击了:", "关闭")
		EndSelect
	Until $iMsg = $GUI_EVENT_CLOSE Or $iMsg = $idExit
EndFunc   ;==>_Main
