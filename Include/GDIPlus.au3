#include-once

#include "GDIPlusConstants.au3"
#include "StructureConstants.au3"
#include "WinAPI.au3"
#include "WinAPIGdi.au3"


; #INDEX# =======================================================================================================================
; Title .........: GDIPlus
; AutoIt Version : 3.3.7.20++
; Language ......: English
; Description ...: Functions that assist with Microsoft Windows GDI+ management.
;                  It enables applications to use graphics and formatted text on both the video display and the printer.
;                  Applications based on the Microsoft Win32 API do not access graphics hardware directly.
;                  Instead, GDI+ interacts with device drivers on behalf of applications.
;                  GDI+ can be used in all Windows-based applications.
;                  GDI+ is new technology that is included in Windows XP and the Windows Server 2003.
; Author ........: Paul Campbell (PaulIA), rover, smashly, monoceres, Malkey, Authenticity
; Modified ......: Gary Frost, UEZ, Eukalyptus
; Dll ...........: GDIPlus.dll
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
Global $ghGDIPBrush = 0
Global $ghGDIPDll = 0
Global $ghGDIPPen = 0
Global $giGDIPRef = 0
Global $giGDIPToken = 0
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; _GDIPlus_ArrowCapCreate
; _GDIPlus_ArrowCapDispose
; _GDIPlus_ArrowCapGetFillState
; _GDIPlus_ArrowCapGetHeight
; _GDIPlus_ArrowCapGetMiddleInset
; _GDIPlus_ArrowCapGetWidth
; _GDIPlus_ArrowCapSetFillState
; _GDIPlus_ArrowCapSetHeight
; _GDIPlus_ArrowCapSetMiddleInset
; _GDIPlus_ArrowCapSetWidth
; _GDIPlus_BitmapCloneArea
; _GDIPlus_BitmapCreateFromFile
; _GDIPlus_BitmapCreateFromGraphics
; _GDIPlus_BitmapCreateFromHBITMAP
; _GDIPlus_BitmapCreateFromMemory
; _GDIPlus_BitmapCreateFromResource
; _GDIPlus_BitmapCreateFromScan0
; _GDIPlus_BitmapCreateFromStream
; _GDIPlus_BitmapCreateHBITMAPFromBitmap
; _GDIPlus_BitmapDispose
; _GDIPlus_BitmapGetPixel
; _GDIPlus_BitmapLockBits
; _GDIPlus_BitmapSetPixel
; _GDIPlus_BitmapUnlockBits
; _GDIPlus_BrushClone
; _GDIPlus_BrushCreateSolid
; _GDIPlus_BrushDispose
; _GDIPlus_BrushGetSolidColor
; _GDIPlus_BrushGetType
; _GDIPlus_BrushSetSolidColor
; _GDIPlus_ColorMatrixCreate
; _GDIPlus_ColorMatrixCreateGrayScale
; _GDIPlus_ColorMatrixCreateNegative
; _GDIPlus_ColorMatrixCreateSaturation
; _GDIPlus_ColorMatrixCreateScale
; _GDIPlus_ColorMatrixCreateTranslate
; _GDIPlus_CustomLineCapCreate
; _GDIPlus_CustomLineCapDispose
; _GDIPlus_Decoders
; _GDIPlus_DecodersGetCount
; _GDIPlus_DecodersGetSize
; _GDIPlus_DrawImagePoints
; _GDIPlus_Encoders
; _GDIPlus_EncodersGetCLSID
; _GDIPlus_EncodersGetCount
; _GDIPlus_EncodersGetParamList
; _GDIPlus_EncodersGetParamListSize
; _GDIPlus_EncodersGetSize
; _GDIPlus_FontCreate
; _GDIPlus_FontDispose
; _GDIPlus_FontFamilyCreate
; _GDIPlus_FontFamilyDispose
; _GDIPlus_FontFamilyGetCellAscent
; _GDIPlus_FontFamilyGetCellDescent
; _GDIPlus_FontFamilyGetEmHeight
; _GDIPlus_FontFamilyGetLineSpacing
; _GDIPlus_FontGetHeight
; _GDIPlus_GraphicsClear
; _GDIPlus_GraphicsCreateFromHDC
; _GDIPlus_GraphicsCreateFromHWND
; _GDIPlus_GraphicsDispose
; _GDIPlus_GraphicsDrawArc
; _GDIPlus_GraphicsDrawArcF
; _GDIPlus_GraphicsDrawBezier
; _GDIPlus_GraphicsDrawBezierF
; _GDIPlus_GraphicsDrawClosedCurve
; _GDIPlus_GraphicsDrawClosedCurve2
; _GDIPlus_GraphicsDrawClosedCurveF
; _GDIPlus_GraphicsDrawCurve
; _GDIPlus_GraphicsDrawCurve2
; _GDIPlus_GraphicsDrawCurveF
; _GDIPlus_GraphicsDrawEllipse
; _GDIPlus_GraphicsDrawEllipseF
; _GDIPlus_GraphicsDrawImage
; _GDIPlus_GraphicsDrawImageF
; _GDIPlus_GraphicsDrawImageRect
; _GDIPlus_GraphicsDrawImageRectF
; _GDIPlus_GraphicsDrawImageRectRect
; _GDIPlus_GraphicsDrawImageRectRectF
; _GDIPlus_GraphicsDrawLine
; _GDIPlus_GraphicsDrawLineF
; _GDIPlus_GraphicsDrawPath
; _GDIPlus_GraphicsDrawPie
; _GDIPlus_GraphicsDrawPieF
; _GDIPlus_GraphicsDrawPolygon
; _GDIPlus_GraphicsDrawPolygonF
; _GDIPlus_GraphicsDrawRect
; _GDIPlus_GraphicsDrawRectF
; _GDIPlus_GraphicsDrawString
; _GDIPlus_GraphicsDrawStringEx
; _GDIPlus_GraphicsFillClosedCurve
; _GDIPlus_GraphicsFillClosedCurve2
; _GDIPlus_GraphicsFillClosedCurveF
; _GDIPlus_GraphicsFillEllipse
; _GDIPlus_GraphicsFillEllipseF
; _GDIPlus_GraphicsFillPath
; _GDIPlus_GraphicsFillPie
; _GDIPlus_GraphicsFillPieF
; _GDIPlus_GraphicsFillPolygon
; _GDIPlus_GraphicsFillPolygonF
; _GDIPlus_GraphicsFillRect
; _GDIPlus_GraphicsFillRectF
; _GDIPlus_GraphicsFillRegion
; _GDIPlus_GraphicsGetDC
; _GDIPlus_GraphicsGetInterpolationMode
; _GDIPlus_GraphicsGetSmoothingMode
; _GDIPlus_GraphicsGetTransform
; _GDIPlus_GraphicsMeasureCharacterRanges
; _GDIPlus_GraphicsMeasureString
; _GDIPlus_GraphicsReleaseDC
; _GDIPlus_GraphicsResetClip
; _GDIPlus_GraphicsResetTransform
; _GDIPlus_GraphicsRotateTransform
; _GDIPlus_GraphicsScaleTransform
; _GDIPlus_GraphicsSetClipPath
; _GDIPlus_GraphicsSetClipRect
; _GDIPlus_GraphicsSetClipRegion
; _GDIPlus_GraphicsSetInterpolationMode
; _GDIPlus_GraphicsSetPixelOffsetMode
; _GDIPlus_GraphicsSetSmoothingMode
; _GDIPlus_GraphicsSetTextRenderingHint
; _GDIPlus_GraphicsSetTransform
; _GDIPlus_GraphicsTransformPoints
; _GDIPlus_GraphicsTranslateTransform
; _GDIPlus_ImageAttributesCreate
; _GDIPlus_ImageAttributesDispose
; _GDIPlus_ImageAttributesSetColorKeys
; _GDIPlus_ImageAttributesSetColorMatrix
; _GDIPlus_ImageDispose
; _GDIPlus_ImageGetFlags
; _GDIPlus_ImageGetGraphicsContext
; _GDIPlus_ImageGetHeight
; _GDIPlus_ImageGetHorizontalResolution
; _GDIPlus_ImageGetPixelFormat
; _GDIPlus_ImageGetRawFormat
; _GDIPlus_ImageGetType
; _GDIPlus_ImageGetVerticalResolution
; _GDIPlus_ImageGetWidth
; _GDIPlus_ImageLoadFromFile
; _GDIPlus_ImageLoadFromStream
; _GDIPlus_ImageSaveToFile
; _GDIPlus_ImageSaveToFileEx
; _GDIPlus_ImageSaveToStream
; _GDIPlus_LineBrushCreate
; _GDIPlus_LineBrushGetColors
; _GDIPlus_LineBrushSetBlend
; _GDIPlus_LineBrushSetColors
; _GDIPlus_LineBrushSetGammaCorrection
; _GDIPlus_LineBrushSetPresetBlend
; _GDIPlus_LineBrushSetSigmaBlend
; _GDIPlus_MatrixCreate
; _GDIPlus_MatrixDispose
; _GDIPlus_MatrixGetElements
; _GDIPlus_MatrixInvert
; _GDIPlus_MatrixRotate
; _GDIPlus_MatrixScale
; _GDIPlus_MatrixSetElements
; _GDIPlus_MatrixTransformPoints
; _GDIPlus_MatrixTranslate
; _GDIPlus_ParamAdd
; _GDIPlus_ParamInit
; _GDIPlus_PathAddArc
; _GDIPlus_PathAddClosedCurve
; _GDIPlus_PathAddClosedCurve2
; _GDIPlus_PathAddCurve
; _GDIPlus_PathAddCurve2
; _GDIPlus_PathAddCurve3
; _GDIPlus_PathAddEllipse
; _GDIPlus_PathAddLine
; _GDIPlus_PathAddPath
; _GDIPlus_PathAddPie
; _GDIPlus_PathAddPolygon
; _GDIPlus_PathAddRectangle
; _GDIPlus_PathAddString
; _GDIPlus_PathBrushCreate
; _GDIPlus_PathBrushCreateFromPath
; _GDIPlus_PathBrushGetCenterPoint
; _GDIPlus_PathBrushGetFocusScales
; _GDIPlus_PathBrushGetPointCount
; _GDIPlus_PathBrushGetRect
; _GDIPlus_PathBrushGetWrapMode
; _GDIPlus_PathBrushResetTransform
; _GDIPlus_PathBrushSetBlend
; _GDIPlus_PathBrushSetCenterColor
; _GDIPlus_PathBrushSetCenterPoint
; _GDIPlus_PathBrushSetFocusScales
; _GDIPlus_PathBrushSetGammaCorrection
; _GDIPlus_PathBrushSetLinearBlend
; _GDIPlus_PathBrushSetPresetBlend
; _GDIPlus_PathBrushSetSigmaBlend
; _GDIPlus_PathBrushSetSurroundColor
; _GDIPlus_PathBrushSetSurroundColorsWithCount
; _GDIPlus_PathBrushSetTransform
; _GDIPlus_PathBrushSetWrapMode
; _GDIPlus_PathClone
; _GDIPlus_PathCloseFigure
; _GDIPlus_PathCreate
; _GDIPlus_PathCreate2
; _GDIPlus_PathDispose
; _GDIPlus_PathFlatten
; _GDIPlus_PathGetData
; _GDIPlus_PathGetFillMode
; _GDIPlus_PathGetPointCount
; _GDIPlus_PathGetPoints
; _GDIPlus_PathGetWorldBounds
; _GDIPlus_PathIsOutlineVisiblePoint
; _GDIPlus_PathIsVisiblePoint
; _GDIPlus_PathIterCreate
; _GDIPlus_PathIterDispose
; _GDIPlus_PathIterGetSubpathCount
; _GDIPlus_PathIterNextSubpathPath
; _GDIPlus_PathIterRewind
; _GDIPlus_PathReset
; _GDIPlus_PathReverse
; _GDIPlus_PathSetFillMode
; _GDIPlus_PathTransform
; _GDIPlus_PathWarp
; _GDIPlus_PathWiden
; _GDIPlus_PathWindingModeOutline
; _GDIPlus_PenCreate
; _GDIPlus_PenCreate2
; _GDIPlus_PenDispose
; _GDIPlus_PenGetAlignment
; _GDIPlus_PenGetColor
; _GDIPlus_PenGetCustomEndCap
; _GDIPlus_PenGetDashCap
; _GDIPlus_PenGetDashStyle
; _GDIPlus_PenGetEndCap
; _GDIPlus_PenGetWidth
; _GDIPlus_PenSetAlignment
; _GDIPlus_PenSetColor
; _GDIPlus_PenSetCustomEndCap
; _GDIPlus_PenSetDashCap
; _GDIPlus_PenSetDashStyle
; _GDIPlus_PenSetEndCap
; _GDIPlus_PenSetLineJoin
; _GDIPlus_PenSetWidth
; _GDIPlus_RectFCreate
; _GDIPlus_RegionClone
; _GDIPlus_RegionCombinePath
; _GDIPlus_RegionCombineRect
; _GDIPlus_RegionCombineRegion
; _GDIPlus_RegionCreate
; _GDIPlus_RegionCreateFromPath
; _GDIPlus_RegionCreateFromRect
; _GDIPlus_RegionDispose
; _GDIPlus_RegionGetBounds
; _GDIPlus_RegionGetHRgn
; _GDIPlus_RegionTransform
; _GDIPlus_RegionTranslate
; _GDIPlus_Shutdown
; _GDIPlus_Startup
; _GDIPlus_StringFormatCreate
; _GDIPlus_StringFormatDispose
; _GDIPlus_StringFormatGetMeasurableCharacterRangeCount
; _GDIPlus_StringFormatSetAlign
; _GDIPlus_StringFormatSetMeasurableCharacterRanges
; _GDIPlus_TextureCreate
; _GDIPlus_TextureCreate2
; ===============================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
; __GDIPlus_BitmapCreateDIBFromBitmap
; __GDIPlus_BrushDefCreate
; __GDIPlus_BrushDefDispose
; __GDIPlus_ExtractFileExt
; __GDIPlus_LastDelimiter
; __GDIPlus_PenDefCreate
; __GDIPlus_PenDefDispose
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_ArrowCapCreate($fHeight, $fWidth, $bFilled = True)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateAdjustableArrowCap", "float", $fHeight, "float", $fWidth, "bool", $bFilled, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[4])
EndFunc   ;==>_GDIPlus_ArrowCapCreate

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_ArrowCapDispose($hCap)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeleteCustomLineCap", "handle", $hCap)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_ArrowCapDispose

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_ArrowCapGetFillState($hArrowCap)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetAdjustableArrowCapFillState", "handle", $hArrowCap, "bool*", 0)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_ArrowCapGetFillState

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_ArrowCapGetHeight($hArrowCap)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetAdjustableArrowCapHeight", "handle", $hArrowCap, "float*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_ArrowCapGetHeight

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_ArrowCapGetMiddleInset($hArrowCap)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetAdjustableArrowCapMiddleInset", "handle", $hArrowCap, "float*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_ArrowCapGetMiddleInset

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_ArrowCapGetWidth($hArrowCap)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetAdjustableArrowCapWidth", "handle", $hArrowCap, "float*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_ArrowCapGetWidth

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_ArrowCapSetFillState($hArrowCap, $bFilled = True)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetAdjustableArrowCapFillState", "handle", $hArrowCap, "bool", $bFilled)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_ArrowCapSetFillState

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_ArrowCapSetHeight($hArrowCap, $fHeight)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetAdjustableArrowCapHeight", "handle", $hArrowCap, "float", $fHeight)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_ArrowCapSetHeight

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_ArrowCapSetMiddleInset($hArrowCap, $fInset)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetAdjustableArrowCapMiddleInset", "handle", $hArrowCap, "float", $fInset)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_ArrowCapSetMiddleInset

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_ArrowCapSetWidth($hArrowCap, $fWidth)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetAdjustableArrowCapWidth", "handle", $hArrowCap, "float", $fWidth)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_ArrowCapSetWidth

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_BitmapCloneArea($hBmp, $iLeft, $iTop, $iWidth, $iHeight, $iFormat = 0x00021808)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCloneBitmapAreaI", "int", $iLeft, "int", $iTop, "int", $iWidth, "int", $iHeight, _
			"int", $iFormat, "handle", $hBmp, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[7])
