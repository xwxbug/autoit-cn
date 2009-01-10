ProcessClose("notepad.exe")

$PID = ProcessExists("notepad.exe")	; Will return the PID or 0 if the process isn't found.
If $PID Then ProcessClose($PID)
