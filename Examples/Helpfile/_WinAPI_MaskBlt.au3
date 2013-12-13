#include <WinAPIGdi.au3>
#include <WinAPIShellEx.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

; Extracts icon and get its AND bitmask bitmap
Local $hIcon = _WinAPI_ShellExtractIcon(@ScriptDir & '\Extras\Arrow.ico', 0, 64, 64)
Local $aInfo = _WinAPI_GetIconInfo($hIcon)
_WinAPI_DeleteObject($aInfo[5])
_WinAPI_DestroyIcon($hIcon)

; Create inverted bitmask bitmap
$aInfo[5] = _WinAPI_InvertANDBitmap($aInfo[4])

; Load pattern bitmap
Local $hPattern = _WinAPI_LoadImage(0, @ScriptDir & '\Extras\Pattern.bmp', $IMAGE_BITMAP, 0, 0, $LR_LOADFROMFILE)

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 320, 64)
GUICtrlCreateIcon(@ScriptDir & '\Extras\Arrow.ico', 0, 0, 0, 64, 64)
GUICtrlCreatePic(@ScriptDir & '\Extras\Pattern.bmp', 192, 0, 64, 64)
Local $Icon = GUICtrlCreateIcon('', 0, 256, 0, 64, 64)
Local $Pic[2], $hPic[2]
$Pic[0] = GUICtrlCreatePic('', 64, 0, 64, 64)
$Pic[1] = GUICtrlCreatePic('', 128, 0, 64, 64)
For $i = 0 To 1
	$hPic[$i] = GUICtrlGetHandle($Pic[$i])
Next

; Create XOR bitmask bitmap
Local $hDC = _WinAPI_GetDC($hPic)
Local $hSrcDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hSrcSv = _WinAPI_SelectObject($hSrcDC, $hPattern)
Local $hDestDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hXOR = _WinAPI_CreateCompatibleBitmap($hDC, 64, 64)
Local $hDestSv = _WinAPI_SelectObject($hDestDC, $hXOR)
_WinAPI_MaskBlt($hDestDC, 0, 0, 64, 64, $hSrcDC, 0, 0, $aInfo[5], 0, 0, $SRCCOPY)
_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_SelectObject($hDestDC, $hDestSv)
_WinAPI_DeleteDC($hDestDC)
_WinAPI_SelectObject($hSrcDC, $hSrcSv)
_WinAPI_DeleteObject($hPattern)
_WinAPI_DeleteDC($hSrcDC)

; Create icon

$hIcon = _WinAPI_CreateIconIndirect($hXOR, $aInfo[4])
_WinAPI_DeleteObject($hXOR)

; Set both bitmask bitmaps to controls
Local $hObj
For $i = 0 To 1
	_SendMessage($hPic[$i], $STM_SETIMAGE, 0, $aInfo[$i + 4])
	$hObj = _SendMessage($hPic[$i], $STM_GETIMAGE)
	If $hObj <> $aInfo[$i + 4] Then
		_WinAPI_DeleteObject($aInfo[$i + 4])
	EndIf
Next

; Set icon to control
GUICtrlSendMsg($Icon, $STM_SETIMAGE, 1, $hIcon)

; Show GUI
GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
