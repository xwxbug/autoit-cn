Local $bak = ClipGet()
MsgBox(0, "剪贴板内容:", $bak)

ClipPut($bak & "附加文本")
MsgBox(0, "剪贴板内容:", ClipGet())