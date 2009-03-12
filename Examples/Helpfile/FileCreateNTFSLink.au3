FileChangeDir(@ScriptDir)

DirCreate('dir')
FileWriteLine("test.txt","test")
MsgBox(0,"Ó²Á´½Ó", FileCreateNTFSLink("dir\test.log", "test.txt",1))
