
; ***************************************************************
; 例1 - 打开工作簿并返回其对象标识后使用循环写入单元格. 删除一列后保存并关闭文件
; *****************************************************************
#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿, 并使之可见

For $i = 1 To 5 ;循环
	_ExcelWriteCell($oExcel, $i, 1, $i) ;使用值1到5水平写入单元格
Next

ToolTip("Deleting Column Soon...")
Sleep(3500)

_ExcelColumnDelete($oExcel, 1, 1) ;删除列1并仅删除一列

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ;将其保存到临时文件夹; 如果有必要覆盖已存在文件
_ExcelBookClose($oExcel) ; 关闭退出


; ***************************************************************
; 例2 - 打开工作簿并返回其对象标识后使用循环写入单元格. 删除几列后保存并关闭文件.
; *****************************************************************
#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿, 并使之可见

For $i = 1 To 5 ;循环
	_ExcelWriteCell($oExcel, $i, 1, $i) ;使用值1到5水平写入单元格
Next

ToolTip("Deleting Columns Soon...")
Sleep(3500)

_ExcelColumnDelete($oExcel, 3, 2) ;从列3开始删除两列

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 将其保存到临时文件夹; 如果有必要覆盖已存在文件
_ExcelBookClose($oExcel) ; 关闭退出

