; ***************************************************************
; 示例 1 - 打开一个工作簿并返回其对象标识符后, 在循环中写入内容到单元格.  对数字进行格式化设置, 然后保存并关闭文件.
; *****************************************************************

#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

; 我们在单个循环中使用随机数填充一些单元格
For $y = 1 To 10
	For $x = 1 To 10
		_ExcelWriteCell($oExcel, Random(1000, 10000), $x, $y) ;写入到文件的一些随机数
	Next
Next

Local $sFormat = "$#,##0.00" ;格式字符串告知 _ExcelNumberFormat 把它格式化成美元 ($) 货币
_ExcelNumberFormat($oExcel, $sFormat, 1, 1, 5, 5) ;从第 1 行, 第一列开始到第 5 行第 5 列结束

MsgBox(4096, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出

; ***************************************************************
; 示例 2 - 打开一个工作簿并返回其对象标识符后, 在循环中写入内容到单元格.  对数字进行格式化设置, 然后保存并关闭文件.
; *****************************************************************

#include <Excel.au3>

$oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见
Local $aFormatExamples[5] = ["Format Examples", "General", "hh:mm:ss", "$#,##0.00", "[Red]($#,##0.00)"] ;创建由标题组成的数组

For $i = 0 To UBound($aFormatExamples) - 1 ;在循环中写入标题
	_ExcelWriteCell($oExcel, $aFormatExamples[$i], 1, $i + 1) ; 给 $i 加 1 这样基于 0 的索引可以与行匹配
Next

; 我们在单个循环中使用随机数填充一些单元格
For $y = 2 To 5 ;从第 2 列开始
	For $x = 2 To 10
		_ExcelWriteCell($oExcel, Random(1000, 10000), $x, $y) ;写入到文件的一些随机数
	Next
Next

ToolTip("Formatting Column(s) Soon...")
Sleep(3500) ;暂停以便用户查看操作

; 我们可以在一个简单的循环中进行格式化
; 每列将使用不同的格式类型
For $i = 1 To UBound($aFormatExamples) - 1
	_ExcelNumberFormat($oExcel, $aFormatExamples[$i], 2, $i, 11, $i)
Next

$oExcel.Columns.AutoFit ;自动调整列以获得更佳视图
$oExcel.Rows.AutoFit ;自动调整行以获得更佳视图

MsgBox(4096, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出
