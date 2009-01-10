; *******************************************************
; Example 1 - Open a browser with the form example, fill in a form field and
;				reset the form back to default values
; *******************************************************
;
#include <IE.au3>
$oIE = _IE_Example ("form")
$oForm = _IEFormGetObjByName ($oIE, "ExampleForm")
$oText = _IEFormElementGetObjByName ($oForm, "textExample")
_IEFormElementSetValue ($oText, "Hey! It works!")
_IEFormReset ($oForm)
