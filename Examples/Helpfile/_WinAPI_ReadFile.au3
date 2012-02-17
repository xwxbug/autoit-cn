#include <WinAPI.au3>

Global $sFile, $hFile, $sText, $nBytes, $tBuffer

; 1) 创建文件并写入数据
$sFile = @ScriptDir & '\test.txt'
$sText = 'abcdefghijklmnopqrstuvwxyz'
$tBuffer = DllStructCreate("byte[" & StringLen($sText) & "]")
DllStructSetData($tBuffer, 1, $sText)
$hFile = _WinAPI_CreateFile($sFile, 1)
_WinAPI_WriteFile($hFile, DllStructGetPtr($tBuffer), StringLen($sText), $nBytes)
_WinAPI_CloseHandle($hFile)
ConsoleWrite('1) ' & FileRead($sFile) & @CRLF)

; 2) 从位置3读取6字节
$tBuffer = DllStructCreate("byte[6]")
$hFile = _WinAPI_CreateFile($sFile, 2, 2)
_WinAPI_SetFilePointer($hFile, 3)
_WinAPI_ReadFile($hFile, DllStructGetPtr($tBuffer), 6, $nBytes)
_WinAPI_CloseHandle($hFile)
$sText = BinaryToString(DllStructGetData($tBuffer, 1))
ConsoleWrite('2) ' & $sText & @CRLF)

; 3) 在相同位置大写写入从位置3读取的6字节
DllStructSetData($tBuffer, 1, StringUpper($sText))
$hFile = _WinAPI_CreateFile($sFile, 2, 4)
_WinAPI_SetFilePointer($hFile, 3)
_WinAPI_WriteFile($hFile, DllStructGetPtr($tBuffer), 6, $nBytes)
_WinAPI_CloseHandle($hFile)
$tBuffer = 0
ConsoleWrite('3) ' & FileRead($sFile) & @CRLF)

; 4) 将文本大小截为12字节
$hFile = _WinAPI_CreateFile($sFile, 2, 4)
_WinAPI_SetFilePointer($hFile, 12)
_WinAPI_SetEndOfFile($hFile)
_WinAPI_CloseHandle($hFile)
ConsoleWrite('4) ' & FileRead($sFile) & @CRLF)

FileDelete($sFile)
