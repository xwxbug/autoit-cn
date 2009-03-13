#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $hGUI, $hWnd, $hGraphic, $hPen, $hEndCap

	; Create GUI
	$hGUI = GUICreate("GDI+", 400, 300)
	$hWnd = WinGetHandle("GDI+")
	GUISetState()

	; Create resources
	_GDIPlus_Startup ()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND ($hWnd)
	$hPen = _GDIPlus_PenCreate (0xFF000000, 4)
	$hEndCap = _GDIPlus_ArrowCapCreate (4, 6)

	; Show fill state
	MsgBox(4096, "Information", "Fill state: " & _GDIPlus_ArrowCapGetFillState($hEndCap))

	; Draw arrow 1
	_GDIPlus_PenSetCustomEndCap($hPen, $hEndCap)
	_GDIPlus_GraphicsDrawLine($hGraphic, 10, 130, 390, 130, $hPen)

	; Draw arrow 2
	_GDIPlus_ArrowCapSetFillState($hEndCap, False)
	_GDIPlus_PenSetCustomEndCap($hPen, $hEndCap)
	_GDIPlus_GraphicsDrawLine($hGraphic, 10, 160, 390, 160, $hPen)

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_ArrowCapDispose ($hEndCap)
	_GDIPlus_PenDispose ($hPen)
	_GDIPlus_GraphicsDispose ($hGraphic)
	_GDIPlus_Shutdown ()
EndFunc   ;==>_Main