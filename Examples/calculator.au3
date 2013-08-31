#include <Constants.au3>

;
; AutoIt Version: 3.0
; Language:       English
; Platform:       Win9x/NT
; Author:         Jonathan Bennett (jon at autoitscript dot com)
;
; Script Function:
;   Plays with the calculator.
;

; Prompt the user to run the script - use a Yes/No prompt with the flag parameter set at 4 (see the help file for more details)
Local $iAnswer = MsgBox(BitOR($MB_YESNO, $MB_SYSTEMMODAL), "AutoIt 例子", "这个脚本运行计算器后输入 2 x 4 x 8 x 16 并退出.  运行")

; Check the user's answer to the prompt (see the help file for MsgBox return values)
; If "No" was clicked (7) then exit the script
If $iAnswer = 7 Then
    MsgBox($MB_SYSTEMMODAL, "AutoIt", "好的,再见!")
	Exit
EndIf

; Run the calculator
Run("calc.exe")

; Wait for the calculator to become active. The classname "CalcFrame" is monitored instead of the window title
WinWaitActive("[CLASS:CalcFrame]")

; Now that the calculator window is active type the values 2 x 4 x 8 x 16
; Use AutoItSetOption to slow down the typing speed so we can see it
AutoItSetOption("SendKeyDelay", 400)
Send("2*4*8*16=")
Sleep(2000)

; Now quit by sending a "close" request to the calculator window using the classname
WinClose("[CLASS:CalcFrame]")

; Now wait for the calculator to close before continuing
WinWaitClose("[CLASS:CalcFrame]")

; Finished!
