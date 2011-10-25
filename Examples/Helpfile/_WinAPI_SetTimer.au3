#Include <Misc.au3>
#Include <WinAPIEx.au3>
#Include <WindowsConstants.au3>

Opt('MustDeclareVars ', 1)

Global $hTimerFunc = DllCallbackRegister('_Timer ', 'none ', 'hwnd ; uint ; uint ; dword')
Global $Count = 0, $iMemo

_Main()

Func _Main()
	Local $hGUI, $Drive = DriveGetDrive('ALL')

	; 创建界面
	$hGUI = GUICreate(" Timer Example ", 400, 300)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	; 设置计时器
	_WinAPI_SetTimer(0, 0, 1000, DllCallBackGetPtr($hTimerFunc))

	; 循环至用户退出
	Do
	Until _IsPressed('1B') ; 按ESC键退出

	DllCallbackFree($hTimerFunc)

endfunc   ;==>_Main

Func _Timer($hWnd, $iMsg, $iTimerId, $iTime)
	$Count += 1
	MemoWrite($Count & @CR)
endfunc   ;==>_Timer

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

