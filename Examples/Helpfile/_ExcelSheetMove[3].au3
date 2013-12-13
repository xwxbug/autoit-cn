; After opening a workbook and returning its object identifier, Move a Sheet by using the Index Value the Sheet

#include <Excel.au3>
#include <MsgBoxConstants.au3>

Local $oExcel = _ExcelBookNew() ;Create new book, make it visible

; Add some sheets, and do Some arranging
Local $sSheetName4 = "Sheet4"
Local $sSheetName5 = "Sheet5"
_ExcelSheetAddNew($oExcel, $sSheetName4) ;Add another sheet
_ExcelSheetMove($oExcel, $sSheetName4, 4, False) ;Move $sSheetName4 to the 4th position (false puts it after the relative sheet)

_ExcelSheetAddNew($oExcel, $sSheetName5) ;Add another sheet
_ExcelSheetMove($oExcel, $sSheetName5, 5, False) ;Move $sSheetName4 5th position (false puts it after the relative sheet)

MsgBox($MB_SYSTEMMODAL, "Show", "Take note of the order of the Worksheets" & @CRLF & @CRLF & "Press OK to Continue")

_ExcelSheetMove($oExcel, $sSheetName5, "Sheet3", True) ;Move the 5th sheet to the relative before position of the sheet named: 'Sheet3'
MsgBox($MB_SYSTEMMODAL, "Exiting", "'" & $sSheetName5 & "'" & " when the $fBefore paramter is True (Relative to 'Sheet3')" & @CRLF & @CRLF & "Press OK to Continue")
_ExcelSheetMove($oExcel, $sSheetName5, "Sheet3", False) ;Move the 5th sheet to the relative before position of the sheet named: 'Sheet3'
MsgBox($MB_SYSTEMMODAL, "Exiting", "'" & $sSheetName5 & "'" & " when the $fBefore paramter is False (Relative to 'Sheet3')" & @CRLF & @CRLF & "Now Press OK to Save File and Exit")

_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; Now we save it into the temp directory; overwrite existing file if necessary
_ExcelBookClose($oExcel) ; And finally we close out
