; *******************************************************
; 示例 1 - 创建一个新的Microsoft Word文件并打开,追加一些文本,
;				执行另存为操作, 然后退出.
; *******************************************************
;
#include <Word.au3>
$oWordApp = _WordCreate ()
$oDoc = _WordDocGetCollection ($oWordApp, 0)

Sleep(3500);延迟以便观察变化
$oDoc.Range.Text = "这是追加的文本内容."
Sleep(3500);延迟以便观察变化

_WordDocSaveAs ($oDoc, @ScriptDir & "\Test.doc")
_WordQuit ($oWordApp)