FileChangeDir(@ScriptDir)

DirCreate('dir')
FileWriteLine("test.txt","test")
MsgBox(0,"硬链接", FileCreateNTFSLink("test.txt", "dir\test.log", 1))
