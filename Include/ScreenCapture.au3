#include-once

#include "GDIPlus.au3"
#include "WinAPI.au3"

; #INDEX# =======================================================================================================================
; Title .........: ScreenCapture
; AutoIt Version : 3.3.7.20++
; Language ......: English
; Description ...: Functions that assist with Screen Capture management.
;                  This module allows you to copy the screen or a region of the screen and save it to file. Depending on the type
;                  of image, you can set various image parameters such as pixel format, quality and compression.
; Author(s) .....: Paul Campbell (PaulIA)
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
Global $giBMPFormat = $GDIP_PXF24RGB
Global $giJPGQuality = 100
Global $giTIFColorDepth = 24
Global $giTIFCompression = $GDIP_EVTCOMPRESSIONLZW
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
Global Const $__SCREENCAPTURECONSTANT_SM_CXSCREEN = 0
Global Const $__SCREENCAPTURECONSTANT_SM_CYSCREEN = 1
Global Const $__SCREENCAPTURECONSTANT_SRCCOPY = 0x00CC0020
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; _ScreenCapture_Capture
; _ScreenCapture_CaptureWnd
; _ScreenCapture_SaveImage
; _ScreenCapture_SetBMPFormat
; _ScreenCapture_SetJPGQuality
; _ScreenCapture_SetTIFColorDepth
; _ScreenCapture_SetTIFCompression
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; ===============================================================================================================================
Func _ScreenCapture_Capture($sFileName = "", $iLeft = 0, $iTop = 0, $iRight = -1, $iBottom = -1, $bCursor = True)
	If $iRight = -1 Then $iRight = _WinAPI_GetSystemMetrics($__SCREENCAPTURECONSTANT_SM_CXSCREEN) - 1
	If $iBottom = -1 Then $iBottom = _WinAPI_GetSystemMetrics($__SCREENCAPTURECONSTANT_SM_CYSCREEN) - 1
	If $iRight < $iLeft Then Return SetError(-1, 0, 0)
	If $iBottom < $iTop Then Return SetError(-2, 0, 0)

	Local $iW = ($iRight - $iLeft) + 1
	Local $iH = ($iBottom - $iTop) + 1
	Local $hWnd = _WinAPI_GetDesktopWindow()
	Local $hDDC = _WinAPI_GetDC($hWnd)
	Local $hCDC = _WinAPI_CreateCompatibleDC($hDDC)
	Local $hBMP = _WinAPI_CreateCompatibleBitmap($hDDC, $iW, $iH)
	_WinAPI_SelectObject($hCDC, $hBMP)
	_WinAPI_BitBlt($hCDC, 0, 0, $iW, $iH, $hDDC, $iLeft, $iTop, $__SCREENCAPTURECONSTANT_SRCCOPY)

	If $bCursor Then
		Local $aCursor = _WinAPI_GetCursorInfo()
		If $aCursor[1] Then
			Local $hIcon = _WinAPI_CopyIcon($aCursor[2])
			Local $aIcon = _WinAPI_GetIconInfo($hIcon)
			_WinAPI_DeleteObject($aIcon[4]) ; delete bitmap mask return by _WinAPI_GetIconInfo()
			If $aIcon[5] <> 0 Then _WinAPI_DeleteObject($aIcon[5]); delete bitmap hbmColor return by _WinAPI_GetIconInfo()
			_WinAPI_DrawIcon($hCDC, $aCursor[3] - $aIcon[2] - $iLeft, $aCursor[4] - $aIcon[3] - $iTop, $hIcon)
			_WinAPI_DestroyIcon($hIcon)
		EndIf
	EndIf

	_WinAPI_ReleaseDC($hWnd, $hDDC)
	_WinAPI_DeleteDC($hCDC)
	If $sFileName = "" Then Return $hBMP

	Local $ret = _ScreenCapture_SaveImage($sFileName, $hBMP, True)
	Return SetError(@error, @extended, $ret)
EndFunc   ;==>_ScreenCapture_Capture

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: jpm based on Kafu
; ===============================================================================================================================
Func _ScreenCapture_CaptureWnd($sFileName, $hWnd, $iLeft = 0, $iTop = 0, $iRight = -1, $iBottom = -1, $bCursor = True)
	If Not IsHWnd($hWnd) Then $hWnd = WinGetHandle($hWnd)
	Local $tRect = DllStructCreate($tagRECT)
	; needed to get rect when Aero theme is active : Thanks Kafu, Zedna
	Local Const $DWMWA_EXTENDED_FRAME_BOUNDS = 9
	Local $bRet = DllCall("dwmapi.dll", "long", "DwmGetWindowAttribute", "hwnd", $hWnd, "dword", $DWMWA_EXTENDED_FRAME_BOUNDS, "struct*", $tRect, "dword", DllStructGetSize($tRect))
	If (@error Or $bRet[0] Or (Abs(DllStructGetData($tRect, "Left")) + Abs(DllStructGetData($tRect, "Top")) + _
			Abs(DllStructGetData($tRect, "Right")) + Abs(DllStructGetData($tRect, "Bottom"))) = 0) Then
		$tRect = _WinAPI_GetWindowRect($hWnd)
		If @error Then Return SetError(@error, @extended, 0)
	EndIf

	$iLeft += DllStructGetData($tRect, "Left")
	$iTop += DllStructGetData($tRect, "Top")
	If $iRight = -1 Then $iRight = DllStructGetData($tRect, "Right") - DllStructGetData($tRect, "Left") - 1
	If $iBottom = -1 Then $iBottom = DllStructGetData($tRect, "Bottom") - DllStructGetData($tRect, "Top") - 1
	$iRight += DllStructGetData($tRect, "Left")
	$iBottom += DllStructGetData($tRect, "Top")
	If $iLeft > DllStructGetData($tRect, "Right") Then $iLeft = DllStructGetData($tRect, "Left")
	If $iTop > DllStructGetData($tRect, "Bottom") Then $iTop = DllStructGetData($tRect, "Top")
	If $iRight > DllStructGetData($tRect, "Right") Then $iRight = DllStructGetData($tRect, "Right") - 1
	If $iBottom > DllStructGetData($tRect, "Bottom") Then $iBottom = DllStructGetData($tRect, "Bottom") - 1
	Return _ScreenCapture_Capture($sFileName, $iLeft, $iTop, $iRight, $iBottom, $bCursor)
