Local $x = ATan(0.5)
MsgBox(4096, "ATan 函数", "反正切值：" & $x)

Local $pi = 4 * ATan(1) ; 等于 3.14159265358979
Local $radToDeg = 180 / $pi
Local $y = ATan(1) * $radToDeg  ; 1的正切值为 45°
MsgBox(4096, "ATan 函数", "反正切值：" & $y & "°")