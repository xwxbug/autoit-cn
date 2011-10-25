
; ***************************************************************
; 示例 - 打开工作簿并返回其对象标识后. 声明一个数组, 然后输入数组
; *****************************************************************

#include  <Excel.au3>

Local $oExcel = _ExcelBookNew() ;新建工作簿, 并使之可见

;声明数组
Local $aArray[5] = ["LocoDarwin", "Jon", "big_daddy", "DaleHolm", "GaryFrost"]

_ExcelWriteArray($oExcel, 1, 1, $aArray) ; 水平写入数组
_ExcelWriteArray($oExcel, 5, 1, $aArray, 1) ; 从第5行开始垂直写入数组

msgbox(0, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; 将其保存到临时文件夹; 如果有必要覆盖已存在文件
_ExcelBookClose($oExcel) ; 关闭退出

