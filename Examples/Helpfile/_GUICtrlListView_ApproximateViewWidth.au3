#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiConstantsEx.au3>
#include <GuiListView.au3>
#include <Constants.au3>

Opt('MustDeclareVars', 1)

$Debug_LV = False ; Check ClassName being passed to ListView functions, set to True and use a handle to another control to see it work

_Main()

Func _Main()
	Local $iX, $hListView
	
	GUICreate("ListView Approximate View Width", 400, 300)
	$hListView = GUICtrlCreateListView("", 2, 2, 394, 268)
	_GUICtrlListView_SetUnicodeFormat($hListView, False)
	GUISetState()
	
	; Add column
	_GUICtrlListView_InsertColumn($hListView, 0, "Column 1", 100)

	; Add items
	For $iI = 0 To 9
		_GUICtrlListView_AddItem($hListView, "Row " & $iI)
	Next

	MsgBox(4096, "Information", "Approximate View Width")
	; Resize view width
	$iX = _GUICtrlListView_ApproximateViewWidth($hListView)
	_WinAPI_SetWindowPos(GUICtrlGetHandle($hListView), 0, 2, 2, $iX, 268, $SWP_NOZORDER)

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main