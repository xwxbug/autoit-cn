#include <Word.au3>
#include <MsgBoxConstants.au3>

; Create application object
Global $oWord = _Word_Create()
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocGet Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open \Extras\test.doc read-only
_Word_DocOpen($oWord, @ScriptDir & "\Extras\Test.doc", Default, Default, True)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocGet Example", "Error opening '.\Extras\Test.doc'." & @CRLF & _
		"@error = " & @error & ", @extended = " & @extended)
; Open \Extras\test2.doc read-only
_Word_DocOpen($oWord, @ScriptDir & "\Extras\Test2.doc", Default, Default, True)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocGet Example", "Error opening '.\Extras\Test2.doc'." & @CRLF & _
		"@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Get the first document in the collection, write name and total # of documents
; to the console.
; *****************************************************************************
Global $oDoc = _Word_DocGet($oWord, 1)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocGet Example", _
		"Error accessing collection of documents." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocGet Example", "First document in the document collection has been selected." & _
		@CRLF & "Name is: " & $oDoc.Name & @CRLF & "Total number of documents in the collection: " & @extended)
