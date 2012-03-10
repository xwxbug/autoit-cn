#include <GUIConstantsEx.au3>
#include <GuiTab.au3>
#include <GuiToolTip.au3>

$Debug_TAB = False ; 检查传递给函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $hGUI, $hTool, $hTab

	; 创建 GUI
	$hGUI = GUICreate("Tab Control Get Tool Tips", 400, 300)
	$hTab = _GUICtrlTab_Create($hGUI, 2, 2, 396, 296)
	GUISetState()

	; 添加标签
	_GUICtrlTab_InsertItem($hTab, 0, "Tab 1")
	_GUICtrlTab_InsertItem($hTab, 1, "Tab 2")
	_GUICtrlTab_InsertItem($hTab, 2, "Tab 3")

	; Get/Set tooltip
	$hTool = _GUIToolTip_Create($hTab)
	_GUICtrlTab_SetToolTips($hTab, $hTool)

	MsgBox(4160, "Information", "ToolTip handle: 0x" & _GUICtrlTab_GetToolTips($hTab) & @CRLF & _
			"IsPtr = " & IsPtr(_GUICtrlTab_GetToolTips($hTab)) & " IsHwnd = " & IsHWnd(_GUICtrlTab_GetToolTips($hTab)))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
