
; ***************************************************************
; 例1 - 打开并返回工作簿对象标识后, 创建并显示工作簿中所有表名的数组
; *****************************************************************
#include  <Excel.au3>
#include  <Array.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿并使之可见

$aArray = _ExcelSheetList($oExcel)
_ArrayDisplay($aArray, "All The WorkSheets In this WorkBook")

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 将其保存至临时目录; 必要时覆盖已存在的文件
_ExcelBookClose($oExcel) ; 关闭退出

; ***************************************************************
; 例2 - 打开并返回工作簿对象标识后, 创建工作簿中所有表名的数组并按表名激活各表
; *****************************************************************
#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿并使之可见

$aArray = _ExcelSheetList($oExcel)

For $i = $aArray[0] To 1 Step -1 ;递减循环操作
	_ExcelSheetActivate($oExcel, $aArray[$i]) ;使用数组元素中返回的字符串名称
	msgbox(0, "ActiveSheet", "The Active Sheet should be:" & @CRLF & $aArray[$i])
Next

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 将其保存至临时目录; 必要时覆盖已存在的文件
_ExcelBookClose($oExcel) ; 关闭退出

; ***************************************************************
; 例3 - 打开并返回工作簿对象标识后, 创建工作簿中所有表名的数组并按索引激活各表
; *****************************************************************
#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿并使之可见

$aArray = _ExcelSheetList($oExcel)

For $i = $aArray[0] To 1 Step -1 ;递减循环操作
	_ExcelSheetActivate($oExcel, $i) ;使用数组索引
	msgbox(0, "ActiveSheet", "The Active Sheet should be:" & @CRLF & $aArray[$i])
Next

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 将其保存至临时目录; 必要时覆盖已存在的文件
_ExcelBookClose($oExcel) ; 关闭退出

; ***************************************************************
; 例4 - 打开并返回工作簿对象标识后, 创建工作簿中所有表名的数组并按索引激活各表.
;               在工作簿每个写入数组的表上放置一些随机数字
; *****************************************************************
#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿并使之可见

$aArray = _ExcelSheetList($oExcel)

For $i = $aArray[0] To 1 Step -1 ;递减循环操作
	_ExcelSheetActivate($oExcel, $i) ;使用数组索引
	_ExcelWriteArray($oExcel, 1, 1, $aArray, 1) ;将数组写入活动工作簿
	; 使用简单循环和随机数字填充单元格
	For $y = 2 To 10
		For $x = 2 To 10
			_ExcelWriteCell($oExcel, Round( Random(1000, 10000), 0), $x, $y) ;一些随机数字
		Next
	Next
	msgbox(0, "ActiveSheet", "The Active Sheet should be:" & @CRLF & $aArray[$i])
Next

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 将其保存至临时目录; 必要时覆盖已存在的文件
_ExcelBookClose($oExcel) ; 关闭退出

