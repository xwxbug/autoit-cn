#include <Array.au3>

; 字符串转换为 ASCII 码数组.
Local $a = StringToASCIIArray("abc")

; 显示包含每个字符的ASCII码的数组.
_ArrayDisplay($a)

; ASCII 码数组转换为字符串.
Local $s = StringFromASCIIArray($a)

;转换结果将会返回 ASCII 码表示的字符串.
MsgBox(0, "转换结果", $s)

