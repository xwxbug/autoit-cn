#Include <Array.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Data = _WinAPI_EnumProcessWindows(0, 0)

If IsArray($Data) Then
	_arraydisplay($Data, '_WinAPI_EnumProcessWindows')
EndIf

