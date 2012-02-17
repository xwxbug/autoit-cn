; *****************************************************************
; 示例 1 - 打开工作簿并返回其对象标识符后, 使用工作表索引值移动相应的工作表
; *****************************************************************

#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见
_ExcelSheetMove($oExcel, 2) ;移动第二个工作表到首位 (整数/基于索引)
MsgBox(4096, "Exiting", "Notice How Sheet2 is in the 1st Position" & @CRLF & @CRLF & "Now Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出

; *****************************************************************
; 示例 2 - 打开工作簿并返回其对象标识符后, 根据表示工作表名称的字符串移动相应的工作表
; *****************************************************************

#include <Excel.au3>

$oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见
_ExcelSheetMove($oExcel, "Sheet2") ;移动第二个工作表到首位 (字符串/基于名称)
MsgBox(4096, "Exiting", "Notice How Sheet2 is in the 1st Position" & @CRLF & @CRLF & "Now Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出

; ***************************************************************
; 示例 3 - 打开工作簿并返回其对象标识符后, 使用工作表索引值移动相应的工作表
; *****************************************************************

#include <Excel.au3>

$oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见
;添加一些工作表, 并进行排列
Local $sSheetName4 = "Sheet4"
Local $sSheetName5 = "Sheet5"
_ExcelSheetAddNew($oExcel, $sSheetName4) ;添加另一个工作表
_ExcelSheetMove($oExcel, $sSheetName4, 4, False) ;移动 $sSheetName4 到第四的位置 (false 使得把它放置在相对工作表之后)

_ExcelSheetAddNew($oExcel, $sSheetName5) ;添加另一个工作表
_ExcelSheetMove($oExcel, $sSheetName5, 5, False) ;移动 $sSheetName5 到第五的位置 (false 使得把它放置在相对工作表之后)

MsgBox(4096, "Show", "Take note of the order of the Worksheets" & @CRLF & @CRLF & "Press OK to Continue")

_ExcelSheetMove($oExcel, $sSheetName5, "Sheet3", True) ;移动第五个工作表到名称为 'Sheet3' 的工作表之后
MsgBox(4096, "Exiting", "'" & $sSheetName5 & "'" & " when the $fBefore paramter is True (Relative to 'Sheet3')" & @CRLF & @CRLF & "Press OK to Continue")
_ExcelSheetMove($oExcel, $sSheetName5, "Sheet3", False) ;移动第五个工作表到名称为 'Sheet3' 的工作表之后
MsgBox(4096, "Exiting", "'" & $sSheetName5 & "'" & " when the $fBefore paramter is False (Relative to 'Sheet3')" & @CRLF & @CRLF & "Now Press OK to Save File and Exit")

_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出
