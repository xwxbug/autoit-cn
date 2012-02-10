#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $Date, $msg
	GUICreate("Get date", 210, 190)

	$Date = GUICtrlCreateMonthCal("1953/03/25", 10, 10)
	GUISetState()

	; Run the GUI until the dialog is closed or timeout

	Do
		$msg = GUIGetMsg()
		If $msg = $Date Then MsgBox(4096, "debug", "calendar clicked")
	Until $msg = $GUI_EVENT_CLOSE

	MsgBox(4096, $msg, GUICtrlRead($Date), 2)
EndFunc   ;==>Example