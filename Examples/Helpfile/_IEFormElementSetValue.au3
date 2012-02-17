; *******************************************************
; 示例 1 - 打开含表单示例的浏览器, 设置文本表单元素的值
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("form")
Local $oForm = _IEFormGetObjByName($oIE, "ExampleForm")
Local $oText = _IEFormElementGetObjByName($oForm, "textExample")
_IEFormElementSetValue($oText, "Hey! This works!")

; *******************************************************
; 示例 2 - 获取到指定表单元素的引用并设置它的值.
;				这里, 提交查询到谷歌搜索引擎
; *******************************************************

#include <IE.au3>

$oIE = _IECreate("http://www.google.com")
$oForm = _IEFormGetObjByName($oIE, "f")
Local $oQuery = _IEFormElementGetObjByName($oForm, "q")
_IEFormElementSetValue($oQuery, "AutoIt IE.au3")
_IEFormSubmit($oForm)

; *******************************************************
; Example 3 - Set the value of an INPUT TYPE=TEXT element using Send()
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("form")
$oForm = _IEFormGetObjByName($oIE, "ExampleForm")
Local $oInputFile = _IEFormElementGetObjByName($oForm, "textExample")

; 把输入焦点定位到这个字段然后发送文本字符串
_IEAction($oInputFile, "focus")

; Select existing content so it will be overwritten.
_IEAction($oInputFile, "selectall")

Send("This works")

; *******************************************************
; 示例 4 - 设置 INPUT TYPE=TEXT 元素的值
;				(由于安全限制而阻止使用 _IEFormElementSetValue)
; *******************************************************
;
#include <IE.au3>

$oIE = _IE_Example("form")

; 隐藏浏览器窗口来演示发送文本到不可见窗口
_IEAction($oIE, "invisible")

$oForm = _IEFormGetObjByName($oIE, "ExampleForm")
$oInputFile = _IEFormElementGetObjByName($oForm, "textExample")

; 把输入焦点定位到这个字段然后发送文本字符串
_IEAction($oInputFile, "focus")

; Select existing content so it will be overwritten.
_IEAction($oInputFile, "selectall")

; Get a handle to the IE window.
Local $hIE = _IEPropertyGet($oIE, "hwnd")
ControlSend($hIE, "", "[CLASS:Internet Explorer_Server; INSTANCE:1]", "This works")

MsgBox(4096, "Success", "Value set to 'This works'")
_IEAction($oIE, "visible")
