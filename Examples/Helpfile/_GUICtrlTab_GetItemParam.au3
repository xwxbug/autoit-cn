#include <GUIConstantsEx.au3>
#include <GuiTab.au3>

$Debug_TAB = False ; 检查传递给函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

; Warning do not use SetItemParam on items created with GUICtrlCreateTabItem
; Param is the controlId for items created with built-in functions

_Main()

Func _Main()
	Local $hGUI, $hTab

	; 创建 GUI
	$hGUI = GUICreate("(UDF Created) Tab Control Get Item Param", 400, 300)
	$hTab = _GUICtrlTab_Create($hGUI, 2, 2, 396, 296)
	GUISetState()

	; 添加标签
	_GUICtrlTab_InsertItem($hTab, 0, "Tab 1")
	_GUICtrlTab_InsertItem($hTab, 1, "Tab 2")
	_GUICtrlTab_InsertItem($hTab, 2, "Tab 3")

	; Get/Set tab 1 parameter
	_GUICtrlTab_SetItemParam($hTab, 0, 1234)
	MsgBox(4160, "Information", "Tab 1 parameter: " & _GUICtrlTab_GetItemParam($hTab, 0))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
