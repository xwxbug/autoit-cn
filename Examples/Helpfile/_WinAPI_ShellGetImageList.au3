#include <WinAPIShPath.au3>
#include <WinAPIRes.au3>
#include <GUIImageList.au3>
#include <GUIConstantsEx.au3>

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

; Initialize system image list
_WinAPI_FileIconInit()

; Retrieve system image list and calculate bitmap size
Local $hImageList = _WinAPI_ShellGetImageList()
If @error Then Exit

Local $Count = _GUIImageList_GetImageCount($hImageList)
Local $Size = _GUIImageList_GetIconSize($hImageList)
Local $CX = Sqrt($Count)
Local $CY
If $CX Then
	$CX = Ceiling($CX)
	$CY = Ceiling($Count / $CX)
Else
	$CX = 1
	$CY = 1
EndIf
Local $W = $CX * ($Size[0] + 14)
Local $H = $CY * ($Size[1] + 14)

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), $W, $H)
Local $Pic = GUICtrlCreatePic('', 0, 0, $W, $H)
Local $hPic = GUICtrlGetHandle($Pic)

; Create bitmap
Local $hDC = _WinAPI_GetDC($hPic)
Local $hMemDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmap($hDC, $W, $H)
Local $hMemSv = _WinAPI_SelectObject($hMemDC, $hBitmap)

; Draw all icons from the system image list into bitmap
Local $Index = 0
For $y = 1 To $CY
	For $x = 1 To $CX
		_GUIImageList_Draw($hImageList, $Index, $hMemDC, ($x - 1) * ($Size[0] + 14) + 7, ($y - 1) * ($Size[0] + 14) + 7)
		$Index += 1
		If $Index >= $Count Then
			ExitLoop
		EndIf
	Next
Next

; Release objects
_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_SelectObject($hMemDC, $hMemSv)
_WinAPI_DeleteDC($hMemDC)

; Set bitmap to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
Local $hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

; Show GUI
GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
