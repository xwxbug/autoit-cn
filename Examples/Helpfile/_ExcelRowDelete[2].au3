; Write to a Cell using a Loop, after opening a workbook and returning its object identifier.  Delete some rows, then Save and Close file.

#include <Excel.au3>
#include <MsgBoxConstants.au3>

Local $oExcel = _ExcelBookNew() ;Create new book, make it visible

For $i = 1 To 5 ;Loop
	_ExcelWriteCell($oExcel, $i, $i, 1) ;Write to the Cell Vertically using values 1 to 5
Next

ToolTip("Deleting Rows Soon...")
Sleep(3500)
ToolTip("")
_ExcelRowDelete($oExcel, 3, 2) ;Delete Rows starting at row 3, and delete 2 Rows

MsgBox($MB_SYSTEMMODAL, "Rows 3 + 4 deleted", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; Now we save it into the temp directory; overwrite existing file if necessary
_ExcelBookClose($oExcel) ; And finally we close out
