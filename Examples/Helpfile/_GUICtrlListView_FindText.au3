
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w
6
#include  <GuiConstantsEx.au3>
#include  <GuiListView.au3>

Opt('MustDeclareVars', 1)

$Debug_LV = False ; 检查传递给函数的类名,
设置为真并使用另一控件句柄观察其工作

_Main()

Func _Main()
	Global $iI, $hListView

	; 创建界面
	GUICreate( "ListView Find
	Text" ,  400 ,  300 )
	$hListView = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState()

	; 添加列
	_GUICtrlListView_AddColumn($hListView, "Items", 100)

	; 添加项
	_GUICtrlListView_BeginUpdate($hListView)
	For $iI = 1 To 49
		_GUICtrlListView_AddItem($hListView, "Item" & $iI)
	Next
	_GUICtrlListView_AddItem($hListView, "Target item")

	For $iI = 51 To 100
		_GUICtrlListView_AddItem($hListView, "Item" & $iI)
	Next
	_GUICtrlListView_EndUpdate($hListView)


	; 搜索目标项目
	$iI = _GUICtrlListView_FindText($hListView, "tArGeT")
	MsgBox(4160, "Information", "Target Item Index:" & $iI)
	_GUICtrlListView_EnsureVisible($hListView, $iI)

	; 循环至用户退出

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

