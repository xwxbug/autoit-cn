Local $bBinary = Binary("0x10203040") ;  从字符串创建二进制(binary)数据 0x10203040.
MsgBox(4096, "二进制变量长度为(字节):", "二进制变量长度为(字节): " &BinaryLen($bBinary) )
