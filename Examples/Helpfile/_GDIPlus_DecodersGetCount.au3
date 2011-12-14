#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>
#include <WindowsConstants.au3>

Global $iMemo

_Main()

Func _Main()
	; 创建 GUI
	GUICreate("GDI+", 600, 400)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 初始化 GDI+ 库
	_GDIPlus_Startup()

	; 显示解码器/编码器的数目
	MemoWrite("Decoder count : " & _GDIPlus_DecodersGetCount());
	MemoWrite("Decoder size .: " & _GDIPlus_DecodersGetSize());
	MemoWrite("Encoder count : " & _GDIPlus_EncodersGetCount());
	MemoWrite("Encoder size .: " & _GDIPlus_EncodersGetSize());

	; 关闭 GDI+ 库
	_GDIPlus_Shutdown()

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>_Main

; 写入一行到 memo 控件
Func MemoWrite($sMessage = '')
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
