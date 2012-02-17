; *******************************************************
; 示例 - 打开带有表单示例的浏览器, 
;				填充表单并重新设置为默认值
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("form")
Local $oForm = _IEFormGetObjByName($oIE, "ExampleForm")
Local $oText = _IEFormElementGetObjByName($oForm, "textExample")
_IEFormElementSetValue($oText, "Hey! It works!")
_IEFormReset($oForm)
