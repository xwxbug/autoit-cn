#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiConstantsEx.au3>
#include <GuiTab.au3>

Opt('MustDeclareVars ', 1)

$Debug_TAB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $hTab

	; 创建界面
	GUICreate(" Tab Control Set Item Size ", 400, 300)
	$hTab = GUICtrlCreateTab(2, 2, 396, 296, BitOR($TCS_BUTTONS, $TCS_FIXEDWIDTH))
	_GUICtrlTab_SetItemSize($hTab, 70, 40)
	GUISetState()

	; 添加标签页
	_GUICtrlTab_InsertItem($hTab, 0, "Tab 1 ")
	_GUICtrlTab_InsertItem($hTab, 1, "Tab 2 ")
	_GUICtrlTab_InsertItem($hTab, 2, "Tab 3 ")

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

