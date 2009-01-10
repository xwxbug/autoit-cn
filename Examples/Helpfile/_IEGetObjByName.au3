; *******************************************************
; Example 1 - Open a browser to the form example, get an object reference
;				to the element with the name "ExampleForm".  In this case the
;				result is identical to using $oForm = _IEFormGetObjByName($oIE, "ExampleForm")
; *******************************************************
;
#include <IE.au3>
$oIE = _IE_Example ("form")
$oForm = _IEGetObjByName ($oIE, "ExampleForm")