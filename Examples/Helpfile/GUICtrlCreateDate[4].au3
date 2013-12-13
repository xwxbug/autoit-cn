#include <GUIConstantsEx.au3>
#include <DateTimeConstants.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $n, $msg

	GUICreate("My GUI get time", 200, 200, 800, 200)
	$n = GUICtrlCreateDate("", 20, 20, 100, 20, $DTS_TIMEFORMAT)
	GUISetState()

	; Run the GUI until the dialog is closed
	Do
		$msg = GUIGetMsg()
	Until $msg = $GUI_EVENT_CLOSE

	MsgBox($MB_SYSTEMMODAL, "Time", GUICtrlRead($n))
	GUIDelete()
EndFunc   ;==>Example
