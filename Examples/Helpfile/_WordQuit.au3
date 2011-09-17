; *******************************************************
; 示例 1 - 创建一个新的Microsoft Word文件并打开,获取文本内容后退出.
;
; *******************************************************
;
#include <Word.au3>

Local $oWordApp = _WordCreate(@ScriptDir & "\Test.doc", 0, 0)
; 显示获取的文本内容
Local $sText = $oWordApp.ActiveDocument.Range.Text
MsgBox(0, "获取文本内容", $sText)
_WordQuit($oWordApp)
