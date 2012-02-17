; *******************************************************
; 示例 1 - 打开含表示例的浏览器, 获取到
;				页面上首个表的引用 (索引 0) 并读取其中所有内容到一个二维数组
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("table")
Local $oTable = _IETableGetCollection($oIE, 0)
Local $aTableData = _IETableWriteToArray($oTable)

; *******************************************************
; 示例 2 - 打开含表示例的浏览器, 获取到
;				表集合的引用并显示页面上表的数目
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("table")
$oTable = _IETableGetCollection($oIE)
Local $iNumTables = @extended
MsgBox(4096, "Table Info", "There are " & $iNumTables & " tables on the page")
