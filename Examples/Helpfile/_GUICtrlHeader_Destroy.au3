
#include <GuiConstantsEx.au3>
#include <GuiHeader.au3>
#include <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

$Debug_HDR = False ; 检查传递给控件的类名, 设置为真并使用另一控件句柄观察其工作

Global $hHeader

_Main()

Func _Main()
	Local $hGUI

	; 创建界面
	$hGUI = GUICreate("Header", 400, 300)
	$hHeader = _GUICtrlHeader_Create($hGUI)
	GUISetState()

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	; 添加列
	_GUICtrlHeader_AddItem($hHeader, "1", 100)
	_GUICtrlHeader_AddItem($hHeader, "2", 100)
	_GUICtrlHeader_AddItem($hHeader, "3", 100)
	_GUICtrlHeader_AddItem($hHeader, "4", 100)

	; 清除所有过滤器
	_GUICtrlHeader_ClearFilterAll($hHeader)

	MsgBox(4096, "Information", "About to Destroy Header")

	_GUICtrlHeader_Destroy($hHeader)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

