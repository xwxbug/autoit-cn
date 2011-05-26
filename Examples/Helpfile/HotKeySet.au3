; 按Esc键终止脚本, 按Pause/Break键暂停

Global $Paused
HotKeySet("{PAUSE}", "TogglePause")
HotKeySet("{ESC}", "Terminate")
HotKeySet("+!d", "ShowMessage") ;Shift-Alt-d

;;;; 下面是程序正文 ;;;;
While 1
	Sleep(100)
WEnd
;;;;;;;;

Func TogglePause()
	$Paused = Not $Paused
	While $Paused
		Sleep(100)
		ToolTip('脚本已经"暂停"了',0,0)
	WEnd
	ToolTip("")
EndFunc

Func Terminate()
	Exit 0
EndFunc

Func ShowMessage()
	MsgBox(4096,"标题","这是一个消息.")
EndFunc
