; ***************************************************************
; 示例 1 - 打开一个工作簿并返回其对象标识符后, 写入内容到单元格.  读取单元格内容, 然后保存并关闭文件.
; *****************************************************************

#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

_ExcelWriteCell($oExcel, "I Wrote to This Cell", 1, 1) ;写入内容到单元格
Local $sCellValue = _ExcelReadCell($oExcel, 1, 1)
MsgBox(4096, "", "The Cell Value is: " & @CRLF & $sCellValue, 2)

MsgBox(4096, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出

; ***************************************************************
; 示例 2 - 打开一个工作簿并返回其对象标识符后, 在循环中写入内容到单元格.  读取单元格内容, 然后保存并关闭文件.
; *****************************************************************

#include <Excel.au3>

$oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

For $i = 1 To 5 ;循环
	_ExcelWriteCell($oExcel, $i, $i, 1) ;写入内容到单元格
Next

For $i = 1 To 5 ;循环
	$sCellValue = _ExcelReadCell($oExcel, $i, 1)
	MsgBox(4096, "", "The Cell Value is: " & @CRLF & $sCellValue, 2)
Next

MsgBox(4096, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出
