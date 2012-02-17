; *******************************************************
; 示例 1 - 创建一个新的Microsoft Word文件并打开,检查状态栏是否可见,
;              如果可见则关闭, 如果不可见则打开.
; *******************************************************
;
#include <Word.au3>

Local $oWordApp = _WordCreate(@ScriptDir & "\Test.doc")
If _WordPropertyGet($oWordApp, "statusbar") Then
	MsgBox(4096, "状态栏状态", "状态栏可见, 将其关闭.")
	_WordPropertySet($oWordApp, "statusbar", False)
Else
	MsgBox(4096, "状态栏状态", "状态栏不可见, 将其打开.")
	_WordPropertySet($oWordApp, "statusbar", True)
EndIf
