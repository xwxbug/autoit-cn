; ***************************************************************
; 示例 1 - 打开一个新的工作表并返回其对象标识符, 然后返回工作表标签名称
; *****************************************************************
#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ;创建一个新的工作表并打开

MsgBox(0, "工作表标签名称", "当前活动工作表标签名称是:" & @CRLF & _ExcelSheetNameGet($oExcel))

MsgBox(0, "退出", "按确定保存文件并退出")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 在临时目录保存文件, 如果文件已存在则覆盖原文件
_ExcelBookClose($oExcel) ;关闭工作表, 退出

; ***************************************************************
;示例 2 打开一个新的工作表并返回其对象标识符，添加一个新的工作表标签，并返回活动工作表标签名称
; *****************************************************************
#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ;创建一个新的工作表并打开

MsgBox(0, "工作表标签名称", "当前活动工作表标签名称是:" & @CRLF & _ExcelSheetNameGet($oExcel))

_ExcelSheetAddNew($oExcel, "New Sheet Example") ;添加一个新的工作表标签

MsgBox(0, "工作表标签名称", "新活动工作表标签名称是:" & @CRLF & _ExcelSheetNameGet($oExcel))

MsgBox(0, "退出", "按确定保存文件并退出")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 在临时目录保存文件, 如果文件已存在则覆盖原文件
_ExcelBookClose($oExcel) ; 关闭工作表, 退出
