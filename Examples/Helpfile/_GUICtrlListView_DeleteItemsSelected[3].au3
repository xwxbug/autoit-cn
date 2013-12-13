#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example_UDF_Created()

Func Example_UDF_Created()
	Local $GUI, $aItems[10][3], $hListView

	$GUI = GUICreate("(UDF Created) ListView Delete Items Selected", 400, 300)
	$hListView = _GUICtrlListView_Create($GUI, "col1|col2|col3", 2, 2, 394, 268, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))
	_GUICtrlListView_SetExtendedListViewStyle($hListView, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT))
	GUISetState()

	; 3 column load
	For $iI = 0 To UBound($aItems) - 1
		$aItems[$iI][0] = "Item " & $iI
		$aItems[$iI][1] = "Item " & $iI & "-1"
		$aItems[$iI][2] = "Item " & $iI & "-2"
	Next

	_GUICtrlListView_AddArray($hListView, $aItems)

	_GUICtrlListView_SetItemSelected($hListView, Random(0, UBound($aItems) - 1, 1))

	MsgBox($MB_SYSTEMMODAL, "Information", "Delete Item Selected")
	; This is already a handle
	MsgBox($MB_SYSTEMMODAL, "Deleted?", _GUICtrlListView_DeleteItemsSelected($hListView))

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example_UDF_Created
