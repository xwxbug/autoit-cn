Local $text = StringReplace("这 是 一 行 文 本", " ", "-")
Local $numreplacements = @extended
MsgBox(0, "新字符串为:", $text)
MsgBox(0, "共替换的数量为:", $numreplacements)
