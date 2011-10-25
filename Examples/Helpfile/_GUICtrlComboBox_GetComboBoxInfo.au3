#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GUIComboBox.au3>
#include <GuiConstantsEx.au3>
#include <Constants.au3>

Opt('MustDeclareVars ', 1)

$Debug_CB = False ; 检查传递给函数的类名, 设置为真并使用另一控件句柄观察其工作

Global $iMemo

_Main()

Func _Main()
	Local $tInfo, $hCombo

	; 创建界面
	GUICreate(" ComboBox Get ComboBox Info ", 400, 296)
	$hCombo = GUICtrlCreateCombo(Courier New " )
	GUISetState()

	; 添加文件
	_GUICtrlComboBox_BeginUpdate($hCombo)
	_GUICtrlComboBox_AddDir($hCombo, @WindowsDir &, "\*.exe ")
	_GUICtrlComboBox_EndUpdate($hCombo)

	If _GUICtrlComboBox_GetComboBoxInfo($hCombo, $tInfo) Then
		MemoWrite(" Handle to the ComboBox .....:" & DllStructGetData($tInfo, "hCombo "))
		MemoWrite(" Handle to the Edit Box .....:" & DllStructGetData($tInfo, "hEdit "))
		MemoWrite(" Handle to the drop-down list:" & DllStructGetData($tInfo, "hList "))
	EndIf

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

; 写入memo控件
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

