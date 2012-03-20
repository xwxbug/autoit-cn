Local $pi = 3.14159265358979
Local $x = Cos($pi / 4)
MsgBox(4096, "Cos函数", "余弦值为：" & $x)

Local $degToRad = $pi / 180
Local $y = Cos(90 * $degToRad)  ; 90°的余弦
MsgBox(4096, "Cos函数", "余弦值为：" & $y)
