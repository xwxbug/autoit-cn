#include <WinAPIMisc.au3>

Local $Val[5] = [532, 1340, 23506, 2400016, 2400000000]

For $i = 0 To 4
	ConsoleWrite(StringFormat('%10s %19s', $Val[$i], _WinAPI_StrFormatByteSizeEx($Val[$i])) & @CRLF)
Next
