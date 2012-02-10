FileChangeDir(@ScriptDir)

DirCreate('dir')
FileWriteLine("test.txt", "test")
MsgBox(4096,"Ó²Á´½Ó", FileCreateNTFSLink("test.txt", "dir\test.log", 1))
