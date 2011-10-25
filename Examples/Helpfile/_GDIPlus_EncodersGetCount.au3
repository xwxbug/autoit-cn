
#include  <GuiConstantsEx.au3>
#include  <GDIPlus.au3>
#include  <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $hBitmap

	; 创建界面
	$hGUI = GUICreate("GDI+", 600, 400)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 初始化GDI+库
	_GDIPlus_Startup()

	; 显示解码器/编码器数量
	MemoWrite("Decoder count :" & _GDIPlus_DecodersGetCount()) ;
	MemoWrite("Decoder size .:" & _GDIPlus_DecodersGetSize()) ;
	MemoWrite("Encoder count :" & _GDIPlus_EncodersGetCount()) ;
	MemoWrite("Encoder size .:" & _GDIPlus_EncodersGetSize()) ;

	; 关闭GDI+库
	_GDIPlus_ShutDown()

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 写入memo控件
Func MemoWrite($sMessage = '')
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

