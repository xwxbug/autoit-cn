; *******************************************************
; 示例 1 - 创建一个新的Word窗口并打开一个已经存在的文档.
; *******************************************************
;
#include <Word.au3>
$oWordApp = _WordCreate ("")
$oDoc = _WordDocOpen ($oWordApp, @ScriptDir & "\Test.doc")