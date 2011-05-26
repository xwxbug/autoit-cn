Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]","")
ControlSend("[CLASS:Notepad]", "", "Edit1", "This is a line of text in the notepad window")
;ControlSend不支持中文