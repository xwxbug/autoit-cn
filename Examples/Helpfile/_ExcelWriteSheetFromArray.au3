; ***************************************************************
; 示例 1 - 打开工作簿并返回其对象标识符后.  声明一个二维数组, 然后把数组内容输入到工作表
; *****************************************************************

#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见

;声明数组
Local $aArray[5][2] = [["LocoDarwin", 1],["Jon", 2],["big_daddy", 3],["DaleHolm", 4],["GaryFrost", 5]] ;基于 0 开始的数组
_ExcelWriteSheetFromArray($oExcel, $aArray, 1, 1, 0, 0) ;基于 0 开始的数组参数

MsgBox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 现在我们把它保存到临时目录; 必要时覆盖文件
_ExcelBookClose($oExcel) ; 最后我们关闭并退出