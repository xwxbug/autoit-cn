#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hGUI, $hBitmap, $hGraphic, $hImage, $iX, $iY, $hClone

	; Create GUI
	$hGUI = GUICreate("GDI+", 400, 300)
	GUISetState()

	; Initialize GDI+ library
	_GDIPlus_Startup ()

	; Capture 32 bit bitmap
	$hBitmap = _ScreenCapture_Capture ("")
	$hImage = _GDIPlus_BitmapCreateFromHBITMAP ($hBitmap)

	; Create 24 bit bitmap clone
	$iX = _GDIPlus_ImageGetWidth ($hImage)
	$iY = _GDIPlus_ImageGetHeight ($hImage)
	$hClone = _GDIPlus_BitmapCloneArea ($hImage, 0, 0, $iX, $iY, $GDIP_PXF24RGB)

	; Save bitmap to file
	_GDIPlus_ImageSaveToFile ($hClone, @MyDocumentsDir & "\GDIPlus_Image.bmp")

	; Clean up resources
	_GDIPlus_ImageDispose ($hClone)
	_GDIPlus_ImageDispose ($hImage)
	_WinAPI_DeleteObject ($hBitmap)

	; Draw bitmap to GUI
	$hBitmap = _GDIPlus_BitmapCreateFromFile (@MyDocumentsDir & "\GDIPlus_Image.bmp")
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND ($hGUI)
	_GDIPlus_GraphicsDrawImage ($hGraphic, $hBitmap, 0, 0)

	; Clean up resources
	_GDIPlus_GraphicsDispose ($hGraphic)
	_GDIPlus_ImageDispose ($hBitmap)
	_WinAPI_DeleteObject ($hBitmap)

	; Shut down GDI+ library
	_GDIPlus_ShutDown ()

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE


EndFunc   ;==>_Main