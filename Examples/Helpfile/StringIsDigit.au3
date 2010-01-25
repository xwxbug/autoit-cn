$x1 = "12333"
MsgBox(0,"检查结果", "返回值为:" & StringIsDigit($x1));返回值为: 1

$x2 = "1.5"
MsgBox(0,"检查结果", "返回值为:" & StringIsDigit($x2));返回值为: 0, 由于有小数点

$x3 = "1 2 3"
MsgBox(0,"检查结果", "返回值为:" & StringIsDigit($x3));返回值为: 0, 由于有空白符

$x4 = ""
MsgBox(0,"检查结果", "返回值为:" & StringIsDigit($x4));返回值为: 0