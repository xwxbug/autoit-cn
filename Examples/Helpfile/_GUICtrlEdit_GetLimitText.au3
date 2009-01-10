#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiEdit.au3>
#include <GuiConstantsEx.au3>

Opt('MustDeclareVars', 1)

$Debug_Ed = False ; Check ClassName being passed to Edit functions, set to True and use a handle to another control to see it work

_Main()

Func _Main()
	Local $hEdit

	; Create GUI
	GUICreate("Edit Get Limit Text", 400, 300)
	$hEdit = GUICtrlCreateEdit("This is a test" & @CRLF & "Another Line", 2, 2, 394, 268)
	GUISetState()

	MsgBox(4160, "Information", "Text Limit: " & _GUICtrlEdit_GetLimitText($hEdit))

	MsgBox(4160, "Information", "Setting Text Limit")
	_GUICtrlEdit_SetLimitText($hEdit, 64000)

	MsgBox(4160, "Information", "Text Limit: " & _GUICtrlEdit_GetLimitText($hEdit))

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main