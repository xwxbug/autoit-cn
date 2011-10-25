
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w
6
#include  <GuiConstantsEx.au3>
#include  <GuiListView.au3>
#include  <GuiImageList.au3>

Opt('MustDeclareVars', 1)

$Debug_LV = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $hImage, $hListView

	GUICreate("ListView Get Item State", 400, 300)
	$hListView = GUICtrlCreateListView("", 2, 2, 394, 268)

	_GUICtrlListView_SetExtendedListViewStyle($hListView, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES))
	GUISetState()


	; 加载图像
	$hImage = _GUIImageList_Create()
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($hListView, 0xFF0000, 16, 16))

	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($hListView, 0x00FF00, 16, 16))

	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($hListView, 0x0000FF, 16, 16))

	_GUICtrlListView_SetImageList($hListView, $hImage, 1)

	; 添加列
	_GUICtrlListView_AddColumn($hListView, "Column 1", 100)
	_GUICtrlListView_AddColumn($hListView, "Column 2", 100)
	_GUICtrlListView_AddColumn($hListView, "Column 3", 100)

	; 添加项目
	_GUICtrlListView_AddItem($hListView, "Row 1: Col 1", 0)

	_GUICtrlListView_AddSubItem($hListView, 0, "Row 1: Col 2", 1, 1)

	_GUICtrlListView_AddSubItem($hListView, 0, "Row 1: Col 3", 2, 2)

	_GUICtrlListView_AddItem($hListView, "Row 2: Col 1", 1)
	_GUICtrlListView_AddSubItem($hListView, 1, "Row 2: Col 2", 1, 2)

	_GUICtrlListView_AddItem($hListView, "Row 3: Col 1", 2)

	;
	获取项目 1 的状态
	_GUICtrlListView_SetItemState($hListView, 0, $LVIS_FOCUSED, $LVIS_FOCUSED)

	MsgBox(4160, "Information", "Item 1 State:" & _GUICtrlListView_GetItemState($hListView, 0, $LVIS_FOCUSED))

	; 循环至用户退出
	Do

	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

