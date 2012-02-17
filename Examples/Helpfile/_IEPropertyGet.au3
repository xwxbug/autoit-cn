; *******************************************************
; 示例 1 - 打开含基本示例的浏览器, 检查
;				地址栏是否可见, 如果可见则让其隐藏, 否则让其显示
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("basic")
If _IEPropertyGet($oIE, "addressbar") Then
	MsgBox(4096, "AddressBar Status", "AddressBar Visible, turning it off")
	_IEPropertySet($oIE, "addressbar", False)
Else
	MsgBox(4096, "AddressBar Status", "AddressBar Invisible, turning it on")
	_IEPropertySet($oIE, "addressbar", True)
EndIf

; *******************************************************
; 示例 2 - 打开含表单示例的浏览器并获取到
;				表单文本区域元素的引用.  获取文本区域的坐标和尺寸,
;				用鼠标描绘其轮廓外形并移动到中心
; *******************************************************

$oIE = _IE_Example("form")

Local $oForm = _IEFormGetObjByName($oIE, "ExampleForm")
Local $oTextArea = _IEFormElementGetObjByName($oForm, "textareaExample")

; 获取文本区域的坐标和尺寸
Local $iScreenX = _IEPropertyGet($oTextArea, "screenx")
Local $iScreenY = _IEPropertyGet($oTextArea, "screeny")
Local $iBrowserX = _IEPropertyGet($oTextArea, "browserx")
Local $iBrowserY = _IEPropertyGet($oTextArea, "browserY")
Local $iWidth = _IEPropertyGet($oTextArea, "width")
Local $iHeight = _IEPropertyGet($oTextArea, "height")

; 用鼠标描绘其轮廓外形并移动到中心
MouseMove($iScreenX, $iScreenY)
MouseMove($iScreenX + $iWidth, $iScreenY)
MouseMove($iScreenX + $iWidth, $iScreenY + $iHeight)
MouseMove($iScreenX, $iScreenY + $iHeight)
MouseMove($iScreenX, $iScreenY)
MouseMove($iScreenX + $iWidth / 2, $iScreenY + $iHeight / 2)
