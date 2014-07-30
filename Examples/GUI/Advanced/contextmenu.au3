#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

GUICreate("一个简单的上下文菜单!",300,200)

Local $idTrackMenu = GUICtrlCreateContextMenu()
Local $idAboutItem = GUICtrlCreateMenuItem("关于", $idTrackMenu)
; next one creates a menu separator (line)
GUICtrlCreateMenuItem("", $idTrackMenu)
Local $idExitItem = GUICtrlCreateMenuItem("退出", $idTrackMenu)

GUISetState()

While 1
	Local $iMsg = GUIGetMsg()
	If $iMsg = $idExitItem Or $iMsg = $GUI_EVENT_CLOSE Or $iMsg = -1 Then ExitLoop
	If $iMsg = $idAboutItem Then MsgBox($MB_SYSTEMMODAL, "关于", "一个简单的上下文菜单!")
WEnd
