#include <String.au3>

; 插入三个 "移动的" 下划线并打印结果到控制台
For $i = -20 To 20
	ConsoleWrite($i & @TAB & _StringInsert("Supercalifragilistic", "___", $i) & @CRLF)
Next
