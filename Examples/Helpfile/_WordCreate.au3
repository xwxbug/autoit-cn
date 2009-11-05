; *******************************************************
; 例子 1 - 创建一个新的Microsoft Word文件并打开(创建成功则自动保存到相应路径)
; *******************************************************
;
#include <Word.au3>
$oWordApp = _WordCreate (@ScriptDir & "\Test.doc")

; *******************************************************
; 例子 2 - 尝试附加到一个已存在的word窗口
;               如果文件不存在，创建一个新的Microsoft Word文件并打开.
; *******************************************************
;尝试附加到一个已存在的word窗口
#include <Word.au3>
$oWordApp = _WordCreate (@ScriptDir & "\Test.doc", 1)
; Check @extended return value to see if attach was successful
If @extended Then
	MsgBox(0, "附加成功", "附加到现有的窗口")
Else
	MsgBox(0, "附加失败", "创建新窗口")
EndIf

; *******************************************************
; 例子 3 - 创建一个新Microsoft Word文件并打开
; *******************************************************
;
#include <Word.au3>
$oWordApp = _WordCreate ()

; *******************************************************
;例子 4 -创建一个新的Microsoft Word文件并打开(指定窗口为隐藏状态)，
;            追加一些文本，然后保存更改退出.
; *******************************************************
;
#include <Word.au3>
$oWordApp = _WordCreate (@ScriptDir & "\Test.doc", 0, 0)
$oDoc = _WordDocGetCollection ($oWordApp, 0)
$oDoc.Range.insertAfter ("这是追加的文本内容.")
_WordQuit ($oWordApp, -1)