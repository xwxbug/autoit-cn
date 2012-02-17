; *******************************************************
; 示例1 - 打开带有表单示例的浏览器, 点击匹配文本的
;				<input type=image>表单元素
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("form")
_IEFormImageClick($oIE, "AutoIt Homepage", "alt")

; *******************************************************
; 示例2 - 打开带有表单示例的浏览器,点击匹配图像源地址(子字符串)的
;				<input type=image>表单元素
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("form")
_IEFormImageClick($oIE, "autoit_6_240x100.jpg", "src")

; *******************************************************
; 示例3 - 打开带有表单示例的浏览器, 点击匹配名称的
;				<input type=image>表单元素
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("form")
_IEFormImageClick($oIE, "imageExample", "name")
