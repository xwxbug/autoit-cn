#include <GuiConstantsEx.au3>
#include <GuiHeader.au3>

Opt('MustDeclareVars', 1)

$Debug_HDR = False ; 检查传递给控件的类名, 设置为真并使用另一控件句柄观察其工作

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $hHeader

	; 创建界面
	$hGUI = GUICreate("Header", 400, 300)
	$hHeader = _GUICtrlHeader_Create($hGUI)
	$iMemo = GUICtrlCreateEdit("", 2, 24, 396, 274, 0)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 显示Unicode格式
	MemoWrite("Using Unicode characters:" & _GUICtrlHeader_GetUnicodeFormat($hHeader))

	; 设置Unicode格式
	_GUICtrlHeader_SetUnicodeFormat($hHeader, True)

	; 添加列
	_GUICtrlHeader_AddItem($hHeader, "Column 1", 100)
	_GUICtrlHeader_AddItem($hHeader, "Column 2", 100)
	_GUICtrlHeader_AddItem($hHeader, "Column 3", 100)
	_GUICtrlHeader_AddItem($hHeader, "Column 4", 100)

	; 显示Unicode格式
	MemoWrite("Using Unicode characters:" & _GUICtrlHeader_GetUnicodeFormat($hHeader))

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入一行
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

