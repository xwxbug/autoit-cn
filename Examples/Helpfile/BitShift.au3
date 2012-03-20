Local $x = BitShift(14, 2)
; x == 3 因为 1110b 右移两次是 11b == 3

Local $y = BitShift(14, -2)
; y == 56 因为 1110b 左移两次是 111000b == 56

Local $z = BitShift(1, -31)
; z == -2147483648 因为在二补码中第32位数是负号。

MsgBox(4096, "BitShift", "X=" & $x & @CRLF & @CRLF & "Y=" & $y & @CRLF & @CRLF & "Z=" & $z)
