; ***************************************************************
; 示例 1 - 打开一个新的工作表并返回其对象标识符, 然后在没有任何提示的情况下保存该文件.
; *****************************************************************

#include <Excel.au3>

Local $sFilePath1 = @ScriptDir & "\Test.xls" ;这个文件应该已经存在
Local $oExcel = _ExcelBookOpen($sFilePath1)

If @error = 1 Then
	MsgBox(4096, "错误!", "无法创建对象!")
	Exit
ElseIf @error = 2 Then
	MsgBox(4096, "错误!", "文件不存在!")
	Exit
EndIf

_ExcelBookSaveAs($oExcel, @TempDir & "\SaveAsExample", "xls");没有任何提示的情况下保存
If Not @error Then MsgBox(4096, "成功!", "文件已保存!", 3)
_ExcelBookClose($oExcel, 1, 0) ;在没有任何提示的情况下保存该文件，然后关闭.


; ***************************************************************
; 示例 2 - 打开一个新的工作表并返回其对象标识符, 然后在没有任何提示的情况下保存该文件.
;				如果文件存在则覆盖它, 并使用密码选项保护文件. 然后打开这个工作表文件，并显示密码保护.
; *****************************************************************

#include <Excel.au3>

$sFilePath1 = @ScriptDir & "\Test.xls" ;这个文件应该已经存在
$oExcel = _ExcelBookOpen($sFilePath1)

;显示打开文件时可能发生的错误提示
If @error = 1 Then
	MsgBox(4096, "错误!", "无法创建对象!")
	Exit
ElseIf @error = 2 Then
	MsgBox(4096, "错误!", "文件不存在!")
	Exit
EndIf

_ExcelBookSaveAs($oExcel, @TempDir & "\SaveAsExample2", "xls", 0, 1, "ReadOnly") ;保存为"SaveAsExample2.xls"文件
If Not @error Then MsgBox(4096, "成功!", "File was Saved!", 3)
_ExcelBookClose($oExcel, 1, 0) ;在没有任何提示的情况下保存该文件，然后关闭.

$oExcel = _ExcelBookOpen(@TempDir & "\SaveAsExample2.xls", 1, False) ;打开这个工作表文件，并显示密码保护