; *******************************************************
; 示例 1 - 创建一个新的Microsoft Word文件并打开,追加一些文本,然后保存更改退出.
;
; *******************************************************
;
#include <Word.au3>
$oWordApp = _WordCreate (@ScriptDir & "\Test.doc")
$oDoc = _WordDocGetCollection ($oWordApp, 0)

Sleep(3500);延迟以便观察变化
$oDoc.Range.insertAfter ("这是追加的文本内容.")
Sleep(3500);延迟以便观察变化

_WordDocSave ($oDoc)
_WordQuit ($oWordApp)