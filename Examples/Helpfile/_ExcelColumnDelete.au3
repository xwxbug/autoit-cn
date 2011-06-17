; ***************************************************************
; 示例 1 打开一个新的工作表并返回其对象标识符, 然后使用一个循环写入单元格. 提示结束后删除一列，然后保存并关闭文件.
; *****************************************************************

#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ;创建一个新的工作表并打开

For $i = 1 To 5 ;循环
	_ExcelWriteCell($oExcel, $i, 1, $i) ;在工作表单元格中横向写入 1 至 5 信息
Next

ToolTip("准备删除列...")
Sleep(3500)

_ExcelColumnDelete($oExcel, 1, 1) ;删除第1列,删除1列

MsgBox(0, "退出", "按[确认]保存文件并退出")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 在临时目录保存文件, 如果文件已存在则覆盖原文件
_ExcelBookClose($oExcel) ; 关闭工作表, 退出


; ***************************************************************
; 示例 2 打开一个新的工作表并返回其对象标识符, 然后使用一个循环写入单元格. 提示结束后删除一些列，然后保存并关闭文件.
; *****************************************************************

#include <Excel.au3>

$oExcel = _ExcelBookNew() ;创建一个新的工作表并打开

For $i = 1 To 5 ;循环
	_ExcelWriteCell($oExcel, $i, 1, $i) ;在工作表单元格中横向写入 1 至 5 信息
Next

ToolTip("准备删除列...")
Sleep(3500)

_ExcelColumnDelete($oExcel, 3, 2) ;删除第3列，删除2列

MsgBox(0, "退出", "按[确定]保存文件并退出")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 在临时目录保存文件, 如果文件已存在则覆盖原文件
_ExcelBookClose($oExcel) ; 关闭工作表, 退出
