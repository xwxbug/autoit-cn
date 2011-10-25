#include <WinApiEx.au3>

Opt('MustDeclareVars ', 1)


If Not _WinAPI_GetVersion ' 6.0 ' Then
	msgbox(16, 'Error ', 'Require Windows Vista or above.')
	Exit
EndIf

Dim $States = [' Disabled ', 'Enabled ']

msgbox('', 'Aero ', $States[_WinAPI_DwmIsCompositionEnabled()]

