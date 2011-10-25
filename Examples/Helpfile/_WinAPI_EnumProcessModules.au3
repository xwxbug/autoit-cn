#Include <Array.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Data = _WinAPI_EnumProcessModules()

If IsArray($Data) Then
	_arraydisplay($Data, '_WinAPI_EnumProcessModules')
EndIf

