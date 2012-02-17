; *******************************************************
; 示例 1 - 创建 word 窗口, 打开文档, 查找 "this",
;				用 "THIS" 替换所有匹配, 不保存修改退出.
; *******************************************************
;
#include <Word.au3>

Local $oWordApp = _WordCreate(@ScriptDir & "\Test.doc")
Local $oDoc = _WordDocGetCollection($oWordApp, 0)
Local $oFind = _WordDocFindReplace($oDoc, "this", "THIS")
If $oFind Then
	MsgBox(4096, "FindReplace", "Found and replaced.")
Else
	MsgBox(4096, "FindReplace", "Not Found")
EndIf
_WordQuit($oWordApp, 0)
