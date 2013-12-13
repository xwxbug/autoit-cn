#include <WinAPIShellEx.au3>
#include <WinAPISys.au3>
#include <MsgBoxConstants.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

Local $Data = _WinAPI_ShellGetLocalizedName(@MyDocumentsDir)
If Not IsArray($Data) Then
	Exit
EndIf

Local $hModule = _WinAPI_LoadLibraryEx($Data[0], $LOAD_LIBRARY_AS_DATAFILE)
ConsoleWrite('Path: ' & $Data[0] & @CRLF)
ConsoleWrite('ID:   ' & $Data[1] & @CRLF)
ConsoleWrite('Name: ' & _WinAPI_LoadString($hModule, $Data[1]) & @CRLF)
_WinAPI_FreeLibrary($hModule)
