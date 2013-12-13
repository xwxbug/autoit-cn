#include <FileConstants.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Create a constant variable in Local scope of the filepaths that will be renamed.
	Local Const $sSource = @TempDir & "\FileMove.txt", _
			$sDestination = @TempDir & "\FileMove_New.txt"

	; Create a temporary file to rename.
	If Not FileCreate($sSource, "This is an example of using FileMove.") Then Return MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst writing the temporary file.")

	; Rename a file using FileMove and overwrite the new file if it exists.
	FileMove($sSource, $sDestination, $FC_OVERWRITE)

	; Display results that the destination file was renamed.
	MsgBox($MB_SYSTEMMODAL, "", "Does FileMove.txt exist?: " & FileExists($sSource) & @CRLF & _ ; FileExists should return 0.
			"Does FileMove_New.txt exist?: " & FileExists($sDestination) & @CRLF) ; FileExists should return 1.

	; Delete the temporary files. FileDelete checks if the file exists.
	FileDelete($sSource)
	FileDelete($sDestination)
EndFunc   ;==>Example

; Create a file.
Func FileCreate($sFilePath, $sString)
	Local $fReturn = True ; Create a variable to store a boolean value.
	If FileExists($sFilePath) = 0 Then $fReturn = FileWrite($sFilePath, $sString) = 1 ; If FileWrite returned 1 this will be True otherwise False.
	Return $fReturn ; Return the boolean value of either True of False, depending on the return value of FileWrite.
EndFunc   ;==>FileCreate
