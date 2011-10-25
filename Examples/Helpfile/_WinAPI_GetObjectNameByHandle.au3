#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $hFile

$hFile = _WinAPI_CreateFile(@ScriptFullPath, 2, 0, 6)

msgbox(0, 'Result ', 'Handle:' & $hFile & @CRLF & ' Type:' & _WinAPI_GetObjectNameByHandle($hFile))

_WinAPI_CloseHandle($hFile)

