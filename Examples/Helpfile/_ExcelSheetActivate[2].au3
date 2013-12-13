; After opening a workbook and returning its object identifier, Activate a Sheet by using the Index Value the Sheet

#include <Excel.au3>
#include <MsgBoxConstants.au3>

Local $oExcel = _ExcelBookNew() ;Create new book, make it visible

Local $iNumberOfWorksheets = $oExcel.Worksheets.Count

MsgBox($MB_SYSTEMMODAL, "Count", "Number of sheets found = " & $oExcel.Worksheets.Count)
_ExcelSheetActivate($oExcel, 2)

MsgBox($MB_SYSTEMMODAL, "Sheet 2 active by index", "Notice How Sheet2 is Active and not Sheet1" & @CRLF & @CRLF & "Now Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; Now we save it into the temp directory; overwrite existing file if necessary
_ExcelBookClose($oExcel) ; And finally we close out
