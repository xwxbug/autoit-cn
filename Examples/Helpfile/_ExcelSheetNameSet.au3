
; ***********************************************************
; 例1 - 打开工作簿并返回其对象标识后, 设置活动表名称
; *****************************************************************
#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿, 并使之可见

_ExcelSheetNameSet($oExcel, "示例") ;重命名活动表

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 将其保存到临时文件夹; 如果有必要覆盖已存在文件
_ExcelBookClose($oExcel) ; 关闭退出

; ***********************************************************************
; 例2 - 打开工作簿并返回其对象标识后, 显示活动表名称, 更改并显示新名称
; ***********************************************************************
#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿, 并使之可见

msgbox(0, "Sheet Name", "The Current Active Sheet Name Is:" & @CRLF & _ExcelSheetNameGet($oExcel))

_ExcelSheetNameSet($oExcel, "示例") ;重命名活动表

msgbox(0, "Sheet Name", "Now The Current Active Sheet Name Is:" & @CRLF & _ExcelSheetNameGet($oExcel))

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 将其保存到临时文件夹; 如果有必要覆盖已存在文件
_ExcelBookClose($oExcel) ; 关闭退出

