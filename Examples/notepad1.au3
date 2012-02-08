;
; AutoIt Version: 3.0
; Language:       English
; Platform:       Win9x/NT
; Author:         Jonathan Bennett (jon@hiddensoft.com)
;
; Script Function:
;   Opens Notepad, types in some text and then quits the application.
;


; Prompt the user to run the script - use a Yes/No prompt (4 - see help file)
Local $iAnswer = MsgBox(4, "AutoIt 例子 (中文)", "这个例子会在运行记事本后输入一些文字并退出.  运行?")


; Check the user's answer to the prompt (see the help file for MsgBox return values)
; If "No" was clicked (7) then exit the script
If $iAnswer = 7 Then
	MsgBox(0, "AutoIt", "好的,再见!")
	Exit
EndIf


; Run Notepad
Run("notepad.exe")


; Wait for the Notepad to become active. The classname "Notepad" is monitored instead of the window title
WinWaitActive("[CLASS:Notepad]")


; Now that the Notepad window is active type some text
Send("Hello from Notepad.{ENTER}1 2 3 4 5 6 7 8 9 10{ENTER}")
Sleep(500)
Send("+{UP 2}")
Sleep(500)


; Now quit by pressing Alt-F and then scrolling down (simulating the down arrow being pressed six times) to the Exit menu
Send("!f")
Sleep(1000)
Send("{DOWN 6}{ENTER}")


; Now a screen will pop up and ask to save the changes, the classname of the window is called
; "#32770" and simulating the "TAB" key to move to the second button in which the "ENTER" is simulated to not "save the file"
WinWaitActive("[CLASS:#32770]")
Sleep(500)
Send("{TAB}{ENTER}")


; Now wait for Notepad to close before continuing
WinWaitClose("[CLASS:Notepad]")


; Finished!
