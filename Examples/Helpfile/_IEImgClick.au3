; *******************************************************
; 示例 1 - 根据 Alt 文本点击 IMG
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("basic")
_IEImgClick($oIE, "AutoIt Homepage Image", "alt")

; *******************************************************
; 示例 2 - 根据名称点击 IMG
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("basic")
_IEImgClick($oIE, "AutoItImage", "name")

; *******************************************************
; 示例 3 - 根据源子字符串点击 IMG
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("basic")
_IEImgClick($oIE, "autoit_6_240x100.jpg", "src")

; *******************************************************
; 示例 4 - 根据完整的源子字符串点击 IMG
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("basic")
_IEImgClick($oIE, "http://www.autoitscript.com/images/autoit_6_240x100.jpg")
