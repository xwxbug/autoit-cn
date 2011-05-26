; Delete C:\Test1 and all subdirs and files
$sFldr1 = "C:\Test1\"
$sFldr2 = "C:\Test1\Folder1\"
$sFldr3 = "C:\Test1\Folder1\Folder2\"
If DirGetSize($sFldr1) = -1 Then
    DirCreate($sFldr3)
    $explorer = RunWait("explorer /root, C:\Test1\Folder1")
    $handle = WinGetHandle($explorer)
    MsgBox( 262144, "Message", "Explorer is opened with Folder2 displayed.")
    DirRemove($sFldr3, 1)
    MsgBox(262144, "Message", "The sub folder: Folder2 has been deleted.")
    WinClose($handle)
    DirRemove($sFldr1, 1) ;clean up test folders
Else
    MsgBox(48, $sFldr1, "Directory already exists!")"^\b.+\b\v", 1)
EndIf
