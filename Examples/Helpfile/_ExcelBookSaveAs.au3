
; ***************************************************************
; 例1 - 打开存在的工作簿并返回其对象标识. 然后在无警告情况下使用新名称另存文件.
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

_ExcelBookSaveAs($oExcel, @ScriptDir & "\SaveAs示例", "xls")
If Not @error Then msgbox(0, "Success", "File was Saved!", 3)
_ExcelBookClose($oExcel, 1, 0) ;此方法将在关闭前保存文件, 且无论文件是否发生改变都不会有普通警告


; ***************************************************************
; 例2 - 打开存在的工作簿并返回其对象标识. ?然后在无警告情况下使用新名称另存文件.
;       当文件存在时覆盖, 其使用密码保护. 然后打开文件显示密码保护
; *****************************************************************
#include  <Excel.au3>

$sFilePath1 = @ScriptDir & "\Test1.xls" ;该文件应该已存在
$oExcel = _ExcelBookOpen($sFilePath1)

;显示打开文件时可能发生的任何错误
If @error = 1 Then
	msgbox(0, "Error!", "Unable to Create the Excel Object")
	Exit
ElseIf @error = 2 Then
	msgbox(0, "Error!", "File does not exist - Shame on you!")
	Exit
EndIf

_ExcelBookSaveAs($oExcel, @ScriptDir & "\SaveAsExample2", "xls", 0, 1, "ReadOnly") ;保存文件为'SaveAsExample2.xls"
If Not @error Then msgbox(0, "Success", "File was Saved!", 3)
_ExcelBookClose($oExcel, 1, 0) ;此方法将在关闭前保存文件, 且无论文件是否发生改变都不会有普通警告

$oExcel = _ExcelBookOpen(@ScriptDir & "\SaveAsExample2.xls", 1, False) ;打开以前的文件并显示密码保护

