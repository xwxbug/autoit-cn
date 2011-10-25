#include <GuiConstantsEx.au3>
#include <GuiHeader.au3>
#include <GuiImageList.au3>
#include <WinAPI.au3>

Opt('MustDeclareVars ', 1)

$Debug_HDR = False ; 检查传递给函数的类名 , 设置为真并使用另一控件的句柄观察其工作

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $hHeader, $msg, $align, $hImage

	; 创建界面
	$hGUI = GUICreate('Header ', 420, 300)
	$align = GUICtrlCreateButton('set/get item align ', 270, 118, 190, 20)
	$hHeader = _GUICtrlHeader_Create($hGUI)
	$iMemo = GUICtrlCreateEdit('', 2, 24, 426, 240)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	; 添加图像
	$hImage = _GUIImageList_Create(11, 11)
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hGUI, 0xFF0000, 11, 11))
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hGUI, 0x00FF00, 11, 11))
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hGUI, 0x0000FF, 11, 11))
	_GUICtrlHeader_SetImageList($hHeader, $hImage)

	; 添加列
	_GUICtrlHeader_AddItem($hHeader, "Column 1 ", 110, 0, 0)
	_GUICtrlHeader_AddItem($hHeader, "Column 2 ", 110, 0, 1)
	_GUICtrlHeader_AddItem($hHeader, "Column 3 ", 110, 0, 2)
	_GUICtrlHeader_AddItem($hHeader, "Column 4 ", 100)

	MemoWrite('Column 1 alignment:' & _GUICtrlHeader_GetItemAlign($hHeader, 0))

	Do
		$msg = GUIGetMsg()
		If $msg = $align Then
			; 设置列1对齐方式
			_GUICtrlHeader_SetItemAlign($hHeader, 0, 2)
			; 显示列1对齐方式
			MemoWrite('Column 1 alignment:' & _GUICtrlHeader_GetItemAlign($hHeader, 0))
		EndIf
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入一行
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

