#include <Word.au3>
#include <MsgBoxConstants.au3>

; Create application object
Global $oWord = _Word_Create()
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocAttach Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open test document read-only
_Word_DocOpen($oWord, @ScriptDir & "\Extras\Test.doc", Default, Default, True)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocAttach Example", "Error opening '.\Extras\Test.doc'." & _
		@CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Attach to the test document by "FileName" and set focus to the window
; *****************************************************************************
Global $oDoc = _Word_DocAttach($oWord, "Test.doc", "Filename")
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocAttach Example", _
		"Error attaching to '.\Extras\Test.doc' by 'FileName'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Set focus to the word document - $f_takeFocus parameter of the old _WordCreate function
WinActivate($oWord.ActiveWindow.Caption & " - " & $oWord.Caption)
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocAttach Example", "Attach to document by 'FileName' successfull!" & @CRLF & _
		@CRLF & "Text of the attached document:" & @CRLF & $oDoc.Range().Text)
