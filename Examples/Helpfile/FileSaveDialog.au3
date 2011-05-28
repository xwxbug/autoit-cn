Local $MyDocsFolder = "::{450D8FBA-AD25-11D0-98A8-0800361B1103}"

Local $var = FileSaveDialog( "输入一个名称.", $MyDocsFolder, "AU3脚本或文本 (*.txt;*.au3)", 2)
; 选项 2 = 除非选择一个有效的路径/文件,或者按下取消按钮,对话框不能关闭.

If @error Then
	MsgBox(4096,"","已取消保存.")
Else
	MsgBox(4096,"","你保存为了:" & $var)
EndIf


; 多组筛选选项
$var = FileSaveDialog( "输入一个名称.", $MyDocsFolder, "AU3脚本 (*.au3)|文本文件 (*.ini;*.txt)", 2)
; 选项 2 = 除非选择一个有效的路径/文件,或者按下取消按钮,对话框不能关闭.

If @error Then
	MsgBox(4096,"","已取消保存.")
Else
	MsgBox(4096,"","你保存为了:" & $var)
EndIf