
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w
6
#include  <GuiConstantsEx.au3>
#include  <GuiListView.au3>

Opt('MustDeclareVars', 1)

$Debug_LV = False ; 检查传递给函数的类名,
设置为真并使用另一控件句柄观察其工作

示例1()
示例2()
示例_UDF_Created()

Func 示例1()
	Local $aItems[10][3], $hListView

	GUICreate( "ListView Delete
	Items Selected" ,  400 ,  300 )
	$hListView = GUICtrlCreateListView("col1|col2|col3", 2, 2, 394, 268, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))
	_GUICtrlListView_SetExtendedListViewStyle($hListView, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT))
	GUISetState()


	; 加载3列
	For $iI = 0 To 9
		GUICtrlCreateListViewItem("Item" & $iI & "|Item" & $iI & "-1|Item
		"  &  $iI  &  " - 2" ,  $hListView )
	Next

	_GUICtrlListView_SetItemSelected($hListView, Random(0, UBound($aItems) - 1, 1))

	MsgBox(4160, "Information", "Delete Item Selected")
	; 使用UDF函
	数创建的项目, 传递句柄到控件
	MsgBox(4160, "Deleted?", _GUICtrlListView_DeleteItemsSelected($hListView))

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>示例1

Func 示例2()
	Local $aItems[10][3], $hListView

	GUICreate( "ListView Delete
	Items Selected" ,  400 ,  300 )
	$hListView = GUICtrlCreateListView("col1|col2|col3", 2, 2, 394, 268, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))
	_GUICtrlListView_SetExtendedListViewStyle($hListView, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT))
	GUISetState()


	; 加载3列
	For $iI = 0 To UBound($aItems) - 1
		$aItems[$iI][0] = "Item" & $iI
		$aItems[$iI][1] = "Item
		"  &  $iI  &  " - 1"
		$aItems[$iI][2] = "Item" & $iI & "-2"
	Next

	_GUICtrlListView_AddArray($hListView, $aItems)

	_GUICtrlListView_SetItemSelected($hListView, Random(0, UBound($aItems) - 1, 1))

	MsgBox(4160, "Information", "Delete Item Selected")
	; 使用UDF函
	数创建的项目, 传递句柄到控件
	MsgBox(4160, "Deleted?", _GUICtrlListView_DeleteItemsSelected( GUICtrlGetHandle($hListView)))

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>示例2

Func 示例_UDF_Created()

	Local $GUI, $aItems[10][3], $hListView

	$GUI = GUICreate( "(UDF Created)
	ListView Delete Items Selected" ,  400 ,  300 )

	$hListView = _GUICtrlListView_Create($GUI, "col1|col2|col3", 2, 2, 394, 268, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))
	_GUICtrlListView_SetExtendedListViewStyle($hListView, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT))
	GUISetState()


	; 加载3列
	For $iI = 0 To UBound($aItems) - 1
		$aItems[$iI][0] = "Item" & $iI
		$aItems[$iI][1] = "Item
		"  &  $iI  &  " - 1"
		$aItems[$iI][2] = "Item" & $iI & "-2"
	Next

	_GUICtrlListView_AddArray($hListView, $aItems)

	_GUICtrlListView_SetItemSelected($hListView, Random(0, UBound($aItems) - 1, 1))

	MsgBox(4160, "Information", "Delete Item Selected")
	; 已经是句柄了
	MsgBox(4160, "Deleted?", _GUICtrlListView_DeleteItemsSelected($hListView))

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>示例_UDF_Created

