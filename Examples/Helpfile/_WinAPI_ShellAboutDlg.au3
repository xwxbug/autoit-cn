#include <WinAPIDlg.au3>
#include <GUIConstantsEx.au3>

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400)
Local $Button = GUICtrlCreateButton('About', 165, 366, 70, 23)
GUICtrlSetState($Button, $GUI_DEFBUTTON)
GUISetState()
Send('{Enter}')

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $Button
			_WinAPI_ShellAboutDlg('About', 'About Dialog Box Test', 'Simple Text', _WinAPI_ShellExtractIcon(@AutoItExe, 0, 32, 32), $hForm)
	EndSwitch
WEnd
