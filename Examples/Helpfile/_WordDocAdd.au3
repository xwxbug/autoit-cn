; *******************************************************
; Example 1 - Create an empty word window and add a new blank document
; *******************************************************
;
#include <Word.au3>
$oWordApp = _WordCreate ("")
$oDoc = _WordDocAdd ($oWordApp)