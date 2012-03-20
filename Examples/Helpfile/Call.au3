; 示例1 调用的一个没用参数的自定义函数函数.
Call("Test1")

Func Test1()
	MsgBox(4096, "Test1", "Hello")
EndFunc   ;==>Test1
;-------------------------------------------------------------------------------
; 示例2 调用的一个函数接受一个参数,并传递了这个参数.
Call("Test2", "来自 Call() 的消息!")

Func Test2($sMsg)
	MsgBox(4096, "Test2", $sMsg)
EndFunc   ;==>Test2
;-------------------------------------------------------------------------------
; 示例3 演示如何使用一个特殊的数组.
Global $array[2]
$array[0] = "数组元素 0"
$array[1] = "数组元素 1"

Global $aArgs[4]
$aArgs[0] = "CallArgArray" ; 这是必需的, 否则, Call() 不承认数组内容为一个参数.
$aArgs[1] = "这是一个字符串" ; 第一个参数为一个字符串
$aArgs[2] = 47 ; 第二个参数为一个数字
$aArgs[3] = $array ; 参数三为一个数组

; 我们构造好了这个特殊数组,现在我们来调用这个函数
Call("Test3", $aArgs)

; 怎么测试一个函数是不是存在.  可以使用下面的方法:
; 检查 @error 和 @extended 中的定义的失败值.
Local Const $sFunction = "DoesNotExist"
Call($sFunction)
If @error = 0xDEAD And @extended = 0xBEEF Then MsgBox(4096, "Test3", "函数不存在.")

Func Test3($sString, $nNumber, $aArray)
	MsgBox(4096, "Test3", "字符串为: " & $sString & @CRLF & @CRLF & "数字为: " & $nNumber)
	For $i = 0 To UBound($aArray) - 1
		MsgBox(4096, "Test3", "Array[" & $i & "] 数组包含: " & $aArray[$i])
	Next
EndFunc   ;==>Test3
