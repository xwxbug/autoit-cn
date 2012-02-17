; ***************************************************************
; 示例 1 - 打开一个工作簿并返回其对象标识符后, 写入内容到单元格.  然后保存并关闭文件
; *****************************************************************

#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

_ExcelWriteCell($oExcel, "I Wrote to This Cell", 1, 1) ;写入内容到单元格

MsgBox(4096, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出

; ***************************************************************
; 示例 2 - 打开一个工作簿并返回其对象标识符后, 在循环中写入内容到单元格.  Then Save and Close file.
; *****************************************************************

#include <Excel.au3>

$oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

For $i = 1 To 20 ;循环
	_ExcelWriteCell($oExcel, "I Wrote to This Cell", $i, 1) ;写入内容到单元格
Next

MsgBox(4096, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出


; ***************************************************************
; 示例 3 - 打开一个工作簿并返回其对象标识符后, 在循环中写入内容到单元格.  然后使用 _ExcelWriteCell 写入公式
; *****************************************************************

#include <Excel.au3>

$oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

For $i = 1 To 20 ;循环
	_ExcelWriteCell($oExcel, $i, $i, 1) ;写入内容到单元格
Next

_ExcelWriteCell($oExcel, "=Average(A:A)", 1, 2) ;使用 A1 引用样式, 而不是 R1C1
_ExcelWriteCell($oExcel, "=Average(A1:A20)", 1, 3) ;写入公式的另一种方法 - 使用 A1 引用样式, 而不是 R1C1

MsgBox(4096, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出
