; ***************************************************************
; 示例 1 - 打开一个工作簿并返回其对象标识符后, 使用循环写入内容到单元格.  然后输入公式.
; *****************************************************************

#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

For $i = 0 To 20 ;循环
	_ExcelWriteCell($oExcel, $i, $i, 1) ;写入内容到单元格
Next

_ExcelWriteFormula($oExcel, "=Average(R1C1:R20C1)", 1, 2) ;使用 R1C1 引用样式

MsgBox(4096, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出
