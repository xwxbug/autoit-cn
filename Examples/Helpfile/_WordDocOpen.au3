; *******************************************************
; Example 1 - Create an empty word window and open an existing document
; *******************************************************
;
#include <Word.au3>
$oWordApp = _WordCreate ("")
$oDoc = _WordDocOpen ($oWordApp, @ScriptDir & "\Test.doc")