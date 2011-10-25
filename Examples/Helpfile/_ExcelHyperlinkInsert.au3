
; ***************************************************************
; 示例 - 向单元格写入一个超链接, 保存并关闭文件.
; *****************************************************************
#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿, 并使之可见

$sLinkText = "AutoIt Website" ;T单元格中显示的文本, 等同于OuterText
$sAddress = "http://www.AutoItScript.com" ;实际链接, 等同于使用href
$sScreenTip = "AutoIt is Awesome! And Don't You Forget it!" ;鼠标经过时出现的屏幕提示
_ExcelHyperlinkInsert($oExcel, $sLinkText, $sAddress, $sScreenTip, 1, 2) ;在行1列2处插入

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在将其保存至临时目录; 必要时覆盖已存在的文件
_ExcelBookClose($oExcel) ; And finally we close out

