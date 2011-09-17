#Include <APIConstants.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

If Not _WinAPI_SetDllDirectory(@ScriptDir & '\Extras') Then
	Exit
EndIf

Global $hModule = _WinAPI_LoadLibraryEx('Resources.dll', $LOAD_LIBRARY_AS_DATAFILE)

ConsoleWrite(_WinAPI_GetDllDirectory() & @CR)
ConsoleWrite($hModule & @CR)

_WinAPI_FreeLibrary($hModule)
