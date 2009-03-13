; ***************************************************************
; Example 1 - Open an existing workbook and returns its object identifier.
; *****************************************************************

#include <Excel.au3>

$sFilePath1 = @ScriptDir & "\Test1.xls" ;This file should already exist
$oExcel = _ExcelBookOpen($sFilePath1)

If @error = 1 Then
	MsgBox(0, "Error!", "Unable to Create the Excel Object")
	Exit
ElseIf @error = 2 Then
	MsgBox(0, "Error!", "File does not exist - Shame on you!")
	Exit
EndIf