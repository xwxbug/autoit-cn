; *******************************************************
; 示例1 - 打开带有"表单"示例的浏览器,  通过名称获取提交按钮的
;    引用并"点击". 该提交表单的方法很有用由于一些表单可响应JavaScript代码产生的
;    "onClick"事件而无法按预期执行_IEFormSubmit()
; *******************************************************
;
#include  <IE.au3>
$oIE = _IE_Example(" form ")
$oSubmit = _IEGetObjByName($oIE, "submit Example ")
_IEAction($oSubmit, "click ")
_IELoadWait($oIE)

; *******************************************************
; 示例2 - 与示例1相同, 但通过给定元素焦点并使用ControlSend发送Enter代替点击.
;    ;与点击操作相关的浏览器端脚本阻止控件自动返回点击操作代码时使用此方法.
; *******************************************************
;
#include  <IE.au3>
$oIE = _IE_Example(" form ")
$oSubmit = _IEGetObjByName($oIE, "submit Example ")
$hwnd = _IEPropertyGet($oIE, "hwnd ")
_IEAction($oSubmit, "focus ")
ControlSend($hwnd, "", "[CLASS:Internet Explorer_Server; INSTANCE:1] ", "{Enter} ")

; 等待警告窗口, 然后点击OK
WinWait(" Windows Internet Explorer ", "Example FormSubmitted ")
ControlClick(" Windows Internet Explorer ", "Example FormSubmitted ", "[CLASS:Button; TEXT:OK; Instance:1;] ")
_IELoadWait($oIE)

