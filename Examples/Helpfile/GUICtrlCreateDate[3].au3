#include <GUIConstantsEx.au3>
#include <DateTimeConstants.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $date, $DTM_SETFORMAT_, $style

	GUICreate("My GUI get date", 200, 200, 800, 200)
	$date = GUICtrlCreateDate("1953/04/25", 10, 10, 185, 20)

	; to select a specific default format
	$DTM_SETFORMAT_ = 0x1032 ; $DTM_SETFORMATW
	$style = "yyyy/MM/dd HH:mm:ss"
	GUICtrlSendMsg($date, $DTM_SETFORMAT_, 0, $style)

	GUISetState()
	While GUIGetMsg() <> $GUI_EVENT_CLOSE
	WEnd

	MsgBox($MB_SYSTEMMODAL, "Time", GUICtrlRead($date))
EndFunc   ;==>Example
