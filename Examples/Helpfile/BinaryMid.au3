Local $bBinary = Binary("0x10203040") ; 创建二进制(binary)数据 0x10203040
Local $bExtract = BinaryMid($bBinary, 2, 2)
MsgBox(4096, "", "第二个字节和第三个字节为:" & $bExtract)
