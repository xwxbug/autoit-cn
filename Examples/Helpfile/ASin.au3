Local $x = ASin(0.5)
MsgBox(32,"ASin函数",$X)

Local $pi = 3.14159265358979
Local $radToDeg = 180 / $pi
Local $y = ASin(1) * $radToDeg  ;1 的反正弦值是 90° 
MsgBox(32,"ASin函数",$y & "°")