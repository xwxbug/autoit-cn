#include <WinAPIMisc.au3>

Local $Val[3] = [23506, 2400016, 2400000000]

For $i = 0 To 2
	ConsoleWrite(StringFormat('%10s %12s', $Val[$i], _WinAPI_StrFormatKBSize($Val[$i])) & @CRLF)
Next
