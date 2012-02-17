; ***************************************************************
; 示例 1 - 打开工作簿并返回其对象标识符后, 使用表示工作表名称的字符串值激活相应的工作表
; *****************************************************************

#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

_ExcelSheetActivate($oExcel, "Sheet2")

MsgBox(4096, "Exiting", "Notice How Sheet2 is Active and not Sheet1" & @CRLF & @CRLF & "Now Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出

; ***************************************************************
; 示例 2 - 打开工作簿并返回其对象标识符后, 使用工作表索引值激活相应的工作表
; *****************************************************************

#include <Excel.au3>

$oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

_ExcelSheetActivate($oExcel, 2)

MsgBox(4096, "Exiting", "Notice How Sheet2 is Active and not Sheet1" & @CRLF & @CRLF & "Now Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出

; ***************************************************************
; 示例 2 - 打开工作簿并返回其对象标识符后, 使用工作表索引值激活相应的工作表
; *****************************************************************

#include <Excel.au3>

$oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

Local $iNumberOfWorksheets = $oExcel.Worksheets.Count

MsgBox(4096, "", $oExcel.Worksheets.Count)
_ExcelSheetActivate($oExcel, 2)

MsgBox(4096, "Exiting", "Notice How Sheet2 is Active and not Sheet1" & @CRLF & @CRLF & "Now Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出
