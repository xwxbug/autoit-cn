#include <Array.au3>
#include <File.au3>
#include <WinApiEx.au3>

Opt('MustDeclareVars ', 1)

Global $FileList = _FileListToArray(@SystemDir, '*.dll ', 1)
Global $SpecList[UBound($FileList) - 1]
Global $Count = 0

For $i = 1 To $FileList[0]
	If _WinAPI_PathMatchSpec($FileList[$i], 'net*.dll') Then
		$SpecList[$Count] = $FileList[$i]
		$Count += 1
	EndIf
Next

_arraydisplay($SpecList, '_WinAPI_PathMatchSpec ', $Count - 1)

