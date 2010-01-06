#include <ID3.au3>
Dim $sID3

$hFile = FileOpenDialog("请选择一个MP3文件", @DesktopDir, "MP3(*.MP3)")
$aID3 = _ID3TagToArray($hFile, 1)
For $I = 1 To $aID3[0]
	$sID3 &= $aID3[$I] & @LF
Next
MsgBox(0, "一共有" & $aID3[0] & "个标签", $sID3)