#include <WinAPIShellEx.au3>
#include <WinAPI.au3>
#include <GUIConstantsEx.au3>

Global Const $STM_SETIMAGE = 0x0172

Local $Index = 0, $Total = _WinAPI_ExtractIconEx(@SystemDir & '\shell32.dll', -1, 0, 0, 0)

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 160, 160)
Local $Button = GUICtrlCreateButton('Next', 50, 130, 70, 23)
Local $Icon = GUICtrlCreateIcon(@SystemDir & '\shell32.dll', 0, 69, 54, 32, 32)
Local $hIcon = GUICtrlGetHandle(-1)
GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $Button
			$Index += 1
			If $Index > $Total - 1 Then
				$Index = 0
			EndIf
			_WinAPI_DestroyIcon(_SendMessage($hIcon, $STM_SETIMAGE, 1, _WinAPI_ShellExtractIcon(@SystemDir & '\shell32.dll', $Index, 32, 32)))
	EndSwitch
WEnd
