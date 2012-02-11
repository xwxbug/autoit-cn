Example()

Func Example()
	; Create an INI section structure as an array. The 0th element is how many items are in the array, in this case 3.
	Local $aSection[4][2] = [[3, ""],["Title", "AutoIt"],["Version", @AutoItVersion],["OS", @OSVersion]]

	; Write the array to the section labelled 'General'.
	IniWriteSection(@ScriptDir & "\Example.ini", "General", $aSection)

	; Read the INI section labelled 'General'. This will return a 2 dimensional array.
	Local $aArray = IniReadSection(@ScriptDir & "\Example.ini", "General")

	; Check if an error occurred.
	If Not @error Then
		; Enumerate through the array displaying the keys and their respective values.
		For $i = 1 To $aArray[0][0]
			MsgBox(4096, "", "Key: " & $aArray[$i][0] & @CRLF & "Value: " & $aArray[$i][1])
		Next
	EndIf

	; Delete the INI file.
	FileDelete(@ScriptDir & "\Example.ini")
EndFunc   ;==>Example
