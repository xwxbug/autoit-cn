Run("notepad.exe")
WinWait("[CLASS:Notepad]")
ControlSetText("[CLASS:Notepad]", "", "Edit1", "这里是设置的文本" )
