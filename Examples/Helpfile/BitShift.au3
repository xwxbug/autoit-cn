Local $x = BitShift(14, 2)
;  x == 3 因为 1110b 右移两次是 11b == 3

Local $y = BitShift(14, -2)
;  y == 56 因为 1110b 左移两次是 111000b == 56

Local $z = BitShift(1, -31)
;  z == -2147483648 因为是 2'补码记法, the
;  32nd digit from the right has a negative sign.
