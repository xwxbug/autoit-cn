; 通过使用 Binary 返回一个表达式的二进制值.
Local $bBinary = Binary("0x10203040")

; 通过使用 BinaryLen 返回一个二进制变量的所用字节数.
MsgBox(4096, "二进制变量长度为(字节):", "二进制变量长度为(字节): " & BinaryLen($bBinary))
