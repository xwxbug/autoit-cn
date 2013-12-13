; Write to a Cell using a Loop, after opening a workbook and returning its object identifier.  Then Save and Close file.

#include <Excel.au3>
#include <MsgBoxConstants.au3>

Local $oExcel = _ExcelBookNew() ;Create new book, make it visible

For $i = 1 To 20 ;Loop
	_ExcelWriteCell($oExcel, "I Wrote to This Cell", $i, 1) ;Write to the Cell
Next

MsgBox($MB_SYSTEMMODAL, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; Now we save it into the temp directory; overwrite existing file if necessary
_ExcelBookClose($oExcel) ; And finally we close out
