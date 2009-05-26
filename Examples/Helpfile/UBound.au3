Dim $myArray[10][20]   ;元素 0,0 到 9,19
$rows = UBound($myArray)
$cols = UBound($myArray, 2)
$dims = UBound($myArray, 0)

MsgBox(0, "当前 " & $dims & "-维数组有", _
	$rows & " 行, " & $cols & " 列")

;显示 $myArray's 内容
$output = ""
For $r = 0 to UBound($myArray,1) - 1
	$output = $output & @LF
	For $c = 0 to UBound($myArray,2) - 1
		$output = $output & $myArray[$r][$c] & " "
	Next
Next
MsgBox(4096,"数组内容", $output)
