; **************************************************************************************************************
; 示例 1 - 基于所选择的模式附加到第一个匹配字符串的Microsoft Excel的实例上.
; **************************************************************************************************************

#include <Excel.au3>
#include <File.au3>

Local $sFilePath = @TempDir & "\Temp.xls"
If Not _FileCreate($sFilePath) Then ;创建一个.XLS文件
	MsgBox(4096, "错误", " 创建文件时出错 - " & @error)
EndIf

_ExcelBookOpen($sFilePath)
Local $oExcel = _ExcelBookAttach($sFilePath) ;搜索模式: Excel工作表路径(默认模式)
_ExcelWriteCell($oExcel, "看到了吗?写入信息成功了!", 1, 1) ;对指定的Excel工作表单元格写入信息.
MsgBox(4096, "退出", "按[确定]保存文件并退出")
_ExcelBookClose($oExcel, 1, 0);在没有任何提示的情况下保存该文件,然后关闭.

; **************************************************************************************************************
; 示例 2 - 基于所选择的模式附加到第一个匹配字符串的Microsoft Excel的实例上.
; **************************************************************************************************************

#include <Excel.au3>
#include <File.au3>

$sFilePath = @TempDir & "\Temp.xls"
If Not _FileCreate($sFilePath) Then  ;创建一个.XLS文件
	MsgBox(4096, "错误", " 创建文件时出错 - " & @error)
EndIf

_ExcelBookOpen($sFilePath)
$oExcel = _ExcelBookAttach("Temp.xls", "FileName") ;搜索模式: Excel工作表的名称
_ExcelWriteCell($oExcel, "看到了吗?写入信息成功了!", 1, 1) ;对指定的Excel工作表单元格写入信息.
MsgBox(4096, "退出", "按[确定]保存文件并退出")
_ExcelBookClose($oExcel, 1, 0);在没有任何提示的情况下保存该文件,然后关闭.

; **************************************************************************************************************
; 示例 3 - 基于所选择的模式附加到第一个匹配字符串的Microsoft Excel的实例上.()
; **************************************************************************************************************

#include <Excel.au3>
#include <File.au3>

$sFilePath = @TempDir & "\Temp.xls"
If Not _FileCreate($sFilePath) Then ;创建一个.XLS文件
	MsgBox(4096, "错误", " 创建文件时出错 - " & @error)
EndIf

_ExcelBookOpen($sFilePath)
$oExcel = _ExcelBookAttach("Microsoft Excel - Temp", "Title") ;搜索模式: Excel工作表的窗口标题
_ExcelWriteCell($oExcel, "看到了吗?写入信息成功了!", 1, 1) ;对指定的Excel工作表单元格写入信息.
MsgBox(4096, "退出", "按[确定]保存文件并退出")
_ExcelBookClose($oExcel, 1, 0) ;在没有任何提示的情况下保存该文件,然后关闭.
