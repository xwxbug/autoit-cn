; ***************************************************************
; 示例 1 打开一个新的工作表并返回其对象标识符, 然后使用一个循环写入单元格. 
;            提示结束后插入一列，然后保存并关闭文件.
; *****************************************************************
#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ;创建一个新的工作表并打开

For $i = 1 To 5 ;循环
	_ExcelWriteCell($oExcel, $i, $i, 1) ;在工作表单元格中纵向写入 1 至 5 信息
Next

ToolTip("准备插入列...")
Sleep(3500) ; 暂停让用户观察操作

_ExcelColumnInsert($oExcel, 1, 1) ;在指定的列插入(在第1列位置插入1列)

MsgBox(0, "退出", "按[确定]保存文件并退出")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 在临时目录保存文件, 如果文件已存在则覆盖原文件
_ExcelBookClose($oExcel) ; 关闭工作表, 退出


; ***************************************************************
; 示例 2 打开一个新的工作表并返回其对象标识符, 然后使用一个循环写入单元格. 
;            提示结束后插入三列,然后保存并关闭文件.
; *****************************************************************
#include <Excel.au3>

Local $oExcel = _ExcelBookNew();创建一个新的工作表并打开

;使用一个简单的循环和随机数字填充单元格
For $i = 1 To 10
	For $j = 1 To 10
		_ExcelWriteCell($oExcel, Round(Random(1, 100), 0), $i, $j)  ;向文件写入随机数字信息
	Next
Next

ToolTip("准备插入列...")
Sleep(3500) ; 暂停让用户观察操作

_ExcelColumnInsert($oExcel, 2, 3) ;在指定的列插入(在第2列位置插入3列)

MsgBox(0, "退出", "按[确定]保存文件并退出")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1)  ; 在临时目录保存文件, 如果文件已存在则覆盖原文件
_ExcelBookClose($oExcel) ; 关闭工作表, 退出
