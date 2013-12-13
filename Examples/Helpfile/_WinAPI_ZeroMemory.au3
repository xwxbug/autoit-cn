#include <WinAPISys.au3>

Local $tStruct = DllStructCreate('byte[8]')
ConsoleWrite(DllStructGetData($tStruct, 1) & @CRLF)

_WinAPI_FillMemory(DllStructGetPtr($tStruct), 8, 0xAB)
ConsoleWrite(DllStructGetData($tStruct, 1) & @CRLF)

_WinAPI_ZeroMemory(DllStructGetPtr($tStruct), 8)
ConsoleWrite(DllStructGetData($tStruct, 1) & @CRLF)
