#Include <File.au3>
#Include <Array.au3>
$FileList=_FileListToArray(@DesktopDir)
If @Error=1 Then
	MsgBox (0,"","No Files\Folders Found.")
	Exit
EndIf
_ArrayDisplay($FileList,"$FileList")