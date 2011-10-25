
; **********************************************************
; 创建一个word窗口, 打开一个文档, 隐藏窗体, 然后再使其可见.
; **********************************************************
#include <Word.au3>
$oWordApp = _WordCreate(@ScriptDir & " \Test.doc ")
Sleep(2000)
_WordPropertySet($oWordApp, "visible ", False)
Sleep(2000)
_WordPropertySet($oWordApp, "visible ", True)

