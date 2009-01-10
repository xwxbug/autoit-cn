Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")
ControlSetText("[CLASS:Notepad]","","[CLASSNN:Edit1]",Random(0,1000))
Sleep(500)



$text = WinGetText("[CLASS:Notepad]", "")
MsgBox(0, "读取的文本为:","读取到的文本为: " & $text)
