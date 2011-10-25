
; ******************************************************************************************
; 例 - 打开并返回工作簿对象标识后, 填充一些单元格并使用不同参数将值读入数组.
; ******************************************************************************************

#include  <Excel.au3>
#include  <Array.au3>

Local $oExcel = _ExcelBookNew() ;创建一个新的工作表并打开

; 可以使用一个简单循环和随机数字填充单元格
For $y = 1 To 10 ;从列1开始
	For $x = 1 To 15
		_ExcelWriteCell($oExcel, Round( Random(1000, 10000), 0), $x, $y) ;填入一些随机数字
	Next
Next

$aArray = _ExcelReadSheetToArray($oExcel) ;使用默认参数
_ArrayDisplay($aArray, "Array using Default param")

$aArray = _ExcelReadSheetToArray($oExcel, 2) ;从第2行开始
_ArrayDisplay($aArray, "Starting on the 2nd Row")

$aArray = _ExcelReadSheetToArray($oExcel, 1, 2) ;从第2列开始
_ArrayDisplay($aArray, "Starting on the 2nd Column")

$aArray = _ExcelReadSheetToArray($oExcel, 1, 1, 5) ;读取5行
_ArrayDisplay($aArray, "Read 5 Rows")

$aArray = _ExcelReadSheetToArray($oExcel, 1, 1, 0, 2) ;读取2列
_ArrayDisplay($aArray, "Read 2 Columns")

$aArray = _ExcelReadSheetToArray($oExcel, 2, 3, 4, 5) ;从第2行第3列开始, 读取4行5列
_ArrayDisplay($aArray, "Starting on the 2nd Row, 3rd Column, Read 4 Rows and 5 Columns")

$aArray = _ExcelReadSheetToArray($oExcel, 1, 1, 0, 0, True) ;使用默认参数, 除非跨列为真
_ArrayDisplay($aArray, "Array with Column shifting")

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 将其保存至临时目录; 必要时覆盖已存在的文件
_ExcelBookClose($oExcel) ; 关闭退出

