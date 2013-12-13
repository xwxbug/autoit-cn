#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <SliderConstants.au3>

Opt('TrayAutoPause', 0)

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

; Load image
Local $hBitmap = _WinAPI_LoadImage(0, @ScriptDir & '\Extras\AutoIt.bmp', $IMAGE_BITMAP, 0, 0, $LR_LOADFROMFILE)
Local $tSIZE = _WinAPI_GetBitmapDimension($hBitmap)
Local $W = DllStructGetData($tSIZE, 'X')
Local $H = DllStructGetData($tSIZE, 'Y')

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), $W, $H + 26)
Local $Pic = GUICtrlCreatePic('', 0, 0, $W, $H)
GUICtrlCreateGraphic(0, $H, $W, 1)
GUICtrlSetBkColor(-1, 0xDFDFDF)
Local $Slider = GUICtrlCreateSlider(0, $H + 1, $W, 25, BitOR($TBS_BOTH, $TBS_NOTICKS))
Local $hSlider = GUICtrlGetHandle(-1)
GUICtrlSetLimit(-1, 255, 0)
GUICtrlSetData(-1, 255)

; Set bitmap to control with alpha
_SetBitmapAlpha($Pic, $hBitmap, 255)

; Register WM_HSCROLL message for live scrolling and show GUI
GUIRegisterMsg($WM_HSCROLL, 'WM_HSCROLL')
GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func _SetBitmapAlpha($hWnd, $hBitmap, $iAlpha)
	If Not IsHWnd($hWnd) Then
		$hWnd = GUICtrlGetHandle($hWnd)
		If Not $hWnd Then
			Return 0
		EndIf
	EndIf

	Local $W[2], $H[2]
	Local $tRECT = _WinAPI_GetClientRect($hWnd)
	$W[0] = DllStructGetData($tRECT, 3) - DllStructGetData($tRECT, 1)
	$H[0] = DllStructGetData($tRECT, 4) - DllStructGetData($tRECT, 2)
	Local $tSIZE = _WinAPI_GetBitmapDimension($hBitmap)
	$W[1] = DllStructGetData($tSIZE, 1)
	$H[1] = DllStructGetData($tSIZE, 2)
	Local $hDC = _WinAPI_GetDC($hWnd)
	Local $hDestDC = _WinAPI_CreateCompatibleDC($hDC)
	Local $hBmp = _WinAPI_CreateCompatibleBitmapEx($hDC, $W[0], $H[0], 0xFFFFFF)
	Local $hDestSv = _WinAPI_SelectObject($hDestDC, $hBmp)
	Local $hSrcDC = _WinAPI_CreateCompatibleDC($hDC)
	Local $hSrcSv = _WinAPI_SelectObject($hSrcDC, $hBitmap)
	_WinAPI_AlphaBlend($hDestDC, 0, 0, $W[0], $H[0], $hSrcDC, 0, 0, $W[1], $H[1], $iAlpha, 0)
	_WinAPI_SelectObject($hDestDC, $hDestSv)
	_WinAPI_DeleteDC($hDestDC)
	_WinAPI_SelectObject($hSrcDC, $hSrcSv)
	_WinAPI_DeleteDC($hSrcDC)
	_WinAPI_ReleaseDC($hWnd, $hDC)
	Local $hObj = _SendMessage($hWnd, $STM_SETIMAGE, $IMAGE_BITMAP, $hBmp)
	If $hObj Then
		_WinAPI_DeleteObject($hObj)
	EndIf
	$hObj = _SendMessage($hWnd, $STM_GETIMAGE)
	If $hObj <> $hBmp Then
		_WinAPI_DeleteObject($hBmp)
	EndIf
	Return 1
EndFunc   ;==>_SetBitmapAlpha

Func WM_HSCROLL($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg,$wParam

	Switch $hWnd
		Case $hForm
			Switch $lParam
				Case $hSlider
					_SetBitmapAlpha($Pic, $hBitmap, GUICtrlRead($Slider))
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_HSCROLL
