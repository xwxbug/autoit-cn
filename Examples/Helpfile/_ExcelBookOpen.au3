; ***************************************************************
; 示例 1 打开一个现有的工作表并返回其对象标识符
; *****************************************************************

#include <Excel.au3>

$sFilePath1 = @ScriptDir & "\Test1.xls" ;这个文件应该已经存在
$oExcel = _ExcelBookOpen($sFilePath1)

If @error = 1 Then
	MsgBox(0, "错误!", "无法创建对象!")
	Exit
ElseIf @error = 2 Then
	MsgBox(0, "错误!", "文件不存在!")
	Exit
EndIf