#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>
#include <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $hBitmap

	; Create GUI
	$hGUI = GUICreate("GDI+", 600, 400)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; Initialize GDI+ library
	_GDIPlus_Startup ()

	; Show number of decoders/encoders
	MemoWrite("Decoder count : " & _GDIPlus_DecodersGetCount());
	MemoWrite("Decoder size .: " & _GDIPlus_DecodersGetSize());
	MemoWrite("Encoder count : " & _GDIPlus_EncodersGetCount());
	MemoWrite("Encoder size .: " & _GDIPlus_EncodersGetSize());

	; Shut down GDI+ library
	_GDIPlus_ShutDown ()

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>_Main

; Write a line to the memo control
Func MemoWrite($sMessage = '')
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
