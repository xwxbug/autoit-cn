; *******************************************************
; Example 1 - Get a reference to a specific form element by 0-based index.
;				In this case, submit a query to the Google search engine
; *******************************************************
;
#include <IE.au3>
$oIE = _IECreate ("http://www.google.com")
$oForm = _IEFormGetCollection ($oIE, 0)
$oQuery = _IEFormElementGetCollection ($oForm, 1)
_IEFormElementSetValue ($oQuery, "AutoIt IE.au3")
_IEFormSubmit ($oForm)