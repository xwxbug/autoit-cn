#include <ACN_HASH.au3>

Global $BufferSize = 0x20000
Global $Filename = FileOpenDialog("Open file", "", "Any file (*.*)")
If $Filename = "" Then Exit

Global $Timer = TimerInit()
Global $FileHandle = FileOpen($Filename, 16)

$MD5CTX = _MD5Init()
For $i = 1 To Ceiling(FileGetSize($Filename) / $BufferSize)
	_MD5Input($MD5CTX, FileRead($FileHandle, $BufferSize))
Next
$Hash = _MD5Result($MD5CTX)
FileClose($FileHandle)

MsgBox (0, "Result", $Hash & " in " & Round(TimerDiff($Timer)) & " ms")
