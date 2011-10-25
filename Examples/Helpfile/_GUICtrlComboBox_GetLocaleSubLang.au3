#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include  <GUIComboBox.au3>
#include  <GuiConstantsEx.au3>

Opt('MustDeclareVars ', 1)

$Debug_CB = False ; 检查传递给函数的类名, 设置为真并使用另一控件句柄观察其工作

_Main()

Func _Main()
	Local $hCombo

	; 创建界面
	GUICreate(" ComboBox Get Locale ", 400, 296)
	$hCombo = GUICtrlCreateCombo("", 2, 2, 396, 296)
	GUISetState()

	; 添加文件
	_GUICtrlComboBox_BeginUpdate($hCombo)
	_GUICtrlComboBox_AddDir($hCombo, @WindowsDir & " \*.exe ")
	_GUICtrlComboBox_EndUpdate($hCombo)

	; 显示地区, 国家代码, 语言标识, 主语言编号, 副语言编号
	MsgBox(4160, "Information ", _
			" Locale .................:" & _GUICtrlComboBox_GetLocale($hCombo) & @LF & _
			" Country code ........:" & _GUICtrlComboBox_GetLocaleCountry($hCombo) & @LF & _
			" Language identifier..:" & _GUICtrlComboBox_GetLocaleLang($hCombo) & @LF & _
			" Primary Language id :" & _GUICtrlComboBox_GetLocalePrimLang($hCombo) & @LF & _
			" Sub-Language id ....:" & _GUICtrlComboBox_GetLocaleSubLang($hCombo))

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

