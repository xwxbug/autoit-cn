#include <WinAPIFiles.au3>

Local $Data = _WinAPI_GetDiskFreeSpaceEx(@HomeDrive)

ConsoleWrite('Total available free space on ' & @HomeDrive & ' => ' & $Data[0] & ' bytes' & @CRLF)
ConsoleWrite('Total available space on ' & @HomeDrive & ' => ' & $Data[1] & ' bytes' & @CRLF)
ConsoleWrite('Total free space on ' & @HomeDrive & ' => ' & $Data[2] & ' bytes' & @CRLF)
