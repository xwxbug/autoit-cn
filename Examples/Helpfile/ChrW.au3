Local $sText = ""
For $i = 32 To 255
	$sText = $sText & ChrW($i) ; 通过使用 $sText &= ChrW($i) 来显示.
Next
MsgBox(4096, "Unicode 字符 32 到 255", $sText) ; 显示 32 至 255 范围内的的字符.