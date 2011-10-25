失败: - 1


示例
#include <GuiConstantsEx.au3>
#include <GuiHeader.au3>

Opt('MustDeclareVars ', 1)

$Debug_HDR = False ; 检查传递给函数的类名 , 设置为真并使用另一控件的句柄观察其工作

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $hHeader

	; 创建界面
	$hGUI = GUICreate('Header ', 420, 300)
	$hHeader = _GUICtrlHeader_Create($hGUI)
	$iMemo = GUICtrlCreateEdit('', 2, 24, 426, 240)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	; 添加列
	_GUICtrlHeader_AddItem($hHeader, "Column 1 ", 110)
	_GUICtrlHeader_AddItem($hHeader, "Column 2 ", 110)
	_GUICtrlHeader_AddItem($hHeader, "Column 3 ", 110)
	_GUICtrlHeader_AddItem($hHeader, "Column 4 ", 100)

	MemoWrite('Column count:' & _GUICtrlHeader_GetItemCount($hHeader))

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入一行
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

