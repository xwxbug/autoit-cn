
; ***************************************************************
; 例1 - 打开工作簿并返回其对象标识后使用循环写入单元格. 格式化数字后保存并关闭文件.
; *****************************************************************
#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿并使之可见

; 可以使用一个简单循环和随机数字填充单元格
For $y = 1 To 10
	For $x = 1 To 10
		_ExcelWriteCell($oExcel, Random(1000, 10000), $x, $y) ;插入一些随机数字
	Next
Next

$sFormat = "$#,##0.00" ;_ExcelNumberFormat格式化字符串单元格使其带有$现金符号
_ExcelNumberFormat($oExcel, $sFormat, 1, 1, 5, 5) ;在行1, 列1开始, 在行5, 列5结束

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 将其保存到临时文件夹; 如果有必要覆盖已存在文件
_ExcelBookClose($oExcel) ; 关闭退出

; ***************************************************************
; 例2 - 打开工作簿并返回其对象标识后使用循环写入单元格. 格式化数字后保存并关闭文件.
; *****************************************************************
#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿并使之可见
Local $aFormatExamples[5] = ["Format Examples", "General", "hh:mm:ss", "$#,##0.00", "[Red]($#,##0.00)"] ;用于创建表头的数组

For $i = 0 To UBound($aFormat示例s) - 1 ;用于创建表头的数组
	_ExcelWriteCell($oExcel, $aFormatExamples[$i], 1, $i + 1) ; +1到$i以便0基索引与行匹配
Next

; 可以使用一个简单循环和随机数字填充单元格
For $y = 2 To 5 ;在列2处开始
	For $x = 2 To 10
		_ExcelWriteCell($oExcel, Random(1000, 10000), $x, $y) ; 插入一些随机数字
	Next
Next

ToolTip("Formatting Column(s) Soon...")
Sleep(3500) ;暂停使用户观察操作

; 可以使用一个简单循环格式化
; 每列将具有不同类型的格式
For $i = 1 To UBound($aFormat示例s) - 1
	_ExcelNumberFormat($oExcel, $aFormatExamples[$i], 2, $i, 11, $i)
Next

$oExcel . Columns . AutoFit ;自动匹配列以便更好观察
$oExcel . Rows . AutoFit ;自动匹配列以便更好观察

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 将其保存到临时文件夹; 如果有必要覆盖已存在文件
_ExcelBookClose($oExcel) ; 关闭退出

