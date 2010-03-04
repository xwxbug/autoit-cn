#Include <Array.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global $Data = _WinAPI_EnumSystemLocales($LCID_INSTALLED)

If IsArray($Data) Then
	_ArrayDisplay($Data, '_WinAPI_EnumSystemLocales')
EndIf
