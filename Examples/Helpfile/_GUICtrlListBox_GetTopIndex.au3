#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GUIListBox.au3>
#include <GuiConstantsEx.au3>

Opt('MustDeclareVars', 1)

$Debug_LB = False ; Check ClassName being passed to ListBox functions, set to True and use a handle to another control to see it work

_Main()

Func _Main()
	Local $sText, $hListBox

	; Create GUI
	GUICreate("List Box Get Top Index", 400, 296)
	$hListBox = GUICtrlCreateList("", 2, 2, 396, 296)
	GUISetState()

	; Add strings
	_GUICtrlListBox_BeginUpdate($hListBox)
	For $iI = 1 To 100
		$sText = StringFormat("%03d : Random string ", $iI)
		For $iX = 1 To Random(1, 20, 1)
			$sText &= Chr(Random(65, 90, 1))
		Next
		_GUICtrlListBox_AddString($hListBox, $sText)
	Next
	_GUICtrlListBox_EndUpdate($hListBox)

	; Show top index
	MsgBox(4160, "Information", "Top Index: " & _GUICtrlListBox_GetTopIndex($hListBox))

	; Set top index
	_GUICtrlListBox_SetTopIndex($hListBox, 50)

	; Show top index
	MsgBox(4160, "Information", "Top Index: " & _GUICtrlListBox_GetTopIndex($hListBox))

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main