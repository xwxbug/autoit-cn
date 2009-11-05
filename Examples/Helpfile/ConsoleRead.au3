; 1、编译此脚本 "ConsoleRead.exe".
; 2、以命令提示符的方式打开程序ConsoleRead.exe所在目录在.
; 3、键入以下命令行:
;	echo Hello! | ConsoleRead.exe
;
; When invoked in a console window, the above command echos the text "Hello!"
; but instead of dispalying it, the | tells the console to pipe it to the STDIN stream
; of the ConsoleRead.exe process.
If Not @Compiled Then
	MsgBox(0, "提示", "此脚本必须编译后才能正确显示.")
	Exit -1
EndIf

Local $data
While True
	$data &= ConsoleRead()
	If @error Then ExitLoop
	Sleep(25)
WEnd
MsgBox(0, "", "Received: " & @CRLF & @CRLF & $data)
