; After opening a workbook and returning its object identifier, Add a New Sheet and Return the Active Sheet Name

#include <Excel.au3>
#include <MsgBoxConstants.au3>

Local $oExcel = _ExcelBookNew() ;Create new book, make it visible

MsgBox($MB_SYSTEMMODAL, "Sheet Name", "The Current Active Sheet Name Is:" & @CRLF & _ExcelSheetNameGet($oExcel))

_ExcelSheetAddNew($oExcel, "New Sheet Example") ;Add a New Sheet

MsgBox($MB_SYSTEMMODAL, "Sheet Name", "Now The Current Active Sheet Name Is:" & @CRLF & _ExcelSheetNameGet($oExcel))

MsgBox($MB_SYSTEMMODAL, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; Now we save it into the temp directory; overwrite existing file if necessary
_ExcelBookClose($oExcel) ; And finally we close out
