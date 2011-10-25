#include <Array.au3>
#include <File.au3>
#include <WinApiEx.au3>

Global $FileList = _FileListToArray( _WinAPI_ShellGetSpecialFolderPath($CSIDL_FONTS), '*.ttf ', 1)
Global $FontList[UBound($FileList) - 1][2]

For $i = 1 To $FileList[0]
	$FontList[$i - 1][0] = $FileList[$i]
	$FontList[$i - 1][1] = _WinAPI_GetFontResourceInfo($FileList[$i], 1)
Next

_arraydisplay($FontList, '_WinAPI_GetFontResourceInfo')

