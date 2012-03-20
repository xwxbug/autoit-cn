$x = BitXOR(10, 6) 
; x == 12 因为 1010b XOR 0110b == 1100

$y = BitXOR(2, 3, 6) 
; y == 7 因为 0010 XOR 0011 XOR 0110 = 0111

MsgBox(4096, "BitXOR", "X=" & $x & @CRLF & @CRLF & "Y=" & $y)
