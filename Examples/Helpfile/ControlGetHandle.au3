Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]","")
Local $handle = ControlGetHandle("[CLASS:Notepad]", "", "Edit1")
MsgBox(32,"这货是不是一个句柄?","返回值:" & IsHWnd($handle))