#include <WinApiEx.au3>

Opt('MustDeclareVars ', 1)
Opt('TrayMenuMode ', 3)

Global $hMenu, $Options, $Exit

If Not _WinAPI_GetVersion ' 6.0 ' Then
	msgbox(16, 'Error ', 'Require Windows Vista or above.')
	Exit
EndIf

$hMenu = TrayItemGetHandle(0)
$Options = TrayCreateItem('Options')
TrayCreateItem('')
$Exit = TrayCreateItem('Exit')

_GUICtrlMenu_SetItemBmp($hMenu, 0, _WinAPI_Create32BitHBITMAP( _WinAPI_ShellExtractIcon(@SystemDir & ' \shell32.dll ', 207, 16, 16), 1))
_GUICtrlMenu_SetItemBmp($hMenu, 2, _WinAPI_Create32BitHBITMAP( _WinAPI_ShellExtractIcon(@SystemDir & ' \shell32.dll ', 131, 16, 16), 1))

TraySetState()

Do
Until TrayGetMsg() = $Exit