EndFunc   ;==>_ScreenCapture_CaptureWnd

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; ===============================================================================================================================
Func _ScreenCapture_SaveImage($sFileName, $hBitmap, $bFreeBmp = True)
	_GDIPlus_Startup()
	If @error Then Return SetError(-1, -1, False)

	Local $sExt = StringUpper(__GDIPlus_ExtractFileExt($sFileName))
	Local $sCLSID = _GDIPlus_EncodersGetCLSID($sExt)
	If $sCLSID = "" Then Return SetError(-2, -2, False)
	Local $hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)
	If @error Then Return SetError(-3, -3, False)

	Local $tData, $tParams
	Switch $sExt
		Case "BMP"
			Local $iX = _GDIPlus_ImageGetWidth($hImage)
			Local $iY = _GDIPlus_ImageGetHeight($hImage)
			Local $hClone = _GDIPlus_BitmapCloneArea($hImage, 0, 0, $iX, $iY, $giBMPFormat)
			_GDIPlus_ImageDispose($hImage)
			$hImage = $hClone
		Case "JPG", "JPEG"
			$tParams = _GDIPlus_ParamInit(1)
			$tData = DllStructCreate("int Quality")
			DllStructSetData($tData, "Quality", $giJPGQuality)
			_GDIPlus_ParamAdd($tParams, $GDIP_EPGQUALITY, 1, $GDIP_EPTLONG, DllStructGetPtr($tData))
		Case "TIF", "TIFF"
			$tParams = _GDIPlus_ParamInit(2)
			$tData = DllStructCreate("int ColorDepth;int Compression")
			DllStructSetData($tData, "ColorDepth", $giTIFColorDepth)
			DllStructSetData($tData, "Compression", $giTIFCompression)
			_GDIPlus_ParamAdd($tParams, $GDIP_EPGCOLORDEPTH, 1, $GDIP_EPTLONG, DllStructGetPtr($tData, "ColorDepth"))
			_GDIPlus_ParamAdd($tParams, $GDIP_EPGCOMPRESSION, 1, $GDIP_EPTLONG, DllStructGetPtr($tData, "Compression"))
	EndSwitch
	Local $pParams = 0
	If IsDllStruct($tParams) Then $pParams = $tParams

	Local $iRet = _GDIPlus_ImageSaveToFileEx($hImage, $sFileName, $sCLSID, $pParams)
	_GDIPlus_ImageDispose($hImage)
	If $bFreeBmp Then _WinAPI_DeleteObject($hBitmap)
	_GDIPlus_Shutdown()

	Return SetError($iRet = False, 0, $iRet = True)
EndFunc   ;==>_ScreenCapture_SaveImage

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; ===============================================================================================================================
Func _ScreenCapture_SetBMPFormat($iFormat)
	Switch $iFormat
		Case 0
			$giBMPFormat = $GDIP_PXF16RGB555
		Case 1
			$giBMPFormat = $GDIP_PXF16RGB565
		Case 2
			$giBMPFormat = $GDIP_PXF24RGB
		Case 3
			$giBMPFormat = $GDIP_PXF32RGB
		Case 4
			$giBMPFormat = $GDIP_PXF32ARGB
		Case Else
			$giBMPFormat = $GDIP_PXF24RGB
	EndSwitch
EndFunc   ;==>_ScreenCapture_SetBMPFormat

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; ===============================================================================================================================
Func _ScreenCapture_SetJPGQuality($iQuality)
	If $iQuality < 0 Then $iQuality = 0
	If $iQuality > 100 Then $iQuality = 100
	$giJPGQuality = $iQuality
EndFunc   ;==>_ScreenCapture_SetJPGQuality

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; ===============================================================================================================================
Func _ScreenCapture_SetTIFColorDepth($iDepth)
	Switch $iDepth
		Case 24
			$giTIFColorDepth = 24
		Case 32
			$giTIFColorDepth = 32
		Case Else
			$giTIFColorDepth = 0
	EndSwitch
EndFunc   ;==>_ScreenCapture_SetTIFColorDepth

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; ===============================================================================================================================
Func _ScreenCapture_SetTIFCompression($iCompress)
	Switch $iCompress
		Case 1
			$giTIFCompression = $GDIP_EVTCOMPRESSIONNONE
		Case 2
			$giTIFCompression = $GDIP_EVTCOMPRESSIONLZW
		Case Else
			$giTIFCompression = 0
	EndSwitch
EndFunc   ;==>_ScreenCapture_SetTIFCompression
