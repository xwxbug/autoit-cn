; *******************************************************
; 示例 1 - 创建一个新的空白文档Word窗口, 打开一个文档,
;				然后设置标题,主题,作者名字属性
; *******************************************************
;
#include <Word.au3>
$oWordApp = _WordCreate (@ScriptDir & "\Test.doc")
$oDoc = _WordDocGetCollection ($oWordApp, 0)
_WordDocPropertySet ($oDoc, "Title", "Test Title")
_WordDocPropertySet ($oDoc, "Subject", "Test Subject")
_WordDocPropertySet ($oDoc, "Author", "Test Author")