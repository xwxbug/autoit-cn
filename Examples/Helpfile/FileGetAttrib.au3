Local $sAttribute = FileGetAttrib(@ScriptFullPath) ; Retrieve the file attributes of the running script.
If @error Then
	MsgBox(4096,"错误", "无法获得属性.")
	Exit
Else
	If StringInStr($sAttribute, "R") Then ; If the attribute string contains the letter 'R' then the file is read-only.
	MsgBox(4096,"文件属性", "只读文件.")
	EndIf
EndIf

; Create a 1D array of the file attribute letters.
Local $aInput = StringSplit("R,A,S,H,N,D,O,C,T", ",")

; Create a 1D array using the friendlier file attribute names.
Local $aOutput = StringSplit("只读 /, 存档 /, 系统 /, 隐藏 /" & _
		", 普通 /, 目录 /, 脱机文件 /, 压缩 /, 临时 /",  ",")

; Loop through the attribute letters array to replace with the friendlier value e.g. A is replaced with Archive.
For $i = 1 To $aInput[0]
	$sAttribute = StringReplace($sAttribute, $aInput[$i], $aOutput[$i], 0, 1)
Next

; Remove the single space and trailing forward slash.
$sAttribute = StringTrimRight($sAttribute, 2)

; Display the converted attribute letters.
MsgBox(4096, "Full file attributes:", $sAttribute)
