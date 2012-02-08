; Excel Automation Example
;
; Using direct assigments of 2-dimensional array's
;
; Based on AutoItCOM version 3.1.1
;
; Beta version 06-02-2005

Local $MyExcel = ObjCreate("Excel.Application") ; Create an Excel Object

If @error Then
	MsgBox(0, "", "Error creating Excel object. Error code: " & @error)
	Exit
EndIf

If Not IsObj($MyExcel) Then
	MsgBox(0, "ExcelTest", "I'm sorry, but creation of an Excel object failed.")
	Exit
EndIf


$MyExcel.Visible = 1 ; Let the guy show himself

$MyExcel.workbooks.add ; Add a new workbook

; Example: Fast Fill some cells

MsgBox(0, "", "Click 'ok' To fastfill some cells")

Local $arr[16][16]

For $i = 0 To 15
	For $j = 0 To 15
		$arr[$i][$j] = Chr($i + 65) & ($j + 1)
	Next
Next

; Set all values in one shot!
$MyExcel.activesheet.range("A1:O16").value = $arr


MsgBox(0, "", "Click 'ok' To clear the cells")

$MyExcel.activesheet.range("A1:O16").clear

Sleep(2000)

$MyExcel.activeworkbook.saved = 1 ; To prevent 'yes/no' questions from Excel

$MyExcel.quit ; Get rid of him.

MsgBox(0, "ExcelTest", "Is Excel gone now ?")
; Nope, only invisible,
; but should be still in memory.

$MyExcel = 0 ; Loose this object.
; Object will also be automatically discarded when you Exit the script

Exit

