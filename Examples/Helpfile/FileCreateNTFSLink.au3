FileChangeDir(@ScriptDir)

DirCreate('dir')
FileWriteLine("test.txt", "test")
MsgBox(0,"Ó²Á´½Ó", FileCreateNTFSLink("test.txt", "dir\test.log", 1))
