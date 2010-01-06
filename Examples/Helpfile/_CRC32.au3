#include "ACN_HASH.au3"

; Method 1
$CRC32 = _CRC32("The quick brown fox jumps over the lazy dog")
MsgBox(0, 'Method 1 Result', Hex($CRC32))

; Method 2
$CRC32 = 0
$CRC32 = _CRC32('The quick brown fox ', BitNot($CRC32))
$CRC32 = _CRC32('jumps over the lazy dog', BitNot($CRC32))
MsgBox(0, 'Method 2 Result', Hex($CRC32))

MsgBox(0, '', Hex($crc32))

;================================================================

Global $BufferSize = 0x20000
Global $Filename = FileOpenDialog("Open file", "", "Any file (*.*)")
If $Filename = "" Then Exit

Global $Timer = TimerInit()
Global $FileHandle = FileOpen($Filename, 16)
Global $CRC32 = 0

For $i = 1 To Ceiling(FileGetSize($Filename) / $BufferSize)
	$CRC32 = _CRC32(FileRead($FileHandle, $BufferSize), BitNot($CRC32))
Next

MsgBox (0, "Result", Hex($CRC32, 8) & " in " & Round(TimerDiff($Timer)) & " ms")