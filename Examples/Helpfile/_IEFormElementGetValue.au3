; *******************************************************
; 示例 1 - 打开含表单示例的浏览器, 设置
;				文本表单元素的值, 获取并显示元素的值
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("form")
Local $oForm = _IEFormGetObjByName($oIE, "ExampleForm")
Local $oText = _IEFormElementGetObjByName($oForm, "textExample")
Local $IEAu3Version = _IE_VersionInfo()
_IEFormElementSetValue($oText, $IEAu3Version[5])
MsgBox(4096, "Form Element Value", _IEFormElementGetValue($oText))
