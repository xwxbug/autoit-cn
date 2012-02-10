Local $bBinary = Binary("0x00204060")
Local $sString = "0x00204060"

MsgBox(4096, "", "Returns 1 as the variable is binary: " & IsBinary($bBinary))
MsgBox(4096, "", "Returns 0 as the variable is a string: " & IsBinary($sString))
