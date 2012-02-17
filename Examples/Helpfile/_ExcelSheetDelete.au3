; ***************************************************************
; 示例 1 - 打开工作簿并返回其对象标识符后, 根据字符串名删除一个工作表
; *****************************************************************

#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

_ExcelSheetDelete($oExcel, "Sheet1") ;根据表示工作表名称的字符串删除相应的工作表

MsgBox(4096, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出

; ***************************************************************
; 示例 2 - 打开工作簿并返回其对象标识符后, 根据索引值删除相应的工作表
; *****************************************************************

#include <Excel.au3>

$oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

_ExcelSheetDelete($oExcel, 1) ;根据工作表名称的索引值删除相应的工作表

MsgBox(4096, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出
