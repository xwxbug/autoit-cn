; *******************************************************
; 打开带有表单示例的浏览器, 获取所有INPUT标签的集合并显示表单名称及类型
; *******************************************************
#include <IE.au3>
$oIE = _IE_Example(" form ")
$oInputs = _IETagNameGetCollection($oIE, "input ")
For $oInput In $oInputs
	msgbox(0, "Form Input Type ", "Form:" & $oInput .form.name & "  Type:" & $oInput .type)
Next

