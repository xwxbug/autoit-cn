; 通过使用 Binary 返回一个表达式的二进制值.
Local $bBinary = Binary("0x10203040")

; 通过使用 BinaryMid 取出的二进制数据. 
Local $bExtract = BinaryMid($bBinary, 2, 2)

MsgBox(4096, "BinaryMid", "第二个字节和第三个字节为：" & $bExtract)
