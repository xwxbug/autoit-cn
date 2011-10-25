; *******************************************************
; 示例1 - 打开带有表单示例的浏览器, 获取表单的引用, 获取选定元素的引用, 循环10次通过值文本及索引选定选项
;    注意: 为查看变化你可能需要向下滚动页面
; *******************************************************
#include  <IE.au3>
$oIE = _IE_Example(" form ")
$oForm = _IEFormGetObjByName($oIE, "Example Form ")
$oSelect = _IEFormElementGetObjByName($oForm, "select Example ")
For $i = 1 To 10
	_IEFormElementOptionSelect($oSelect, "Freepage ", 1, "byText ")
	Sleep(1000)
	_IEFormElementOptionSelect($oSelect, "midipage.html ", 1, "byValue ")
	Sleep(1000)
	_IEFormElementOptionSelect($oSelect, 0, 1, "byIndex ")
	Sleep(1000)
Next

; *******************************************************
; 示例2 - 打开带有表单示例的浏览器, 获取表单的引用, 获取选定的多个元素的引用, 循环5次通过值, 文本及索引选定选项选定后反选
;    注意: 为查看变化你可能需要向下滚动页面
; *******************************************************
#include  <IE.au3>
$oIE = _IE_Example(" form ")
$oForm = _IEFormGetObjByName($oIE, "Example Form ")
$oSelect = _IEFormElementGetObjByName($oForm, "multipleSelect Example ")
For $i = 1 To 5
	_IEFormElementOptionSelect($oSelect, "Carlos ", 1, "byText ")
	Sleep(1000)
	_IEFormElementOptionSelect($oSelect, "Name2 ", 1, "byValue ")
	Sleep(1000)
	_IEFormElementOptionSelect($oSelect, 5, 1, "byIndex ")
	Sleep(1000)
	_IEFormElementOptionSelect($oSelect, "Carlos ", 0, "byText ")
	Sleep(1000)
	_IEFormElementOptionSelect($oSelect, "Name2 ", 0, "byValue ")
	Sleep(1000)
	_IEFormElementOptionSelect($oSelect, 5, 0, "byIndex ")
	Sleep(1000)
Next

; *******************************************************
; 示例3 - 打开带有表单示例的浏览器, 获取表单的引用, 获取选定元素的引用, 查看是否选定选项"Freepage "
;   并报告结果. 重复索引为0的选项和值为'midipage.html'的选项
; *******************************************************
#include  <IE.au3>
$oIE = _IE_Example(" form ")
$oForm = _IEFormGetObjByName($oIE, "Example Form ")
$oSelect = _IEFormElementGetObjByName($oForm, "select Example ")
If _IEFormElementOptionSelect($oSelect, "Freepage ", -1, "byText ") Then
	msgbox(0, "Option Selected ", "Option Freepage is selected ")
Else
	msgbox(0, "Option Selected ", "Option Freepage is Not selected ")
EndIf
If _IEFormElementOptionSelect($oSelect, 0, -1, "byIndex ") Then
	msgbox(0, "Option Selected ", "The First (index 0) option is selected ")
Else
	msgbox(0, "Option Selected ", "The First (index 0) option is Not selected ")
EndIf
If _IEFormElementOptionSelect($oSelect, "midipage.html ", -1, "byValue ") Then
	msgbox(0, "Option Selected ", "The option with value 'midipage.html' is selected ")
Else
	msgbox(0, "Option Selected ", "The option with value 'midipage.html' is NOT selected ")
EndIf

