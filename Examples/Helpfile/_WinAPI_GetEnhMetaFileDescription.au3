#include <WinAPIGdi.au3>

Local $hEmf = _WinAPI_GetEnhMetaFile(@ScriptDir & '\Extras\Flag.emf')
Local $Data = _WinAPI_GetEnhMetaFileDescription($hEmf)
_WinAPI_DeleteEnhMetaFile($hEmf)

ConsoleWrite('Application: ' & $Data[0] & @CRLF)
ConsoleWrite('Picture:     ' & $Data[1] & @CRLF)
