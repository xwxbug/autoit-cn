; Excel Automation Example
;
; Testfile For AutoIt 3.1.1.x
;

Local $MyExcel = ObjCreate("Excel.Application") ; Create an Excel Object

If @error Then
	MsgBox(0, "ExcelTest", "Error creating the Excel Object. Error code: " & @error)
	Exit
EndIf

If Not IsObj($MyExcel) Then
	MsgBox(0, "ExcelTest", "I'm sorry, but creation of the Excel object failed.")
	Exit
EndIf


$MyExcel.Visible = 1 ; Let the guy show himself

$MyExcel.workbooks.add ; Add a new workbook

; Example: Fill some cells

MsgBox(0, "", "Click 'ok' to fill some cells")

Local $i
Local $j

With $MyExcel.activesheet
	For $i = 1 To 15
		For $j = 1 To 15
			.cells($i, $j).value = $i
		Next
	Next

	MsgBox(0, "", "Click 'ok' to clear the cells")
	.range("A1:O15").clear

EndWith

Sleep(2000)

$MyExcel.activeworkbook.saved = 1 ; To prevent 'yes/no' questions from Excel

$MyExcel.quit ; Get rid of him.

MsgBox(0, "ExcelTest", "Is Excel gone now ?")
; Nope, only invisible,
; but should be still in memory.

$MyExcel = "" ; Only now Excel is removed from memory.

Exit

