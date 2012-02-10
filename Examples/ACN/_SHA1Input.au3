#include <ACN_HASH.au3>

Global $BufferSize = 0x20000
Global $Filename = FileOpenDialog("Open file", "", "Any file (*.*)")
If $Filename = "" Then Exit

Global $Timer = TimerInit()
Global $FileHandle = FileOpen($Filename, 16)

$SHA1CTX = _SHA1Init()
For $i = 1 To Ceiling(FileGetSize($Filename) / $BufferSize)
	_SHA1Input($SHA1CTX, FileRead($FileHandle, $BufferSize))
Next
$Hash = _SHA1Result($SHA1CTX)
FileClose($FileHandle)

msgbox(0, "Result", $Hash & " in" & Round(TimerDiff($Timer)) & " ms")
