
; ***************************************************************
; 示例 - 打开并返回工作簿对象标识后, 将单元格读入数组, 显示数组, 保存后关闭文件.
; *****************************************************************

#include  <Excel.au3>
#include  <Array.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿, 并使之可见

For $i = 1 To 5 ;循环
	_ExcelWriteCell($oExcel, $i, $i, 1) ;用值1到5垂直写入单元格
Next

For $i = 1 To 5 ;循环
	_ExcelWriteCell($oExcel, Asc($i), 1, $i + 2) ;水平写入单元格, 出于读取目的需使用不同值时可使用ASCII
Next

$aArray1 = _ExcelReadArray($oExcel, 1, 1, 5, 1) ;垂直方向
$aArray2 = _ExcelReadArray($oExcel, 1, 3, 5) ;水平方向
_ArrayDisplay($aArray2, "Horizontal")
_ArrayDisplay($aArray1, "Vertical")

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在将其保存至临时目录; 必要时覆盖已存在的文件
_ExcelBookClose($oExcel) ; 关闭退出

