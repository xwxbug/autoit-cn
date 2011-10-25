
; ***************************************************************
; 示例 - 打开并返回工作簿对象标识后使用循环写入一个单元格, 然后输入一个公式.
; *****************************************************************

#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿, 并使之可见

For $i = 0 To 20 ;循环
	_ExcelWriteCell($oExcel, $i, $i, 1) ;写入单元格
Next

_ExcelWriteFormula($oExcel, "=Average(R1C1:R20C1)", 1, 2) ;使用R1C1格式

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 将其保存到临时文件夹; 如果有必要覆盖已存在文件
_ExcelBookClose($oExcel) ; 关闭退出

