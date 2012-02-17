; ***************************************************************
; 示例 1 - 打开工作簿并返回其对象标识符后, 创建并显示含有工作簿中所有工作表名称的数组
; *****************************************************************

#include <Excel.au3>
#include <Array.au3>

Local $oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

Local $aArray = _ExcelSheetList($oExcel)
_ArrayDisplay($aArray, "All The WorkSheets In this WorkBook")

MsgBox(4096, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出

; ***************************************************************
; 示例 2 - 打开工作簿并返回其对象标识符后, 创建含有工作簿中所有工作表名称的数组
;				并根据字符串激活每个工作表
; *****************************************************************

#include <Excel.au3>

$oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

$aArray = _ExcelSheetList($oExcel)

For $i = $aArray[0] To 1 Step -1 ;倒序循环
	_ExcelSheetActivate($oExcel, $aArray[$i]) ;使用数组元素返回的字符串
	MsgBox(4096, "ActiveSheet", "The Active Sheet should be:" & @CRLF & $aArray[$i])
Next

MsgBox(4096, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出

; ***************************************************************
; 示例 3 - 打开工作簿并返回其对象标识符后, 创建含有工作簿中所有工作表名的数组
;				并根据索引值激活每个工作表
; *****************************************************************

#include <Excel.au3>

$oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

$aArray = _ExcelSheetList($oExcel)

For $i = $aArray[0] To 1 Step -1 ;倒序循环
	_ExcelSheetActivate($oExcel, $i) ;使用数组索引
	MsgBox(4096, "ActiveSheet", "The Active Sheet should be:" & @CRLF & $aArray[$i])
Next

MsgBox(4096, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出

; ***************************************************************
; 示例 4 - 打开工作簿并返回其对象标识符后, 创建含有工作簿中所有工作表名称的数组
;				并根据索引值激活每个工作表.  写入数组内容到每个工作表中并放进一些随机数字
; *****************************************************************

#include <Excel.au3>

$oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

$aArray = _ExcelSheetList($oExcel)

For $i = $aArray[0] To 1 Step -1 ;倒序循环
	_ExcelSheetActivate($oExcel, $i) ;使用数组索引
	_ExcelWriteArray($oExcel, 1, 1, $aArray, 1) ;写入数组内容到活动的工作表
	; 我们在单个循环中使用随机数填充一些单元格
	For $y = 2 To 10
		For $x = 2 To 10
			_ExcelWriteCell($oExcel, Round(Random(1000, 10000), 0), $x, $y) ;写入到文件的一些随机数
		Next
	Next
	MsgBox(4096, "ActiveSheet", "The Active Sheet should be:" & @CRLF & $aArray[$i])
Next

MsgBox(4096, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出
