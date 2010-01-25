;示例 1, 返回匹配项目的数组.并使用偏移量
$nOffset = 1
While 1
	$array = StringRegExp('<test>a</test> <test>b</test> <test>c</Test>', '<(?i)test>(.*?)</(?i)test>', 1, $nOffset)
	If @error = 0 Then
		$nOffset = @extended
	Else
		ExitLoop
	EndIf
	for $i = 0 to UBound($array) - 1
		msgbox(0, "正则测试 标志值 1 - " & $i, $array[$i])
	Next
WEnd

;示例 2, 返回包括完整匹配的数组.(Perl/ PHP 样式).
$array = StringRegExp('<test>a</test> <test>b</test> <test>c</Test>', '<(?i)test>(.*?)</(?i)test>', 2)
for $i = 0 to UBound($array) - 1
	msgbox(0, "正则测试 标志值 2 - " & $i, $array[$i])
Next

;示例 3, 返回全局匹配的数组.
$array = StringRegExp('<test>a</test> <test>b</test> <test>c</Test>', '<(?i)test>(.*?)</(?i)test>', 3)
for $i = 0 to UBound($array) - 1
	msgbox(0, "正则测试 标志值 3 - " & $i, $array[$i])
Next

;示例 4, 返回包括完整匹配(Perl/ PHP 样式)和全局匹配的数组.
$array = StringRegExp('F1oF2oF3o', '(F.o)*?', 4)
for $i = 0 to UBound($array) - 1
$match = $array[$i]
	for $j = 0 to UBound($match) - 1
		msgbox(0, "正则测试 标志值 4 - " & $i & ',' & $j, $match[$j])
	Next
Next
