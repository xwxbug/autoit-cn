#include <Word.au3>
#include <MsgBoxConstants.au3>

; Create application object
Global $oWord = _Word_Create()
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocFindReplace Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open test document read-only
Global $oDoc = _Word_DocOpen($oWord, @ScriptDir & "\Extras\Test.doc", Default, Default, True)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocFindReplace Example", _
		"Error opening '.\Extras\Test.doc'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Change "test document" to "test document with replaced text".
; *****************************************************************************
_Word_DocFindReplace($oDoc, "test document", "test document with replaced text")
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocFindReplace Example", _
		"Error replacing text in the document." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocFindReplace Example", "Text successfully replaced.")
