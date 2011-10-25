#include <WinApiEx.au3>

Opt('MustDeclareVars ', 1)


If Not _WinAPI_DwmIsCompositionEnabled() Then
	msgbox(16, 'Error ', 'Require Windows Vista or above with enabled Aero theme.')
	Exit
EndIf

Global $Color, $Blend

$Color = _WinAPI_DwmGetColorizationColor()
$Blend = @extended

msgbox('', 'Color for glass composition ', 'Color: 0x' & Hex($Color) & @CRLF & _
		' Transparency:' & (Not $Blend))

