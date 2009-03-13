; *******************************************************
; Example 1 - Create an invisible word window, open a
;               document, retrieve some information and Quit
; *******************************************************
;
#include <Word.au3>
$oWordApp = _WordCreate (@ScriptDir & "\Test.doc", 0, 0)
; Display the text within the document
$sText = $oWordApp.ActiveDocument.Range.Text
MsgBox(0, "Document Text", $sText)
_WordQuit ($oWordApp)