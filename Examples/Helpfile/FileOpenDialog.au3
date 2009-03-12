$message = "按下 Ctrl 或 Shift 键选择多个文件."

$var = FileOpenDialog($message, @WindowsDir & "\", "图像文件 (*.jpg;*.bmp)", 1 + 4 )

If @error Then
	MsgBox(4096,"","没有选择文件!")
Else
	$var = StringReplace($var, "|", @CRLF)
	MsgBox(4096,"","你选择了:" & $var)
EndIf


; 多筛选组
$message = "按下 Ctrl 或 Shift 键选择多个文件."

$var = FileOpenDialog($message, @WindowsDir & "", "图像 (*.jpg;*.bmp)|视频 (*.avi;*.mpg)", 1 + 4 )

If @error Then
	MsgBox(4096,"","没有选择文件!")
Else
	$var = StringReplace($var, "|", @CRLF)
	MsgBox(4096,"","你选择了:" & $var)
EndIf

