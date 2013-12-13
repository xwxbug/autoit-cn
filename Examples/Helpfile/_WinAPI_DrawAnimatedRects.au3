#NoTrayIcon

#include <WinAPIGdi.au3>
#include <APIGdiConstants.au3>
#include <WinAPISys.au3>
#include <APISysConstants.au3>
#include <Constants.au3>
#include <WIndowsConstants.au3>
#include <MenuConstants.au3>
#include <GUIConstantsEx.au3>

Opt('TrayMenuMode', 1)

Local $hTray = ControlGetHandle('[CLASS:Shell_TrayWnd]', '', 'TrayNotifyWnd1')

Local $TrayRestoreItem = TrayCreateItem('Restore')
TrayItemSetState(-1, $TRAY_DEFAULT)
TrayCreateItem('')
Local $TrayExitItem = TrayCreateItem('Exit')
TraySetClick(8)

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'))
Local $Dummy = GUICtrlCreateDummy()
GUIRegisterMsg($WM_SYSCOMMAND, 'WM_SYSCOMMAND')
GUISetState()

While 1
	Switch TrayGetMsg()
		Case $TrayRestoreItem
			_WinAPI_DrawAnimatedRects($hForm, _WinAPI_GetWindowRect($hTray), _WinAPI_GetWindowRect($hForm))
			GUISetState(@SW_SHOW, $hForm)
			TraySetState(2)
		Case $TrayExitItem
			ExitLoop
	EndSwitch
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			_WinAPI_AnimateWindow($hForm, BitOR($AW_BLEND, $AW_HIDE))
			ExitLoop
		Case $Dummy ; Minimize
			_WinAPI_DrawAnimatedRects($hForm, _WinAPI_GetWindowRect($hForm), _WinAPI_GetWindowRect($hTray))
			GUISetState(@SW_HIDE, $hForm)
			TraySetState(1)
	EndSwitch
WEnd

Func WM_SYSCOMMAND($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $lParam

	Switch $hWnd
		Case $hForm
			Switch $wParam
				Case $SC_MINIMIZE
					GUICtrlSendToDummy($Dummy)
					Return 0
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SYSCOMMAND
