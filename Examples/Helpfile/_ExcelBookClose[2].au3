; Open a new Excel Window and Close it, with default parameters

#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ; Create a Microsoft Excel window
_ExcelBookClose($oExcel, 0) ;This method will either: 1) Close the file, or 2) if a change has been made to the Excel Window, then Prompt the user
