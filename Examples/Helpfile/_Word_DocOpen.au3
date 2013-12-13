#include <Word.au3>
#include <MsgBoxConstants.au3>

; Create application object
Global $oWord = _Word_Create()
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocOpen Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Open a document read-only
; *****************************************************************************
Global $sDocument = @ScriptDir & "\Extras\Test.doc"
_Word_DocOpen($oWord, $sDocument, Default, Default, True)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocOpen Example 1", "Error opening '.\Extras\Test.doc'." & _
		@CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocOpen Example 1", "Document '" & $sDocument & "' has been opened successfully.")
