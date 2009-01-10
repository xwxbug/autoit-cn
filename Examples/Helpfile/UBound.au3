Dim $myArray[10][20]   ;element 0,0 to 9,19
$rows = UBound($myArray)
$cols = UBound($myArray, 2)
$dims = UBound($myArray, 0)

MsgBox(0, "The " & $dims & "-dimensional array has", _
	$rows & " rows, " & $cols & " columns")

;Display $myArray's contents
$output = ""
For $r = 0 to UBound($myArray,1) - 1
	$output = $output & @LF
	For $c = 0 to UBound($myArray,2) - 1
		$output = $output & $myArray[$r][$c] & " "
	Next
Next
MsgBox(4096,"Array Contents", $output)
