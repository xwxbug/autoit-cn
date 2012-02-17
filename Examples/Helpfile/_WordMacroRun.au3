; *******************************************************
; 示例 - 创建一个新的Microsoft Word文件并,带参数"Test"运行一个
;        名为"My Macro"的宏, 然后不保存退出.
; *******************************************************
;
#include <Word.au3>

Local $oWordApp = _WordCreate(@ScriptDir & "\Test.doc")
_WordMacroRun($oWordApp, "My Macro", "Test")
_WordQuit($oWordApp, 0)
