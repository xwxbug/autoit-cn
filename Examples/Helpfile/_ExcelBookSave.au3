
; ***************************************************************
; 示例 - 打开新工作簿并返回对象标识. 无提示情况下保存文件
; *****************************************************************

#include  <Excel.au3>

$oExcel = _ExcelBookNew()

_ExcelBookSave($oExcel) ;Save File With No Alerts
If Not @error Then msgbox(0, "Success", "File was Saved!", 3)

