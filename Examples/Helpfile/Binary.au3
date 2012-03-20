; 通过使用 Binary 返回一个表达式的二进制值.
Local $bBinary = Binary("0x00204060") 

; 通过使用 IsBinary 检查是否是二进制类型
MsgBox(4096, "检查是否二进制类型", "如果是二进制类型则返回1: " & IsBinary($bBinary))
