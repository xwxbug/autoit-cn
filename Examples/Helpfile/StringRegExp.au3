;=============================================================
;官方例子
;=============================================================
;示例 1, 返回匹配项目的数组.并使用偏移量
Local $nOffset = 1

Local $array
While 1
	$array = StringRegExp('<test>a</test> <test>b</test> <test>c</Test>', '<(?i)test>(.*?)</(?i)test>', 1, $nOffset)

	If @error = 0 Then
		$nOffset = @extended
	Else
		ExitLoop
	EndIf
	For $i = 0 To UBound($array) - 1
		MsgBox(0, "正则测试 标志值 1 - " & $i, $array[$i])
	Next
WEnd


;示例 2, 返回包括完整匹配的数组.(Perl/ PHP 样式).
$array = StringRegExp('<test>a</test> <test>b</test> <test>c</Test>', '<(?i)test>(.*?)</(?i)test>', 2)
For $i = 0 To UBound($array) - 1
	MsgBox(0, "正则测试 标志值 2 - " & $i, $array[$i])
Next


;示例 3, 返回全局匹配的数组.
$array = StringRegExp('<test>a</test> <test>b</test> <test>c</Test>', '<(?i)test>(.*?)</(?i)test>', 3)

For $i = 0 To UBound($array) - 1
	MsgBox(0, "正则测试 标志值 3 - " & $i, $array[$i])
Next


;示例 4, 返回包括完整匹配(Perl/ PHP 样式)和全局匹配的数组.
$array = StringRegExp('F1oF2oF3o', '(F.o)*?', 4)

For $i = 0 To UBound($array) - 1

	Local $match = $array[$i]
	For $j = 0 To UBound($match) - 1
		MsgBox(0, "正则测试 标志值 4 - " & $i & ',' & $j, $match[$j])
	Next
Next

;=============================================================
;kodin温馨提示：本人极力推荐使用正则测试工具辅助学习。
;在线正则测试工具地址：http://www.gskinner.com/RegExr/
;=============================================================

;示例 1 匹配 Email地址
$Email = '131sg31gsg autoit@acn.com  313sfsg31sg'
$array = StringRegExp($Email, '\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b', 2)
MsgBox(0, "正则测试", $array[UBound($array[0])])

;示例 2 匹配 日期时间(yyyy-mm-dd hh:mm:ss)
$data = 'data 2010-03-27 12:30:10'
$array = StringRegExp($data, '(19[0-9]{2}|2[0-9]{3})-(0[1-9]|1[012])-([123]0|[012][1-9]|31) ([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])', 2)
MsgBox(0, "正则测试", $array[UBound($array[0])])