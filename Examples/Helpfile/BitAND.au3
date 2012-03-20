$x = BitAND(13, 7) 
; x == 5 ,因为 1101 AND 0111 = 0101

$y = BitAND(2, 3, 6) 
;y == 2 ,因为 0010 AND 0011 AND 0110 = 0010

MsgBox(4096, "BitAND", "X=" & $x & @CRLF & @CRLF & "Y=" & $y)