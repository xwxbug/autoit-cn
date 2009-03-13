#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hGUI, $hWnd, $hGraphic

	; Create GUI
	$hGUI = GUICreate("GDI+", 400, 300)
	$hWnd = WinGetHandle("GDI+")
	GUISetState()

	; Draw a Bezier curve
	_GDIPlus_Startup ()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND ($hWnd)

	_GDIPlus_GraphicsDrawBezier ($hGraphic, 50, 50, 100, 5, 125, 25, 250, 50)

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_GraphicsDispose ($hGraphic)
	_GDIPlus_Shutdown ()

EndFunc   ;==>_Main