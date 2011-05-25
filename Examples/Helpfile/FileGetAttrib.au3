Local $attrib = FileGetAttrib("c:\boot.ini")
If @error Then
	MsgBox(4096,"错误", "无法获得属性.")
	Exit
Else
	If StringInStr($attrib, "R") Then
	MsgBox(4096,"文件属性", "只读文件.")
	EndIf
EndIf

;显示指定文件的完整属性代码
;事实上数组里每一个大写字母是唯一的

Local $input = StringSplit("R,A,S,H,N,D,O,C,T", ",")
Local $output = StringSplit("只读 /, 存档 /, 系统 /, 隐藏 /" & _
		", 普通 /, 目录 /, 脱机文件 /, 压缩 /, 临时 /",  ",")
For $i = 1 To 9
	$attrib = StringReplace($attrib, $input[$i], $output[$i], 0, 1)
	;StringReplace 最后一个参数是指 区分大小写
Next
$attrib = StringTrimRight($attrib, 2) ;移除反斜杠
MsgBox(0,"完整的文件属性:", $attrib)
