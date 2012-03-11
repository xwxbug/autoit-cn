#include <GUIConstantsEx.au3>
#include <GuiTab.au3>

$Debug_TAB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

_Main()

Func _Main()
	Local $hTab

	; 创建 GUI
	GUICreate("Tab Control Get Item State", 400, 300)
	$hTab = GUICtrlCreateTab(2, 2, 396, 296, $TCS_BUTTONS)
	GUISetState()

	; 添加标签
	_GUICtrlTab_InsertItem($hTab, 0, "Tab 1")
	_GUICtrlTab_InsertItem($hTab, 1, "Tab 2")
	_GUICtrlTab_InsertItem($hTab, 2, "Tab 3")

	; 获取/设置第二个标签的状态
	_GUICtrlTab_SetItemState($hTab, 1, $TCIS_BUTTONPRESSED)
	MsgBox(4160, "信息", "Tab 2 state: " & _ExplainItemState(_GUICtrlTab_GetItemState($hTab, 1)))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

Func _ExplainItemState($iState)
	Local $sText = ""
	If $iState = 0 Then $sText &= "No state set on this item" & @LF
	If BitAND($iState, $TCIS_BUTTONPRESSED) Then $sText &= "Button Pressed" & @LF
	If BitAND($iState, $TCIS_HIGHLIGHTED) Then $sText &= "Button Highlighted"
	Return $sText
EndFunc   ;==>_ExplainItemState
