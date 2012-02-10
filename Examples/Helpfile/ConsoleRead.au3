#cs
	1,编译此脚本为 "ConsoleRead.exe".
	2,以命令提示符的方式打开程序ConsoleRead.exe所在目录在.
	3,键入以下命令行:
	echo Hello! | ConsoleRead.exe

	When invoked in a console window, the above command echos the text "Hello!"
	but instead of displaying it, the | tells the console to pipe it to the STDIN stream
	of the ConsoleRead.exe process.
#ce

Example()

Func Example()
	If Not @Compiled Then
		MsgBox(4096, "提示", "此脚本必须编译后才能正确显示.")
		Exit
	EndIf

	Local $sOutput
	While True
		$sOutput &= ConsoleRead()
		If @error Then ExitLoop
		Sleep(25)
	WEnd
	MsgBox(4096, "", "返回: " & @CRLF & @CRLF & $sOutput)
EndFunc   ;==>Example
