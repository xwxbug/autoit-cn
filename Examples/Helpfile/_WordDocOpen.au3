; *******************************************************
; 示例 - 创建空的word窗口并打开文件
; *******************************************************
;
#include <Word.au3>
$oWordApp = _WordCreate("")
$oDoc = _WordDocOpen($oWordApp, @ScriptDir & " \Test.doc ")

