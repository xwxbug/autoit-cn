
; ***************************************************************
; 例1 - 打开并返回工作簿对象标识后, 返回活动表名称
; *****************************************************************
#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿并使之可见

msgbox(0, "Sheet Name", "The Current Active Sheet Name Is:" & @CRLF & _ExcelSheetNameGet($oExcel))

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 将其保存至临时目录; 必要时覆盖已存在的文件
_ExcelBookClose($oExcel) ; 关闭退出

; ***************************************************************
; 例2 - 打开并返回工作簿对象标识后, 添加新表并返回活动表名称
; *****************************************************************
#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿并使之可见

msgbox(0, "Sheet Name", "The Current Active Sheet Name Is:" & @CRLF & _ExcelSheetNameGet($oExcel))

_ExcelSheetAddNew($oExcel, "New Sheet 示例") ;Add a New Sheet

msgbox(0, "Sheet Name", "Now The Current Active Sheet Name Is:" & @CRLF & _ExcelSheetNameGet($oExcel))

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 将其保存至临时目录; 必要时覆盖已存在的文件
_ExcelBookClose($oExcel) ; 关闭退出

