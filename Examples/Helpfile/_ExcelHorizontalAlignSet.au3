; *****************************************************************
; 示例 1 打开一个新的工作表并返回其对象标识符, 然后设置一个范围内每个单元格的水平对齐方式
; *****************************************************************

#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ;创建一个新的工作表并打开
Local $sRangeOrRowStart = 1, $iColStart = 1, $iRowEnd = 10, $iColEnd = 10, $sHorizAlign = "left"

;使用一个简单的循环和随机数字填充单元格
For $i = 1 To 10
	For $j = 1 To 10
		_ExcelWriteCell($oExcel, Round(Random(1, 100), 0), $i, $j) ;向文件写入随机数字信息
	Next
Next

MsgBox(0, "提示", "在一个范围内设置每个单元格的水平对齐方式" & @CRLF & "按[确定]开始")

_ExcelHorizontalAlignSet($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, $sHorizAlign)
MsgBox(0, "提示", "水平对齐方式 '左对齐'")

$sHorizAlign = "center"
_ExcelHorizontalAlignSet($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, $sHorizAlign)
MsgBox(0, "提示", "水平对齐方式 '居中'")

$sHorizAlign = "right"
_ExcelHorizontalAlignSet($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, $sHorizAlign)
MsgBox(0, "提示", "水平对齐方式 '右对齐'")

MsgBox(0, "退出", "按[确定]保存文件并退出")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ;保存至临时目录中,如果文件已存在将覆盖原文件
_ExcelBookClose($oExcel)  ;关闭工作表.