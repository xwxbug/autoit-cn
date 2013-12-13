; Open a new Excel Window and Close it, with default parameters

#include <Excel.au3>

Local $oExcel = _ExcelBookNew() ; Create a Microsoft Excel window
_ExcelBookClose($oExcel, 1, 0) ;This method will save then Close the file, without any of the normal prompts, regardless of changes
