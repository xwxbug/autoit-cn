#include <Constants.au3>

;
; AutoIt Version: 3.0
; Language:       English
; Platform:       Win9x/NT
; Author:         Jonathan Bennett (jon at autoitscript dot com)
;
; Script Function:
;   Demonstrates the InputBox, looping and the use of @error.
;

; Prompt the user to run the script - use a Yes/No prompt with the flag parameter set at 4 (see the help file for more details)
Local $iAnswer = MsgBox(BitOR($MB_YESNO, $MB_SYSTEMMODAL), "AutoIt 例子 (英文+您系统的语言)", "这个脚本打开一个输入框,并要求您输入一些文本.  运行?")

; Check the user's answer to the prompt (see the help file for MsgBox return values)
; If "No" was clicked (7) then exit the script
If $iAnswer = 7 Then
	MsgBox($MB_SYSTEMMODAL, "AutoIt", "好的,再见!")
	Exit
EndIf

; Loop around until the user gives a valid "thesnow" answer. This is not case-sensitive, therefore AutoIt and AuToIT are acceptable values as well
Local $iLoop = 1, $sText = ""
While $iLoop = 1
	$sText = InputBox("AutoIt 例子", "请输入:""thesnow"" 并单击确定")
	If @error = 1 Then
		MsgBox($MB_SYSTEMMODAL, "错误", "您按下了 '取消' - 请重试!")
	Else
		; They clicked OK, but did they type the right thing?
	If $sText <> "thesnow" Then ; This is not case-sensitive, therefore AutoIt and AuToIT are acceptable values as well
			MsgBox($MB_SYSTEMMODAL, "错误", "难道您不知道小名鼎鼎的 thesnow 吗? - 请重试!")
		Else
			$iLoop = 0 ; Exit the loop - ExitLoop would have been an alternative too :)
		EndIf
	EndIf
WEnd

; Print the success message
MsgBox($MB_SYSTEMMODAL,"AutoIt 例子", "您输入了正确的单词!  恭喜.")

; Finished!
