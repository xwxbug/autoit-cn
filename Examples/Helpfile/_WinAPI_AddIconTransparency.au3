#include <WinAPIRes.au3>
#include <WinAPIShellEx.au3>
#include <GUIConstantsEx.au3>

Global Const $STM_SETIMAGE = 0x0172

Local $hIcon = _WinAPI_Create32BitHICON(_WinAPI_ShellExtractIcon(@SystemDir & '\shell32.dll', 1, 32, 32), 1)

GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 262, 108)
For $i = 0 To 3
	GUICtrlCreateIcon('', 0, 30 + 58 * $i, 38, 32, 32)
	GUICtrlSendMsg(-1, $STM_SETIMAGE, 1, _WinAPI_AddIconTransparency($hIcon, 100 - 25 * $i))
Next
_WinAPI_DestroyIcon($hIcon)
GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
