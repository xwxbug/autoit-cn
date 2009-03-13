#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>
#include <WinAPI.au3>


Opt('MustDeclareVars', 1)

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $hBitmap, $hImage, $aRet

	; Create GUI
	$hGUI = GUICreate("GDI+", 600, 400)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; Initialize GDI+ library
	_GDIPlus_Startup()

	; Capture 32 bit bitmap
	$hBitmap = _ScreenCapture_Capture("")
	$hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)
	
	; Show image format for screen capture
	$aRet = _GDIPlus_ImageGetRawFormat($hImage)
	MemoWrite("Image format of screen capture: " & $aRet[1]);
	MemoWrite("GUID: " & $aRet[0]);
	MemoWrite();
	
	; Save screen capture bitmap to file
	_GDIPlus_ImageSaveToFile($hImage, @MyDocumentsDir & "\GDIPlus_Image.jpg")
	
	; Clean up resources
	_GDIPlus_ImageDispose($hImage)
	_WinAPI_DeleteObject($hBitmap)
	
	; Load screen capture bitmap from file
	$hImage = _GDIPlus_ImageLoadFromFile(@MyDocumentsDir & "\GDIPlus_Image.jpg")
	
	; Show image format for saved file
	$aRet = _GDIPlus_ImageGetRawFormat($hImage)
	MemoWrite("Image format of saved file: " & $aRet[1]);
	MemoWrite("GUID: " & $aRet[0]);
	
	; Clean up resources
	_GDIPlus_ImageDispose($hImage)

	; Shut down GDI+ library
	_GDIPlus_Shutdown()

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

EndFunc   ;==>_Main

; Write a line to the memo control
Func MemoWrite($sMessage = '')
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite