; *******************************************************
; Example 1 - Create browser windows with each of the example pages displayed.
;				The object variable returned can be used just as the object
;				variables returned by _IECreate or _IEAttach
; *******************************************************
;
#include <IE.au3>
$oIE_basic = _IE_Example ("basic")
$oIE_form = _IE_Example ("form")
$oIE_table = _IE_Example ("table")
$oIE_frameset = _IE_Example ("frameset")
$oIE_iframe = _IE_Example ("iframe")