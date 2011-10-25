; *******************************************************
; 示例1 -打开带有表单示例的浏览器, 设置表单文本元素的值, 获取并显示元素的值
; *******************************************************
#include <IE.au3>
$oIE = _IE_Example("form")
$oForm = _IEFormGetObjByName($oIE, "ExampleForm")
$oText = _IEFormElementGetObjByName($oForm, "textExample")
$IEAu3Version = _IE_VersionInfo()
_IEFormElementSetValue($oText, $IEAu3Version[5])
msgbox(0, "Form Element Value", _IEFormElementGetValue($oText))

