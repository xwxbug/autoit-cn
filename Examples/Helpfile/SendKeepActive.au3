Run("notepad.exe")
WinWait("Untitled")

SendKeepActive("Untitled")

; Change the active window during pauses
For $i = 1 to 10
	Sleep(1000)
	Send("Hello")
Next
