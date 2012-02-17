; ***************************************************************
; 示例 1 - 打开工作簿并返回其对象标识符后.  声明数组, 然后把数组内容输入到工作表
; *****************************************************************

#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

;声明数组
Local $aArray[5] = ["LocoDarwin", "Jon", "big_daddy", "DaleHolm", "GaryFrost"]

_ExcelWriteArray($oExcel, 1, 1, $aArray) ; 把数组水平写入
_ExcelWriteArray($oExcel, 5, 1, $aArray, 1) ; 把数组垂直写入, 从第五行开始

MsgBox(4096, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出