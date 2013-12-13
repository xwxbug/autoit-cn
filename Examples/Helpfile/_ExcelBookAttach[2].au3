; Attach to the first existing instance of Microsoft Excel where the search string matches based on the selected mode.

#include <Excel.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>

Local $sFilePath = @TempDir & "\Temp.xls"
If Not _FileCreate($sFilePath) Then ;Create an .XLS file to attach to
	MsgBox($MB_SYSTEMMODAL, "Error", " Error Creating File - " & @error)
EndIf

_ExcelBookOpen($sFilePath)
Local $oExcel = _ExcelBookAttach("Temp.xls", "FileName") ;with $s_mode = "FileName" ==> Name of the open workbook
_ExcelWriteCell($oExcel, "If you can read this, then Success!", 1, 1) ;Write to the Cell
MsgBox($MB_SYSTEMMODAL, "Exiting", "Press OK to Save File and Exit")
_ExcelBookClose($oExcel, 1, 0) ;This method will save then Close the file, without any of the normal prompts, regardless of changes
