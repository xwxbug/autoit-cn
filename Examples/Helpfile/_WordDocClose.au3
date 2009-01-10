; *******************************************************
; Example 1 - Create an empty word window, open an existing document,
;				close the document and quit.
; *******************************************************
;
#include <Word.au3>
$oWordApp = _WordCreate ("")
$oDoc = _WordDocOpen ($oWordApp, @ScriptDir & "\Test.doc")
_WordDocClose ($oDoc)
_WordQuit ($oWordApp)