; Example getting an Object using it's class name
;
; Excel must be activated for this example to be successfull

$oExcel = ObjGet("","Excel.Application")	; Get an existing Excel Object

if @error then 
  Msgbox (0,"ExcelTest","Error Getting an active Excel Object. Error code: " & hex(@error,8))
  exit
endif

$oExcel.Visible = 1		; Let the guy show himself
$oExcel.workbooks.add		; Add a new workbook
exit



; Example getting an Object using a file name
;
; An Excel file with filename Worksheet.xls must be created in the root directory
; of the C:\ drive in order for this example to work.

$FileName="C:\Worksheet.xls"

if not FileExists($FileName) then
  Msgbox (0,"Excel File Test","Can't run this test, because you didn't create the Excel file "& $FileName)
  Exit
endif

$oExcelDoc = ObjGet($FileName)	; Get an Excel Object from an existing filename

if IsObj($oExcelDoc) then

  ; Tip: Uncomment these lines to make Excel visible (credit: DaleHohm)
  ; $oExcelDoc.Windows(1).Visible = 1; Set the first worksheet in the workbook visible
  ; $oExcelDoc.Application.Visible = 1; Set the application visible (without this Excel will exit)

  $String = ""		; String for displaying purposes

  ; Some document properties do not return a value, we will ignore those.
  $OEvent=ObjEvent("AutoIt.Error","nothing"); Equal to VBscript's On Error Resume Next
  
  For $Property In $oExcelDoc.BuiltinDocumentProperties
     $String = $String &  $Property.Name & ":" & $Property.Value & @CRLF
  Next

  Msgbox(0,"Excel File Test","The document properties of " & $FileName & " are:" & @CRLF & @CRLF & $String)

  $oExcelDoc.Close		; Close the Excel document

else
  Msgbox (0,"Excel File Test","Error: Could not open "& $FileName & " as an Excel Object.")
endif
