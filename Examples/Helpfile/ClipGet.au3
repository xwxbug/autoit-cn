Example()

Func Example()
	; Retrieve the data stored in the clipboard.
	Local $sData = ClipGet()

	; Display the data returned by ClipGet.
	MsgBox(4096, "", "The following data is stored in the clipboard: " & @CRLF & $sData)

	; Add new data to the clipboard.
	ClipPut("A new string added to the clipboard.")

	; Retrieve the data stored in the clipboard.
	$sData = ClipGet()

	; Display the data returned by ClipGet.
	MsgBox(4096, "", "The following data is now stored in the clipboard: " & @CRLF & $sData)
EndFunc   ;==>Example
