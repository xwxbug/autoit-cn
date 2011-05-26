Opt("WinTitleMatchMode", 2) ; 匹配子字符串
Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")

WinSetTrans("[CLASS:Notepad]", "", 170) ; 让记事本半透明.
