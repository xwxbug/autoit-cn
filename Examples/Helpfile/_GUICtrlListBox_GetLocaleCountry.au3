#include <GuiListBox.au3>
#include <GUIConstantsEx.au3>

$Debug_LB = False ;检查传递给 ListBox 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $hListBox

	; 创建 GUI
	GUICreate("List Box Get Locale Country Code", 400, 296)
	$hListBox = GUICtrlCreateList("", 2, 2, 396, 296)
	GUISetState()

	; 显示区域, 国家代码, 语言标识符, 主要语言标识符和子语言标识符
	MsgBox(4160, "信息", _
			"Locale .................: " & _GUICtrlListBox_GetLocale($hListBox) & @LF & _
			"Country code ........: " & _GUICtrlListBox_GetLocaleCountry($hListBox) & @LF & _
			"Language identifier..: " & _GUICtrlListBox_GetLocaleLang($hListBox) & @LF & _
			"Primary Language id : " & _GUICtrlListBox_GetLocalePrimLang($hListBox) & @LF & _
			"Sub-Language id ....: " & _GUICtrlListBox_GetLocaleSubLang($hListBox))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
