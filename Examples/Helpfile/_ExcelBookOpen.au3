
; ***************************************************************
; 示例 - 打开存在的工作簿并返回其对象标识
; *****************************************************************

#include  <Excel.au3>

$sFilePath1 = @ScriptDir & "\Test1.xls" ;该文件应该已存在
$oExcel = _ExcelBookOpen($sFilePath1)

If @error = 1 Then
	msgbox(0, "Error!", "Unable to Create the Excel Object")
	Exit
ElseIf @error = 2 Then
	msgbox(0, "Error!", "File does not exist - Shame on you!")
	Exit
EndIf

