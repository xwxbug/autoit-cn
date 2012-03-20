; 默认读取模式
MsgBox(4096, "目录信息", @WindowsDir & @LF _
		 & "文件夹大小(MB) :" & Round(DirGetSize(@WindowsDir) / 1024 / 1024))

; 启用扩展模式 -> 返回一个包含扩展信息的数组
$size = DirGetSize(@WindowsDir, 1)
MsgBox(4096, "目录信息", @WindowsDir & @LF _
		 & "文件夹大小(字节):" & $size[0] & @LF _
		 & "文件数:" & $size[1] & @LF _
		 & "文件夹数:" & $size[2])

; 子目录下的文件大小将不计算入内(递归模式被取消)
MsgBox(4096, @WindowsDir, "文件夹大小(字节) :" & DirGetSize(@WindowsDir, 2))

; 读取共享文件目录大小
Local $timer = TimerInit()
$size = DirGetSize("\\127.0.0.1\c$", 1);请试试填入一个真实路径
Local $diff = Round(TimerDiff($timer) / 1000) ; 按秒计时
If IsArray($size) Then
	MsgBox(4096, "共享目录信息", "文件夹大小(字节):" & $size[0] & @LF _
			 & "文件数:" & $size[1] & @LF & "文件夹数:" & $size[2] & @LF _
			 & "用时(秒):" & $diff)
EndIf
