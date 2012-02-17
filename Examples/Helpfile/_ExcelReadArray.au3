; ***************************************************************
; 示例 1 - 打开一个工作簿并返回其对象标识符后, 在循环中写入内容到单元格.  读取单元格内容到数组中, 显示数组,
;				然后保存并关闭文件.
; *****************************************************************

#include <Excel.au3>
#include <Array.au3>

Local $oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

For $i = 1 To 5 ;循环
	_ExcelWriteCell($oExcel, $i, $i, 1) ;把数值 1 到 5 垂直写入单元格
Next

For $i = 1 To 5 ;循环
	_ExcelWriteCell($oExcel, Asc($i), 1, $i + 2) ;水平写入单元格, 使用 Asc 得到不同值用于读取
Next

Local $aArray1 = _ExcelReadArray($oExcel, 1, 1, 5, 1) ;方向是水平的
Local $aArray2 = _ExcelReadArray($oExcel, 1, 3, 5) ;方向是垂直的
_ArrayDisplay($aArray2, "Horizontal")
_ArrayDisplay($aArray1, "Vertical")

MsgBox(4096, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出
