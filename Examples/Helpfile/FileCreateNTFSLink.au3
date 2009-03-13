FileChangeDir(@ScriptDir)

DirCreate('dir')
FileWriteLine("test.txt","test")
MsgBox(0,"硬链接", FileCreateNTFSLink("dir\test.log", "test.txt",1))
