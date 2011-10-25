#include <GuiComboBoxEx.au3>
#include <GuiConstantsEx.au3>
#include <GuiImageList.au3>

Opt('MustDeclareVars ', 1)

$Debug_CB = False ; 检查传递给函数的类名 , 设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $hGUI, $hImage, $hCombo

	; 创建界面
	$hGUI = GUICreate(" ComboBoxEx Get Control ", 400, 300)
	$hCombo = _GUICtrlComboBoxEx_Create($hGUI, "", 2, 2, 394, 268)
	GUISetState()

	$hImage = _GUIImageList_Create(16, 16, 5, 3)
	_GUIImageList_AddIcon($hImage, @SystemDir & " \shell32.dll ", 110)
	_GUIImageList_AddIcon($hImage, @SystemDir & " \shell32.dll ", 131)
	_GUIImageList_AddIcon($hImage, @SystemDir & " \shell32.dll ", 165)
	_GUIImageList_AddIcon($hImage, @SystemDir & " \shell32.dll ", 168)
	_GUIImageList_AddIcon($hImage, @SystemDir & " \shell32.dll ", 137)
	_GUIImageList_AddIcon($hImage, @SystemDir & " \shell32.dll ", 146)
	_GUICtrlComboBoxEx_SetImageList($hCombo, $hImage)

	For $x = 0 To 5
		_GUICtrlComboBoxEx_AddString($hCombo, StringFormat(" %03d : Random string ", Random(1, 100, 1)), $x)
	Next

	MsgBox(4160, "Information ", _
			" Combo Control Handle:" & _GUICtrlComboBoxEx_GetComboControl($hCombo) & @LF & _
			" Edit Control Handle:" & _GUICtrlComboBoxEx_GetEditControl($hCombo))

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

