; *******************************************************
; 示例 - 打开带有表单示例的浏览器, 获取名称为"Example Form"的元素的对象的引用.
;     在此情况下结果与使用$oForm = _IEFormGetObjByName($oIE, "Example Form")相同
; *******************************************************
#include <IE.au3>
$oIE = _IE_Example(" form ")
$oForm = _IEGetObjByName($oIE, "Example Form ")

