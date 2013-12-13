#include <WinAPIGdi.au3>
#include <MsgBoxConstants.au3>

If Not _WinAPI_DwmIsCompositionEnabled() Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later with enabled Aero theme.')
	Exit
EndIf

Local $Color = _WinAPI_DwmGetColorizationColor()
Local $Blend = @extended

ConsoleWrite('Color for glass composition: 0x' & Hex($Color) & @CRLF)
ConsoleWrite('Transparency: ' & (Not $Blend) & @CRLF)
