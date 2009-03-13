$text = ""
For $i = 65 to 90
	$text = $text & Chr($i)
Next
MsgBox(0, "全部大写字母:", $text)
