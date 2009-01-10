;Wait for the window "未命名" to exist

Run("notepad")
WinWait("未命名")

;Wait a maximum of 5 seconds for "未命名" to exist
WinWait("未命名", "", 5)
