Local $oExcel = ObjCreate("Excel.Application")	;本例需要安装office
$oExcel.visible = 1
$oExcel.workbooks.add

With $oExcel.activesheet
	.cells(2, 2).value = 1
	.range("A1:B2" ).clear
EndWith

$oExcel.quit
