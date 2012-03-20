#cs
	1、编译此脚本为 "ConsoleRead.exe".
	2、以命令提示符的方式打开程序 ConsoleRead.exe 所在目录在.
	3、键入以下命令行: echo Hello! | ConsoleRead.exe
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
	MsgBox(4096, "提示", "返回: " & @CRLF & @CRLF & $sOutput)
EndFunc   ;==>Example
