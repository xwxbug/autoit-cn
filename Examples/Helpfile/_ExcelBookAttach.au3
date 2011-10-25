
; ***************************************************************************
; 例1 - 连接到首个存在的使基于选择模式与搜索字符串相匹配的Microsoft Excel实例
; ***************************************************************************
#include  <Excel.au3>
#include  <File.au3>

$sFilePath = @TempDir & "\Temp.xls"
If Not _FileCreate($sFilePath) Then ;创建要连接的.XLS文件
	msgbox(4096, "Error", "Error Creating File -" & @error)
EndIf

_ExcelBookOpen($sFilePath)
$oExcel = _ExcelBookAttach($sFilePath) ;默认设置 ($s_mode = "FilePath" ==> 打开的工作簿的完整路径)
_ExcelWriteCell($oExcel, "If you can read this, then Success!", 1, 1) ;写入单元格
msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookClose($oExcel, 1, 0) ;该方法将保存然后不论是否改变无提示关闭文件

; ****************************************************************************
; 例2 - 连接到首个存在的使基于选择模式与搜索字符串相匹配的Microsoft Excel实例
; ****************************************************************************
#include  <Excel.au3>
#include  <File.au3>

$sFilePath = @TempDir & "\Temp.xls"
If Not _FileCreate($sFilePath) Then ;创建要连接的.XLS文件
	msgbox(4096, "Error", "Error Creating File -" & @error)
EndIf

_ExcelBookOpen($sFilePath)
$oExcel = _ExcelBookAttach("Temp.xls", "FileName") ;使用$s_mode = "FileName" ==> 打开的工作簿名称
_ExcelWriteCell($oExcel, "If you can read this, then Success!", 1, 1) ;写入单元格
msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookClose($oExcel, 1, 0) ;该方法将保存然后不论是否改变无提示关闭文件

; ***************************************************************************
; 例3 - 连接到首个存在的使基于选择模式与搜索字符串相匹配的Microsoft Excel实例
; ***************************************************************************
#include  <Excel.au3>
#include  <File.au3>

$sFilePath = @TempDir & "\Temp.xls"
If Not _FileCreate($sFilePath) Then ;创建要连接的.XLS文件
	msgbox(4096, "Error", "Error Creating File -" & @error)
EndIf

_ExcelBookOpen($sFilePath)
$oExcel = _ExcelBookAttach("Microsoft Excel - Temp.xls", "Title") ;使用$s_mode="Title" ==> 窗口标题
_ExcelWriteCell($oExcel, "If you can read this, then Success!", 1, 1) ;写入单元格
msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookClose($oExcel, 1, 0) ;该方法将保存然后不论是否改变无提示关闭文件

