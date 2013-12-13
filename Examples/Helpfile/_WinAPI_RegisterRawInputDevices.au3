#include <WinAPISys.au3>
#include <APISysConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPIMisc.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

Opt('TrayAutoPause', 0)

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

Local $hPart[9]
; Load bitmaps (Mice*.bmp) that are required to display picture
For $i = 0 To 6
	$hPart[$i] = _WinAPI_LoadImage(0, @ScriptDir & '\Extras\Mice' & $i & '.bmp', $IMAGE_BITMAP, 0, 0, $LR_LOADFROMFILE)
Next

; Copy some bitmaps for proper "Mice" drawing
$hPart[7] = _WinAPI_CopyBitmap($hPart[0])
$hPart[8] = _WinAPI_CopyBitmap($hPart[6])

; Create GUI
Global $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 160, 212, @DesktopWidth - 179, @DesktopHeight - 283, BitOR($WS_CAPTION, $WS_POPUP, $WS_SYSMENU), $WS_EX_TOPMOST)
Local $Pic = GUICtrlCreatePic('', 0, 0, 160, 160)
GUICtrlCreateGraphic(0, 160, 160, 1)
GUICtrlSetBkColor(-1, 0xDFDFDF)
GUICtrlCreateLabel('X:', 10, 170, 12, 14)
Local $Label[3]
$Label[0] = GUICtrlCreateLabel('', 23, 170, 30, 14)
GUICtrlCreateLabel('Y:', 10, 190, 12, 14)
$Label[1] = GUICtrlCreateLabel('', 23, 190, 30, 14)
GUICtrlCreateLabel('Wheel:', 80, 170, 36, 14)
$Label[2] = GUICtrlCreateLabel('', 117, 170, 30, 14)

_SetBitmap($Pic, $hPart[0])

; To obtain the values of "UsagePage" and "Usage" members of this structure read HID Usage Tables documentation
; http://www.usb.org/developers/devclass_docs/HID1_11.pdf
Local $tRID = DllStructCreate($tagRAWINPUTDEVICE)
DllStructSetData($tRID, 'UsagePage', 0x01) ; Generic Desktop Controls
DllStructSetData($tRID, 'Usage', 0x02) ; Mouse
DllStructSetData($tRID, 'Flags', $RIDEV_INPUTSINK)
DllStructSetData($tRID, 'hTarget', $hForm)
Local $pRID = DllStructGetPtr($tRID)

; Register HID input to obtain row input from mice
_WinAPI_RegisterRawInputDevices($pRID)

; Register WM_INPUT message
GUIRegisterMsg($WM_INPUT, 'WM_INPUT')

GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func _SetBitmap($hWnd, $hBitmap, $fUpdate = 0)
	If Not IsHWnd($hWnd) Then
		$hWnd = GUICtrlGetHandle($hWnd)
		If Not $hWnd Then
			Return 0
		EndIf
	EndIf

	$hBitmap = _WinAPI_CopyBitmap($hBitmap)
	If @error Then
		Return 0
	EndIf
	Local $hPrev = _SendMessage($hWnd, $STM_SETIMAGE, $IMAGE_BITMAP, $hBitmap)
	If $hPrev Then
		_WinAPI_DeleteObject($hPrev)
	EndIf
	$hPrev = _SendMessage($hWnd, $STM_GETIMAGE)
	If $hPrev <> $hBitmap Then
		_WinAPI_DeleteObject($hBitmap)
	EndIf
	If $fUpdate Then
		_WinAPI_UpdateWindow($hWnd)
	EndIf
	Return 1
EndFunc   ;==>_SetBitmap

Func WM_INPUT($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam

	Switch $hWnd
		Case $hForm
			Local $tRIM = DllStructCreate($tagRAWINPUTMOUSE)
			If _WinAPI_GetRawInputData($lParam, DllStructGetPtr($tRIM), DllStructGetSize($tRIM), $RID_INPUT) Then
				Local $Flags = DllStructGetData($tRIM, 'Flags')
				Select
					Case BitAND($Flags, $MOUSE_ATTRIBUTES_CHANGED)
						; You need to query the mouse attributes and update bitmap...
					Case Else

				EndSelect
				$Flags = DllStructGetData($tRIM, 'ButtonFlags')
				If BitAND($Flags, BitOR($RI_MOUSE_MIDDLE_BUTTON_DOWN, $RI_MOUSE_MIDDLE_BUTTON_UP, $RI_MOUSE_LEFT_BUTTON_DOWN, $RI_MOUSE_LEFT_BUTTON_UP, $RI_MOUSE_RIGHT_BUTTON_DOWN, $RI_MOUSE_RIGHT_BUTTON_UP)) Then
					Local $hDC = _WinAPI_CreateCompatibleDC(0)
					Local $hSv = _WinAPI_SelectObject($hDC, $hPart[8])
					Select
						Case BitAND($Flags, $RI_MOUSE_MIDDLE_BUTTON_DOWN)
							_WinAPI_DrawBitmap($hDC, 0, 0, $hPart[5])
						Case BitAND($Flags, $RI_MOUSE_MIDDLE_BUTTON_UP)
							_WinAPI_DrawBitmap($hDC, 0, 0, $hPart[6])
					EndSelect
					_WinAPI_SelectObject($hDC, $hPart[7])
					Select
						Case BitAND($Flags, $RI_MOUSE_LEFT_BUTTON_DOWN)
							_WinAPI_DrawBitmap($hDC, 39, 25, $hPart[1])
						Case BitAND($Flags, $RI_MOUSE_LEFT_BUTTON_UP)
							_WinAPI_DrawBitmap($hDC, 39, 25, $hPart[2])
						Case BitAND($Flags, $RI_MOUSE_RIGHT_BUTTON_DOWN)
							_WinAPI_DrawBitmap($hDC, 81, 25, $hPart[3])
						Case BitAND($Flags, $RI_MOUSE_RIGHT_BUTTON_UP)
							_WinAPI_DrawBitmap($hDC, 81, 25, $hPart[4])
					EndSelect
					_WinAPI_DrawBitmap($hDC, 74, 33, $hPart[8])
					_WinAPI_SelectObject($hDC, $hSv)
					_WinAPI_DeleteDC($hDC)
					_SetBitmap($Pic, $hPart[7])
				EndIf
				Local $Data = MouseGetPos()
				For $i = 0 To 1
					If StringCompare(GUICtrlRead($Label[$i]), $Data[$i]) Then
						GUICtrlSetData($Label[$i], $Data[$i])
					EndIf
				Next
				If BitAND($Flags, $RI_MOUSE_WHEEL) Then
					$Data = _WinAPI_WordToShort(DllStructGetData($tRIM, 'ButtonData'))
					If $Data > 0 Then
						$Data = 'Up'
					Else
						$Data = 'Down'
					EndIf
				Else
					$Data = ''
				EndIf
				If StringCompare(GUICtrlRead($Label[2]), $Data) Then
					GUICtrlSetData($Label[2], $Data)
				EndIf
			EndIf
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_INPUT
