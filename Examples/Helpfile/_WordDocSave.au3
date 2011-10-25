; *******************************************************
; 示例 - 打开一个已存在的word文档, 添加一些文本, 然后保存并退出.
; *******************************************************
#include  <Word.au3>
$oWordApp = _WordCreate(@ScriptDir & " \Test.doc ")
$oDoc = _WordDocGetCollection($oWordApp ", 0 )
$oDoc.Range.insertAfter(" This is some text to insert. ")
_WordDocSave($oDoc)
_WordQuit($oWordApp)

