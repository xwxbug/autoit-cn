#include <WinAPIMisc.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>

Global $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 96)
Global $Input1 = GUICtrlCreateInput('', 20, 20, 360, 20)
GUICtrlSetLimit(-1, 255)
Global $Input2 = GUICtrlCreateInput('', 20, 56, 360, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_READONLY))
GUIRegisterMsg($WM_COMMAND, 'WM_COMMAND')
GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $lParam

	Switch $hWnd
		Case $hForm
			Switch _WinAPI_LoWord($wParam)
				Case $Input1
					Switch _WinAPI_HiWord($wParam)
						Case $EN_CHANGE
							Local $Hash
							$Hash = _WinAPI_HashString(GUICtrlRead($Input1), 0, 16)
							If Not @error Then
								GUICtrlSetData($Input2, $Hash)
							Else
								GUICtrlSetData($Input2, '')
							EndIf
					EndSwitch
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND
