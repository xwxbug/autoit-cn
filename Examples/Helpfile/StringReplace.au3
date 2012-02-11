Local $sText = StringReplace("这 是 一 行 文 本", " ", "-")
Local $iReplacements = @extended
MsgBox(4096, "新字符串", "新字符串为:" & @CRLF & $sText)
MsgBox(4096, "替换", "共替换的数量为:" & @CRLF & $iReplacements & " 次.")
