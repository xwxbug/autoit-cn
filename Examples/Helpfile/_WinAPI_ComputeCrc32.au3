#include <WinAPISys.au3>

Local $tData = DllStructCreate('byte[4096]')
Local $pData = DllStructGetPtr($tData)

ConsoleWrite(Hex(_WinAPI_ComputeCrc32($pData, 4096)) & @CRLF)

_WinAPI_FillMemory($pData, 4096, Random(0, 255, 1))

ConsoleWrite(Hex(_WinAPI_ComputeCrc32($pData, 4096)) & @CRLF)

_WinAPI_ZeroMemory($pData, 4096)

ConsoleWrite(Hex(_WinAPI_ComputeCrc32($pData, 4096)) & @CRLF & @CRLF)

ConsoleWrite('Invalid pointer -> ' & _WinAPI_ComputeCrc32(0, 4) & ' @error = ' & @error & ' @extended = 0x' & Hex(@extended) & @CRLF)
