#include <GuiComboBoxEx.au3>
#include <GuiImageList.au3>
#include <GUIConstantsEx.au3>

$Debug_CB = False ;检查传递给 ComboBox/ComboBoxEx 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $hGUI, $hImage, $hCombo

	; 创建 GUI
	$hGUI = GUICreate("ComboBoxEx Set Extended Style", 400, 300)
	$hCombo = _GUICtrlComboBoxEx_Create($hGUI, "", 2, 2, 394, 100)
	;设置扩展样式
	_GUICtrlComboBoxEx_SetExtendedStyle($hCombo, $CBES_EX_CASESENSITIVE)
	GUISetState()

	$hImage = _GUIImageList_Create(16, 16, 5, 3)
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 110)
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 131)
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 165)
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 168)
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 137)
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 146)
	_GUIImageList_Add($hImage, _GUICtrlComboBoxEx_CreateSolidBitMap($hCombo, 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlComboBoxEx_CreateSolidBitMap($hCombo, 0x00FF00, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlComboBoxEx_CreateSolidBitMap($hCombo, 0x0000FF, 16, 16))
	_GUICtrlComboBoxEx_SetImageList($hCombo, $hImage)

	For $x = 0 To 8
		_GUICtrlComboBoxEx_AddString($hCombo, StringFormat("%03d : Random string", Random(1, 100, 1)), $x, $x)
	Next

	;获取扩展样式
	MsgBox(4160, "信息", "Extend Styles found: " & _DisplayExtendStringList($hCombo))

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>_Main

Func _DisplayExtendStringList($hCombo)
	Local $Styles = @LF & @LF & @TAB
	If (BitAND(_GUICtrlComboBoxEx_GetExtendedStyle($hCombo), $CBES_EX_CASESENSITIVE) = $CBES_EX_CASESENSITIVE) Then $Styles &= "$CBES_EX_CASESENSITIVE" & @LF & @TAB
	If (BitAND(_GUICtrlComboBoxEx_GetExtendedStyle($hCombo), $CBES_EX_NOEDITIMAGE) = $CBES_EX_NOEDITIMAGE) Then $Styles &= "$CBES_EX_NOEDITIMAGE" & @LF & @TAB
	If (BitAND(_GUICtrlComboBoxEx_GetExtendedStyle($hCombo), $CBES_EX_NOEDITIMAGEINDENT) = $CBES_EX_NOEDITIMAGEINDENT) Then $Styles &= "$CBES_EX_NOEDITIMAGEINDENT" & @LF & @TAB
	If (BitAND(_GUICtrlComboBoxEx_GetExtendedStyle($hCombo), $CBES_EX_NOSIZELIMIT) = $CBES_EX_NOSIZELIMIT) Then $Styles &= "$CBES_EX_NOSIZELIMIT" & @LF & @TAB
;~ 	If (BitAND(_GUICtrlComboBoxEx_GetExtendedStyle ($hCombo), $CBES_EX_PATHWORDBREAKPROC) = $CBES_EX_PATHWORDBREAKPROC) Then $Styles &= "$CBES_EX_PATHWORDBREAKPROC"
	Return $Styles
EndFunc   ;==>_DisplayExtendStringList
