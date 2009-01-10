; *******************************************************
; Example 1 - Create an invisible browser window, navigate to a
;				website, retrieve some information and Quit
; *******************************************************
;
#include <IE.au3>
$oIE = _IECreate ("http://sourceforge.net", 0, 0)
; Display the innerText on an element on the page with a name of "sfmarquee"
$oMarquee = _IEGetObjByName ($oIE, "sfmarquee")
MsgBox(0, "SourceForge Information", $oMarquee.innerText)
_IEQuit ($oIE)