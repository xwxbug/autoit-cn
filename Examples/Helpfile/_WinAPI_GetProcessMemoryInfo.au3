#include <WinAPIProc.au3>

Local $Data = _WinAPI_GetProcessMemoryInfo()

ConsoleWrite('Number of page faults: ' & $Data[0] & @CRLF)
ConsoleWrite('Peak working set size: ' & $Data[1] & ' bytes' & @CRLF)
ConsoleWrite('Current working set size: ' & $Data[2] & ' bytes' & @CRLF)
ConsoleWrite('Peak paged pool usage: ' & $Data[3] & ' bytes' & @CRLF)
ConsoleWrite('Current paged pool usage: ' & $Data[4] & ' bytes' & @CRLF)
ConsoleWrite('Peak nonpaged pool usage: ' & $Data[5] & ' bytes' & @CRLF)
ConsoleWrite('Current nonpaged pool usage: ' & $Data[6] & ' bytes' & @CRLF)
ConsoleWrite('Current space allocated for the pagefile: ' & $Data[7] & ' bytes' & @CRLF)
ConsoleWrite('Peak space allocated for the pagefile: ' & $Data[8] & ' bytes' & @CRLF)
ConsoleWrite('Current private space: ' & $Data[9] & ' bytes' & @CRLF)
