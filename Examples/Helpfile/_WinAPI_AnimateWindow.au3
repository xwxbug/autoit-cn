#Include  <GUIConstantsEx.au3>
#Include  <Constants.au3>
#Include  <WinAPIEx.au3>
#Include  <WindowsConstants.au3>

Opt('TrayMenuMode ', 1)

Global Const $SC_MINIMIZE = 0xF020

Global $hTray = ControlGetHandle('[CLASS:Shell_TrayWnd] ', '', 'TrayNotifyWnd1')
Global $hForm, $GUIMsg, $TrayMsg, $Dummy, $TrayRestoreItem, $TrayExitItem

$TrayRestoreItem = TrayCreateItem('Restore')
TrayItemSetState(-1, $TRAY_DEFAULT)
TrayCreateItem('')
$TrayExitItem = TrayCreateItem('Exit')
TraySetClick(8)

$hForm = GUICreate('My GUI')
$Dummy = GUICtrlCreateDummy()
GUIRegisterMsg($WM_SYSCOMMAND, 'WM_SYSCOMMAND')
GUISetState()

While 1
	$TrayMsg = TrayGetMsg()
	Switch $TrayMsg
		Case $GUI_EVENT_CLOSE
			_WinAPI_DrawAnimateRect($hForm, _WinAPI_GetWindowRect($hTray), _WinAPI_GetWindowRect($hForm))
			GUISetState(@SW_SHOW, $hForm)
			TraySetClick(2)
		Case $Dummy
			ExitLoop
	EndSwitch
	$TrayMsg = GUIGetMsg()
	Switch $GUIMsg
		Case $GUI_EVENT_CLOSE
			_WinAPI_AnimateWindow($hForm, BitOR($AW_BLEND, $AW_HIDE))
			ExitLoop
		Case $Dummy
			_WinAPI_DrawAnimateRect($hForm, _WinAPI_GetWindowRect($hForm), _WinAPI_GetWindowRect($hTray))
			GUISetState(@SW_SHOW, $hForm)
			TraySetClick(1)
	EndSwitch
WEnd

Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
	Switch $hWnd
		Case $hForm
			Switch $wParam
				Case $SC_MINIMIZE
					GUICtrlCreateDummy()
					Return 0
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
endfunc   ;==>WM_COMMAND

