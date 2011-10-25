#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

If Not _WinAPI_SetDllDirectory(@TempDir) Then
	Exit
EndIf

span class = S5 > Global $hModule = _WinAPI_LoadLibraryEx(', Resources.dll ', $LOAD_LIBRARY_AS_DATAFILE)

msgbox(6 4, 'DllDirectory ', _WinAPI_GetDllDirectory() & @CRLF & $hModule)

_WinAPI_FreeLibrary($hModule)

