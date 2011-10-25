#include <GuiComboBoxEx.au3>
#include <GuiImageList.au3>
#include <GuiConstantsEx.au3>

Opt('MustDeclareVars ', 1)

$Debug_CB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $hGUI, $hImage, $hCombo

	; 创建界面
	$hGUI = GUICreate(" ComboBoxEx ", 400, 300)
	$hCombo = _GUICtrlComboBoxEx_Create($hGUI, "", 2, 2, 394, 100)
	GUISetState()

	$hImage = _GUIImageList_Create(16, 16, 5, 3)
	For $x = 0 To 146
		_GUIImageList_AddIcon($hImage, @SystemDir & " \shell32.dll ", $x)
	Next
	_GUIImageList_Add($hImage, _GUICtrlComboBoxEx_CreateSolidBitMap($hCombo, 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlComboBoxEx_CreateSolidBitMap($hCombo, 0x00FF00, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlComboBoxEx_CreateSolidBitMap($hCombo, 0x0000FF, 16, 16))
	_GUICtrlComboBoxEx_SetImageList($hCombo, $hImage)

	_GUICtrlComboBoxEx_InitStorage($hCombo, 150, 300)

	_GUICtrlComboBoxEx_BeginUpdate($hCombo)
	For $x = 0 To 149
		_GUICtrlComboBoxEx_AddString($hCombo, StringFormat(" %03d : Random string Information ", "Delete String ")
		_GUICtrlComboBoxEx_DeleteString($hCombo, 1)
		Do
		Until GUIGetMsg() = $GUI_EVENT_CLOSE
;### Tidy Error -> "endfunc" is closing previous "for" on line 31
	endfunc   ;==>_Main


;### Tidy Error -> func is never closed in your script.
