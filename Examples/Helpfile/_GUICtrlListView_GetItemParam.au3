#include <GUIConstantsEx.au3>
#include <GuiListView.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

; 警告不要把 SetItemParam 用于使用 GuiCtrlCreateListViewItem 创建的项目上
; Param 为用内置函数创建的项目的控件 ID

Example_UDF_Created()

Func Example_UDF_Created()
	Local $GUI, $hListView

	$GUI = GUICreate("(UDF Created) ListView Get Item Param", 400, 300)
	$hListView = _GUICtrlListView_Create($GUI, "", 2, 2, 394, 268)
	GUISetState()

	; 添加列
	_GUICtrlListView_AddColumn($hListView, "Items", 100)

	; 添加项目
	_GUICtrlListView_AddItem($hListView, "Item 1")
	_GUICtrlListView_AddItem($hListView, "Item 2")
	_GUICtrlListView_AddItem($hListView, "Item 3")

	; 设置第二项的参数
	_GUICtrlListView_SetItemParam($hListView, 1, 1234)
	MsgBox(4160, "信息", "Item 2 Parameter: " & _GUICtrlListView_GetItemParam($hListView, 1))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example_UDF_Created
