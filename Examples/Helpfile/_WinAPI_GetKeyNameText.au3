#include <WinAPISys.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'))
GUIRegisterMsg($WM_KEYDOWN, 'WM_KEYDOWN')
GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func WM_KEYDOWN($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam

	ConsoleWrite(_WinAPI_GetKeyNameText($lParam) & @CRLF)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_KEYDOWN
