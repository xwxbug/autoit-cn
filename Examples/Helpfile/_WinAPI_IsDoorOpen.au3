#include <WinAPIFiles.au3>

Local $Drive = DriveGetDrive('CDROM')

If IsArray($Drive) Then
	ConsoleWrite('Open...' & @CRLF)
	_WinAPI_EjectMedia($Drive[1])
	ConsoleWrite('Tray is open: ' & _WinAPI_IsDoorOpen($Drive[1]) & @CRLF)
	Sleep(1000)
	ConsoleWrite('Close...' & @CRLF)
	_WinAPI_LoadMedia($Drive[1])
	ConsoleWrite('Tray is open: ' & _WinAPI_IsDoorOpen($Drive[1]) & @CRLF)
EndIf
