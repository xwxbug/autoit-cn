; *******************************************************
; 示例 1 - 创建一个新的Microsoft Word文件并打开，隐藏Word窗口, 然后再使其可见.
;
; *******************************************************
;
#include <Word.au3>
$oWordApp = _WordCreate (@ScriptDir & "\Test.doc")
Sleep(2000)
_WordPropertySet ($oWordApp, "visible", False);隐藏
Sleep(2000)
_WordPropertySet ($oWordApp, "visible", True);显示