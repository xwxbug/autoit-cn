
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w
6
#include  <GuiConstantsEx.au3>
#include  <GuiListView.au3>

Opt('MustDeclareVars', 1)

$Debug_LV = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $hListView

	GUICreate("ListView Ensure Visible", 400, 300)
	$hListView = GUICtrlCreateListView("Items", 2, 2, 394, 268)

	_GUICtrlListView_SetColumnWidth($hListView, 0, 100)

	_GUICtrlListView_SetExtendedListViewStyle($hListView, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT))
	GUISetState()


	_GUICtrlListView_BeginUpdate($hListView)

	For $i = 1 To 100
		GUICtrlCreateListViewItem("Item" & $i, $hListView)
	Next
	_GUICtrlListView_EndUpdate($hListView)


	MsgBox(4160, "Information", "Making item 50
	visible" )
	_GUICtrlListView_EnsureVisible($hListView, 49)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

