#include <WinAPIGdi.au3>
#include <WinAPIShellEx.au3>
#include <GUIConstantsEx.au3>

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

; Extracts icon and create AND bitmask bitmap
Local $hIcon = _WinAPI_ShellExtractIcon(@ScriptDir & '\Extras\Script.ico', 0, 128, 128)
Local $aInfo = _WinAPI_GetIconInfo($hIcon)
_WinAPI_DeleteObject($aInfo[5])
_WinAPI_DestroyIcon($hIcon)

; Create inverted bitmask bitmap
$aInfo[5] = _WinAPI_InvertANDBitmap($aInfo[4])

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 256, 128)
Local $Pic[2], $hPic[2]
$Pic[0] = GUICtrlCreatePic('', 0, 0, 128, 128)
$Pic[1] = GUICtrlCreatePic('', 128, 0, 128, 128)
For $i = 0 To 1
	$hPic[$i] = GUICtrlGetHandle($Pic[$i])
Next

; Set both bitmaps to controls
For $i = 0 To 1
	_SendMessage($hPic[$i], $STM_SETIMAGE, 0, $aInfo[$i + 4])
	Local $hObj = _SendMessage($hPic[$i], $STM_GETIMAGE)
	If $hObj <> $aInfo[$i + 4] Then
		_WinAPI_DeleteObject($aInfo[$i + 4])
	EndIf
Next

GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
