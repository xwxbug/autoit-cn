#include <file.au3>
#include <array.au3>
Dim $szDrive, $szDir, $szFName, $szExt
$TestPath = _PathSplit(@ScriptFullPath, $szDrive, $szDir, $szFName, $szExt)
_ArrayDisplay($TestPath,"Demo _PathSplit()")