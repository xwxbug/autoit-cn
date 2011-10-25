#include <GuiConstantsEx.au3>
#include <WinApiEx.au3>
#include <WindowsConstants.au3>

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $aDisk

	; 创建界面
	$hGUI = GUICreate("Locale Info", 400, 300)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 获取区域设置信息
	$ID = _WinAPI_GetUserDefaultLCID()
	MemoWrite('Language =>' & _WinAPI_GetLocaleInfo($ID, $LOCALE_SLANGUAGE) & @CR)
	MemoWrite('Date format =>' & _WinAPI_GetLocaleInfo($ID, $LOCALE_SSHORTDATE) & @CR)
	MemoWrite('Time format =>' & _WinAPI_GetLocaleInfo($ID, $LOCALE_STIMEFORMAT) & @CR)
	MemoWrite('Currency name =>' & _WinAPI_GetLocaleInfo($ID, $LOCALE_SNATIVECURRNAME) & @CR)
	MemoWrite('Monetary symbol =>' & _WinAPI_GetLocaleInfo($ID, $LOCALE_SCURRENCY) & @CR)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

