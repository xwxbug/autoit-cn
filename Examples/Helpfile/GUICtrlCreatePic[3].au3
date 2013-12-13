; PNG work around by Zedna

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GDIPlus.au3>
#include <WinAPI.au3>

Global $hGUI, $hImage, $hGraphic, $hImage1

; Create GUI
$hGUI = GUICreate("Show PNG", 250, 250)

; Load PNG image
_GDIPlus_Startup()
$hImage = _GDIPlus_ImageLoadFromFile("..\GUI\Torus.png")
$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)

GUIRegisterMsg($WM_PAINT, "MY_WM_PAINT")
GUISetState()

; Loop until user exits
Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

; Clean up resources
_GDIPlus_GraphicsDispose($hGraphic)
_GDIPlus_ImageDispose($hImage)
_GDIPlus_Shutdown()

; Draw PNG image
Func MY_WM_PAINT($hWnd, $msg, $wParam, $lParam)
	#forceref $hWnd, $Msg, $wParam, $lParam
	_WinAPI_RedrawWindow($hGUI, 0, 0, $RDW_UPDATENOW)
	_GDIPlus_GraphicsDrawImage($hGraphic, $hImage, 0, 0)
	_WinAPI_RedrawWindow($hGUI, 0, 0, $RDW_VALIDATE)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>MY_WM_PAINT
