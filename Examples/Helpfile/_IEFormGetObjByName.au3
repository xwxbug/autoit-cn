; *******************************************************
; 获取名称指定的表单的引用. 此例中, 向Google搜索引擎提交查询
; 注意表单名称及通过页面HTML源找到的表单元素
; *******************************************************
#include  <IE.au3>
$oIE = _IECreate(" http://www.google.com ")
$oForm = _IEFormGetObjByName($oIE, "f ")
$oQuery = _IEFormElementGetObjByName($oForm, "q ")
_IEFormElementSetValue($oQuery, "AutoIt IE.au3 ")
_IEFormSubmit($oForm)

