Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]","")
ControlSend("[CLASS:Notepad]", "", "Edit1", "将会发送一些文本到记事本窗口去.")