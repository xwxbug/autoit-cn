#include <GUIConstants.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <GuiListView.au3>
#include <SendMessage.au3>

$GUI = GUICreate('_GUICtrlListView_MoveItemsSelected ', 300, 320)

$Up_Button = GUICtrlCreateButton(" Up ", 20, 20, 40, 24)

$Down_Button = GUICtrlCreateButton(" Down ", 70, 20, 40, 24)

$ListView = _GUICtrlListView_Create($GUI, "Column1|Column2 ", 20, 50, 260, 250, BitOR($LVS_SHOWSELALWAYS, $LVS_REPORT), $WS_EX_CLIENTEDGE)

_GUICtrlListView_SetExtendedListViewStyle($ListView, BitOR($LVS_EX_CHECKBOXES, $LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES))

For $i = 0 To 9
	_GUICtrlListView_AddItem($ListView, "Item" & $i + 1, Random(0, 2, 1))
	_GUICtrlListView_AddSubItem($ListView, $i, "SubItem" & $i + 1, 1, Random(0, 2, 1))
Next

$iRandom_1 = Random(0, 9, 1)
$iRandom_2 = Random(0, 9, 1)

_GUICtrlListView_SetItemChecked($ListView, $iRandom_1, 1)
_GUICtrlListView_SetItemSelected($ListView, $iRandom_1, 1)

_GUICtrlListView_SetItemChecked($ListView, $iRandom_2, 1)
_GUICtrlListView_SetItemSelected($ListView, $iRandom_2, 1)

_SendMessage($ListView, $LVM_SETCOLUMNWIDTH, 0, -1)
_SendMessage($ListView, $LVM_SETCOLUMNWIDTH, 1, -1)

ControlFocus($GUI, "", $ListView)

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Up_Button
			_GUICtrlListView_MoveItemsSelected($ListView, -1)
			ControlFocus($GUI, "", $ListView)
		Case $Down_Button
			_GUICtrlListView_MoveItemsSelected($ListView, 1)
			ControlFocus($GUI, "", $ListView)
	EndSwitch
WEnd

