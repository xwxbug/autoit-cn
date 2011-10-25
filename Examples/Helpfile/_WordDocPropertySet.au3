
;
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; 示例 - 创建word窗口, 打开文档, 然后设置标题，题目和作者属性
;
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;
#include  <Word.au3>
$oWordApp = _WordCreate(@ScriptDir & "\Test.doc")
$oDoc = _WordDocGetCollection($oWordApp, 0)
_WordDocPropertySet($oDoc, "Title", "Test Title")
_WordDocPropertySet($oDoc, "Subject", "Test
Subject" )
_WordDocPropertySet($oDoc, "Author", "Test Author")

