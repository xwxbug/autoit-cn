#include <GUIConstantsEx.au3>
#include <GuiHeader.au3>

$Debug_HDR = False ; 检查传递给函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $hGUI, $hHeader

	; 创建 GUI
	$hGUI = GUICreate("Header", 400, 300)
	$hHeader = _GUICtrlHeader_Create($hGUI)
	GUISetState()

	; 添加列
	_GUICtrlHeader_AddItem($hHeader, "Column 1", 100)
	_GUICtrlHeader_AddItem($hHeader, "Column 2", 100)
	_GUICtrlHeader_AddItem($hHeader, "Column 3", 100)
	_GUICtrlHeader_AddItem($hHeader, "Column 4", 100)

	; Set up filters
	_GUICtrlHeader_EditFilter($hHeader, 0)
	Send("Filter 1")
	Sleep(1000)
	Send("{ENTER}")
	_GUICtrlHeader_EditFilter($hHeader, 1)
	Send("Filter 2")
	Sleep(1000)
	Send("{ENTER}")

	; Clear first filter
	_GUICtrlHeader_ClearFilter($hHeader, 0)

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>_Main
