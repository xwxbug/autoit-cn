; *******************************************************
; 示例 1 - 创建 word 窗口, 打开文档,
;				然后根据索引读取所有有效的文档属性
; *******************************************************
;
#include <Word.au3>

Local $oWordApp = _WordCreate(@ScriptDir & "\Test.doc")
Local $oDoc = _WordDocGetCollection($oWordApp, 0)
For $i = 1 To 30
	ConsoleWrite("Property Index " & $i & " - " & _WordDocPropertyGet($oDoc, $i) & @CR)
Next

; *******************************************************
; 示例 2 - 创建 word 窗口, 打开文档,
;				然后根据名称读取标题, 主题和作者属性.
; *******************************************************
;
#include <Word.au3>
$oWordApp = _WordCreate(@ScriptDir & "\Test.doc")
$oDoc = _WordDocGetCollection($oWordApp, 0)
ConsoleWrite("Title - " & _WordDocPropertyGet($oDoc, "Title") & @CRLF)
ConsoleWrite("Subject - " & _WordDocPropertyGet($oDoc, "Subject") & @CRLF)
ConsoleWrite("Author - " & _WordDocPropertyGet($oDoc, "Author") & @CRLF)
