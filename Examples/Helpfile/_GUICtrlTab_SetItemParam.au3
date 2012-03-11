#include <GUIConstantsEx.au3>
#include <GuiTab.au3>

$Debug_TAB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

; 警告不要把 SetItemParam 用在使用 GUICtrlCreateTabItem 创建的项目上
; Param 为用内置函数创建的项目的控件 ID

_Main()

Func _Main()
	Local $hGUI, $hTab

	; 创建 GUI
	$hGUI = GUICreate("(UDF Created) Tab Control Set Item Param", 400, 300)
	$hTab = _GUICtrlTab_Create($hGUI, 2, 2, 396, 296)
	GUISetState()

	; 添加标签
	_GUICtrlTab_InsertItem($hTab, 0, "Tab 1")
	_GUICtrlTab_InsertItem($hTab, 1, "Tab 2")
	_GUICtrlTab_InsertItem($hTab, 2, "Tab 3")

	; 获取/设置首个标签的参数
	_GUICtrlTab_SetItemParam($hTab, 0, 1234)
	MsgBox(4160, "信息", "Tab 1 parameter: " & _GUICtrlTab_GetItemParam($hTab, 0))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