EndFunc   ;==>_GDIPlus_BitmapCloneArea

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_BitmapCreateFromFile($sFileName)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateBitmapFromFile", "wstr", $sFileName, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_BitmapCreateFromFile

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $hGraphics)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateBitmapFromGraphics", "int", $iWidth, "int", $iHeight, "handle", $hGraphics, _
			"ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[4])
EndFunc   ;==>_GDIPlus_BitmapCreateFromGraphics

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_BitmapCreateFromHBITMAP($hBmp, $hPal = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateBitmapFromHBITMAP", "handle", $hBmp, "handle", $hPal, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[3])
EndFunc   ;==>_GDIPlus_BitmapCreateFromHBITMAP

;==================================================================================================================================
; Author ........: UEZ
; Modified.......: progandy
;===================================================================================================================================
Func _GDIPlus_BitmapCreateFromMemory($bImage, $hHBITMAP = False)
	If Not IsBinary($bImage) Then Return SetError(1, 0, 0)
	Local $aResult
	Local Const $memBitmap = Binary($bImage) ;load image saved in variable (memory) and convert it to binary
	Local Const $iLen = BinaryLen($memBitmap) ;get binary length of the image
	Local Const $GMEM_MOVEABLE = 0x0002
	$aResult = DllCall("kernel32.dll", "handle", "GlobalAlloc", "uint", $GMEM_MOVEABLE, "ulong_ptr", $iLen) ;allocates movable memory ($GMEM_MOVEABLE = 0x0002)
	If @error Then Return SetError(4, 0, 0)
	Local Const $hData = $aResult[0]
	$aResult = DllCall("kernel32.dll", "ptr", "GlobalLock", "handle", $hData)
	If @error Then Return SetError(5, 0, 0)
	Local Const $pData = $aResult[0] ;translate the handle into a pointer
	Local $tMem = DllStructCreate("byte[" & $iLen & "]", $pData) ;create struct
	DllStructSetData($tMem, 1, $memBitmap) ;fill struct with image data
	DllCall("kernel32.dll", "bool", "GlobalUnlock", "handle", $hData) ;decrements the lock count associated with a memory object that was allocated with GMEM_MOVEABLE
	If @error Then Return SetError(6, 0, 0)
	Local Const $hStream = _WinAPI_CreateStreamOnHGlobal($pData) ;creates a stream object that uses an HGLOBAL memory handle to store the stream contents
	If @error Then Return SetError(2, 0, 0)
	Local Const $hBitmap = _GDIPlus_BitmapCreateFromStream($hStream) ;creates a Bitmap object based on an IStream COM interface
	If @error Then Return SetError(3, 0, 0)
	Local $tVARIANT = DllStructCreate("word vt;word r1;word r2;word r3;ptr data; ptr")
	DllCall("oleaut32.dll", "long", "DispCallFunc", "ptr", $hStream, "dword", 8 + 8 * @AutoItX64, _
			"dword", 4, "dword", 23, "dword", 0, "ptr", 0, "ptr", 0, "struct*", $tVARIANT) ;release memory from $hStream to avoid memory leak
	$tMem = 0
	$tVARIANT = 0
	If $hHBITMAP Then
		Local Const $hHBmp = __GDIPlus_BitmapCreateDIBFromBitmap($hBitmap) ;supports GDI transparent color format
		_GDIPlus_BitmapDispose($hBitmap)
		Return $hHBmp
	EndIf
	Return $hBitmap
EndFunc   ;==>_GDIPlus_BitmapCreateFromMemory

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_BitmapCreateFromResource($hInst, $vResourceName)
	Local $sType = "int", $aResult
	If IsString($vResourceName) Then $sType = "wstr"
	$aResult = DllCall($ghGDIPDll, "int", "GdipCreateBitmapFromResource", "handle", $hInst, $sType, $vResourceName, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[3])
EndFunc   ;==>_GDIPlus_BitmapCreateFromResource

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight, $iStride = 0, $iPixelFormat = $GDIP_PXF32ARGB, $pScan0 = 0)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipCreateBitmapFromScan0", "int", $iWidth, "int", $iHeight, "int", $iStride, "int", $iPixelFormat, "ptr", $pScan0, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[6]
EndFunc   ;==>_GDIPlus_BitmapCreateFromScan0

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_BitmapCreateFromStream($pStream)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateBitmapFromStream", "ptr", $pStream, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_BitmapCreateFromStream

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap, $iARGB = 0xFF000000)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateHBITMAPFromBitmap", "handle", $hBitmap, "ptr*", 0, "dword", $iARGB)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_BitmapCreateHBITMAPFromBitmap

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_BitmapDispose($hBitmap)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDisposeImage", "handle", $hBitmap)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_BitmapDispose

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_BitmapGetPixel($hBitmap, $iX, $iY)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipBitmapGetPixel", "handle", $hBitmap, "int", $iX, "int", $iY, "uint*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[4])
EndFunc   ;==>_GDIPlus_BitmapGetPixel

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_BitmapLockBits($hBitmap, $iLeft, $iTop, $iWidth, $iHeight, $iFlags = $GDIP_ILMREAD, $iFormat = $GDIP_PXF32RGB)
	Local $tData = DllStructCreate($tagGDIPBITMAPDATA)
	Local $tRect = DllStructCreate($tagRECT)

	; The RECT is initialized strange for this function. It wants the Left and
	; Top members set as usual but instead of Right and Bottom also being
	; coordinates they are expected to be the Width and Height sizes
	; respectively.
	DllStructSetData($tRect, "Left", $iLeft)
	DllStructSetData($tRect, "Top", $iTop)
	DllStructSetData($tRect, "Right", $iWidth)
	DllStructSetData($tRect, "Bottom", $iHeight)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipBitmapLockBits", "handle", $hBitmap, "struct*", $tRect, "uint", $iFlags, "int", $iFormat, "struct*", $tData)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $tData)
EndFunc   ;==>_GDIPlus_BitmapLockBits

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_BitmapSetPixel($hBitmap, $iX, $iY, $iARGB)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipBitmapSetPixel", "handle", $hBitmap, "int", $iX, "int", $iY, "uint", $iARGB)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_BitmapSetPixel

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_BitmapUnlockBits($hBitmap, $tBitmapData)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipBitmapUnlockBits", "handle", $hBitmap, "struct*", $tBitmapData)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_BitmapUnlockBits

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_BrushClone($hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCloneBrush", "handle", $hBrush, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_BrushClone

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_BrushCreateSolid($iARGB = 0xFF000000)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateSolidFill", "int", $iARGB, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_BrushCreateSolid

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_BrushDispose($hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeleteBrush", "handle", $hBrush)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_BrushDispose

; #FUNCTION# ====================================================================================================================
; Author ........:
; Modified.......: smashly
; ===============================================================================================================================
Func _GDIPlus_BrushGetSolidColor($hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetSolidFillColor", "handle", $hBrush, "dword*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_BrushGetSolidColor

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_BrushGetType($hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetBrushType", "handle", $hBrush, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_BrushGetType

; #FUNCTION# ====================================================================================================================
; Author ........:
; Modified.......: smashly
; ===============================================================================================================================
Func _GDIPlus_BrushSetSolidColor($hBrush, $iARGB = 0xFF000000)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetSolidFillColor", "handle", $hBrush, "dword", $iARGB)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_BrushSetSolidColor

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_ColorMatrixCreate()
	Return _GDIPlus_ColorMatrixCreateScale(1, 1, 1, 1)
EndFunc   ;==>_GDIPlus_ColorMatrixCreate

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_ColorMatrixCreateGrayScale()
	Local $iI, $iJ, $tCM, $aLums[4] = [$GDIP_RLUM, $GDIP_GLUM, $GDIP_BLUM, 0]
	$tCM = DllStructCreate($tagGDIPCOLORMATRIX)
	For $iI = 0 To 3
		For $iJ = 1 To 3
			DllStructSetData($tCM, "m", $aLums[$iI], $iI * 5 + $iJ)
		Next
	Next
	DllStructSetData($tCM, "m", 1, 19)
	DllStructSetData($tCM, "m", 1, 25)
	Return $tCM
EndFunc   ;==>_GDIPlus_ColorMatrixCreateGrayScale

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_ColorMatrixCreateNegative()
	Local $iI, $tCM
	$tCM = _GDIPlus_ColorMatrixCreateScale(-1, -1, -1, 1)
	For $iI = 1 To 4
		DllStructSetData($tCM, "m", 1, 20 + $iI)
	Next
	Return $tCM
EndFunc   ;==>_GDIPlus_ColorMatrixCreateNegative

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_ColorMatrixCreateSaturation($fSat)
	Local $fSatComp, $tCM
	$tCM = DllStructCreate($tagGDIPCOLORMATRIX)
	$fSatComp = (1 - $fSat)
	DllStructSetData($tCM, "m", $fSatComp * $GDIP_RLUM + $fSat, 1)
	DllStructSetData($tCM, "m", $fSatComp * $GDIP_RLUM, 2)
	DllStructSetData($tCM, "m", $fSatComp * $GDIP_RLUM, 3)
	DllStructSetData($tCM, "m", $fSatComp * $GDIP_GLUM, 6)
	DllStructSetData($tCM, "m", $fSatComp * $GDIP_GLUM + $fSat, 7)
	DllStructSetData($tCM, "m", $fSatComp * $GDIP_GLUM, 8)
	DllStructSetData($tCM, "m", $fSatComp * $GDIP_BLUM, 11)
	DllStructSetData($tCM, "m", $fSatComp * $GDIP_BLUM, 12)
	DllStructSetData($tCM, "m", $fSatComp * $GDIP_BLUM + $fSat, 13)
	DllStructSetData($tCM, "m", 1, 19)
	DllStructSetData($tCM, "m", 1, 25)
	Return $tCM
EndFunc   ;==>_GDIPlus_ColorMatrixCreateSaturation

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_ColorMatrixCreateScale($fRed, $fGreen, $fBlue, $fAlpha = 1)
	Local $tCM
	$tCM = DllStructCreate($tagGDIPCOLORMATRIX)
	DllStructSetData($tCM, "m", $fRed, 1)
	DllStructSetData($tCM, "m", $fGreen, 7)
	DllStructSetData($tCM, "m", $fBlue, 13)
	DllStructSetData($tCM, "m", $fAlpha, 19)
	DllStructSetData($tCM, "m", 1, 25)
	Return $tCM
EndFunc   ;==>_GDIPlus_ColorMatrixCreateScale

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_ColorMatrixCreateTranslate($fRed, $fGreen, $fBlue, $fAlpha = 0)
	Local $iI, $tCM, $aFactors[4] = [$fRed, $fGreen, $fBlue, $fAlpha]
	$tCM = _GDIPlus_ColorMatrixCreate()
	For $iI = 0 To 3
		DllStructSetData($tCM, "m", $aFactors[$iI], 21 + $iI)
	Next
	Return $tCM
EndFunc   ;==>_GDIPlus_ColorMatrixCreateTranslate

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_CustomLineCapCreate($hPathFill, $hPathStroke, $iLineCap = 0, $inBaseInset = 0)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipCreateCustomLineCap", "handle", $hPathFill, "handle", $hPathStroke, "int", $iLineCap, "float", $inBaseInset, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[5]
EndFunc   ;==>_GDIPlus_CustomLineCapCreate

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_CustomLineCapDispose($hCap)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeleteCustomLineCap", "handle", $hCap)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_CustomLineCapDispose

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_Decoders()
	Local $iCount = _GDIPlus_DecodersGetCount()
	Local $iSize = _GDIPlus_DecodersGetSize()
	Local $tBuffer = DllStructCreate("byte[" & $iSize & "]")
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageDecoders", "uint", $iCount, "uint", $iSize, "struct*", $tBuffer)
	If @error Then Return SetError(@error, @extended, 0)
	If $aResult[0] <> 0 Then Return SetError($aResult[0], 0, 0)

	Local $pBuffer = DllStructGetPtr($tBuffer)
	Local $tCodec, $aInfo[$iCount + 1][14]
	$aInfo[0][0] = $iCount
	For $iI = 1 To $iCount
		$tCodec = DllStructCreate($tagGDIPIMAGECODECINFO, $pBuffer)
		$aInfo[$iI][1] = _WinAPI_StringFromGUID(DllStructGetPtr($tCodec, "CLSID"))
		$aInfo[$iI][2] = _WinAPI_StringFromGUID(DllStructGetPtr($tCodec, "FormatID"))
		$aInfo[$iI][3] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "CodecName"))
		$aInfo[$iI][4] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "DllName"))
		$aInfo[$iI][5] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "FormatDesc"))
		$aInfo[$iI][6] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "FileExt"))
		$aInfo[$iI][7] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "MimeType"))
		$aInfo[$iI][8] = DllStructGetData($tCodec, "Flags")
		$aInfo[$iI][9] = DllStructGetData($tCodec, "Version")
		$aInfo[$iI][10] = DllStructGetData($tCodec, "SigCount")
		$aInfo[$iI][11] = DllStructGetData($tCodec, "SigSize")
		$aInfo[$iI][12] = DllStructGetData($tCodec, "SigPattern")
		$aInfo[$iI][13] = DllStructGetData($tCodec, "SigMask")
		$pBuffer += DllStructGetSize($tCodec)
	Next
	Return $aInfo
