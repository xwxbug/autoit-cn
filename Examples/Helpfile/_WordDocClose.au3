; *******************************************************
; 示例 - 创建空白的word窗体, 打开一个已存在的文件, 关闭文件退出.
; *******************************************************
#include  <Word.au3>
$oWordApp = _WordCreate("")
$oDoc = _WordDocOpen($oWordApp, @ScriptDir & " \Test.doc ")
_WordDocClose($oDoc)
_WordQuit($oWordApp)

