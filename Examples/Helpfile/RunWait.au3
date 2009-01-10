$val = RunWait("Notepad.exe", @WindowsDir, @SW_MAXIMIZE)
; script waits until Notepad closes
MsgBox(0, "Program returned with exit code:", $val)