EndFunc   ;==>_GDIPlus_Decoders

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_DecodersGetCount()
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageDecodersSize", "uint*", 0, "uint*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[1])
EndFunc   ;==>_GDIPlus_DecodersGetCount

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_DecodersGetSize()
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageDecodersSize", "uint*", 0, "uint*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_DecodersGetSize

; #FUNCTION# ====================================================================================================================
; Author ........: Malkey
; Modified.......:
; ===============================================================================================================================
Func _GDIPlus_DrawImagePoints($hGraphic, $hImage, $nULX, $nULY, $nURX, $nURY, $nLLX, $nLLY, $count = 3)
	Local $tPoint = DllStructCreate("float X;float Y;float X2;float Y2;float X3;float Y3")
	DllStructSetData($tPoint, "X", $nULX)
	DllStructSetData($tPoint, "Y", $nULY)
	DllStructSetData($tPoint, "X2", $nURX)
	DllStructSetData($tPoint, "Y2", $nURY)
	DllStructSetData($tPoint, "X3", $nLLX)
	DllStructSetData($tPoint, "Y3", $nLLY)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawImagePoints", "handle", $hGraphic, "handle", $hImage, "struct*", $tPoint, "int", $count)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_DrawImagePoints

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_Encoders()
	Local $iCount = _GDIPlus_EncodersGetCount()
	Local $iSize = _GDIPlus_EncodersGetSize()
	Local $tBuffer = DllStructCreate("byte[" & $iSize & "]")
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageEncoders", "uint", $iCount, "uint", $iSize, "struct*", $tBuffer)
	If @error Then Return SetError(@error, @extended, 0)
	If $aResult[0] <> 0 Then Return SetError($aResult[0], 0, 0)

	Local $pBuffer = DllStructGetPtr($tBuffer)
	Local $tCodec, $aInfo[$iCount + 1][14]
	$aInfo[0][0] = $iCount
	For $iI = 1 To $iCount
		$tCodec = DllStructCreate($tagGDIPIMAGECODECINFO, $pBuffer)
		$aInfo[$iI][1] = _WinAPI_StringFromGUID(DllStructGetPtr($tCodec, "CLSID"))
		$aInfo[$iI][2] = _WinAPI_StringFromGUID(DllStructGetPtr($tCodec, "FormatID"))
		$aInfo[$iI][3] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "CodecName"))
		$aInfo[$iI][4] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "DllName"))
		$aInfo[$iI][5] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "FormatDesc"))
		$aInfo[$iI][6] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "FileExt"))
		$aInfo[$iI][7] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "MimeType"))
		$aInfo[$iI][8] = DllStructGetData($tCodec, "Flags")
		$aInfo[$iI][9] = DllStructGetData($tCodec, "Version")
		$aInfo[$iI][10] = DllStructGetData($tCodec, "SigCount")
		$aInfo[$iI][11] = DllStructGetData($tCodec, "SigSize")
		$aInfo[$iI][12] = DllStructGetData($tCodec, "SigPattern")
		$aInfo[$iI][13] = DllStructGetData($tCodec, "SigMask")
		$pBuffer += DllStructGetSize($tCodec)
	Next
	Return $aInfo
EndFunc   ;==>_GDIPlus_Encoders

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; ===============================================================================================================================
Func _GDIPlus_EncodersGetCLSID($sFileExt)
	Local $aEncoders = _GDIPlus_Encoders()
	For $iI = 1 To $aEncoders[0][0]
		If StringInStr($aEncoders[$iI][6], "*." & $sFileExt) > 0 Then Return $aEncoders[$iI][1]
	Next
	Return SetError(-1, -1, "")
EndFunc   ;==>_GDIPlus_EncodersGetCLSID

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_EncodersGetCount()
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageEncodersSize", "uint*", 0, "uint*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[1])
EndFunc   ;==>_GDIPlus_EncodersGetCount

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_EncodersGetParamList($hImage, $sEncoder)
	Local $iSize = _GDIPlus_EncodersGetParamListSize($hImage, $sEncoder)
	If @error Then Return SetError(@error, -1, 0)
	Local $tGUID = _WinAPI_GUIDFromString($sEncoder)
	Local $tBuffer = DllStructCreate("dword Count;byte Params[" & $iSize - 4 & "]")
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetEncoderParameterList", "handle", $hImage, "struct*", $tGUID, "uint", $iSize, "struct*", $tBuffer)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $tBuffer)
EndFunc   ;==>_GDIPlus_EncodersGetParamList

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_EncodersGetParamListSize($hImage, $sEncoder)
	Local $tGUID = _WinAPI_GUIDFromString($sEncoder)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetEncoderParameterListSize", "handle", $hImage, "struct*", $tGUID, "uint*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[3])
EndFunc   ;==>_GDIPlus_EncodersGetParamListSize

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_EncodersGetSize()
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageEncodersSize", "uint*", 0, "uint*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_EncodersGetSize

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_FontCreate($hFamily, $fSize, $iStyle = 0, $iUnit = 3)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateFont", "handle", $hFamily, "float", $fSize, "int", $iStyle, "int", $iUnit, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[5])
EndFunc   ;==>_GDIPlus_FontCreate

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_FontDispose($hFont)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeleteFont", "handle", $hFont)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_FontDispose

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_FontFamilyCreate($sFamily)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateFontFamilyFromName", "wstr", $sFamily, "ptr", 0, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[3])
EndFunc   ;==>_GDIPlus_FontFamilyCreate

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_FontFamilyDispose($hFamily)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeleteFontFamily", "handle", $hFamily)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_FontFamilyDispose

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_FontFamilyGetCellAscent($hFontFamily, $iStyle = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetCellAscent", "handle", $hFontFamily, "int", $iStyle, "short*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[3])
EndFunc   ;==>_GDIPlus_FontFamilyGetCellAscent

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_FontFamilyGetCellDescent($hFontFamily, $iStyle = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetCellDescent", "handle", $hFontFamily, "int", $iStyle, "short*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[3])
EndFunc   ;==>_GDIPlus_FontFamilyGetCellDescent

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_FontFamilyGetEmHeight($hFontFamily, $iStyle = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetEmHeight", "handle", $hFontFamily, "int", $iStyle, "short*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[3])
EndFunc   ;==>_GDIPlus_FontFamilyGetEmHeight

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_FontFamilyGetLineSpacing($hFontFamily, $iStyle = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetLineSpacing", "handle", $hFontFamily, "int", $iStyle, "short*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[3])
EndFunc   ;==>_GDIPlus_FontFamilyGetLineSpacing

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_FontGetHeight($hFont, $hGraphics)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetFontHeight", "handle", $hFont, "handle", $hGraphics, "float*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[3])
EndFunc   ;==>_GDIPlus_FontGetHeight

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsClear($hGraphics, $iARGB = 0xFF000000)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGraphicsClear", "handle", $hGraphics, "dword", $iARGB)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsClear

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsCreateFromHDC($hDC)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateFromHDC", "handle", $hDC, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_GraphicsCreateFromHDC

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsCreateFromHWND($hWnd)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateFromHWND", "hwnd", $hWnd, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_GraphicsCreateFromHWND

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsDispose($hGraphics)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeleteGraphics", "handle", $hGraphics)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDispose

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawArc($hGraphics, $iX, $iY, $iWidth, $iHeight, $fStartAngle, $fSweepAngle, $hPen = 0)
	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawArcI", "handle", $hGraphics, "handle", $hPen, "int", $iX, "int", $iY, _
			"int", $iWidth, "int", $iHeight, "float", $fStartAngle, "float", $fSweepAngle)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawArc

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost, UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawArcF($hGraphics, $fX, $fY, $fWidth, $fHeight, $fStartAngle, $fSweepAngle, $hPen = 0)
	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawArc", "handle", $hGraphics, "handle", $hPen, "float", $fX, "float", $fY, _
			"float", $fWidth, "float", $fHeight, "float", $fStartAngle, "float", $fSweepAngle)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawArcF

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawBezier($hGraphics, $iX1, $iY1, $iX2, $iY2, $iX3, $iY3, $iX4, $iY4, $hPen = 0)
	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawBezierI", "handle", $hGraphics, "handle", $hPen, "int", $iX1, "int", $iY1, _
			"int", $iX2, "int", $iY2, "int", $iX3, "int", $iY3, "int", $iX4, "int", $iY4)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawBezier

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost, UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawBezierF($hGraphics, $fX1, $fY1, $fX2, $fY2, $fX3, $fY3, $fX4, $fY4, $hPen = 0)
	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawBezier", "handle", $hGraphics, "handle", $hPen, "float", $fX1, "float", $fY1, _
			"float", $fX2, "float", $fY2, "float", $fX3, "float", $fY3, "float", $fX4, "float", $fY4)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawBezierF

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawClosedCurve($hGraphics, $aPoints, $hPen = 0)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("long[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next

	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawClosedCurveI", "handle", $hGraphics, "handle", $hPen, "struct*", $tPoints, "int", $iCount)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawClosedCurve

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawClosedCurve2($hGraphics, $aPoints, $fTension, $hPen = 0)
	Local $iI, $iCount, $iTmpErr, $iTmpExt, $tPoints, $aResult
	__GDIPlus_PenDefCreate($hPen)
	$iCount = $aPoints[0][0]
	$tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	$aResult = DllCall($ghGDIPDll, "int", "GdipDrawClosedCurve2", "handle", $hGraphics, "handle", $hPen, "struct*", $tPoints, "int", $iCount, "float", $fTension)
	$iTmpErr = @error
	$iTmpExt = @extended
	__GDIPlus_PenDefDispose()
	If $iTmpErr Then Return SetError($iTmpErr, $iTmpExt, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawClosedCurve2

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost, UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawClosedCurveF($hGraphics, $aPoints, $hPen = 0)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawClosedCurve", "handle", $hGraphics, "handle", $hPen, "struct*", $tPoints, "int", $iCount)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawClosedCurveF

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawCurve($hGraphics, $aPoints, $hPen = 0)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("long[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next

	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawCurveI", "handle", $hGraphics, "handle", $hPen, "struct*", $tPoints, "int", $iCount)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawCurve

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawCurve2($hGraphics, $aPoints, $nTension, $hPen = 0)
	Local $iI, $iCount, $iTmpErr, $iTmpExt, $tPoints, $aResult
	__GDIPlus_PenDefCreate($hPen)
	$iCount = $aPoints[0][0]
	$tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	$aResult = DllCall($ghGDIPDll, "int", "GdipDrawCurve2", "handle", $hGraphics, "handle", $hPen, "struct*", $tPoints, "int", $iCount, "float", $nTension)
	$iTmpErr = @error
	$iTmpExt = @extended
	__GDIPlus_PenDefDispose()
	If $iTmpErr Then Return SetError($iTmpErr, $iTmpExt, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawCurve2

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawCurveF($hGraphics, $aPoints, $hPen = 0)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawCurve", "handle", $hGraphics, "handle", $hPen, "struct*", $tPoints, "int", $iCount)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawCurveF

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawEllipse($hGraphics, $iX, $iY, $iWidth, $iHeight, $hPen = 0)
	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawEllipseI", "handle", $hGraphics, "handle", $hPen, "int", $iX, "int", $iY, _
			"int", $iWidth, "int", $iHeight)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawEllipse

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawEllipseF($hGraphics, $fX, $fY, $fWidth, $fHeight, $hPen = 0)
	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawEllipse", "handle", $hGraphics, "handle", $hPen, "float", $fX, "float", $fY, _
			"float", $fWidth, "float", $fHeight)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawEllipseF

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawImage($hGraphics, $hImage, $iX, $iY)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawImageI", "handle", $hGraphics, "handle", $hImage, "int", $iX, "int", $iY)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawImage

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost, UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawImageF($hGraphics, $hImage, $fX, $fY)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawImage", "handle", $hGraphics, "handle", $hImage, "float", $fX, "float", $fY)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawImageF

; #FUNCTION# ====================================================================================================================
; Author ........: smashly
; Modified.......:
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawImageRect($hGraphics, $hImage, $iX, $iY, $iW, $iH)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawImageRectI", "handle", $hGraphics, "handle", $hImage, "int", $iX, "int", $iY, _
			"int", $iW, "int", $iH)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawImageRect

; #FUNCTION# ====================================================================================================================
; Author ........: smashly
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawImageRectF($hGraphics, $hImage, $fX, $fY, $fW, $fH)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawImageRect", "handle", $hGraphics, "handle", $hImage, "float", $fX, "float", $fY, _
			"float", $fW, "float", $fH)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawImageRectF

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hImage, $iSrcX, $iSrcY, $iSrcWidth, $iSrcHeight, $iDstX, $iDstY, $iDstWidth, $iDstHeight, $hAttributes = 0, $iUnit = 2)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawImageRectRectI", "handle", $hGraphics, "handle", $hImage, "int", $iDstX, _
			"int", $iDstY, "int", $iDstWidth, "int", $iDstHeight, "int", $iSrcX, "int", $iSrcY, "int", $iSrcWidth, _
			"int", $iSrcHeight, "int", $iUnit, "int", $hAttributes, "int", 0, "int", 0)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawImageRectRect


; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost, UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawImageRectRectF($hGraphics, $hImage, $fSrcX, $fSrcY, $fSrcWidth, $fSrcHeight, $fDstX, $fDstY, $fDstWidth, $fDstHeight, $hAttributes = 0, $iUnit = 2)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawImageRectRect", "handle", $hGraphics, "handle", $hImage, _
			"float", $fDstX, "float", $fDstY, "float", $fDstWidth, "float", $fDstHeight, _
			"float", $fSrcX, "float", $fSrcY, "float", $fSrcWidth, "float", $fSrcHeight, _
			"int", $iUnit, "int", $hAttributes, "int", 0, "int", 0)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawImageRectRectF

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawLine($hGraphics, $iX1, $iY1, $iX2, $iY2, $hPen = 0)
	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawLineI", "handle", $hGraphics, "handle", $hPen, "int", $iX1, "int", $iY1, _
			"int", $iX2, "int", $iY2)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawLine

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost, UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawLineF($hGraphics, $fX1, $fY1, $fX2, $fY2, $hPen = 0)
	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawLine", "handle", $hGraphics, "handle", $hPen, "float", $fX1, "float", $fY1, _
			"float", $fX2, "float", $fY2)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawLineF

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawPath($hGraphics, $hPath, $hPen = 0)
	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawPath", "handle", $hGraphics, "handle", $hPen, "handle", $hPath)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawPath

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawPie($hGraphics, $iX, $iY, $iWidth, $iHeight, $fStartAngle, $fSweepAngle, $hPen = 0)
	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawPieI", "handle", $hGraphics, "handle", $hPen, "int", $iX, "int", $iY, _
			"int", $iWidth, "int", $iHeight, "float", $fStartAngle, "float", $fSweepAngle)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawPie

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost, UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawPieF($hGraphics, $fX, $fY, $fWidth, $fHeight, $fStartAngle, $fSweepAngle, $hPen = 0)
	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawPie", "handle", $hGraphics, "handle", $hPen, "float", $fX, "float", $fY, _
			"float", $fWidth, "float", $fHeight, "float", $fStartAngle, "float", $fSweepAngle)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawPieF

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawPolygon($hGraphics, $aPoints, $hPen = 0)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("long[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next

	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawPolygonI", "handle", $hGraphics, "handle", $hPen, "struct*", $tPoints, "int", $iCount)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawPolygon

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost, UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawPolygonF($hGraphics, $aPoints, $hPen = 0)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next

	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawPolygon", "handle", $hGraphics, "handle", $hPen, "struct*", $tPoints, "int", $iCount)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawPolygonF

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawRect($hGraphics, $iX, $iY, $iWidth, $iHeight, $hPen = 0)
	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawRectangleI", "handle", $hGraphics, "handle", $hPen, "int", $iX, "int", $iY, _
			"int", $iWidth, "int", $iHeight)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawRect

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost, UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawRectF($hGraphics, $fX, $fY, $fWidth, $fHeight, $hPen = 0)
	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawRectangle", "handle", $hGraphics, "handle", $hPen, "float", $fX, "float", $fY, _
			"float", $fWidth, "float", $fHeight)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawRectF

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawString($hGraphics, $sString, $nX, $nY, $sFont = "Arial", $nSize = 10, $iFormat = 0)
	Local $hBrush = _GDIPlus_BrushCreateSolid()
	Local $hFormat = _GDIPlus_StringFormatCreate($iFormat)
	Local $hFamily = _GDIPlus_FontFamilyCreate($sFont)
	Local $hFont = _GDIPlus_FontCreate($hFamily, $nSize)
	Local $tLayout = _GDIPlus_RectFCreate($nX, $nY, 0, 0)
	Local $aInfo = _GDIPlus_GraphicsMeasureString($hGraphics, $sString, $hFont, $tLayout, $hFormat)
	Local $aResult = _GDIPlus_GraphicsDrawStringEx($hGraphics, $sString, $hFont, $aInfo[0], $hFormat, $hBrush)
	Local $iError = @error
	_GDIPlus_FontDispose($hFont)
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_BrushDispose($hBrush)
	Return SetError($iError, 0, $aResult)
