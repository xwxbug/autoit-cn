; ASCII码所对应的数字字符(ASCII中的48-57).
Local $sText = ""
For $i = 48 To 57
	$sText = $sText & Chr($i) 
Next
MsgBox(4096, "数字", $sText) 

;-----------------------------------------------------------------------------------
; ASCII码所对应的英文大写字符(ASCII中的65-90).
Local $sText = ""
For $i = 65 To 90
	$sText = $sText & Chr($i) 
Next
MsgBox(4096, "英文大写字母", $sText)

;-----------------------------------------------------------------------------------
; ASCII码所对应的英文小写字符(ASCII中的97-122).
Local $sText = ""
For $i = 97 To 122
	$sText = $sText & Chr($i) 
Next
MsgBox(4096, "英文小写字母", $sText) 
