#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example_UDF_Created()

Func Example_UDF_Created()
	Local $GUI, $hListView, $aItems[10][3]

	$GUI = GUICreate("(UDF Created) ListView Delete All Items", 400, 300)

	$hListView = _GUICtrlListView_Create($GUI, "col1|col2|col3", 2, 2, 394, 268)
	GUISetState()

	; 3 column load
	For $iI = 0 To UBound($aItems) - 1
		$aItems[$iI][0] = "Item " & $iI
		$aItems[$iI][1] = "Item " & $iI & "-1"
		$aItems[$iI][2] = "Item " & $iI & "-2"
	Next

	_GUICtrlListView_AddArray($hListView, $aItems)

	MsgBox($MB_SYSTEMMODAL, "Information", "Delete All Items")
	; This is already a handle
	MsgBox($MB_SYSTEMMODAL, "Deleted?", _GUICtrlListView_DeleteAllItems($hListView))

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example_UDF_Created
