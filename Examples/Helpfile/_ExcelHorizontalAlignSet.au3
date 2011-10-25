
; *****************************************************************
; 示例 - 打开并返回工作簿对象标识后, 设置一个范围内各行的水平对齐.
; *****************************************************************

#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿, 并使之可见
Local $sRangeOrRowStart = 1, $iColStart = 1, $iRowEnd = 10, $iColEnd = 10, $sHorizAlign = "left"

; 可以使用简单循环和随机数字填充单元格
For $i = 1 To 10
	For $j = 1 To 10
		_ExcelWriteCell($oExcel, Round( Random(1, 100), 0), $i, $j) ; 向文件随机写入数字
	Next
Next

msgbox(0, "_ExcelHorizontalAlignSet", "Notice the Alignment" & @CRLF & "Press OK to Continue")

_ExcelHorizontalAlignSet($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, $sHorizAlign)
msgbox(0, "_ExcelHorizontalAlignSet", "Alignment should be 'left'")

$sHorizAlign = "center"
_ExcelHorizontalAlignSet($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, $sHorizAlign)
msgbox(0, "_ExcelHorizontalAlignSet", "Alignment should be 'center'")

$sHorizAlign = "right"
_ExcelHorizontalAlignSet($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, $sHorizAlign)
msgbox(0, "_ExcelHorizontalAlignSet", "Alignment should be 'right'")

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在将其保存至临时目录; 必要时覆盖已存在的文件
_ExcelBookClose($oExcel) ;

