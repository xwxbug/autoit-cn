#include <Array.au3>
#include <WinApiEx.au3>

Opt('MustDeclareVars ', 1)

Global $Drivers = _WinAPI_EnumDeviceDrivers(), $Data

If IsArray($Drivers) Then
	Dim $Data[$Drivers[0]][3]
	For $i = 1 To $Drivers[0]
		$Data[$i - 1][0] = $Drivers[$i]
		$Data[$i - 1][1] = _WinAPI_GetDeviceDriverBaseName($Drivers[$i])
		$Data[$i - 1][2] = _WinAPI_GetDeviceDriverFileName($Drivers[$i])
	Next
	_arraydisplay($Data, '_WinAPI_EnumDeviceDrivers')
	RndIf


;### Tidy Error -> if is never closed in your script.
