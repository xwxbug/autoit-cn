
; ***************************************************************
; 例1 - 打开并返回工作簿对象标识后写入单元格, 读取单元格, 保存后关闭文件.
; *****************************************************************

#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿, 并使之可见

_ExcelWriteCell($oExcel, "I Wrote to This Cell", 1, 1) ;写入单元格
$sCellValue = _ExcelReadCell($oExcel, 1, 1)
msgbox(0, "", "The Cell Value is:" & @CRLF & $sCellValue, 2)

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在将其保存至临时目录; 必要时覆盖已存在的文件
_ExcelBookClose($oExcel) ; 关闭退出

; ***************************************************************
; 例2 - 打开并返回工作簿对象标识后使用循环写入单元格, 读取单元格, 保存后关闭文件.
; *****************************************************************

#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿, 并使之可见

For $i = 1 To 5 ;循环
	_ExcelWriteCell($oExcel, $i, $i, 1) ;写入单元格
Next

For $i = 1 To 5 ;循环
	$sCellValue = _ExcelReadCell($oExcel, $i, 1)
	msgbox(0, "", "The Cell Value is:" & @CRLF & $sCellValue, 2)
Next

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 将其保存至临时目录; 必要时覆盖已存在的文件
_ExcelBookClose($oExcel) ; 关闭退出

