#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

_Example()

Func _Example()
	If Not _GDIPlus_Startup() Then
		MsgBox($MB_SYSTEMMODAL, "ERROR", "GDIPlus.dll v1.1 not available")
		Return
	EndIf

	Local $sFile = FileOpenDialog("Select an image", "", "Images (*.bmp;*.png;*.jpg;*.gif;*.tif)")
	If @error Or Not FileExists($sFile) Then Return

	Local $hImage = _GDIPlus_ImageLoadFromFile($sFile)

	Local $hEffect = _GDIPlus_EffectCreateBlur()

	Local $tRect = DllStructCreate($tagRECT)
	Local $hBitmap = _GDIPlus_BitmapCreateApplyEffect($hImage, $hEffect, Null, $tRect)

	Local $iBmpW = $tRect.Right - $tRect.Left
	Local $iBmpH = $tRect.Bottom - $tRect.Top

	Local $iWidth = 600
	Local $iHeight = $iBmpH * 600 / $iBmpW

	Local $hGui = GUICreate("GDI+ v1.1", $iWidth, $iHeight)
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGui)
	GUISetState()

	_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	_GDIPlus_EffectDispose($hEffect)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>_Example
