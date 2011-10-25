#include  <GuiConstantsEx.au3>
#include  <WinApiEx.au3>
#include  <WindowsConstants.au3>

Opt('MustDeclareVars ', 1)

Dim $OnOff[2] = [' OFF ', 'ON ']
Global $iMemo
Global Const $VK_NUMLOCK = 0x90

_Main()

Func _Main()
	Local $hGUI, $aDisk

	; 创建界面
	$hGUI = GUICreate("Key State", 400, 300)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 获取NUMLOCK键状态, 观察键盘指示灯状态
	MemoWrite('NumLock:' & $OnOff[BitAND( _WinAPI_GetKeyState($VK_NUMLOCK), 1)])
	Sleep(1500)
	Send('{NUMLOCK toggle}')
	MemoWrite('NumLock:' & $OnOff[BitAND( _WinAPI_GetKeyState($VK_NUMLOCK), 1)])
	Sleep(1500)
	Send('{NUMLOCK toggle}')
	MemoWrite('NumLock:' & $OnOff[BitAND( _WinAPI_GetKeyState($VK_NUMLOCK), 1)])

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

