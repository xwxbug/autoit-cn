
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w
6
#include  <GuiConstantsEx.au3>
#include  <GuiListView.au3>

Opt('MustDeclareVars', 1)

$Debug_LV = False ; 检查传递给函数的类名,
设置为真并使用另一控件句柄观察其工作

_Main()

Func _Main()
	Local $hListView

	GUICreate("ListView Get Column Count", 400, 300)
	$hListView = GUICtrlCreateListView("col1|col2|col3", 2, 2, 394, 268)
	GUISetState()


	MsgBox(4160, "Information", "Column Count:" & _GUICtrlListView_GetColumnCount($hListView))


	; 循环至用户退出
	Do

	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	GUIDelete()
endfunc   ;==>_Main

