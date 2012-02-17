; *******************************************************
; 示例1 - 打开带有表单示例的浏览器, 获取表单的引用. 
;				通过值选定或不选定复选框. 由于未指定$s_Name,
;				对表单中所有的<input type=checkbox>元素集合进行操作
;				注意: 为查看变化你可能需要向下滚动页面
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("form")
Local $oForm = _IEFormGetObjByName($oIE, "ExampleForm")
For $i = 1 To 5
	_IEFormElementCheckBoxSelect($oForm, "gameBasketball", "", 1, "byValue")
	Sleep(1000)
	_IEFormElementCheckBoxSelect($oForm, "gameFootball", "", 1, "byValue")
	Sleep(1000)
	_IEFormElementCheckBoxSelect($oForm, "gameTennis", "", 1, "byValue")
	Sleep(1000)
	_IEFormElementCheckBoxSelect($oForm, "gameBaseball", "", 1, "byValue")
	Sleep(1000)
	_IEFormElementCheckBoxSelect($oForm, "gameBasketball", "", 0, "byValue")
	Sleep(1000)
	_IEFormElementCheckBoxSelect($oForm, "gameFootball", "", 0, "byValue")
	Sleep(1000)
	_IEFormElementCheckBoxSelect($oForm, "gameTennis", "", 0, "byValue")
	Sleep(1000)
	_IEFormElementCheckBoxSelect($oForm, "gameBaseball", "", 0, "byValue")
	Sleep(1000)
Next

; *******************************************************
; 示例2 - 打开带有表单示例的浏览器, 获取表单的引用. 
;				通过索引选定或不选定复选框. 由于未指定$s_Name
;				对表单中所有的<input type=checkbox>元素集合进行操作
;				注意: 为查看变化你可能需要向下滚动页面
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("form")
$oForm = _IEFormGetObjByName($oIE, "ExampleForm")
For $i = 1 To 5
	_IEFormElementCheckBoxSelect($oForm, 3, "", 1, "byIndex")
	Sleep(1000)
	_IEFormElementCheckBoxSelect($oForm, 2, "", 1, "byIndex")
	Sleep(1000)
	_IEFormElementCheckBoxSelect($oForm, 1, "", 1, "byIndex")
	Sleep(1000)
	_IEFormElementCheckBoxSelect($oForm, 0, "", 1, "byIndex")
	Sleep(1000)
	_IEFormElementCheckBoxSelect($oForm, 3, "", 0, "byIndex")
	Sleep(1000)
	_IEFormElementCheckBoxSelect($oForm, 2, "", 0, "byIndex")
	Sleep(1000)
	_IEFormElementCheckBoxSelect($oForm, 1, "", 0, "byIndex")
	Sleep(1000)
	_IEFormElementCheckBoxSelect($oForm, 0, "", 0, "byIndex")
	Sleep(1000)
Next

; *******************************************************
; 示例3 - 打开带有表单示例的浏览器, 获取表单的引用.
;				通过checkboxG2Example组中的索引选定或不选定复选框.
;				注意: 为查看变化你可能需要向下滚动页面
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("form")
$oForm = _IEFormGetObjByName($oIE, "ExampleForm")
For $i = 1 To 5
	_IEFormElementCheckBoxSelect($oForm, 0, "checkboxG2Example", 1, "byIndex")
	Sleep(1000)
	_IEFormElementCheckBoxSelect($oForm, 1, "checkboxG2Example", 1, "byIndex")
	Sleep(1000)
	_IEFormElementCheckBoxSelect($oForm, 0, "checkboxG2Example", 0, "byIndex")
	Sleep(1000)
	_IEFormElementCheckBoxSelect($oForm, 1, "checkboxG2Example", 0, "byIndex")
	Sleep(1000)
Next
