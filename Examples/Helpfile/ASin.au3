Local $x = ASin(0.5)
MsgBox(4096, "ASin 函数", "反正弦值：" & $x)

Local $pi = 4 * ATan(1) ; 等于 3.14159265358979
Local $radToDeg = 180 / $pi
Local $y = ASin(1) * $radToDeg; 1的反正弦值是 90°
MsgBox(4096, "ASin 函数", "反正弦值：" & $y & "°")
