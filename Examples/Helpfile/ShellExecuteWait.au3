$val = ShellExecuteWait("Notepad.exe")

; script waits until Notepad closes
MsgBox(0, "Program returned with exit code:", $val)
