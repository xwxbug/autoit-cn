; *******************************************************
; 示例 1 - 打开含表单示例的浏览器, 获取到表单的引用, 获取
;				到选择元素的引用, 根据 byValue, byText 和 byIndex 循环十次进行选择
;				注意: 您可能需要往下滚动页面来查看发生的变化
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("form")
Local $oForm = _IEFormGetObjByName($oIE, "ExampleForm")
Local $oSelect = _IEFormElementGetObjByName($oForm, "selectExample")
For $i = 1 To 10
	_IEFormElementOptionSelect($oSelect, "Freepage", 1, "byText")
	Sleep(1000)
	_IEFormElementOptionSelect($oSelect, "midipage.html", 1, "byValue")
	Sleep(1000)
	_IEFormElementOptionSelect($oSelect, 0, 1, "byIndex")
	Sleep(1000)
Next

; *******************************************************
; 示例 2 - 打开含表单示例的浏览器, 获取到表单的引用, 获取
;				到选择的多个元素的引用, 循环 5 次进行选择然后取消选择
;				选项 byValue, byText 和 byIndex.
;				注意: 您可能需要往下滚动页面来查看发生的变化
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("form")
$oForm = _IEFormGetObjByName($oIE, "ExampleForm")
$oSelect = _IEFormElementGetObjByName($oForm, "multipleSelectExample")
For $i = 1 To 5
	_IEFormElementOptionSelect($oSelect, "Carlos", 1, "byText")
	Sleep(1000)
	_IEFormElementOptionSelect($oSelect, "Name2", 1, "byValue")
	Sleep(1000)
	_IEFormElementOptionSelect($oSelect, 5, 1, "byIndex")
	Sleep(1000)
	_IEFormElementOptionSelect($oSelect, "Carlos", 0, "byText")
	Sleep(1000)
	_IEFormElementOptionSelect($oSelect, "Name2", 0, "byValue")
	Sleep(1000)
	_IEFormElementOptionSelect($oSelect, 5, 0, "byIndex")
	Sleep(1000)
Next

; *******************************************************
; 示例 3 - 打开含表单示例的浏览器, 获取到表单的引用, 获取
;				到选择的元素的引用, 检查是否选择了 "Freepage" 选项并
;				报告结果.  加上 index 0 和
;				'midipage.html' 的选项值重复操作
;				注意: 您可能需要往下滚动页面来查看发生的变化
; *******************************************************
;
#include <IE.au3>
$oIE = _IE_Example("form")
$oForm = _IEFormGetObjByName($oIE, "ExampleForm")
$oSelect = _IEFormElementGetObjByName($oForm, "selectExample")
If _IEFormElementOptionSelect($oSelect, "Freepage", -1, "byText") Then
	MsgBox(4096, "Option Selected", "Option Freepage is selected")
Else
	MsgBox(4096, "Option Selected", "Option Freepage is Not selected")
EndIf
If _IEFormElementOptionSelect($oSelect, 0, -1, "byIndex") Then
	MsgBox(4096, "Option Selected", "The First (index 0) option is selected")
Else
	MsgBox(4096, "Option Selected", "The First (index 0) option is Not selected")
EndIf
If _IEFormElementOptionSelect($oSelect, "midipage.html", -1, "byValue") Then
	MsgBox(4096, "Option Selected", "The option with value 'midipage.html' is selected")
Else
	MsgBox(4096, "Option Selected", "The option with value 'midipage.html' is NOT selected")
EndIf
