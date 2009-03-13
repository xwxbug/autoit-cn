; *******************************************************
; Example 1 - Create a word window with a new blank document,
;				add a second blank document, and get a collection of the documents.
; *******************************************************
;
#include <Word.au3>
$oWordApp = _WordCreate ()
_WordDocAdd ($oWordApp)
$oDocuments = _WordDocGetCollection ($oWordApp)
MsgBox(0, "Document Count", @extended)
_WordQuit ($oWordApp)