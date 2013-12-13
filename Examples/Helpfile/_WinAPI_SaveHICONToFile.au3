#include <WinAPIGdi.au3>
#include <WinAPIShellEx.au3>

Global $Icon[3] = [48, 32, 16]

For $i = 0 To UBound($Icon) - 1
	$Icon[$i] = _WinAPI_Create32BitHICON(_WinAPI_ShellExtractIcon(@SystemDir & '\shell32.dll', 32, $Icon[$i], $Icon[$i]), 1)
Next
_WinAPI_SaveHICONToFile(@TempDir & '\MyIcon.ico', $Icon)
For $i = 0 To UBound($Icon) - 1
	_WinAPI_DestroyIcon($Icon[$i])
Next
