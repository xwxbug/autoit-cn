#include <WinAPIMisc.au3>

Local $bData = Binary('0x00112233445566778899AABBCCDDEEFF00112233445566778899AABBCCDDEEFF00112233445566778899AABBCCDDEEFF00112233445566778899AABBCCDDEEFF')
Local $iSize = BinaryLen($bData)
Local $tData = DllStructCreate('byte[' & $iSize & ']')
Local $pData = DllStructGetPtr($tData)
DllStructSetData($tData, 1, $bData)

ConsoleWrite(_WinAPI_HashData($pData, $iSize) & @CRLF)
