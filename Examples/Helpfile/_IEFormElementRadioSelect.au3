; *******************************************************
; 示例1 - 打开带有表单示例的浏览器, 获取表单的引用, 通过值选定每个单选框,
;				然后反选最后一项并保留未选定.
;				注意: 为查看变化你可能需要向下滚动页面
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("form")
Local $oForm = _IEFormGetObjByName($oIE, "ExampleForm")
For $i = 1 To 5
	_IEFormElementRadioSelect($oForm, "vehicleAirplane", "radioExample", 1, "byValue")
	Sleep(1000)
	_IEFormElementRadioSelect($oForm, "vehicleTrain", "radioExample", 1, "byValue")
	Sleep(1000)
	_IEFormElementRadioSelect($oForm, "vehicleBoat", "radioExample", 1, "byValue")
	Sleep(1000)
	_IEFormElementRadioSelect($oForm, "vehicleCar", "radioExample", 1, "byValue")
	Sleep(1000)
	_IEFormElementRadioSelect($oForm, "vehicleCar", "radioExample", 0, "byValue")
	Sleep(1000)
Next

; *******************************************************
; 示例2 - 打开带有表单示例的浏览器, 获取表单的引用, 
;				通过索引选定每个单选框, 然后反选最后一项并保留未选定.
;				注意: 为查看变化你可能需要向下滚动页面
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("form")
$oForm = _IEFormGetObjByName($oIE, "ExampleForm")
For $i = 1 To 5
	_IEFormElementRadioSelect($oForm, 3, "radioExample", 1, "byIndex")
	Sleep(1000)
	_IEFormElementRadioSelect($oForm, 2, "radioExample", 1, "byIndex")
	Sleep(1000)
	_IEFormElementRadioSelect($oForm, 1, "radioExample", 1, "byIndex")
	Sleep(1000)
	_IEFormElementRadioSelect($oForm, 0, "radioExample", 1, "byIndex")
	Sleep(1000)
	_IEFormElementRadioSelect($oForm, 0, "radioExample", 0, "byIndex")
	Sleep(1000)
Next
