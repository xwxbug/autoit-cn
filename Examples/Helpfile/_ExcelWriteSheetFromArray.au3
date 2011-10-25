
; ***************************************************************
; 示例 - 打开并返回工作簿对象标识后, 声明一个二维数组, 然后输入数组
; *****************************************************************

#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿, 并使之可见

;声明数组
Local $aArray[5][2] = [["LocoDarwin", 1],["Jon", 2],["big_daddy", 3],["DaleHolm", 4],["GaryFrost", 5]] ;0基数组
_ExcelWriteSheetFromArray($oExcel, $aArray, 1, 1, 0, 0) ;0基数组参数

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 将其保存至临时目录; 必要时覆盖已存在的文件
_ExcelBookClose($oExcel) ; 关闭退出

