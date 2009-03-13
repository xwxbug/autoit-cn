$text = ""
For $i = 256 to 512
	$text = $text & ChrW($i)
Next
MsgBox(0, "Unicode 字符 256 到 512", $text)
