
; *******************************************************
; 示例 - 创建一个不可见的word窗体, 打开一个文档, 获取信息后退出
; *******************************************************

#include <Word.au3>

$oWordApp = _WordCreate(@ScriptDir & "\Test.doc", 0, 0)
; 显示文档中的文本
$sText = $oWordApp.ActiveDocument.Range.Text
msgbox(0, "Document Text", $sText)
_WordQuit($oWordApp)

