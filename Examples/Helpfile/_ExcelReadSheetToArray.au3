; ******************************************************************************************
; 示例 1 打开一个新的工作表并返回其对象标识符, 填充一些单元格并使用不同参数将值读入数组, 然后保存并关闭文件.
; ******************************************************************************************

#include <Excel.au3>
#include <Array.au3>

Local $oExcel = _ExcelBookNew() ;创建一个新的工作表并打开

;使用一个简单的循环和随机数字填充单元格
For $y = 1 To 10 ;从第一列开始
	For $x = 1 To 15
		_ExcelWriteCell($oExcel, Round(Random(1000, 10000), 0), $x, $y) ;向文件写入随机数字信息
	Next
Next

$aArray = _ExcelReadSheetToArray($oExcel) ;使用默认参数
_ArrayDisplay($aArray, "使用默认参数")

$aArray = _ExcelReadSheetToArray($oExcel, 2) ;从第2行开始
_ArrayDisplay($aArray, "从第2行开始")

$aArray = _ExcelReadSheetToArray($oExcel, 1, 2) ;从第2列开始
_ArrayDisplay($aArray, "从第2列开始")

$aArray = _ExcelReadSheetToArray($oExcel, 1, 1, 5) ;读取5行
_ArrayDisplay($aArray, "读取5行")

$aArray = _ExcelReadSheetToArray($oExcel, 1, 1, 0, 2) ;读取2列
_ArrayDisplay($aArray, "读取2列")

$aArray = _ExcelReadSheetToArray($oExcel, 2, 3, 4, 5) ;从第2行第3列开始, 读取4行5列
_ArrayDisplay($aArray, "从第2行第3列开始, 读取4行5列")

$aArray = _ExcelReadSheetToArray($oExcel, 1, 1, 0, 0, True);使用默认参数, 除非跨列(真)
_ArrayDisplay($aArray, "使用默认参数, 除非跨列(真)")

MsgBox(0, "退出", "按[确定]保存文件并退出")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 在临时目录保存文件, 如果文件已存在则覆盖原文件
_ExcelBookClose($oExcel) ; 关闭工作表, 退出