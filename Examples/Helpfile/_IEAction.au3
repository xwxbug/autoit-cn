; *******************************************************
; 示例 1 - 打开含 "表单" 示例的浏览器, 通过名称
;				获取到提交按钮的引用并 "点击" 它. 这种提交
;				表单的方法很有用, 因为许多表单依赖于 JavaScript
;				代码和在提交按钮上 "onClick" 事件使得 _IEFormSubmit()
;				不能像预期一样执行
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("form")
Local $oSubmit = _IEGetObjByName($oIE, "submitExample")
_IEAction($oSubmit, "click")
_IELoadWait($oIE)

; *******************************************************
; 示例 2 - 如同示例 1, 但不使用点击, 而是设置焦点到元素上
;				然后使用 ControlSend 发送回车当浏览器端的脚本
;				与点击动作关联时使用这种方法会阻止控件
;				自动返回到您的代码.
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("form")
$oSubmit = _IEGetObjByName($oIE, "submitExample")
Local $hwnd = _IEPropertyGet($oIE, "hwnd")
_IEAction($oSubmit, "focus")
ControlSend($hwnd, "", "[CLASS:Internet Explorer_Server; INSTANCE:1]", "{Enter}")

; 等待警告窗口, 然后点击 OK
WinWait("Windows Internet Explorer", "ExampleFormSubmitted")
ControlClick("Windows Internet Explorer", "ExampleFormSubmitted", "[CLASS:Button; TEXT:OK; Instance:1;]")
_IELoadWait($oIE)
