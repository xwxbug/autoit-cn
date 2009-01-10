$size = WinGetClientSize("[active]")
MsgBox(0, "活动窗口客户端大小 (宽度,高度):", $size[0] & "," & $size[1])
