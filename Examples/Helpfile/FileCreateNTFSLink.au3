FileChangeDir(@ScriptDir)

DirCreate('dir')
FileWriteLine("test.txt","test")
MsgBox(0,"Hardlink", FileCreateNTFSLink("dir\test.log", "test.txt",1))
