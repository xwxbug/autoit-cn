Run("notepad.exe")
WinWait("[CLASS:Notepad]")
Local $hWnd = WinGetHandle("[CLASS:Notepad]")
Local $sHWND = String($hWnd)	; Convert to a string
WinSetState(HWnd($sHWND), "", @SW_MINIMIZE)
Sleep(5000)	; Notepad should be minimized
WinClose(HWnd($sHWND))
