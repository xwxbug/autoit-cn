#include <WinAPITheme.au3>
#include <APIThemeConstants.au3>

Local $Data = _WinAPI_GetCurrentThemeName()
If IsArray($Data) Then
	ConsoleWrite('File:    ' & $Data[0] & @CRLF)
	ConsoleWrite('Color:   ' & $Data[1] & @CRLF)
	ConsoleWrite('Size:    ' & $Data[2] & @CRLF)
	ConsoleWrite('Name:    ' & _WinAPI_GetThemeDocumentationProperty($Data[0], $SZ_THDOCPROP_CANONICALNAME) & @CRLF)
	ConsoleWrite('Display: ' & _WinAPI_GetThemeDocumentationProperty($Data[0], $SZ_THDOCPROP_DISPLAYNAME) & @CRLF)
	ConsoleWrite('Tooltip: ' & _WinAPI_GetThemeDocumentationProperty($Data[0], $SZ_THDOCPROP_TOOLTIP) & @CRLF)
	ConsoleWrite('Author:  ' & _WinAPI_GetThemeDocumentationProperty($Data[0], $SZ_THDOCPROP_AUTHOR) & @CRLF)
EndIf
