$x = BitOR(3, 6)
; x == 7 因为 0011 OR 0110 = 0111
 
$y = BitOR(3, 15, 32) 
; y == 47 因为 0011 OR 1111 OR 00100000 = 00101111

MsgBox(4096, "BitOR", "X=" & $x & @CRLF & @CRLF & "Y=" & $y)