#include <WinAPIShPath.au3>
#include <Array.au3>
#include <File.au3>

Local $FileList = _FileListToArray(@SystemDir, '*.*', 1)
Local $SortList[UBound($FileList) - 1]
Local $Count = 0

For $i = 1 To $FileList[0]
	If _WinAPI_PathIsContentType($FileList[$i], 'text/xml') Then
		$SortList[$Count] = $FileList[$i]
		$Count += 1
	EndIf
Next
If $Count Then
	ReDim $SortList[$Count]
Else
	Exit
EndIf

_ArrayDisplay($SortList, '_WinAPI_PathIsContentType')
