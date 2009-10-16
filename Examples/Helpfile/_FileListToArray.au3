#Include <File.au3>
#Include <Array.au3>

$FileList=_FileListToArray(@DesktopDir)
If @Error=1 Then
	MsgBox (0,"","No Folders Found.")
	Exit
EndIf
If @Error=4 Then
	MsgBox (0,"","No Files Found.")
	Exit
EndIf
_ArrayDisplay($FileList,"$FileList")