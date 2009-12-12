; *****************************************************************
; 示例 1 打开一个新的工作表并返回其对象标识符, 然后设置一个范围内的字体属性.
; *****************************************************************
#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ;创建一个新的工作表并打开
Local $sRangeOrRowStart = 1, $iColStart = 1, $iRowEnd = 10, $iColEnd = 10
Local $fBold, $fItalic, $fUnderline, $i = 1

;使用一个简单的循环和随机数字填充单元格
For $i = 1 To 10
	For $j = 1 To 10
		_ExcelWriteCell($oExcel, Round(Random(1, 100), 0), $i, $j) ;向文件写入随机数字信息
	Next
Next

MsgBox(0, "提示", "注意字体属性,下面将会显示所有可能的组合！" & @CRLF & "按[确定]开始")

$i = 1
_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, False, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, False, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, False, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, False, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, False, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, False, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, True, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, True, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, True, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, False, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, False, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, False, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, True, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, True, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, True, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, True, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, True, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, True, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, True, True, True)
ToolTip("设置一个新的字体属性: " & $i)
$i += 1
Sleep(2500)

_ExcelFontSetProperties($oExcel, $sRangeOrRowStart, $iColStart, $iRowEnd, $iColEnd, False, False, False)
ToolTip("设置一个新的字体属性: " & $i)

MsgBox(0, "退出", "按[确定]保存文件并退出")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ;保存至临时目录中,如果文件已存在将覆盖原文件
_ExcelBookClose($oExcel)  ;关闭工作表.