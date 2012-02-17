; ***************************************************************
; 示例 1 向单元格插入一个超链接文本, 然后保存并关闭文件.
; *****************************************************************

#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ;创建一个新的工作表并打开

Local $sLinkText = "AutoIt Website" ;单元格中显示的超链接文本, 等同于OuterText
Local $sAddress = "http://www.AutoItScript.com" ;连接到的URL文本, 等同于使用href
Local $sScreenTip = "AutoIt is Awesome! And Don't You Forget it!" ;鼠标经过时弹出文本屏幕提示
_ExcelHyperlinkInsert($oExcel, $sLinkText, $sAddress, $sScreenTip, 1, 2) ;在指定位置插入(在第1行第2列插入)

MsgBox(4096, "退出", "按[确定]保存文件并退出")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 在临时目录保存文件, 如果文件已存在则覆盖原文件.
_ExcelBookClose($oExcel) ; 关闭工作表,退出