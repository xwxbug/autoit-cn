#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiConstantsEx.au3>
#include <WinAPI.au3>
#include <GuiImageList.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hImage, $hGUI, $hDC
	
	$hGUI = GUICreate("ImageList DrawEx", 400, 300)
	GUISetState()
	
	; Load images
	$hImage = _GUIImageList_Create(32, 24)
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hGUI, 0xFF0000, 32, 24))
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hGUI, 0x00FF00, 32, 24))
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hGUI, 0x0000FF, 32, 24))

	; Draw images
	$hDC = _WinAPI_GetDC($hGUI)
	_GUIImageList_DrawEx($hImage, 0, $hDC, 4, 4)
	_GUIImageList_DrawEx($hImage, 1, $hDC, 40, 4)
	_GUIImageList_DrawEx($hImage, 2, $hDC, 76, 4)

	_WinAPI_ReleaseDC($hGUI, $hDC)

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main