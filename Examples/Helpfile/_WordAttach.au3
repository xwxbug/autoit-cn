; *******************************************************
; 示例 1 - 附加到已打开 "Test.doc" 文件的 Word 窗口,
;				然后显示此文档的完整文件路径.
; *******************************************************
;
#include <Word.au3>

Local $oWordApp = _WordAttach(@ScriptDir & "\Test.doc", "FileName")
If Not @error Then
	Local $oDoc = _WordDocGetCollection($oWordApp, 0)
	MsgBox(4160, "Document FileName", $oDoc.FullName)
EndIf

; *******************************************************
; 示例 2 - 附加到文档正文中含有 "The quick brown fox"
;               文本的 Word 窗口
; *******************************************************
;
#include <Word.au3>
$oWordApp = _WordAttach("The quick brown fox", "Text")
