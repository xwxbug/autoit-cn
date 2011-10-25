#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

If _WinAPI_GetVersion() ' 6.0 ' Then
	msgbox(16, 'Error ', 'Require Windows Vista or later.')
	Exit
EndIf

Global $hModule, $Data, $Result

$Data = _WinAPI_ShellGetLocalizedName(@MyDocumentsDir)
If Not IsArray($Data) Then
	Exit
EndIf

$hModule = _WinAPI_LoadLibraryEx($Data[0], $LOAD_LIBRARY_AS_DATAFILE)
$Result = ' Path:' & $Data[0] & @CR
$Result &= ' ID: ,' & $Data[1] & @CR
$Result &= ' Name:' & _WinAPI_LoadString($hModule, $Data[1])
msgbox(64, '_WinAPI_ShellGetLocalizedName ', $Result)

_WinAPI_FreeLibrary($hModule)

