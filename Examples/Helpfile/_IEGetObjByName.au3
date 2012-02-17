; *******************************************************
; 示例 1 - 打开含表单示例的浏览器, 获取到
;				名称为 "ExampleForm" 的元素的对象引用.  此时
;				结果等同于使用 $oForm = _IEFormGetObjByName($oIE, "ExampleForm")
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("form")
Local $oForm = _IEGetObjByName($oIE, "ExampleForm")
