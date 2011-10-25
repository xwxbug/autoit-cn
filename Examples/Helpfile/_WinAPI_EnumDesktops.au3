#Include <Array.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Data = _WinAPI_EnumDesktops( _WinAPI_GetProcessWindowStation())

_arraydisplay($Data, '_WinAPI_EnumDesktops')

