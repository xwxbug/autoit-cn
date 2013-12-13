; Write to a Cell using a Loop, after opening a workbook and returning its object identifier.  Delete some columns, then Save and Close file.

#include <Excel.au3>
#include <MsgBoxConstants.au3>

Local $oExcel = _ExcelBookNew() ;Create new book, make it visible

$oExcel = _ExcelBookNew() ;Create new book, make it visible

For $i = 1 To 5 ;Loop
	_ExcelWriteCell($oExcel, $i, 1, $i) ;Write to the Cell Horizontally using values 1 to 5
Next

ToolTip("Deleting Columns Soon...")
Sleep(3500)

_ExcelColumnDelete($oExcel, 3, 2) ;Delete Columns starting at column 3, and delete 2 columns

MsgBox($MB_SYSTEMMODAL, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; Now we save it into the temp directory; overwrite existing file if necessary
_ExcelBookClose($oExcel) ; And finally we close out
