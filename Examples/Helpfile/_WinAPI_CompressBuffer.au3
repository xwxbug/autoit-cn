#include <WinAPISys.au3>
#include <APISysConstants.au3>

; Create compressed and uncompressed buffers
Local $pBuffer[2]
For $i = 0 To 1
	$pBuffer[$i] = _WinAPI_CreateBuffer(1024)
Next

; Compress binary data
Local $Data = Binary('0x00112233445566778899AABBCCDDEEFF00112233445566778899AABBCCDDEEFF00112233445566778899AABBCCDDEEFF00112233445566778899AABBCCDDEEFF')
Local $Size = BinaryLen($Data)
DllStructSetData(DllStructCreate('byte[' & $Size & ']', $pBuffer[0]), 1, $Data)
$Size = _WinAPI_CompressBuffer($pBuffer[0], $Size, $pBuffer[1], 1024, BitOR($COMPRESSION_FORMAT_LZNT1, $COMPRESSION_ENGINE_MAXIMUM))
If Not @error Then
	ConsoleWrite('Compressed:   ' & DllStructGetData(DllStructCreate('byte[' & $Size & ']', $pBuffer[1]), 1) & @CRLF)
EndIf

; Decompress data
$Size = _WinAPI_DecompressBuffer($pBuffer[0], 1024, $pBuffer[1], $Size)
If Not @error Then
	ConsoleWrite('Uncompressed: ' & DllStructGetData(DllStructCreate('byte[' & $Size & ']', $pBuffer[0]), 1) & @CRLF)
EndIf

; Free memory
For $i = 0 To 1
	_WinAPI_FreeMemory($pBuffer[$i])
Next
