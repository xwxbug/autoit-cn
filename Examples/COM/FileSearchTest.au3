; AutoItCOM 3.1.1
;
; Test File
;
; Tests the SearchFiles() function of Microsoft Excel


Func SearchFiles($strFileSpec, $Subdirs = 0)

	Local $strFileList = ""

	Local $oXlApp = ObjCreate("Excel.Application")

	Local $fsoFileSearch = $oXlApp.FileSearch

	If @error Then
		MsgBox(0, "SearchFiles", "Error opening FileSearch Object")
	Else
		With $fsoFileSearch
			.NewSearch
			.LookIn = "c:\"
			.FileName = $strFileSpec
			.SearchSubFolders = $Subdirs

			Local $Number = .Execute()
			If $Number > 0 Then
				For $i = 1 To .FoundFiles.Count
					$strFileList = $strFileList & .FoundFiles($i) & @CRLF
				Next
			EndIf
		EndWith
	EndIf

	$fsoFileSearch = ""

	$oXlApp.quit

	$oXlApp = ""

	Return $strFileList
EndFunc   ;==>SearchFiles



; Example usage:

Local $Result = SearchFiles(@WindowsDir & "\*.txt", 0)

MsgBox(0, "FileSearch Object test", "SearchFiles on '" & @WindowsDir & "\*.txt' resulted in:" & @CRLF & @CRLF & $Result)

