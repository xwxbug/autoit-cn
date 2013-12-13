#include <GUIConstantsEx.au3>
#include <DateTimeConstants.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $n, $msg

	GUICreate("My GUI get date", 200, 200, 800, 200)
	$n = GUICtrlCreateDate("", 10, 10, 100, 20, $DTS_SHORTDATEFORMAT)
	GUISetState()

	; Run the GUI until the dialog is closed
	Do
		$msg = GUIGetMsg()
	Until $msg = $GUI_EVENT_CLOSE

	MsgBox($MB_SYSTEMMODAL, "Date", GUICtrlRead($n))
	GUIDelete()
EndFunc   ;==>Example
