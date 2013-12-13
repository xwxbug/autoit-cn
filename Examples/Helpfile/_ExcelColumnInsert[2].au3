; Write to a Cell using a Loop, after opening a workbook and returning its object identifier.  Insert columns, then Save and Close file.

#include <Excel.au3>
#include <MsgBoxConstants.au3>

Local $oExcel = _ExcelBookNew() ;Create new book, make it visible

; We can fill-up some cells using a simple loop and random Numbers
For $i = 1 To 10
	For $j = 1 To 10
		_ExcelWriteCell($oExcel, Round(Random(1, 100), 0), $i, $j) ;Round off some random numbers to file
	Next
Next

ToolTip("Inserting Column(s) Soon...")
Sleep(3500) ;Pause to let user view action

_ExcelColumnInsert($oExcel, 2, 3) ;Insert 3 Columns at column 2

MsgBox($MB_SYSTEMMODAL, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; Now we save it into the temp directory; overwrite existing file if necessary
_ExcelBookClose($oExcel) ; And finally we close out
