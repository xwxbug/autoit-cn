; AutoIt V3.1.1++
;
; Test File
;
; Scripting.FileSystemObject example

; This example returns file information for AutoIt.exe

Local $objFS = ObjCreate("Scripting.FileSystemObject")

Local $strPath = @AutoItExe

Local $objFile = $objFS.GetFile($strPath)

With $objFile

	MsgBox(0, $strPath, _
			@AutoItExe & " " & @CRLF & _
			"File Version: " & $objFS.GetFileVersion($strPath) & @CRLF & _
			"File Size: " & Round((.Size / 1024), 2) & " KB" & @CRLF & _
			"Date Created: " & .DateCreated & @CRLF & _
			"Date Last Modified: " & .DateLastModified)

EndWith

