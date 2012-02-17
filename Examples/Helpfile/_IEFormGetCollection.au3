; *******************************************************
; 示例 1 - 根据基于 0 的索引获取到指定表单的引用,
;				此时是页面上首个表单
; *******************************************************

#include <IE.au3>

Local $oIE = _IECreate("http://www.google.com")
Local $oForm = _IEFormGetCollection($oIE, 0)
Local $oQuery = _IEFormElementGetCollection($oForm, 1)
_IEFormElementSetValue($oQuery, "AutoIt IE.au3")
_IEFormSubmit($oForm)

; *******************************************************
; 示例 2 - 获取到页面上表单集合的引用,
;				然后对其进行循环显示其中每个的信息
; *******************************************************

#include <IE.au3>

$oIE = _IECreate("http://www.autoitscript.com")
Local $oForms = _IEFormGetCollection($oIE)
MsgBox(4096, "Forms Info", "There are " & @extended & " forms on this page")
For $oForm In $oForms
	MsgBox(4096, "Form Info", $oForm.name)
Next

; *******************************************************
; 示例 3 - 获取到页面上表单集合的引用,
;				然后对其进行循环显示其中每个的信息
;				演示表单索引的使用
; *******************************************************

#include <IE.au3>

$oIE = _IECreate("http://www.autoitscript.com")
$oForms = _IEFormGetCollection($oIE)
Local $iNumForms = @extended
MsgBox(4096, "Forms Info", "There are " & $iNumForms & " forms on this page")
For $i = 0 To $iNumForms - 1
	$oForm = _IEFormGetCollection($oIE, $i)
	MsgBox(4096, "Form Info", $oForm.name)
Next
