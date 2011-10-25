; *******************************************************
; 示例 1 - 创建word窗口, 打开文档, 然后读取按索引读取所有可用属性
; *******************************************************
#include <Word.au3>
#include <Array.au3>
Dim $aProp
$oWordApp = _WordCreate(@ScriptDir & "\Test.doc")
$oDoc = _WordDocGetCollection($oWordApp, 0)
For $i = 1 To 30
	_ArrayAdd($aProp, _WordDocPropertyGet($oDoc, $i))
Next
_ArrayDisplay($aProp)

; *******************************************************
; 示例2 - 创建word窗口, 打开文档, 然后读取标题，主题和作者名
; *******************************************************
#include <Word.au3>
$oWordApp = _WordCreate(@ScriptDir & "\Test.doc")
$oDoc = _WordDocGetCollection($oWordApp, 0)
msgbox(4096, '', "Title -" & _WordDocPropertyGet($oDoc, "Title") & @CRLF & _
		"Subject -" & _WordDocPropertyGet($oDoc, "Subject") & @CRLF & _
		"Author -" & _WordDocPropertyGet($oDoc, "Author"))

