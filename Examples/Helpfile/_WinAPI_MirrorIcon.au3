#include <WinAPISys.au3>
#include <WinAPIShellEx.au3>
#include <GUIConstantsEx.au3>

Global Const $STM_SETIMAGE = 0x0172

Global $hIcon = _WinAPI_ShellExtractIcon(@SystemDir & '\shell32.dll', 4, 32, 32)

GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 156, 108)
GUICtrlCreateIcon('', 0, 30, 38, 32, 32)
GUICtrlSendMsg(-1, $STM_SETIMAGE, 1, $hIcon)
GUICtrlCreateIcon('', 0, 88, 38, 32, 32)
GUICtrlSendMsg(-1, $STM_SETIMAGE, 1, _WinAPI_MirrorIcon($hIcon))
GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
