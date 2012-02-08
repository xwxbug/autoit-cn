; Excel Automation Example
;
; Based on AutoIt version 3.1.0
;
;
; Beta version 06-02-2005


; NOTE: This will open an existing instance of Excel

; So Excel must be started first!!

Local $oExcel = ObjGet("", "Excel.Application") ; Get an existing Excel Object

If @error Then
	MsgBox(0, "ExcelFileTest", "You don't have Excel running at this moment. Error code: " & Hex(@error, 8))
	Exit
EndIf

If IsObj($oExcel) Then MsgBox(0, "", "You successfully attached to the existing Excel Application.")


$oExcel.Visible = 1 ; Let the guy show himself

$oExcel.workbooks.add ; Add a new workbook

; Example: Fill some cells

MsgBox(0, "", "Click 'ok' to fill some cells")

Local $i
Local $j

With $oExcel.activesheet
	For $i = 1 To 15
		For $j = 1 To 15
			.cells($i, $j).value = $i
		Next
	Next

	MsgBox(0, "", "Click 'ok' to clear the cells")
	.range("A1:O15").clear

EndWith

Sleep(2000)

$oExcel.activeworkbook.saved = 1 ; To prevent 'yes/no' questions from Excel

$oExcel.quit ; Get rid of him.

MsgBox(0, "", "Is Excel gone now??") ; Nope, should be still in memory.

$oExcel = 0 ; Loose the object

Exit

