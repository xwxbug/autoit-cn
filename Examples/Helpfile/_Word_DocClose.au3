#include <Word.au3>
#include <MsgBoxConstants.au3>

; Create application object
Global $oWord = _Word_Create()
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocClose Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open test document read-only
Global $oDoc = _Word_DocOpen($oWord, @ScriptDir & "\Extras\Test.doc", Default, Default, True)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocClose Example", _
		"Error opening '.\Extras\Test.doc'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Close a Word coument
; *****************************************************************************
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocClose Example", "Press 'OK' to close document '.\Extras\Test.doc'.")
_Word_DocClose($oDoc)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocClose Example", _
		"Error closing document '.\Extras\Test.doc'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocClose Example", "The document has been closed successfully.")
