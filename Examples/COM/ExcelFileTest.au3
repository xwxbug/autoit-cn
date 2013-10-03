#include <Constants.au3>

; Excel file Automation Example
;
; Based on AutoItCOM version 3.1.0
;
; Beta version 06-02-2005

; An Excel file with filename Worksheet.xls must be created in the root directory
; of the C:\ drive in order for this example to work.

Local $FileName = @ScriptDir & "\Worksheet.xls"

If Not FileExists($FileName) Then
	MsgBox($MB_SYSTEMMODAL, "Excel File Test", "Can't run this test, because you didn't create the Excel file " & $FileName)
	Exit
EndIf

Local $oExcelDoc = ObjGet($FileName) ; Get an Excel Object from an existing filename

If IsObj($oExcelDoc) Then

	Local $String = "" ; String for displaying purposes

	; Some document properties do not return a value, we will ignore those.
	Local $OEvent = ObjEvent("AutoIt.Error", "nothing") ; Equal to VBscript's On Error Resume Next

	For $Property In $oExcelDoc.BuiltinDocumentProperties
		; $String = $String &  $Property.Name & ":" & $Property.Value & @CRLF
		$String = $String & $Property.Name & ":" & @CRLF
	Next

	MsgBox($MB_SYSTEMMODAL, "Excel File Test", "The document properties of " & $FileName & " are:" & @CRLF & @CRLF & $String)

	$oExcelDoc.Close ; Close the Excel document

Else
	MsgBox($MB_SYSTEMMODAL, "Excel File Test", "Error: Could not open " & $FileName & " as an Excel Object.")
EndIf
