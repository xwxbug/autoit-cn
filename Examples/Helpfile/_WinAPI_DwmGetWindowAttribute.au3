#include <WinAPIGdi.au3>
#include <APIGdiConstants.au3>
#include <MsgBoxConstants.au3>

If Not _WinAPI_DwmIsCompositionEnabled() Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later with enabled Aero theme.')
	Exit
EndIf

Run(@SystemDir & '\calc.exe')
Local $hWnd = WinWaitActive("[CLASS:CalcFrame]", '', 3)
If Not $hWnd Then
	Exit
EndIf

Local $Pos = _WinAPI_GetPosFromRect(_WinAPI_DwmGetWindowAttribute($hWnd, $DWMWA_EXTENDED_FRAME_BOUNDS))

ConsoleWrite('Left:   ' & $Pos[0] & @CRLF)
ConsoleWrite('Top:    ' & $Pos[1] & @CRLF)
ConsoleWrite('Width:  ' & $Pos[2] & @CRLF)
ConsoleWrite('Height: ' & $Pos[3] & @CRLF)
