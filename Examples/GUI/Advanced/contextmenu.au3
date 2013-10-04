#include <GUIConstantsEx.au3>
#include <Constants.au3>

GUICreate("一个简单的上下文菜单!",300,200)

Local $trackmenu = GUICtrlCreateContextMenu()
Local $aboutitem = GUICtrlCreateMenuItem("关于", $trackmenu)
; next one creates a menu separator (line)
GUICtrlCreateMenuItem("", $trackmenu)
Local $exititem = GUICtrlCreateMenuItem("退出", $trackmenu)

GUISetState()

While 1
	Local $msg = GUIGetMsg()
	If $msg = $exititem Or $msg = $GUI_EVENT_CLOSE Or $msg = -1 Then ExitLoop
	If $msg = $aboutitem Then MsgBox($MB_SYSTEMMODAL,"关于","一个简单的上下文菜单!")
WEnd
