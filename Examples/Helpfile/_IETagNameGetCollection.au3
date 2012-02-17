; *******************************************************
; 示例 1 - 打开含表单示例的浏览器, 获取到
;				所有 INPUT 标记的集合并显示其中每个的表单名称和类型
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("form")
Local $oInputs = _IETagNameGetCollection($oIE, "input")
For $oInput In $oInputs
	MsgBox(4096, "Form Input Type", "Form: " & $oInput.form.name & " Type: " & $oInput.type)
Next
