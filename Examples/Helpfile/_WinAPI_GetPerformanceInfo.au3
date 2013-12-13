#include <WinAPISys.au3>

Local $Data = _WinAPI_GetPerformanceInfo()

ConsoleWrite('Physical Memory (MB)' & @CRLF)
ConsoleWrite('--------------------' & @CRLF)
ConsoleWrite('Total:     ' & Floor($Data[3] / 1024 / 1024) & @CRLF)
ConsoleWrite('Available: ' & Floor($Data[4] / 1024 / 1024) & @CRLF)
ConsoleWrite('Cached:    ' & Floor($Data[5] / 1024 / 1024) & @CRLF)
ConsoleWrite('Free:      ' & Floor($Data[6] / 1024 / 1024) & @CRLF)

ConsoleWrite(@CRLF)

ConsoleWrite('Kernel Memory (MB)' & @CRLF)
ConsoleWrite('--------------------' & @CRLF)
ConsoleWrite('Paged:     ' & Floor($Data[7] / 1024 / 1024) & @CRLF)
ConsoleWrite('Nonpaged:  ' & Floor($Data[8] / 1024 / 1024) & @CRLF)

ConsoleWrite(@CRLF)

ConsoleWrite('System' & @CRLF)
ConsoleWrite('--------------------' & @CRLF)
ConsoleWrite('Handles:   ' & $Data[10] & @CRLF)
ConsoleWrite('Processes: ' & $Data[11] & @CRLF)
ConsoleWrite('Threads:   ' & $Data[12] & @CRLF)
