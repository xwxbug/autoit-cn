#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiEdit.au3>
#include <GuiConstantsEx.au3>

Opt('MustDeclareVars', 1)

$Debug_Ed = False ; Check ClassName being passed to Edit functions, set to True and use a handle to another control to see it work

_Main()

Func _Main()
	Local $hEdit

	; Create GUI
	GUICreate("(Internal) Edit Get Password Char", 400, 300)
	$hEdit = GUICtrlCreateInput("Test of build-in control", 2, 2, 394, 25, $ES_PASSWORD)
	GUISetState()

	MsgBox(4096, "Information", "Password Char: " & _GUICtrlEdit_GetPasswordChar($hEdit))

	_GUICtrlEdit_SetPasswordChar($hEdit, "$") ; change password char to $
	
	MsgBox(4096, "Information", "Password Char: " & _GUICtrlEdit_GetPasswordChar($hEdit))

	_GUICtrlEdit_SetPasswordChar($hEdit) ; display characters typed by the user.

	MsgBox(4096, "Information", "Password Char: " & _GUICtrlEdit_GetPasswordChar($hEdit))

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main