EndFunc   ;==>_GDIPlus_GraphicsDrawString

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawStringEx($hGraphics, $sString, $hFont, $tLayout, $hFormat, $hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawString", "handle", $hGraphics, "wstr", $sString, "int", -1, "handle", $hFont, _
			"struct*", $tLayout, "handle", $hFormat, "handle", $hBrush)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawStringEx

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsFillClosedCurve($hGraphics, $aPoints, $hBrush = 0)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("long[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next

	__GDIPlus_BrushDefCreate($hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipFillClosedCurveI", "handle", $hGraphics, "handle", $hBrush, "struct*", $tPoints, "int", $iCount)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_BrushDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsFillClosedCurve

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsFillClosedCurve2($hGraphics, $aPoints, $nTension, $hBrush = 0, $iFillMode = 0)
	Local $iI, $iCount, $iTmpErr, $iTmpExt, $tPoints, $aResult
	__GDIPlus_BrushDefCreate($hBrush)
	$iCount = $aPoints[0][0]
	$tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	$aResult = DllCall($ghGDIPDll, "int", "GdipFillClosedCurve2", "handle", $hGraphics, "handle", $hBrush, "struct*", $tPoints, "int", $iCount, "float", $nTension, "int", $iFillMode)
	$iTmpErr = @error
	$iTmpExt = @extended
	__GDIPlus_BrushDefDispose()
	If $iTmpErr Then Return SetError($iTmpErr, $iTmpExt, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsFillClosedCurve2

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost, UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsFillClosedCurveF($hGraphics, $aPoints, $hBrush = 0)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next

	__GDIPlus_BrushDefCreate($hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipFillClosedCurve", "handle", $hGraphics, "handle", $hBrush, "struct*", $tPoints, "int", $iCount)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_BrushDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsFillClosedCurveF

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsFillEllipse($hGraphics, $iX, $iY, $iWidth, $iHeight, $hBrush = 0)
	__GDIPlus_BrushDefCreate($hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipFillEllipseI", "handle", $hGraphics, "handle", $hBrush, "int", $iX, "int", $iY, _
			"int", $iWidth, "int", $iHeight)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_BrushDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsFillEllipse

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost, UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsFillEllipseF($hGraphics, $fX, $fY, $fWidth, $fHeight, $hBrush = 0)
	__GDIPlus_BrushDefCreate($hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipFillEllipse", "handle", $hGraphics, "handle", $hBrush, "float", $fX, "float", $fY, _
			"float", $fWidth, "float", $fHeight)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_BrushDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsFillEllipseF

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_GraphicsFillPath($hGraphics, $hPath, $hBrush = 0)
	__GDIPlus_BrushDefCreate($hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipFillPath", "handle", $hGraphics, "handle", $hBrush, "handle", $hPath)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_BrushDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsFillPath

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsFillPie($hGraphics, $iX, $iY, $iWidth, $iHeight, $fStartAngle, $fSweepAngle, $hBrush = 0)
	__GDIPlus_BrushDefCreate($hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipFillPieI", "handle", $hGraphics, "handle", $hBrush, "int", $iX, "int", $iY, _
			"int", $iWidth, "int", $iHeight, "float", $fStartAngle, "float", $fSweepAngle)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_BrushDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsFillPie

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsFillPieF($hGraphics, $fX, $fY, $fWidth, $fHeight, $fStartAngle, $fSweepAngle, $hBrush = 0)
	__GDIPlus_BrushDefCreate($hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipFillPie", "handle", $hGraphics, "handle", $hBrush, "float", $fX, "float", $fY, _
			"float", $fWidth, "float", $fHeight, "float", $fStartAngle, "float", $fSweepAngle)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_BrushDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsFillPieF

; #FUNCTION# ====================================================================================================================
; Author ........:
; Modified.......: smashly
; ===============================================================================================================================
Func _GDIPlus_GraphicsFillPolygon($hGraphics, $aPoints, $hBrush = 0)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("long[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next

	__GDIPlus_BrushDefCreate($hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipFillPolygonI", "handle", $hGraphics, "handle", $hBrush, _
			"struct*", $tPoints, "int", $iCount, "int", "FillModeAlternate")
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_BrushDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsFillPolygon

; #FUNCTION# ====================================================================================================================
; Author ........: smashly
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsFillPolygonF($hGraphics, $aPoints, $hBrush = 0)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	__GDIPlus_BrushDefCreate($hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipFillPolygon", "handle", $hGraphics, "handle", $hBrush, _
			"struct*", $tPoints, "int", $iCount, "int", "FillModeAlternate")
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_BrushDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsFillPolygonF

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsFillRect($hGraphics, $iX, $iY, $iWidth, $iHeight, $hBrush = 0)
	__GDIPlus_BrushDefCreate($hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipFillRectangleI", "handle", $hGraphics, "handle", $hBrush, "int", $iX, "int", $iY, _
			"int", $iWidth, "int", $iHeight)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_BrushDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsFillRect

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost, UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsFillRectF($hGraphics, $fX, $fY, $fWidth, $fHeight, $hBrush = 0)
	__GDIPlus_BrushDefCreate($hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipFillRectangle", "handle", $hGraphics, "handle", $hBrush, "float", $fX, "float", $fY, _
			"float", $fWidth, "float", $fHeight)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_BrushDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsFillRectF

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_GraphicsFillRegion($hGraphics, $hRegion, $hBrush = 0)
	__GDIPlus_BrushDefCreate($hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipFillRegion", "handle", $hGraphics, "handle", $hBrush, "handle", $hRegion)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_BrushDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsFillRegion

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsGetDC($hGraphics)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetDC", "handle", $hGraphics, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, False)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_GraphicsGetDC

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsGetInterpolationMode($hGraphics)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetInterpolationMode", "handle", $hGraphics, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	If $aResult[0] Then Return SetError($aResult[0], $aResult[0], -1)
	Return $aResult[2]
EndFunc   ;==>_GDIPlus_GraphicsGetInterpolationMode

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost, UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsGetSmoothingMode($hGraphics)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetSmoothingMode", "handle", $hGraphics, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Switch $aResult[2]
		Case $GDIP_SMOOTHINGMODE_NONE
			Return SetExtended($aResult[0], 0)
		Case $GDIP_SMOOTHINGMODE_HIGHQUALITY, $GDIP_SMOOTHINGMODE_ANTIALIAS8X4
			Return SetExtended($aResult[0], 1)
		Case $GDIP_SMOOTHINGMODE_ANTIALIAS8X8
			Return SetExtended($aResult[0], 2)
		Case Else
			Return SetExtended($aResult[0], 0)
	EndSwitch
EndFunc   ;==>_GDIPlus_GraphicsGetSmoothingMode

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_GraphicsGetTransform($hGraphics, $hMatrix)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetWorldTransform", "handle", $hGraphics, "handle", $hMatrix)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsGetTransform

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_GraphicsMeasureCharacterRanges($hGraphics, $sString, $hFont, $tLayout, $hStringFormat)
	Local $iCount = _GDIPlus_StringFormatGetMeasurableCharacterRangeCount($hStringFormat)
	If @error Then Return SetError(@error, @extended, 0)

	Local $tRegions = DllStructCreate("handle[" & $iCount & "]")
	Local $aRegions[$iCount + 1] = [$iCount]
	For $iI = 1 To $iCount
		$aRegions[$iI] = _GDIPlus_RegionCreate()
		DllStructSetData($tRegions, 1, $aRegions[$iI], $iI)
	Next

	DllCall($ghGDIPDll, "int", "GdipMeasureCharacterRanges", "handle", $hGraphics, "wstr", $sString, "int", -1, "hwnd", $hFont, "struct*", $tLayout, "handle", $hStringFormat, "int", $iCount, "struct*", $tRegions)
	Local $tmpError = @error, $tmpExtended = @extended
	If $tmpError Then
		For $iI = 1 To $iCount
			_GDIPlus_RegionDispose($aRegions[$iI])
		Next
		Return SetError($tmpError, $tmpExtended, False)
	EndIf

	Return $aRegions
EndFunc   ;==>_GDIPlus_GraphicsMeasureCharacterRanges

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsMeasureString($hGraphics, $sString, $hFont, $tLayout, $hFormat)
	Local $tRectF = DllStructCreate($tagGDIPRECTF)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipMeasureString", "handle", $hGraphics, "wstr", $sString, "int", -1, "handle", $hFont, _
			"struct*", $tLayout, "handle", $hFormat, "struct*", $tRectF, "int*", 0, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)

	Local $aInfo[3]
	$aInfo[0] = $tRectF
	$aInfo[1] = $aResult[8]
	$aInfo[2] = $aResult[9]
	Return SetExtended($aResult[0], $aInfo)
EndFunc   ;==>_GDIPlus_GraphicsMeasureString

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsReleaseDC($hGraphics, $hDC)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipReleaseDC", "handle", $hGraphics, "handle", $hDC)
	If @error Then Return SetError(@error, @extended, False)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_GraphicsReleaseDC

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_GraphicsResetClip($hGraphics)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipResetClip", "handle", $hGraphics)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsResetClip

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_GraphicsResetTransform($hGraphics)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipResetWorldTransform", "handle", $hGraphics)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsResetTransform

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_GraphicsRotateTransform($hGraphics, $fAngle, $iOrder = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipRotateWorldTransform", "handle", $hGraphics, "float", $fAngle, "int", $iOrder)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsRotateTransform

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_GraphicsScaleTransform($hGraphics, $fScaleX, $fScaleY, $iOrder = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipScaleWorldTransform", "handle", $hGraphics, "float", $fScaleX, "float", $fScaleY, "int", $iOrder)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsScaleTransform

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_GraphicsSetClipPath($hGraphics, $hPath, $iCombineMode = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetClipPath", "handle", $hGraphics, "handle", $hPath, "int", $iCombineMode)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsSetClipPath

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_GraphicsSetClipRect($hGraphics, $fX, $fY, $fWidth, $fHeight, $iCombineMode = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetClipRect", "handle", $hGraphics, "float", $fX, "float", $fY, "float", $fWidth, "float", $fHeight, "int", $iCombineMode)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsSetClipRect

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_GraphicsSetClipRegion($hGraphics, $hRegion, $iCombineMode = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetClipRegion", "handle", $hGraphics, "handle", $hRegion, "int", $iCombineMode)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsSetClipRegion

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsSetInterpolationMode($hGraphics, $iInterpolationMode)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetInterpolationMode", "handle", $hGraphics, "int", $iInterpolationMode)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsSetInterpolationMode

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsSetPixelOffsetMode($hGraphics, $iPixelOffsetMode)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPixelOffsetMode", "handle", $hGraphics, "int", $iPixelOffsetMode)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsSetPixelOffsetMode

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost, UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsSetSmoothingMode($hGraphics, $iSmooth)
	If $iSmooth < $GDIP_SMOOTHINGMODE_DEFAULT Or $iSmooth > $GDIP_SMOOTHINGMODE_ANTIALIAS8X8 Then $iSmooth = $GDIP_SMOOTHINGMODE_DEFAULT
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetSmoothingMode", "handle", $hGraphics, "int", $iSmooth)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsSetSmoothingMode

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_GraphicsSetTextRenderingHint($hGraphics, $iTextRenderingHint)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetTextRenderingHint", "handle", $hGraphics, "int", $iTextRenderingHint)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsSetTextRenderingHint

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_GraphicsSetTransform($hGraphics, $hMatrix)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetWorldTransform", "handle", $hGraphics, "handle", $hMatrix)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsSetTransform

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_GraphicsTransformPoints($hGraphics, ByRef $aPoints, $iCoordSpaceTo = 0, $iCoordSpaceFrom = 1)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], ($iI - 1) * 2 + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], ($iI - 1) * 2 + 2)
	Next

	Local $aResult = DllCall($ghGDIPDll, "int", "GdipTransformPoints", "handle", $hGraphics, "int", $iCoordSpaceTo, "int", $iCoordSpaceFrom, "struct*", $tPoints, "int", $iCount)
	If @error Then Return SetError(@error, @extended, False)

	For $iI = 1 To $iCount
		$aPoints[$iI][0] = DllStructGetData($tPoints, 1, ($iI - 1) * 2 + 1)
		$aPoints[$iI][1] = DllStructGetData($tPoints, 1, ($iI - 1) * 2 + 2)
	Next

	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsTransformPoints

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_GraphicsTranslateTransform($hGraphics, $fDX, $fDY, $iOrder = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipTranslateWorldTransform", "handle", $hGraphics, "float", $fDX, "float", $fDY, "int", $iOrder)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsTranslateTransform

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_ImageAttributesCreate()
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateImageAttributes", "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[1])
EndFunc   ;==>_GDIPlus_ImageAttributesCreate

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_ImageAttributesDispose($hImageAttributes)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDisposeImageAttributes", "handle", $hImageAttributes)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_ImageAttributesDispose

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_ImageAttributesSetColorKeys($hImageAttributes, $iColorAdjustType = 0, $fEnable = False, $iARGBLow = 0, $iARGBHigh = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetImageAttributesColorKeys", "handle", $hImageAttributes, "int", $iColorAdjustType, "int", $fEnable, "uint", $iARGBLow, "uint", $iARGBHigh)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_ImageAttributesSetColorKeys

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_ImageAttributesSetColorMatrix($hImageAttributes, $iColorAdjustType = 0, $fEnable = False, $pClrMatrix = 0, $pGrayMatrix = 0, $iColorMatrixFlags = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetImageAttributesColorMatrix", "handle", $hImageAttributes, "int", $iColorAdjustType, "int", $fEnable, "ptr", $pClrMatrix, "ptr", $pGrayMatrix, "int", $iColorMatrixFlags)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_ImageAttributesSetColorMatrix

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_ImageDispose($hImage)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDisposeImage", "handle", $hImage)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_ImageDispose

; #FUNCTION# ====================================================================================================================
; Author ........: rover
; Modified.......:
; ===============================================================================================================================
Func _GDIPlus_ImageGetFlags($hImage)
	Local $aFlag[2] = [0, ""]
	If ($hImage = -1) Or (Not $hImage) Then Return SetError(10, 1, $aFlag)
	Local $aImageFlags[13][2] = _
			[["Pixel data Cacheable", $GDIP_IMAGEFLAGS_CACHING], _
			["Pixel data read-only", $GDIP_IMAGEFLAGS_READONLY], _
			["Pixel size in image", $GDIP_IMAGEFLAGS_HASREALPIXELSIZE], _
			["DPI info in image", $GDIP_IMAGEFLAGS_HASREALDPI], _
			["YCCK color space", $GDIP_IMAGEFLAGS_COLORSPACE_YCCK], _
			["YCBCR color space", $GDIP_IMAGEFLAGS_COLORSPACE_YCBCR], _
			["Grayscale image", $GDIP_IMAGEFLAGS_COLORSPACE_GRAY], _
			["CMYK color space", $GDIP_IMAGEFLAGS_COLORSPACE_CMYK], _
			["RGB color space", $GDIP_IMAGEFLAGS_COLORSPACE_RGB], _
			["Partially scalable", $GDIP_IMAGEFLAGS_PARTIALLYSCALABLE], _
			["Alpha values other than 0 (transparent) and 255 (opaque)", $GDIP_IMAGEFLAGS_HASTRANSLUCENT], _
			["Alpha values", $GDIP_IMAGEFLAGS_HASALPHA], _
			["Scalable", $GDIP_IMAGEFLAGS_SCALABLE]]
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageFlags", "handle", $hImage, "long*", 0)
	If @error Then Return SetError(@error, 2, $aFlag)
	If $aResult[2] = $GDIP_IMAGEFLAGS_NONE Then
		$aFlag[1] = "No pixel data"
		Return SetError($aResult[0], 3, $aFlag)
	EndIf
	$aFlag[0] = $aResult[2]
	For $i = 0 To 12
		If BitAND($aResult[2], $aImageFlags[$i][1]) = $aImageFlags[$i][1] Then
			If StringLen($aFlag[1]) Then $aFlag[1] &= "|"
			$aResult[2] -= $aImageFlags[$i][1]
			$aFlag[1] &= $aImageFlags[$i][0]
		EndIf
	Next
	Return SetExtended($aResult[0], $aFlag)
EndFunc   ;==>_GDIPlus_ImageGetFlags

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_ImageGetGraphicsContext($hImage)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageGraphicsContext", "handle", $hImage, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_ImageGetGraphicsContext

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_ImageGetHeight($hImage)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageHeight", "handle", $hImage, "uint*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_ImageGetHeight

; #FUNCTION# ====================================================================================================================
; Author ........: rover
; Modified.......:
; ===============================================================================================================================
Func _GDIPlus_ImageGetHorizontalResolution($hImage)
	If ($hImage = -1) Or (Not $hImage) Then Return SetError(10, 1, 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageHorizontalResolution", "handle", $hImage, "float*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], Round($aResult[2]))
EndFunc   ;==>_GDIPlus_ImageGetHorizontalResolution

; #FUNCTION# ====================================================================================================================
; Author ........: rover
; Modified.......:
; ===============================================================================================================================
Func _GDIPlus_ImageGetPixelFormat($hImage)
	Local $aFormat[2] = [0, ""]
	If ($hImage = -1) Or (Not $hImage) Then Return SetError(10, 1, $aFormat)
	Local $aPixelFormat[14][2] = _
			[["1 Bpp Indexed", $GDIP_PXF01INDEXED], _
			["4 Bpp Indexed", $GDIP_PXF04INDEXED], _
			["8 Bpp Indexed", $GDIP_PXF08INDEXED], _
			["16 Bpp Grayscale", $GDIP_PXF16GRAYSCALE], _
			["16 Bpp RGB 555", $GDIP_PXF16RGB555], _
			["16 Bpp RGB 565", $GDIP_PXF16RGB565], _
			["16 Bpp ARGB 1555", $GDIP_PXF16ARGB1555], _
			["24 Bpp RGB", $GDIP_PXF24RGB], _
			["32 Bpp RGB", $GDIP_PXF32RGB], _
			["32 Bpp ARGB", $GDIP_PXF32ARGB], _
			["32 Bpp PARGB", $GDIP_PXF32PARGB], _
			["48 Bpp RGB", $GDIP_PXF48RGB], _
			["64 Bpp ARGB", $GDIP_PXF64ARGB], _
			["64 Bpp PARGB", $GDIP_PXF64PARGB]]
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImagePixelFormat", "handle", $hImage, "int*", 0)
	If @error Then Return SetError(@error, @extended, $aFormat)
	For $i = 0 To 13
		If $aPixelFormat[$i][1] = $aResult[2] Then
			$aFormat[0] = $aPixelFormat[$i][1]
			$aFormat[1] = $aPixelFormat[$i][0]
			Return SetExtended($aResult[0], $aFormat)
		EndIf
	Next
	Return SetExtended($aResult[0], $aFormat)
EndFunc   ;==>_GDIPlus_ImageGetPixelFormat

; #FUNCTION# ====================================================================================================================
; Author ........: rover
; Modified.......:
; ===============================================================================================================================
Func _GDIPlus_ImageGetRawFormat($hImage)
	Local $aGuid[2]
	If ($hImage = -1) Or (Not $hImage) Then Return SetError(10, 1, $aGuid)
	Local $aImageType[11][2] = _
			[["UNDEFINED", $GDIP_IMAGEFORMAT_UNDEFINED], _
			["MEMORYBMP", $GDIP_IMAGEFORMAT_MEMORYBMP], _
			["BMP", $GDIP_IMAGEFORMAT_BMP], _
			["EMF", $GDIP_IMAGEFORMAT_EMF], _
			["WMF", $GDIP_IMAGEFORMAT_WMF], _
			["JPEG", $GDIP_IMAGEFORMAT_JPEG], _
			["PNG", $GDIP_IMAGEFORMAT_PNG], _
			["GIF", $GDIP_IMAGEFORMAT_GIF], _
			["TIFF", $GDIP_IMAGEFORMAT_TIFF], _
			["EXIF", $GDIP_IMAGEFORMAT_EXIF], _
			["ICON", $GDIP_IMAGEFORMAT_ICON]]
	Local $tStruct = DllStructCreate("byte[16]")
	Local $aResult1 = DllCall($ghGDIPDll, "int", "GdipGetImageRawFormat", "handle", $hImage, "struct*", $tStruct)
	If @error Then Return SetError(@error, @extended, $aGuid)
	If (Not IsArray($aResult1)) Then Return SetError(1, 3, $aGuid)
	Local $sResult2 = _WinAPI_StringFromGUID($aResult1[2])
	If @error Then Return SetError(@error, 4, $aGuid)
	For $i = 0 To 10
		If $aImageType[$i][1] == $sResult2 Then
			$aGuid[0] = $aImageType[$i][1]
			$aGuid[1] = $aImageType[$i][0]
			Return SetExtended($aResult1[0], $aGuid)
		EndIf
	Next
	Return SetError(-1, 5, $aGuid)
EndFunc   ;==>_GDIPlus_ImageGetRawFormat

; #FUNCTION# ====================================================================================================================
; Author ........: rover
; Modified.......:
; ===============================================================================================================================
Func _GDIPlus_ImageGetType($hImage)
	If ($hImage = -1) Or (Not $hImage) Then Return SetError(10, 0, -1)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageType", "handle", $hImage, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_ImageGetType

; #FUNCTION# ====================================================================================================================
; Author ........: rover
; Modified.......:
; ===============================================================================================================================
Func _GDIPlus_ImageGetVerticalResolution($hImage)
	If ($hImage = -1) Or (Not $hImage) Then Return SetError(10, 0, 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageVerticalResolution", "handle", $hImage, "float*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], Round($aResult[2]))
EndFunc   ;==>_GDIPlus_ImageGetVerticalResolution

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_ImageGetWidth($hImage)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageWidth", "handle", $hImage, "uint*", -1)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_ImageGetWidth

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost/martin
; ===============================================================================================================================
Func _GDIPlus_ImageLoadFromFile($sFileName)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipLoadImageFromFile", "wstr", $sFileName, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_ImageLoadFromFile

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_ImageLoadFromStream($pStream)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipLoadImageFromStream", "ptr", $pStream, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[2]
EndFunc   ;==>_GDIPlus_ImageLoadFromStream

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_ImageSaveToFile($hImage, $sFileName)
	Local $sExt = __GDIPlus_ExtractFileExt($sFileName)
	Local $sCLSID = _GDIPlus_EncodersGetCLSID($sExt)
	If $sCLSID = "" Then Return SetError(-1, 0, False)
	Return _GDIPlus_ImageSaveToFileEx($hImage, $sFileName, $sCLSID, 0)
EndFunc   ;==>_GDIPlus_ImageSaveToFile

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_ImageSaveToFileEx($hImage, $sFileName, $sEncoder, $pParams = 0)
	Local $tGUID = _WinAPI_GUIDFromString($sEncoder)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSaveImageToFile", "handle", $hImage, "wstr", $sFileName, "struct*", $tGUID, "struct*", $pParams)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_ImageSaveToFileEx

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_ImageSaveToStream($hImage, $pStream, $pEncoder, $pParams = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSaveImageToStream", "handle", $hImage, "ptr", $pStream, "ptr", $pEncoder, "ptr", $pParams)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_ImageSaveToStream

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_LineBrushCreate($nX1, $nY1, $nX2, $nY2, $iARGBClr1, $iARGBClr2, $iWrapMode = 0)
	Local $tPointF1, $tPointF2, $aResult
	$tPointF1 = DllStructCreate("float;float")
	$tPointF2 = DllStructCreate("float;float")
	DllStructSetData($tPointF1, 1, $nX1)
	DllStructSetData($tPointF1, 2, $nY1)
	DllStructSetData($tPointF2, 1, $nX2)
	DllStructSetData($tPointF2, 2, $nY2)
	$aResult = DllCall($ghGDIPDll, "int", "GdipCreateLineBrush", "struct*", $tPointF1, "struct*", $tPointF2, "uint", $iARGBClr1, "uint", $iARGBClr2, "int", $iWrapMode, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[6])
EndFunc   ;==>_GDIPlus_LineBrushCreate

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_LineBrushGetColors($hLineGradientBrush)
	Local $tARGBs, $aARGBs[2], $aResult
	$tARGBs = DllStructCreate("uint;uint")
	$aResult = DllCall($ghGDIPDll, "uint", "GdipGetLineColors", "handle", $hLineGradientBrush, "struct*", $tARGBs)
	If @error Or $aResult[0] Then Return SetError(@error, @extended, -1)
	$aARGBs[0] = DllStructGetData($tARGBs, 1)
	$aARGBs[1] = DllStructGetData($tARGBs, 2)
	Return $aARGBs
EndFunc   ;==>_GDIPlus_LineBrushGetColors

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_LineBrushSetBlend($hLineGradientBrush, $aBlends)
	Local $iI, $iCount, $tFactors, $tPositions, $aResult
	$iCount = $aBlends[0][0]
	$tFactors = DllStructCreate("float[" & $iCount & "]")
	$tPositions = DllStructCreate("float[" & $iCount & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tFactors, 1, $aBlends[$iI][0], $iI)
		DllStructSetData($tPositions, 1, $aBlends[$iI][1], $iI)
	Next
	$aResult = DllCall($ghGDIPDll, "int", "GdipSetLineBlend", "handle", $hLineGradientBrush, "struct*", $tFactors, "struct*", $tPositions, "int", $iCount)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_LineBrushSetBlend

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_LineBrushSetColors($hLineGradientBrush, $iARGBStart, $iARGBEnd)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetLineColors", "handle", $hLineGradientBrush, "uint", $iARGBStart, "uint", $iARGBEnd)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_LineBrushSetColors

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_LineBrushSetGammaCorrection($hLineGradientBrush, $fUseGammaCorrection = True)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetLineGammaCorrection", "handle", $hLineGradientBrush, "int", $fUseGammaCorrection)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_LineBrushSetGammaCorrection

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_LineBrushSetPresetBlend($hLineGradientBrush, $aInterpolations)
	Local $iI, $iCount, $tColors, $tPositions, $aResult
	$iCount = $aInterpolations[0][0]
	$tColors = DllStructCreate("uint[" & $iCount & "]")
	$tPositions = DllStructCreate("float[" & $iCount & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tColors, 1, $aInterpolations[$iI][0], $iI)
		DllStructSetData($tPositions, 1, $aInterpolations[$iI][1], $iI)
	Next
	$aResult = DllCall($ghGDIPDll, "int", "GdipSetLinePresetBlend", "handle", $hLineGradientBrush, "struct*", $tColors, "struct*", $tPositions, "int", $iCount)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_LineBrushSetPresetBlend

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_LineBrushSetSigmaBlend($hLineGradientBrush, $fFocus, $fScale = 1)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetLineSigmaBlend", "handle", $hLineGradientBrush, "float", $fFocus, "float", $fScale)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_LineBrushSetSigmaBlend

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_MatrixCreate()
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateMatrix", "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[1])
EndFunc   ;==>_GDIPlus_MatrixCreate

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_MatrixDispose($hMatrix)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeleteMatrix", "handle", $hMatrix)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_MatrixDispose

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_MatrixGetElements($hMatrix)
	Local $tElements = DllStructCreate("float[6]")
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetMatrixElements", "handle", $hMatrix, "struct*", $tElements)
	If @error Then Return SetError(@error, @extended, -1)
	If $aResult[0] Then Return SetError($aResult[0], $aResult[0], -1)

	Local $aElements[6]
	For $iI = 1 To 6
		$aElements[$iI - 1] = DllStructGetData($tElements, 1, $iI)
	Next
	Return $aElements
EndFunc   ;==>_GDIPlus_MatrixGetElements

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_MatrixInvert($hMatrix)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipInvertMatrix", "handle", $hMatrix)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_MatrixInvert

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_MatrixRotate($hMatrix, $fAngle, $bAppend = False)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipRotateMatrix", "handle", $hMatrix, "float", $fAngle, "int", $bAppend)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_MatrixRotate

; #FUNCTION# ====================================================================================================================
; Author ........: monoceres
; Modified.......:
; ===============================================================================================================================
Func _GDIPlus_MatrixScale($hMatrix, $fScaleX, $fScaleY, $bOrder = False)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipScaleMatrix", "handle", $hMatrix, "float", $fScaleX, "float", $fScaleY, "int", $bOrder)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_MatrixScale

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_MatrixSetElements($hMatrix, $nM11 = 1, $nM12 = 0, $nM21 = 0, $nM22 = 1, $nDX = 0, $nDY = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetMatrixElements", "handle", $hMatrix, "float", $nM11, "float", $nM12, _
			"float", $nM21, "float", $nM22, "float", $nDX, "float", $nDY)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_MatrixSetElements

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_MatrixTransformPoints($hMatrix, ByRef $aPoints)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], ($iI - 1) * 2 + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], ($iI - 1) * 2 + 2)
	Next

	Local $aResult = DllCall($ghGDIPDll, "int", "GdipTransformMatrixPoints", "handle", $hMatrix, "struct*", $tPoints, "int", $iCount)
	If @error Then Return SetError(@error, @extended, False)

	For $iI = 1 To $iCount
		$aPoints[$iI][0] = DllStructGetData($tPoints, 1, ($iI - 1) * 2 + 1)
		$aPoints[$iI][1] = DllStructGetData($tPoints, 1, ($iI - 1) * 2 + 2)
	Next

	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_MatrixTransformPoints

; #FUNCTION# ====================================================================================================================
; Author ........: monoceres
; Modified.......:
; ===============================================================================================================================
Func _GDIPlus_MatrixTranslate($hMatrix, $fOffsetX, $fOffsetY, $bAppend = False)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipTranslateMatrix", "handle", $hMatrix, "float", $fOffsetX, "float", $fOffsetY, "int", $bAppend)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_MatrixTranslate

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; ===============================================================================================================================
Func _GDIPlus_ParamAdd(ByRef $tParams, $sGUID, $iCount, $iType, $pValues)
	Local $tParam = DllStructCreate($tagGDIPENCODERPARAM, DllStructGetPtr($tParams, "Params") + (DllStructGetData($tParams, "Count") * 28))
	_WinAPI_GUIDFromStringEx($sGUID, DllStructGetPtr($tParam, "GUID"))
	DllStructSetData($tParam, "Type", $iType)
	DllStructSetData($tParam, "Count", $iCount)
	DllStructSetData($tParam, "Values", $pValues)
	DllStructSetData($tParams, "Count", DllStructGetData($tParams, "Count") + 1)
EndFunc   ;==>_GDIPlus_ParamAdd

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; ===============================================================================================================================
Func _GDIPlus_ParamInit($iCount)
	If $iCount <= 0 Then Return SetError(-1, -1, 0)
	Return DllStructCreate("dword Count;byte Params[" & $iCount * 28 & "]")
EndFunc   ;==>_GDIPlus_ParamInit

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathAddArc($hPath, $fX, $fY, $fWidth, $fHeight, $fStartAngle, $fSweepAngle)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipAddPathArc", "handle", $hPath, "float", $fX, "float", $fY, _
			"float", $fWidth, "float", $fHeight, "float", $fStartAngle, "float", $fSweepAngle)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathAddArc

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathAddClosedCurve($hPath, $aPoints)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipAddPathClosedCurve", "handle", $hPath, "struct*", $tPoints, "int", $iCount)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathAddClosedCurve

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathAddClosedCurve2($hPath, $aPoints, $fTension = 0.5)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipAddPathClosedCurve2", "handle", $hPath, "struct*", $tPoints, "int", $iCount, "float", $fTension)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathAddClosedCurve2

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathAddCurve($hPath, $aPoints)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipAddPathCurve", "handle", $hPath, "struct*", $tPoints, "int", $iCount)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathAddCurve

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathAddCurve2($hPath, $aPoints, $fTension = 0.5)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipAddPathCurve2", "handle", $hPath, "struct*", $tPoints, "int", $iCount, "float", $fTension)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathAddCurve2

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathAddCurve3($hPath, $aPoints, $iOffset, $iNumOfSegments, $fTension = 0.5)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipAddPathCurve3", "handle", $hPath, "struct*", $tPoints, "int", $iCount, "int", $iOffset, "int", $iNumOfSegments, "float", $fTension)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathAddCurve3

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathAddEllipse($hPath, $fX, $fY, $fWidth, $fHeight)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipAddPathEllipse", "handle", $hPath, "float", $fX, "float", $fY, "float", $fWidth, "float", $fHeight)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathAddEllipse

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathAddLine($hPath, $fX1, $fY1, $fX2, $fY2)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipAddPathLine", "handle", $hPath, "float", $fX1, "float", $fY1, "float", $fX2, "float", $fY2)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathAddLine

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathAddPath($hPath1, $hPath2, $bConnect = True)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipAddPathPath", "handle", $hPath1, "handle", $hPath2, "int", $bConnect)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathAddPath

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathAddPie($hPath, $fX, $fY, $fWidth, $fHeight, $fStartAngle, $fSweepAngle)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipAddPathPie", "handle", $hPath, "float", $fX, "float", $fY, _
			"float", $fWidth, "float", $fHeight, "float", $fStartAngle, "float", $fSweepAngle)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathAddPie

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathAddPolygon($hPath, $aPoints)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipAddPathPolygon", "handle", $hPath, "struct*", $tPoints, "int", $iCount)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathAddPolygon

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathAddRectangle($hPath, $fX, $fY, $fWidth, $fHeight)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipAddPathRectangle", "handle", $hPath, "float", $fX, "float", $fY, "float", $fWidth, "float", $fHeight)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathAddRectangle

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathAddString($hPath, $sString, $tLayout, $hFamily, $iStyle = 0, $fSize = 8.5, $hFormat = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipAddPathString", "handle", $hPath, "wstr", $sString, "int", -1, _
			"handle", $hFamily, "int", $iStyle, "float", $fSize, "struct*", $tLayout, "handle", $hFormat)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathAddString

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushCreate($aPoints, $iWrapMode = 0)
	Local $iCount = $aPoints[0][0]
	Local $tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreatePathGradient", "struct*", $tPoints, "int", $iCount, "int", $iWrapMode, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[4])
EndFunc   ;==>_GDIPlus_PathBrushCreate

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushCreateFromPath($hPath)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreatePathGradientFromPath", "handle", $hPath, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_PathBrushCreateFromPath

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushGetCenterPoint($hPathGradientBrush)
	Local $tPointF = DllStructCreate("float;float")
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetPathGradientCenterPoint", "handle", $hPathGradientBrush, "struct*", $tPointF)
	If @error Then Return SetError(@error, @extended, -1)
	If $aResult[0] Then Return SetError($aResult[0], $aResult[0], -1)
	Local $aPointF[2]
	$aPointF[0] = DllStructGetData($tPointF, 1)
	$aPointF[1] = DllStructGetData($tPointF, 2)
	Return $aPointF
EndFunc   ;==>_GDIPlus_PathBrushGetCenterPoint

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushGetFocusScales($hPathGradientBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetPathGradientFocusScales", "handle", $hPathGradientBrush, "float*", 0, "float*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	If $aResult[0] Then Return SetError($aResult[0], $aResult[0], -1)

	Local $aScales[2]
	$aScales[0] = $aResult[2]
	$aScales[1] = $aResult[3]
	Return $aScales
EndFunc   ;==>_GDIPlus_PathBrushGetFocusScales

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushGetPointCount($hPathGradientBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetPathGradientPointCount", "handle", $hPathGradientBrush, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	If $aResult[0] Then Return SetError($aResult[0], $aResult[0], -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_PathBrushGetPointCount

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushGetRect($hPathGradientBrush)
	Local $tRectF = DllStructCreate($tagGDIPRECTF)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetPathGradientRect", "handle", $hPathGradientBrush, "struct*", $tRectF)
	If @error Then Return SetError(@error, @extended, -1)
	If $aResult[0] Then Return SetError($aResult[0], $aResult[0], -1)

	Local $aRectF[4]
	For $iI = 1 To 4
		$aRectF[$iI - 1] = DllStructGetData($tRectF, $iI)
	Next
	Return $aRectF
EndFunc   ;==>_GDIPlus_PathBrushGetRect

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushGetWrapMode($hPathGradientBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetPathGradientWrapMode", "handle", $hPathGradientBrush, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	If $aResult[0] Then Return SetError($aResult[0], $aResult[0], -1)
	Return $aResult[2]
EndFunc   ;==>_GDIPlus_PathBrushGetWrapMode

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushResetTransform($hPathGradientBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipResetPathGradientTransform", "handle", $hPathGradientBrush)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathBrushResetTransform

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushSetBlend($hPathGradientBrush, $aBlends)
	Local $iCount = $aBlends[0][0]
	Local $tFactors = DllStructCreate("float[" & $iCount & "]")
	Local $tPositions = DllStructCreate("float[" & $iCount & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tFactors, 1, $aBlends[$iI][0], $iI)
		DllStructSetData($tPositions, 1, $aBlends[$iI][1], $iI)
	Next
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPathGradientBlend", "handle", $hPathGradientBrush, "struct*", $tFactors, "struct*", $tPositions, "int", $iCount)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathBrushSetBlend

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushSetCenterColor($hPathGradientBrush, $iARGB)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPathGradientCenterColor", "handle", $hPathGradientBrush, "uint", $iARGB)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathBrushSetCenterColor

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushSetCenterPoint($hPathGradientBrush, $fX, $fY)
	Local $tPointF = DllStructCreate("float;float")
	DllStructSetData($tPointF, 1, $fX)
	DllStructSetData($tPointF, 2, $fY)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPathGradientCenterPoint", "handle", $hPathGradientBrush, "struct*", $tPointF)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathBrushSetCenterPoint

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushSetFocusScales($hPathGradientBrush, $fScaleX, $fScaleY)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPathGradientFocusScales", "handle", $hPathGradientBrush, "float", $fScaleX, "float", $fScaleY)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathBrushSetFocusScales

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushSetGammaCorrection($hPathGradientBrush, $bUseGammaCorrection)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPathGradientGammaCorrection", "handle", $hPathGradientBrush, "int", $bUseGammaCorrection)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathBrushSetGammaCorrection

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushSetLinearBlend($hPathGradientBrush, $fFocus, $fScale = 1)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPathGradientLinearBlend", "handle", $hPathGradientBrush, "float", $fFocus, "float", $fScale)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathBrushSetLinearBlend

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushSetPresetBlend($hPathGradientBrush, $aInterpolations)
	Local $iCount = $aInterpolations[0][0]
	Local $tColors = DllStructCreate("uint[" & $iCount & "]")
	Local $tPositions = DllStructCreate("float[" & $iCount & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tColors, 1, $aInterpolations[$iI][0], $iI)
		DllStructSetData($tPositions, 1, $aInterpolations[$iI][1], $iI)
	Next
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPathGradientPresetBlend", "handle", $hPathGradientBrush, "struct*", $tColors, "struct*", $tPositions, "int", $iCount)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathBrushSetPresetBlend

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushSetSigmaBlend($hPathGradientBrush, $fFocus, $fScale = 1)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPathGradientSigmaBlend", "handle", $hPathGradientBrush, "float", $fFocus, "float", $fScale)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathBrushSetSigmaBlend

; #FUNCTION# ====================================================================================================================
; Author ........: Eukalyptus
; Modified.......:
; ===============================================================================================================================
Func _GDIPlus_PathBrushSetSurroundColor($hPathGradientBrush, $iARGB)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPathGradientSurroundColorsWithCount", "handle", $hPathGradientBrush, "uint*", $iARGB, "int*", 1)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathBrushSetSurroundColor

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushSetSurroundColorsWithCount($hPathGradientBrush, $aColors)
	Local $iCount = $aColors[0]
	Local $iColors = _GDIPlus_PathBrushGetPointCount($hPathGradientBrush)
	If $iColors < $iCount Then $iCount = $iColors
	Local $tColors = DllStructCreate("uint[" & $iCount & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tColors, 1, $aColors[$iI], $iI)
	Next
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPathGradientSurroundColorsWithCount", "handle", $hPathGradientBrush, "struct*", $tColors, "int*", $iCount)
	If @error Then Return SetError(@error, @extended, False)
	Return SetExtended($aResult[0], $aResult[3])
EndFunc   ;==>_GDIPlus_PathBrushSetSurroundColorsWithCount

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushSetTransform($hPathGradientBrush, $hMatrix)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPathGradientTransform", "handle", $hPathGradientBrush, "handle", $hMatrix)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathBrushSetTransform

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathBrushSetWrapMode($hPathGradientBrush, $iWrapMode)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPathGradientWrapMode", "handle", $hPathGradientBrush, "int", $iWrapMode)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathBrushSetWrapMode

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathClone($hPath)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipClonePath", "handle", $hPath, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_PathClone

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathCloseFigure($hPath)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipClosePathFigure", "handle", $hPath)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathCloseFigure

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathCreate($iFillMode = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreatePath", "int", $iFillMode, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_PathCreate

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathCreate2($aPathData, $iFillMode = 0)
	Local $iCount = $aPathData[0][0]
	Local $tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	Local $tTypes = DllStructCreate("byte[" & $iCount & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPathData[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPathData[$iI][1], (($iI - 1) * 2) + 2)
		DllStructSetData($tTypes, 1, $aPathData[$iI][2], $iI)
	Next
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreatePath2", "struct*", $tPoints, "struct*", $tTypes, "int", $iCount, "int", $iFillMode, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[5])
EndFunc   ;==>_GDIPlus_PathCreate2

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathDispose($hPath)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeletePath", "handle", $hPath)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathDispose

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathFlatten($hPath, $fFlatness = 0.25, $hMatrix = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipFlattenPath", "handle", $hPath, "handle", $hMatrix, "float", $fFlatness)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathFlatten

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathGetData($hPath)
	Local $iCount = _GDIPlus_PathGetPointCount($hPath)
	Local $tPathData = DllStructCreate("int Count; ptr Points; ptr Types;")
	Local $tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	Local $tTypes = DllStructCreate("ubyte[" & $iCount & "]")
	DllStructSetData($tPathData, "Count", $iCount)
	DllStructSetData($tPathData, "Points", DllStructGetPtr($tPoints))
	DllStructSetData($tPathData, "Types", DllStructGetPtr($tTypes))

	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetPathData", "handle", $hPath, "struct*", $tPathData)
	If @error Then Return SetError(@error, @extended, 0)
	If $aResult[0] Then Return SetError($aResult[0], $aResult[0], -1)

	Local $aData[$iCount + 1][3]
	$aData[0][0] = $iCount
	For $iI = 1 To $iCount
		$aData[$iI][0] = DllStructGetData($tPoints, 1, (($iI - 1) * 2) + 1)
		$aData[$iI][1] = DllStructGetData($tPoints, 1, (($iI - 1) * 2) + 2)
		$aData[$iI][2] = DllStructGetData($tTypes, 1, $iI)
	Next
	Return $aData
EndFunc   ;==>_GDIPlus_PathGetData

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathGetFillMode($hPath)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetPathFillMode", "handle", $hPath, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_PathGetFillMode

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathGetPointCount($hPath)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetPointCount", "handle", $hPath, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_PathGetPointCount

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathGetPoints($hPath)
	Local $iI, $iCount, $tPoints, $aPoints[1][1], $aResult
	$iCount = _GDIPlus_PathGetPointCount($hPath)
	If @error Then Return SetError(@error, @extended, -1)

	$tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetPathPoints", "handle", $hPath, "struct*", $tPoints, "int", $iCount)
	If @error Then Return SetError(@error, @extended, -1)
	If $aResult[0] Then Return SetError($aResult[0], $aResult[0], -1)
	Local $aPoints[$iCount + 1][2]
	$aPoints[0][0] = $iCount
	For $iI = 1 To $iCount
		$aPoints[$iI][0] = DllStructGetData($tPoints, 1, (($iI - 1) * 2) + 1)
		$aPoints[$iI][1] = DllStructGetData($tPoints, 1, (($iI - 1) * 2) + 2)
	Next
	Return $aPoints
EndFunc   ;==>_GDIPlus_PathGetPoints

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathGetWorldBounds($hPath, $hMatrix = 0, $hPen = 0)
	Local $tRectF = DllStructCreate($tagGDIPRECTF)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetPathWorldBounds", "handle", $hPath, "struct*", $tRectF, "handle", $hMatrix, "handle", $hPen)
	If @error Then Return SetError(@error, @extended, -1)
	If $aResult[0] Then Return SetError($aResult[0], $aResult[0], -1)
	Local $aRectF[4]
	For $iI = 1 To 4
		$aRectF[$iI - 1] = DllStructGetData($tRectF, $iI)
	Next
	Return $aRectF
EndFunc   ;==>_GDIPlus_PathGetWorldBounds

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathIsOutlineVisiblePoint($hPath, $fX, $fY, $hPen = 0, $hGraphics = 0)
	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipIsOutlineVisiblePathPoint", "handle", $hPath, "float", $fX, "float", $fY, "handle", $hPen, "handle", $hGraphics, "int*", 0)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, -1)
	If $aResult[0] Then Return SetError($aResult[0], $aResult[0], -1)
	Return $aResult[6] <> 0
EndFunc   ;==>_GDIPlus_PathIsOutlineVisiblePoint

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathIsVisiblePoint($hPath, $fX, $fY, $hGraphics = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipIsVisiblePathPoint", "handle", $hPath, "float", $fX, "float", $fY, "handle", $hGraphics, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	If $aResult[0] Then Return SetError($aResult[0], $aResult[0], -1)
	Return $aResult[5] <> 0
EndFunc   ;==>_GDIPlus_PathIsVisiblePoint

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathIterCreate($hPath)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreatePathIter", "handle*", 0, "handle", $hPath)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[1])
EndFunc   ;==>_GDIPlus_PathIterCreate

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathIterDispose($hPathIter)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeletePathIter", "handle", $hPathIter)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathIterDispose

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathIterGetSubpathCount($hPathIter)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipPathIterGetSubpathCount", "handle", $hPathIter, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	If $aResult[0] Then Return SetError($aResult[0], $aResult[0], -1)
	Return $aResult[2]
EndFunc   ;==>_GDIPlus_PathIterGetSubpathCount

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathIterNextSubpathPath($hPathIter, $hPath)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipPathIterNextSubpathPath", "handle", $hPathIter, "int*", 0, "handle", $hPath, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	If $aResult[0] Then Return SetError($aResult[0], $aResult[0], -1)

	Local $aReturn[2]
	$aReturn[0] = $aResult[2]
	$aReturn[1] = $aResult[4]
	Return $aReturn
EndFunc   ;==>_GDIPlus_PathIterNextSubpathPath

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathIterRewind($hPathIter)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipPathIterRewind", "handle", $hPathIter)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathIterRewind

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathReset($hPath)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipResetPath", "handle", $hPath)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathReset

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathReverse($hPath)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipReversePath", "handle", $hPath)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathReverse

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathSetFillMode($hPath, $iFillMode)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPathFillMode", "handle", $hPath, "int", $iFillMode)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathSetFillMode

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathTransform($hPath, $hMatrix)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipTransformPath", "handle", $hPath, "handle", $hMatrix)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathTransform

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathWarp($hPath, $hMatrix, $aPoints, $fX, $fY, $fWidth, $fHeight, $iWarpMode = 0, $fFlatness = 0.25)
	Local $iCount = $aPoints[0][0]
	If $iCount <> 3 And $iCount <> 4 Then Return SetError(1, 0, False)

	Local $tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], ($iI - 1) * 2 + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], ($iI - 1) * 2 + 2)
	Next

	Local $aResult = DllCall($ghGDIPDll, "int", "GdipWarpPath", "handle", $hPath, "handle", $hMatrix, "struct*", $tPoints, "int", $iCount, _
			"float", $fX, "float", $fY, "float", $fWidth, "float", $fHeight, "int", $iWarpMode, "float", $fFlatness)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathWarp

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathWiden($hPath, $hPen, $hMatrix = 0, $fFlatness = 0.25)
	__GDIPlus_PenDefCreate($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipWidenPath", "handle", $hPath, "handle", $hPen, "handle", $hMatrix, "float", $fFlatness)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathWiden

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PathWindingModeOutline($hPath, $hMatrix = 0, $fFlatness = 0.25)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipWindingModeOutline", "handle", $hPath, "handle", $hMatrix, "float", $fFlatness)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathWindingModeOutline

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_PenCreate($iARGB = 0xFF000000, $fWidth = 1, $iUnit = 2)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreatePen1", "dword", $iARGB, "float", $fWidth, "int", $iUnit, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[4])
EndFunc   ;==>_GDIPlus_PenCreate

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PenCreate2($hBrush, $fWidth = 1, $iUnit = 2)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreatePen2", "handle", $hBrush, "float", $fWidth, "int", $iUnit, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[4])
EndFunc   ;==>_GDIPlus_PenCreate2

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_PenDispose($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeletePen", "handle", $hPen)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PenDispose

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_PenGetAlignment($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetPenMode", "handle", $hPen, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_PenGetAlignment

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_PenGetColor($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetPenColor", "handle", $hPen, "dword*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_PenGetColor

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_PenGetCustomEndCap($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetPenCustomEndCap", "handle", $hPen, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_PenGetCustomEndCap

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_PenGetDashCap($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetPenDashCap197819", "handle", $hPen, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_PenGetDashCap

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_PenGetDashStyle($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetPenDashStyle", "handle", $hPen, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_PenGetDashStyle

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_PenGetEndCap($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetPenEndCap", "handle", $hPen, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_PenGetEndCap

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_PenGetWidth($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetPenWidth", "handle", $hPen, "float*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_PenGetWidth

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_PenSetAlignment($hPen, $iAlignment = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPenMode", "handle", $hPen, "int", $iAlignment)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PenSetAlignment

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_PenSetColor($hPen, $iARGB)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPenColor", "handle", $hPen, "dword", $iARGB)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PenSetColor

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_PenSetCustomEndCap($hPen, $hEndCap)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPenCustomEndCap", "handle", $hPen, "handle", $hEndCap)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PenSetCustomEndCap

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_PenSetDashCap($hPen, $iDash = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPenDashCap197819", "handle", $hPen, "int", $iDash)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PenSetDashCap

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_PenSetDashStyle($hPen, $iStyle = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPenDashStyle", "handle", $hPen, "int", $iStyle)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PenSetDashStyle

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_PenSetEndCap($hPen, $iEndCap)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPenEndCap", "handle", $hPen, "int", $iEndCap)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PenSetEndCap

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_PenSetLineJoin($hPen, $iLineJoin)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPenLineJoin", "handle", $hPen, "int", $iLineJoin)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PenSetLineJoin

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_PenSetWidth($hPen, $fWidth)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPenWidth", "handle", $hPen, "float", $fWidth)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PenSetWidth

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; ===============================================================================================================================
Func _GDIPlus_RectFCreate($nX = 0, $nY = 0, $nWidth = 0, $nHeight = 0)
	Local $tRectF = DllStructCreate($tagGDIPRECTF)
	DllStructSetData($tRectF, "X", $nX)
	DllStructSetData($tRectF, "Y", $nY)
	DllStructSetData($tRectF, "Width", $nWidth)
	DllStructSetData($tRectF, "Height", $nHeight)
	Return $tRectF
EndFunc   ;==>_GDIPlus_RectFCreate

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_RegionClone($hRegion)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCloneRegion", "handle", $hRegion, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_RegionClone

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_RegionCombinePath($hRegion, $hPath, $iCombineMode = 2)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCombineRegionPath", "handle", $hRegion, "handle", $hPath, "int", $iCombineMode)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_RegionCombinePath

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_RegionCombineRect($hRegion, $fX, $fY, $fWidth, $fHeight, $iCombineMode = 2)
	Local $tRectF = _GDIPlus_RectFCreate($fX, $fY, $fWidth, $fHeight)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCombineRegionRect", "handle", $hRegion, "struct*", $tRectF, "int", $iCombineMode)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_RegionCombineRect

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_RegionCombineRegion($hRegionDst, $hRegionSrc, $iCombineMode = 2)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCombineRegionRegion", "handle", $hRegionDst, "handle", $hRegionSrc, "int", $iCombineMode)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_RegionCombineRegion

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_RegionCreate()
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateRegion", "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[1])
EndFunc   ;==>_GDIPlus_RegionCreate

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_RegionCreateFromPath($hPath)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateRegionPath", "handle", $hPath, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_RegionCreateFromPath

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_RegionCreateFromRect($fX, $fY, $fWidth, $fHeight)
	Local $tRectF = _GDIPlus_RectFCreate($fX, $fY, $fWidth, $fHeight)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateRegionRect", "struct*", $tRectF, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_RegionCreateFromRect

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_RegionDispose($hRegion)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeleteRegion", "handle", $hRegion)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_RegionDispose

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_RegionGetBounds($hRegion, $hGraphics)
	Local $tRectF = DllStructCreate($tagGDIPRECTF)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetRegionBounds", "handle", $hRegion, "handle", $hGraphics, "struct*", $tRectF)
	If @error Then Return SetError(@error, @extended, -1)
	If $aResult[0] Then Return SetError($aResult[0], $aResult[0], -1)
	Local $aBounds[4]
	For $iI = 1 To 4
		$aBounds[$iI - 1] = DllStructGetData($tRectF, $iI)
	Next
	Return $aBounds
EndFunc   ;==>_GDIPlus_RegionGetBounds

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_RegionGetHRgn($hRegion, $hGraphics = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetRegionHRgn", "handle", $hRegion, "handle", $hGraphics, "handle*", 0)
	If @error Then Return SetError(@error, @extended, False)
	Return SetExtended($aResult[0], $aResult[3])
EndFunc   ;==>_GDIPlus_RegionGetHRgn

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_RegionTransform($hRegion, $hMatrix)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipTransformRegion", "handle", $hRegion, "handle", $hMatrix)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_RegionTransform

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_RegionTranslate($hRegion, $fDX, $fDY)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipTranslateRegion", "handle", $hRegion, "float", $fDX, "float", $fDY)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_RegionTranslate

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; ===============================================================================================================================
Func _GDIPlus_Shutdown()
	If $ghGDIPDll = 0 Then Return SetError(-1, -1, False)

	$giGDIPRef -= 1
	If $giGDIPRef = 0 Then
		DllCall($ghGDIPDll, "none", "GdiplusShutdown", "ulong_ptr", $giGDIPToken)
		DllClose($ghGDIPDll)
		$ghGDIPDll = 0
	EndIf
	Return True
EndFunc   ;==>_GDIPlus_Shutdown

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_Startup()
	$giGDIPRef += 1
	If $giGDIPRef > 1 Then Return True

	$ghGDIPDll = DllOpen("GDIPlus.dll")
	If $ghGDIPDll = -1 Then
		$giGDIPRef = 0
		Return SetError(1, 2, False)
	EndIf
	Local $tInput = DllStructCreate($tagGDIPSTARTUPINPUT)
	Local $tToken = DllStructCreate("ulong_ptr Data")
	DllStructSetData($tInput, "Version", 1)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdiplusStartup", "struct*", $tToken, "struct*", $tInput, "ptr", 0)
	If @error Then Return SetError(@error, @extended, False)
	$giGDIPToken = DllStructGetData($tToken, "Data")
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_Startup

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_StringFormatCreate($iFormat = 0, $iLangID = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateStringFormat", "int", $iFormat, "word", $iLangID, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[3])
EndFunc   ;==>_GDIPlus_StringFormatCreate

; #FUNCTION# ====================================================================================================================
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; ===============================================================================================================================
Func _GDIPlus_StringFormatDispose($hFormat)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeleteStringFormat", "handle", $hFormat)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_StringFormatDispose

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_StringFormatGetMeasurableCharacterRangeCount($hStringFormat)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetStringFormatMeasurableCharacterRangeCount", "handle", $hStringFormat, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	If $aResult[0] Then Return SetError($aResult[0], $aResult[0], -1)
	Return $aResult[2]
EndFunc   ;==>_GDIPlus_StringFormatGetMeasurableCharacterRangeCount

; #FUNCTION# ====================================================================================================================
; Author ........: Andreas Karlsson (monoceres)
; Modified.......:
; ===============================================================================================================================
Func _GDIPlus_StringFormatSetAlign($hStringFormat, $iFlag)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetStringFormatAlign", "handle", $hStringFormat, "int", $iFlag)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_StringFormatSetAlign

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: Eukalyptus
; ===============================================================================================================================
Func _GDIPlus_StringFormatSetMeasurableCharacterRanges($hStringFormat, $aRanges)
	Local $iCount = $aRanges[0][0]
	Local $tCharacterRanges = DllStructCreate("int[" & $iCount * 2 & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tCharacterRanges, 1, $aRanges[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tCharacterRanges, 1, $aRanges[$iI][1], (($iI - 1) * 2) + 2)
	Next
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetStringFormatMeasurableCharacterRanges", "handle", $hStringFormat, "int", $iCount, "struct*", $tCharacterRanges)
	If @error Then Return SetError(@error, @extended, False)
	Return SetExtended($aResult[0], $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_StringFormatSetMeasurableCharacterRanges

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_TextureCreate($hImage, $iWrapMode = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateTexture", "handle", $hImage, "int", $iWrapMode, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[3])
EndFunc   ;==>_GDIPlus_TextureCreate

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus_TextureCreate2($hImage, $fX, $fY, $fWidth, $fHeight, $iWrapMode = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateTexture2", "handle", $hImage, "int", $iWrapMode, "float", $fX, "float", $fY, "float", $fWidth, "float", $fHeight, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[7])
EndFunc   ;==>_GDIPlus_TextureCreate2

; #FUNCTION# ====================================================================================================================
; Author ........: Authenticity
; Modified.......: UEZ
; ===============================================================================================================================
Func _GDIPlus11_Startup()
	Local $tInput, $tToken, $aResult, $sGDIPDLL, $sVer
	$giGDIPRef += 1
	If $giGDIPRef > 1 Then Return True
	$sGDIPDLL = @ScriptDir & "\gdiplus.dll"
	If FileExists($sGDIPDLL) And @OSBuild < 6000 Then
		$sVer = FileGetVersion($sGDIPDLL)
		If $sVer < "6.0" Then Return SetError(10, 0, 0) ;For XP you need a GDIPlus.dll v1.1 in the script directory, refer to: http://www.winsxs.org/?OtherTech/thread-13-1-1
	Else
		Switch @OSBuild
			Case 0 To 2599
				Return SetError(1, 0, 0)
			Case 2600 To 4999
				Return SetError(2, 0, 0)
			Case 5000 To 7599
				$sGDIPDLL = @WindowsDir & "\winsxs\x86_microsoft.windows.gdiplus_6595b64144ccf1df_1.1.6000.16386_none_8df21b8362744ace\gdiplus.dll"
			Case Else
				$sGDIPDLL = @SystemDir & "\gdiplus.dll"
		EndSwitch
	EndIf
	$ghGDIPDll = DllOpen($sGDIPDLL)
	If @error Then Return SetError(3, 0, 0)
	$tInput = DllStructCreate($tagGDIPSTARTUPINPUT)
	$tToken = DllStructCreate("int Data")
	DllStructSetData($tInput, "Version", 1)
	$aResult = DllCall($ghGDIPDll, "int", "GdiplusStartup", "struct*", $tToken, "struct*", $tInput, "ptr", 0)
	If @error Then Return SetError(4, @extended, 0)
	$giGDIPToken = DllStructGetData($tToken, "Data")
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus11_Startup


; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __GDIPlus_BrushDefCreate
; Description ...: Create a default Brush object if needed
; Syntax.........: __GDIPlus_BrushDefCreate ( ByRef $hBrush )
; Parameters ....: $hBrush      - Handle to a Brush object
; Return values .: Success      - $hBrush or a default Brush object
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __GDIPlus_BrushDefCreate(ByRef $hBrush)
	If $hBrush = 0 Then
		$ghGDIPBrush = _GDIPlus_BrushCreateSolid()
		$hBrush = $ghGDIPBrush
	EndIf
EndFunc   ;==>__GDIPlus_BrushDefCreate

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __GDIPlus_BrushDefDispose
; Description ...: Free default Brush object
; Syntax.........: __GDIPlus_BrushDefDispose ( )
; Parameters ....:
; Return values .:
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __GDIPlus_BrushDefDispose()
	If $ghGDIPBrush <> 0 Then
		_GDIPlus_BrushDispose($ghGDIPBrush)
		$ghGDIPBrush = 0
	EndIf
EndFunc   ;==>__GDIPlus_BrushDefDispose

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __GDIPlus_ExtractFileExt
; Description ...: Extracts the extension part of the given filename
; Syntax.........: __GDIPlus_ExtractFileExt ( $sFileName [, $fNoDot = True] )
; Parameters ....: $sFileName   - Filename
;                  $fNoDot      - Determines whether the filename/extension separator is returned
;                  |True  - The separator is returned with the extension
;                  |False - The separator is not returned with the extension
; Return values .: Success      - Extension part
;                  Failure      - Empty string
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __GDIPlus_ExtractFileExt($sFileName, $fNoDot = True)
	Local $iIndex = __GDIPlus_LastDelimiter(".\:", $sFileName)
	If ($iIndex > 0) And (StringMid($sFileName, $iIndex, 1) = '.') Then
		If $fNoDot Then
			Return StringMid($sFileName, $iIndex + 1)
		Else
			Return StringMid($sFileName, $iIndex)
		EndIf
	Else
		Return ""
	EndIf
EndFunc   ;==>__GDIPlus_ExtractFileExt

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __GDIPlus_LastDelimiter
; Description ...: Returns the index of the right most whole character that matches any character in a delimiter string
; Syntax.........: __GDIPlus_LastDelimiter ( $sDelimiters, $sString )
; Parameters ....: $sDelimiters - Delimiters
;                  $String      - String to be searched
; Return values .: Success      - Right most whole character that matches one of the delimiters
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __GDIPlus_LastDelimiter($sDelimiters, $sString)
	Local $sDelimiter, $iN

	For $iI = 1 To StringLen($sDelimiters)
		$sDelimiter = StringMid($sDelimiters, $iI, 1)
		$iN = StringInStr($sString, $sDelimiter, 0, -1)
		If $iN > 0 Then Return $iN
	Next
EndFunc   ;==>__GDIPlus_LastDelimiter

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __GDIPlus_PenDefCreate
; Description ...: Create a default Pen object if needed
; Syntax.........: __GDIPlus_PenDefCreate ( ByRef $hPen )
; Parameters ....: $hPen        - Handle to a pen object
; Return values .: Success      - $hPen or a default pen object
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __GDIPlus_PenDefCreate(ByRef $hPen)
	If $hPen = 0 Then
		$ghGDIPPen = _GDIPlus_PenCreate()
		$hPen = $ghGDIPPen
	EndIf
EndFunc   ;==>__GDIPlus_PenDefCreate

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __GDIPlus_PenDefDispose
; Description ...: Free default Pen object
; Syntax.........: __GDIPlus_PenDefDispose ( )
; Parameters ....:
; Return values .:
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __GDIPlus_PenDefDispose()
	If $ghGDIPPen <> 0 Then
		_GDIPlus_PenDispose($ghGDIPPen)
		$ghGDIPPen = 0
	EndIf
EndFunc   ;==>__GDIPlus_PenDefDispose

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __GDIPlus_BitmapCreateDIBFromBitmap
; Description ...: Creates a 32 bit GDI bitmap v5 using a GDI+ bitmap as source
; Syntax ........: __GDIPlus_BitmapCreateDIBFromBitmap($hBitmap)
; Parameters ....: $hBitmap             - A handle to a GDI+ bitmap
; Return values .: success - A handle to a DIB bitmap, failure  - 0
; Remarks .......: After you are done with the object, call _GDIPlus_BitmapDispose or _WinAPI_DeleteObject to release
; the object resources
; Author ........: UEZ
; Modified ......:
; Related .......: _WinAPI_CreateDIBSection _WinAPI_SetBitmapBits _GDIPlus_BitmapLockBits _GDIPlus_BitmapUnlockBits
; Link ..........: @@MsdnLink@@ CreateDIBSection SetBitmapBits
; Example .......: No
; ===============================================================================================================================
Func __GDIPlus_BitmapCreateDIBFromBitmap($hBitmap)
	Local $tBIHDR, $aRet, $tData, $pBits, $hHBitmapv5 = 0
	$aRet = DllCall($ghGDIPDll, "uint", "GdipGetImageDimension", "handle", $hBitmap, "float*", 0, "float*", 0)
	If @error Or $aRet[0] Then Return 0
	$tData = _GDIPlus_BitmapLockBits($hBitmap, 0, 0, $aRet[2], $aRet[3], $GDIP_ILMREAD, $GDIP_PXF32ARGB)
	$pBits = DllStructGetData($tData, "Scan0")
	If Not $pBits Then Return 0
	$tBIHDR = DllStructCreate("dword bV5Size;long bV5Width;long bV5Height;word bV5Planes;word bV5BitCount;dword bV5Compression;" & _ ;http://msdn.microsoft.com/en-us/library/windows/desktop/dd183381(v=vs.85).aspx
			"dword bV5SizeImage;long bV5XPelsPerMeter;long bV5YPelsPerMeter;dword bV5ClrUsed;dword bV5ClrImportant;" & _
			"dword bV5RedMask;dword bV5GreenMask;dword bV5BlueMask;dword bV5AlphaMask;dword bV5CSType;" & _
			"int bV5Endpoints[3];dword bV5GammaRed;dword bV5GammaGreen;dword bV5GammaBlue;dword bV5Intent;" & _
			"dword bV5ProfileData;dword bV5ProfileSize;dword bV5Reserved")
	DllStructSetData($tBIHDR, "bV5Size", DllStructGetSize($tBIHDR))
	DllStructSetData($tBIHDR, "bV5Width", $aRet[2])
	DllStructSetData($tBIHDR, "bV5Height", $aRet[3])
	DllStructSetData($tBIHDR, "bV5Planes", 1)
	DllStructSetData($tBIHDR, "bV5BitCount", 32)
	DllStructSetData($tBIHDR, "bV5Compression", 0) ; $BI_BITFIELDS = 3, $BI_RGB = 0, $BI_RLE8 = 1, $BI_RLE4 = 2, $RGBA = 0x41424752
	DllStructSetData($tBIHDR, "bV5SizeImage", $aRet[3] * DllStructGetData($tData, "Stride"))
	DllStructSetData($tBIHDR, "bV5AlphaMask", 0xFF000000)
	DllStructSetData($tBIHDR, "bV5RedMask", 0x00FF0000)
	DllStructSetData($tBIHDR, "bV5GreenMask", 0x0000FF00)
	DllStructSetData($tBIHDR, "bV5BlueMask", 0x000000FF)
	DllStructSetData($tBIHDR, "bV5CSType", 2) ; $LCS_WINDOWS_COLOR_SPACE = 2
	DllStructSetData($tBIHDR, "bV5Intent", 4) ; $LCS_GM_IMA = 4
	$hHBitmapv5 = DllCall("gdi32.dll", "ptr", "CreateDIBSection", "hwnd", 0, "struct*", $tBIHDR, "uint", 0, "ptr*", 0, "ptr", 0, "dword", 0)
	If Not @error And $hHBitmapv5[0] Then
		DllCall("gdi32.dll", "dword", "SetBitmapBits", "ptr", $hHBitmapv5[0], "dword", $aRet[2] * $aRet[3] * 4, "ptr", DllStructGetData($tData, "Scan0"))
		$hHBitmapv5 = $hHBitmapv5[0]
	Else
		$hHBitmapv5 = 0
	EndIf
	_GDIPlus_BitmapUnlockBits($hBitmap, $tData)
	$tData = 0
	$tBIHDR = 0
	Return $hHBitmapv5
EndFunc   ;==>__GDIPlus_BitmapCreateDIBFromBitmap
