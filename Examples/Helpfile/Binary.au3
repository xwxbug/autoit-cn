Local $bBinary = Binary("0x00204060") ;$var 为一个二进制(binary)类型.

MsgBox(4096, "检查变量是否是 binary (二进制)类型", "如果是一个二进制类型变量则返回1: " & IsBinary($bBinary))
