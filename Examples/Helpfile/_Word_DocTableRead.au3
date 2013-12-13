#include <Word.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>

; Create application object
Global $oWord = _Word_Create()
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocTableRead Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open the test document
Global $oDoc = _Word_DocOpen($oWord, @ScriptDir & "\Extras\Test.doc", Default, Default, True)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocTableRead Example", _
		"Error opening '.\Extras\Test.doc'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Create a table from an array
Global $asArray[3][3] = [[1, 2, 3],["a", "b", "c"],["x", "y", "z"]]
Global $oRange = _Word_DocRangeSet($oDoc, -2)
Global $oTable = _Word_DocTableWrite($oRange, $asArray, 0)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocTableRead Example", _
		"Error creating the table." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Read the first table in the document and return the content
; *****************************************************************************
Global $asResult = _Word_DocTableRead($oDoc, 1, 1)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocTableRead Example", _
		"Error reading the table to an array." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
_ArrayDisplay($asResult, "Word UDF: _Word_DocTableRead Example")
