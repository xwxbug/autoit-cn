#include <Word.au3>
#include <MsgBoxConstants.au3>

; Create application object
Global $oWord = _Word_Create()
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocTableWrite Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open the test document
Global $oDoc = _Word_DocOpen($oWord, @ScriptDir & "\Extras\Test.doc", Default, Default, True)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocTableWrite Example", _
		"Error opening '.\Extras\Test.doc'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Write the content of a 0-based two dimensional array to a Word table
; *****************************************************************************
Global $asArray[3][3] = [[1, 2, 3],["a", "b", "c"],["x", "y", "z"]]
Global $oRange = _Word_DocRangeSet($oDoc, -2)
_Word_DocTableWrite($oRange, $asArray, 0)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocTableWrite Example", _
		"Error creating the table." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocTableWrite Example", _
		"Table successfully added to the end of the document.")
