; *******************************************************
; 示例1 - 通过可选文本点击IMG
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("basic")
_IEImgClick($oIE, "AutoIt Homepage Image", "alt")

; *******************************************************
; 示例2 - 通过名称点击IMG
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("basic")
_IEImgClick($oIE, "AutoItImage", "name")

; *******************************************************
; 示例3 - 通过源的子字符串点击IMG
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("basic")
_IEImgClick($oIE, "autoit_6_240x100.jpg", "src")

; *******************************************************
; 示例4 - 通过完整的源字符串点击IMG
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("basic")
_IEImgClick($oIE, "http://www.autoitscript.com/images/autoit_6_240x100.jpg")
