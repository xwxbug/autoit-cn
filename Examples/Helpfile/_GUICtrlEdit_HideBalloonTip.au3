#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiEdit.au3>
#include <GuiConstantsEx.au3>

Opt('MustDeclareVars', 1)

$Debug_Ed = False ; Check ClassName being passed to Edit functions, set to True and use a handle to another control to see it work

_Main()

Func _Main()
	Local $hEdit, $sTitle = "ShowBalloonTip", $sText = "Displays a balloon tip associated with an edit control"

	; Create GUI
	GUICreate("Edit ShowBalloonTip", 400, 300)
	$hEdit = GUICtrlCreateEdit("", 2, 2, 394, 268)
	GUISetState()

	; Set Text
	_GUICtrlEdit_SetText($hEdit, "This is a test" & @CRLF & "Another Line" & @CRLF & "Append to the end?")
	
	_GUICtrlEdit_ShowBalloonTip($hEdit, $sTitle, $sText, $TTI_INFO)
	Sleep(500)
	_GUICtrlEdit_HideBalloonTip($hEdit)

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main