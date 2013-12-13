#include <WinAPIFiles.au3>

Local $Data, $Drive = 0

While 1
	$Data = _WinAPI_GetDriveGeometryEx($Drive)
	If @error Then
		ExitLoop
	EndIf
	If Not $Drive Then
		ConsoleWrite('-------------------------------' & @CRLF)
	EndIf
	ConsoleWrite('Drive: ' & $Drive & @CRLF)
	ConsoleWrite('Cylinders: ' & $Data[0] & @CRLF)
	ConsoleWrite('Tracks per Cylinder: ' & $Data[2] & @CRLF)
	ConsoleWrite('Sectors per Track: ' & $Data[3] & @CRLF)
	ConsoleWrite('Bytes per Sector: ' & $Data[4] & @CRLF)
	ConsoleWrite('Total Space: ' & $Data[5] & ' bytes' & @CRLF)
	ConsoleWrite('-------------------------------' & @CRLF)
	$Drive += 1
WEnd
