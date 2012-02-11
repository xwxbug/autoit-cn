; 演示调整数组大小
Local $I, $K, $T, $MSG
Local $X[4][6], $Y[4][6]

For $I = 0 To 3
	For $K = 0 To 5
      $T = Int(Random(20) + 1)  ;得到 1 到 20 之间的随机数
		$X[$I][$K] = $T
		$Y[$I][$K] = $T
	Next
Next

ReDim $X[3][8]
Dim $Y[3][8]

$MSG = ""
For $I = 0 To UBound($X, 1) - 1
	For $K = 0 To UBound($X, 2) - 1
		If $K > 0 Then $MSG = $MSG & ", "
		$MSG = $MSG & $X[$I][$K]
	Next
	$MSG = $MSG & @CR
Next
MsgBox(4096, "ReDim 演示", $MSG)

$MSG = ""
For $I = 0 To UBound($Y, 1) - 1
	For $K = 0 To UBound($Y, 2) - 1
		If $K > 0 Then $MSG = $MSG & ", "
		$MSG = $MSG & $Y[$I][$K]
	Next
	$MSG = $MSG & @CR
Next
MsgBox(4096, "ReDim 演示", $MSG)
