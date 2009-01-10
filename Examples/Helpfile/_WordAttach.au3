; *******************************************************
; Example 1 - Attach to a word window with an open file named "Test.doc",
;				then display the documents full file path.
; *******************************************************
;
#include <Word.au3>
$oWordApp = _WordAttach ("Test.doc", "FileName")
If Not @error Then
	$oDoc = _WordDocGetCollection ($oWordApp, 0)
	MsgBox(64, "Document FileName", $oDoc.FullName)
EndIf

; *******************************************************
; Example 2 - Attach to a word window with "The quick brown fox"
;               in the text of the document
; *******************************************************
;
#include <Word.au3>
$oWordApp = _WordAttach ("The quick brown fox", "Text")