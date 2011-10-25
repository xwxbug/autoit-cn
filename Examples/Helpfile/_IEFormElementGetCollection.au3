; *******************************************************
; 示例 - 获取0基索引的指定表单元素的引用. 此例中, 向Google搜索引擎提交查询
; *******************************************************
#include  <IE.au3>
$oIE = _IECreate(" http://www.google.com ")
$oForm = _IEFormGetCollection($oIE, 0)
$oQuery = _IEFormElementGetCollection($oForm, 1)
_IEFormElementSetValue($oQuery, "AutoIt IE.au3 ")
_IEFormSubmit($oForm)

