; *******************************************************
; 示例 1 - 打开含表单示例的浏览器, 点击
;				匹配 alt 文本的 <input type=image> 表单元素
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("form")
_IEFormImageClick($oIE, "AutoIt Homepage", "alt")

; *******************************************************
; 示例 2 - 打开含表单示例的浏览器, 点击匹配 img 源 URL (子字符串) 的 <input type=image>
;				表单元素
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("form")
_IEFormImageClick($oIE, "autoit_6_240x100.jpg", "src")

; *******************************************************
; 示例 3 - 打开含表单示例的浏览器, 点击匹配名称的
;				<input type=image> 表单元素
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("form")
_IEFormImageClick($oIE, "imageExample", "name")
