; After opening a workbook and returning its object identifier, create an array of all the Sheet Names in the workbook
; and Activate each Sheet by String Name

#include <Excel.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>

Local $oExcel = _ExcelBookNew() ;Create new book, make it visible

Local $aArray = _ExcelSheetList($oExcel)

For $i = $aArray[0] To 1 Step -1 ;Work backwards through loop
	_ExcelSheetActivate($oExcel, $aArray[$i]) ;Using the String Name returned in the Array Elements
	MsgBox($MB_SYSTEMMODAL, "ActiveSheet", "The Active Sheet should be:" & @CRLF & $aArray[$i])
Next

MsgBox($MB_SYSTEMMODAL, "Exiting", "Press OK to Save File and Exit")
_ExcelBookSaveAs($oExcel, @TempDir & "\Temp.xls", "xls", 0, 1) ; Now we save it into the temp directory; overwrite existing file if necessary
_ExcelBookClose($oExcel) ; And finally we close out
