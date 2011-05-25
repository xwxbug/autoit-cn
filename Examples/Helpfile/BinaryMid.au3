; 创建二进制(binary)数据 0x10203040
Local $binary = Binary("0x10203040")
Local $extract = BinaryMid($binary, 2, 2)
MsgBox(0, "第二个字节和第三个字节为:", $extract)
