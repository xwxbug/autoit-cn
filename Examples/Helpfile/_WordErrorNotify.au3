; *******************************************************
; 示例 1 - 检查 _WordErrorNotify 的当前状态, 如果状态为打开则关闭,如果状态为关闭则打开
; *******************************************************
;
#include <Word.au3>

If _WordErrorNotify() Then
	MsgBox(4096, "_WordErrorNotify 状态", "状态为打开, 关闭它.")
	_WordErrorNotify(1)
Else
	MsgBox(4096, "_WordErrorNotify 状态", "状态为关闭, 打开它.")
	_WordErrorNotify(0)
EndIf