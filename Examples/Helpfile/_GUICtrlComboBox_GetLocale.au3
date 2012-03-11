#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>

$Debug_CB = False ;检查传递给 ComboBox/ComboBoxEx 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $hCombo

	; 创建 GUI
	GUICreate("ComboBox Get Locale", 400, 296)
	$hCombo = GUICtrlCreateCombo("", 2, 2, 396, 296)
	GUISetState()

	; 添加文件
	_GUICtrlComboBox_BeginUpdate($hCombo)
	_GUICtrlComboBox_AddDir($hCombo, @WindowsDir & "\*.exe")
	_GUICtrlComboBox_EndUpdate($hCombo)

	; 显示区域, 国家代码, 语言标识符, 主要语言标识符和子语言标识符
	MsgBox(4160, "信息", _
			"Locale .................: " & _GUICtrlComboBox_GetLocale($hCombo) & @LF & _
			"Country code ........: " & _GUICtrlComboBox_GetLocaleCountry($hCombo) & @LF & _
			"Language identifier..: " & _GUICtrlComboBox_GetLocaleLang($hCombo) & @LF & _
			"Primary Language id : " & _GUICtrlComboBox_GetLocalePrimLang($hCombo) & @LF & _
			"Sub-Language id ....: " & _GUICtrlComboBox_GetLocaleSubLang($hCombo))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
