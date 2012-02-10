Local $sText = ""
For $i = 65 To 90
	$sText = $sText & Chr($i) ; Or $sText &= Chr($i) can be used as well.
Next
MsgBox(4096, "Uppercase alphabet", $sText) ; 英语中使用的所有大写字母(ASCII中的65-90).
