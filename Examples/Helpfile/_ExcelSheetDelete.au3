
; ***************************************************************
; 例1 - 打开并返回工作簿对象标识后, 按表名删除工作表
; *****************************************************************
#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿并使之可见

_ExcelSheetDelete($oExcel, "Sheet1") ;通过表的名称字符串删除表

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 将其保存至临时目录; 必要时覆盖已存在的文件
_ExcelBookClose($oExcel) ; 关闭退出

; ***************************************************************
; 例2 - 打开并返回工作簿对象标识后, 按索引删除工作表
; *****************************************************************
#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿并使之可见

_ExcelSheetDelete($oExcel, 1) ;通过表名的索引删除表

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 将其保存至临时目录; 必要时覆盖已存在的文件
_ExcelBookClose($oExcel) ; 关闭退出

