Run("notepad.exe")
$pos = ControlGetPos("[CLASS:Notepad]", "", "Edit1")
MsgBox(0, "Window Stats:", "POS: " & $pos[0] & "," & $pos[1] & " SIZE: " & $pos[2] & "," & $pos[3] )
