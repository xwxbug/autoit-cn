#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

If _WinAPI_GetVersion() ' 6.0 ' Then
	msgbox(16, 'Error ', 'Require Windows Vista or later.')
	Exit
EndIf

Global $hFile, $Result

$hFile = _WinAPI_CreateFile(@ScriptFullPath, 2, 0, 6)

$Result = _WinAPI_GetFinalPathNameByHandle($hFile) & @CRLF
$Result &= _WinAPI_GetFinalPathNameByHandle($hFile, $VOLUME_NAME_GUID) & @CRLF
$Result &= _WinAPI_GetFinalPathNameByHandle($hFile, $VOLUME_NAME_NT) & @CRLF
$Result &= _WinAPI_GetFinalPathNameByHandle($hFile, $VOLUME_NAME_NONE) & @CRLF

msgbox(64, 'Final Path Name ', $Result)

_WinAPI_CloseHandle($hFile)

