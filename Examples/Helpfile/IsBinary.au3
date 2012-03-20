; 通过使用 Binary 返回一个表达式的二进制值.
Local $bBinary = Binary("0x00204060") 

; 通过使用 IsBinary 检查是否是二进制类型，结果是二进制类型，所以返回1.
MsgBox(4096, "检查是否二进制类型", "因为是二进制类型所以会返回1: " & @LF & "返回值等于：" & IsBinary($bBinary))

; 没有使用 Binary
Local $sString = "0x00204060"

; 通过使用 IsBinary 检查是否是二进制类型，结果并不是二进制类型，所以返回0.
MsgBox(4096, "检查是否二进制类型", "因为不是二进制类型所以会返回0: " & @LF & "返回值等于：" & IsBinary($sString))
