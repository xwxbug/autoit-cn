#include <WinAPIFiles.au3>

Local $Data = _WinAPI_GetVolumeInformation()

ConsoleWrite('Volume name: ' & $Data[0] & @CRLF)
ConsoleWrite('File system: ' & $Data[4] & @CRLF)
ConsoleWrite('Serial number: ' & $Data[1] & @CRLF)
ConsoleWrite('File name length: ' & $Data[2] & @CRLF)
ConsoleWrite('Flags: 0x' & Hex($Data[3]) & @CRLF)
