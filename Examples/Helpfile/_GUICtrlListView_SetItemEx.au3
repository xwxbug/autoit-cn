
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w
6
#include  <GuiConstantsEx.au3>
#include  <GuiListView.au3>

Opt('MustDeclareVars', 1)

$Debug_LV = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $tText, $tItem, $hListView

	GUICreate("ListView Set Item Ex", 400, 300)
	$hListView = GUICtrlCreateListView("", 2, 2, 394, 268)

	GUISetState()

	;
	添加列
	_GUICtrlListView_AddColumn($hListView, "Items", 100)

	; 添加项
	GUICtrlCreateListViewItem("Item 1", $hListView)
	GUICtrlCreateListViewItem("Item 2", $hListView)

	GUICtrlCreateListViewItem("Item 3", $hListView)

	;
	Change item 2
	MsgBox(4160, "Information", "Changing item
	2" )
	$tText = DllStructCreate("wchar Text[11]")
	$tItem = DllStructCreate($tagLVITEM)
	DllStructSetData($tText, "Text", "New Item 2")

	DllStructSetData($tItem, "Mask", $LVIF_TEXT)

	DllStructSetData($tItem, "Item", 1)
	DllStructSetData($tItem, "Text", DllStructGetPtr($tText))
	_GUICtrlListView_SetItemEx($hListView, $tItem)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

