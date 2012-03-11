#include <GuiListBox.au3>
#include <GUIConstantsEx.au3>

$Debug_LB = False ;检查传递给 ListBox 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $aTabs[4] = [3, 100, 200, 300], $hListBox

	; 创建 GUI
	GUICreate("List Box Set Tab Stops", 400, 296)
	$hListBox = GUICtrlCreateList("", 2, 2, 396, 296, BitOR($LBS_STANDARD, $LBS_USETABSTOPS))
	GUISetState()

	; Set tab stops
	_GUICtrlListBox_SetTabStops($hListBox, $aTabs)

	; Add tabbed string
	_GUICtrlListBox_AddString($hListBox, "Column 1" & @TAB & "Column 2" & @TAB & "Column 3")

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
