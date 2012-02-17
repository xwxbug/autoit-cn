; ***************************************************************
; 示例 1 - 打开一个工作簿并返回其对象标识符后, 在循环中写入内容到单元格.  删除一行, 然后保存并关闭文件.
; *****************************************************************

#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

For $i = 1 To 5 ;循环
	_ExcelWriteCell($oExcel, $i, $i, 1) ;把数值 1 到 5 垂直写入单元格
Next

ToolTip("Deleting Rows Soon...")
Sleep(3500)

_ExcelRowDelete($oExcel, 1, 1) ;删除第一行并且仅删除一行

MsgBox(4096, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出

; ***************************************************************
; 示例 2 - 打开一个工作簿并返回其对象标识符后, 在循环中写入内容到单元格.  删除一些行, 然后保存并关闭文件.
; *****************************************************************

#include <Excel.au3>

$oExcel = _ExcelBookNew() ; 打开新工作簿, 并使其可见

For $i = 1 To 5 ;循环
	_ExcelWriteCell($oExcel, $i, $i, 1) ;把数值 1 到 5 垂直写入单元格
Next

ToolTip("Deleting Rows Soon...")
Sleep(3500)

_ExcelRowDelete($oExcel, 3, 2) ;从第三行开始删除, 并且删除两行

MsgBox(4096, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出
