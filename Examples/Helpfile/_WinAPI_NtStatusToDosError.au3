#include <WinAPIDiag.au3>

Local $Error = _WinAPI_NtStatusToDosError(0xC0000023) ; STATUS_BUFFER_TOO_SMALL

ConsoleWrite($Error & ' - ' & _WinAPI_GetErrorMessage($Error) & @CRLF)
