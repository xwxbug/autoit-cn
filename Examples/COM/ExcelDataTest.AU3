; ExcelDataTest.AU3
;
; Retrieves information from an Excel sheet
; Modifies the data
; Returns the modified data in back in the sheet


Local $FileName = "C:\temp\test.xls" ; Change this to the path/name of your Excel sheet
$FileName = @ScriptDir & "\Worksheet.xls"
Local $CellRange = "A1:E3" ; Change this to the range of cells you want to modify

If Not FileExists($FileName) Then ; Just a check to be sure..
	MsgBox(0, "Excel Data Test", "Error: Can't find file " & $FileName)
	Exit
EndIf

Local $oExcelDoc = ObjGet($FileName) ; Get an Excel Object from an existing filename

If (Not @error) And IsObj($oExcelDoc) Then ; Check again If everything went well
	; NOTE: $oExcelDoc is a "Workbook Object", Not Excel itself!
	Local $oDocument = $oExcelDoc.Worksheets(1) ; We use the 'Default' worksheet

	Local $aArray = $oDocument.range($CellRange).value ; Retrieve the cell values from given range

	; The data should now be in the 2-dimensional array: $aArray

	If IsArray($aArray) And UBound($aArray, 0) > 0 Then ; Check If we retrieved any data

		MsgBox(0, "Excel Data Test", "Debugging information for retrieved cells:" & @CRLF & _
				"Number of dimensions: " & UBound($aArray, 0) & @CRLF & _
				"Size of first dimension: " & UBound($aArray, 1) & @CRLF & _
				"Size of second dimension: " & UBound($aArray, 2))

		; The next lines are just for debugging purposes, it puts all cell values into
		; a string to display in a MsgBox.
		; Note: you can't use a FOR..IN loop for a multi-dimensional array!

		Local $string = ""
		For $x = 0 To UBound($aArray, 1) - 1
			For $y = 0 To UBound($aArray, 2) - 1
				$string = $string & "(" & $x & "," & $y & ")=" & $aArray[$x][$y] & @CRLF
			Next
		Next
		MsgBox(0, "Excel Data Test", "Debug information: Read Cell contents: " & @CRLF & $string)


		; Now we modify the data
		$aArray[0][0] = "This is cell A1"
		$aArray[1][1] = "This is cell B2"

		$oDocument.range($CellRange).value = $aArray ; Write the data back in one shot

		$oExcelDoc.Windows(1).Visible = True ; Otherwise the worksheet window will be saved 'hidden'
		$oExcelDoc.Save ; Save the workbook

	Else
		MsgBox(0, "Excel Data Test", "Error: Could Not retrieve data from cell range: " & $CellRange)
	EndIf

	$oExcelDoc.saved = 1 ; Prevent questions from excel to save the file
	$oExcelDoc.close ; Get rid of Excel.
Else
	MsgBox(0, "Excel Data Test", "Error: Could Not open " & $FileName & " as an Excel Object.")
EndIf

$oExcelDoc = 0
