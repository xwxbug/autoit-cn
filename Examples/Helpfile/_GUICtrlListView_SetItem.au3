#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiConstantsEx.au3>
#include <GuiListView.au3>

Opt('MustDeclareVars', 1)

$Debug_LV = False ; Check ClassName being passed to ListView functions, set to True and use a handle to another control to see it work

_Main()

Func _Main()
	Local $hListView
	
	GUICreate("ListView Set Item", 400, 300)
	$hListView = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState()

	; Add columns
	_GUICtrlListView_AddColumn($hListView, "Items", 100)

	; Add items
	GUICtrlCreateListViewItem("Item 1", $hListView)
	GUICtrlCreateListViewItem("Item 2", $hListView)
	GUICtrlCreateListViewItem("Item 3", $hListView)

	; Change item 2
	MsgBox(4160, "Information", "Changing item 2")
	_GUICtrlListView_SetItem($hListView, "New Item 2", 1)
	
	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main