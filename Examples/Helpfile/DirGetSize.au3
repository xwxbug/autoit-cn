Local $size = DirGetSize(@HomeDrive)
MsgBox(4096,"","大小(MB) :" & Round($size / 1024 / 1024))

$size = DirGetSize(@WindowsDir, 2)
MsgBox(4096,"","大小(MB) :" & Round($size / 1024 / 1024))

Local $timer = TimerInit()
$size	= DirGetSize("\\10.0.0.1\h$",1);请试试填入一个真实路径
Local $diff	= Round(TimerDiff($timer) / 1000)	; 按秒计时
If IsArray($size) Then
	MsgBox(4096,"DirGetSize-信息","大小(字节):" & $size[0] & @LF _
		& "文件:" & $size[1] & @LF & "文件夹:" & $size[2] & @LF _
		& "用时(秒):" & $diff)
EndIf