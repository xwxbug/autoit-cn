#include <File.au3>
#include <Array.au3>

Local $FileList = _FileListToArray(@DesktopDir)
If @error = 1 Then
	MsgBox(4096, "", "No Folders Found.")
	Exit
EndIf
If @error = 4 Then
	MsgBox(4096, "", "No Files Found.")
	Exit
EndIf
_ArrayDisplay($FileList, "$FileList")
