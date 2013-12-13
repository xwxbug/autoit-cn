#include <Word.au3>
#include <MsgBoxConstants.au3>

; Create application object
Global $oWord = _Word_Create()
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocPrint Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open test document
Global $oDoc = _Word_DocOpen($oWord, @ScriptDir & "\Extras\Test.doc", Default, Default, True)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocPrint Example", _
		"Error opening '.\Extras\Test.doc'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Export the complete document with default values
; *****************************************************************************
Global $sFilename = @TempDir & "\Test1.pdf"
_Word_DocExport($oDoc, $sFilename)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocExport Example", _
		"Error exporting the document." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
ShellExecute($sFilename)
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocExport Example", _
		"The whole document has successfully been exported to: " & $sFilename)
