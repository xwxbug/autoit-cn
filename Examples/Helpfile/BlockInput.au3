BlockInput(1)

Run("notepad")
WinWaitActive("[CLASS:Notepad]")
Send("{F5}")  ;pastes time and date

BlockInput(0)
