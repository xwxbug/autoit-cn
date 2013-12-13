; Create a new book, write data to 10 rows and 4 columns,
; use a separate formatting string for each column

#include <Excel.au3>
#include <MsgBoxConstants.au3>

Example()
Exit

Func Example()
	Local $oExcel = _ExcelBookNew() ; Create new book, make it visible
	Local $aFormatExamples[5] = ["Format Examples", "General", "hh:mm:ss", "$#,##0.00", "[Red]($#,##0.00)"] ; Array of formatting strings
	For $i = 0 To UBound($aFormatExamples) - 1 ; Write formatting strings as column headers
		_ExcelWriteCell($oExcel, $aFormatExamples[$i], 1, $i + 1) ; +1 to $i so that 0-base index and row match
	Next
	; Fill some cells with random numbers
	For $y = 2 To 5
		For $x = 2 To 10
			_ExcelWriteCell($oExcel, Random(1000, 10000), $x, $y)
		Next
	Next
	$oExcel.Columns.AutoFit ; AutoFits the Columns for better viewing
	$oExcel.Rows.AutoFit ; AutoFits the Rows for better viewing
	MsgBox($MB_SYSTEMMODAL, "Formatting", "Formatting columns soon...", 3)
	; Each Column will have a different format
	For $i = 1 To UBound($aFormatExamples) - 1
		_ExcelNumberFormat($oExcel, $aFormatExamples[$i], 2, $i + 1, 11, $i + 1)
		If @error Then MsgBox($MB_SYSTEMMODAL, "Error", "Formatting string '" & $aFormatExamples[$i] & "' is invalid." & @CRLF & "This can be caused by wrong formatting strings if running on a non english system.")
	Next
	MsgBox($MB_SYSTEMMODAL, "Exiting", "Press OK to Exit Example 2")
	_ExcelBookClose($oExcel, 0) ; Close and drop changes
EndFunc   ;==>Example
