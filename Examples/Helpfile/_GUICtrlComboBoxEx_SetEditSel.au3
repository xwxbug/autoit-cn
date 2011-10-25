#include <GuiComboBoxEx.au3>
#include <GuiConstantsEx.au3>
#include <GuiImageList.au3>
#include <WindowsConstants.au3>

Opt('MustDeclareVars ', 1)

$Debug_CB = False ; 检查传递给函数的类名 , 设置为真并使用另一控件的句柄观察其工作

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $hImage, $aSel, $hCombo

	; 创建界面
	$hGUI = GUICreate(" ComboBoxEx Cur Sel ", 400, 300)
	$hCombo = _GUICtrlComboBoxEx_Create($hGUI, "", 2, 2, 394, 100, BitOR($CBS_SIMPLE, $WS_VSCROLL, $WS_BORDER))
	$iMemo = GUICtrlCreateEdit("", 2, 72, 396, 226, 0)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	$hImage = _GUIImageList_Create(16, 16, 5, 3)
	_GUIImageList_AddIcon($hImage, @SystemDir & " \shell32.dll ", 110)
	_GUIImageList_AddIcon($hImage, @SystemDir & " \shell32.dll ", 131)
	_GUIImageList_AddIcon($hImage, @SystemDir & " \shell32.dll ", 165)
	_GUIImageList_AddIcon($hImage, @SystemDir & " \shell32.dll ", 168)
	_GUIImageList_AddIcon($hImage, @SystemDir & " \shell32.dll ", 137)
	_GUIImageList_AddIcon($hImage, @SystemDir & " \shell32.dll ", 146)
	_GUIImageList_Add($hImage, _GUICtrlComboBoxEx_CreateSolidBitMap($hCombo, 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlComboBoxEx_CreateSolidBitMap($hCombo, 0x00FF00, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlComboBoxEx_CreateSolidBitMap($hCombo, 0x0000FF, 16, 16))
	_GUICtrlComboBoxEx_SetImageList($hCombo, $hImage)

	; 添加字符串
	For $x = 0 To 8
		_GUICtrlComboBoxEx_AddString($hCombo, StringFormat(" %03d : Random string ", Random(1, 100, 1)), $x, $x)
	Next

	; 设置当前选项
	_GUICtrlComboBoxEx_SetCurSel($hCombo, Random(0, 8, 1))

	; 设置编辑选项
	_GUICtrlComboBoxEx_SetEditSel($hCombo, 0, 4)

	; 获取编辑选项
	$aSel = _GUICtrlComboBoxEx_GetEditSel($hCombo)
	MemoWrite( StringFormat(" Selected: [%d][%d] ", $aSel[0], $aSel[1]))

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 写入memo控件
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

