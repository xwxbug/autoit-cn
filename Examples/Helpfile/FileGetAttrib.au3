$attrib = FileGetAttrib("c:\boot.ini")
If @error Then
	MsgBox(4096,"错误", "无法获得属性.")
	Exit
Else
	If StringInStr($attrib, "R") Then
	MsgBox(4096,"文件属性", "只读文件.")
	EndIf
EndIf

; Display full attribute information in text form
; Arrays rely upon the fact that each capital letter is unique
; Figuring out how this works is a good string exercise...
$input = StringSplit("R,A,S,H,N,D,O,C,T",",")
$output = StringSplit("只读 /, 存档 /, 系统 /, 隐藏 /" & _
		", 普通 /, 目录 /, 脱机文件 /, 压缩 /, 临时 /",  ",")
For $i = 1 to 9
	$attrib = StringReplace($attrib, $input[$i], $output[$i], 0, 1)
	; last parameter in StringReplace means case-sensitivity
Next
$attrib = StringTrimRight($attrib, 2) ;remove trailing slash
MsgBox(0,"完整的文件属性:", $attrib)
