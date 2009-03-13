; *******************************************************
; Example 1 - Open a browser to the basic example, get an object reference
;				to the DIV element with the ID "line1". Display the innerText
;				of this element to the console.
; *******************************************************
;
#include <IE.au3>
$oIE = _IE_Example ("basic")
$oDiv = _IEGetObjById ($oIE, "line1")
ConsoleWrite(_IEPropertyGet($oDiv, "innertext") & @CR)