Example()

Func Example()
	; Create an INI section structure as a string.
	Local $sSection = "Title=AutoIt" & @LF & "Version=" & @AutoItVersion & @LF & "OS=" & @OSVersion

	; Write the string to the section labelled 'General'.
	IniWriteSection(@ScriptDir & "\Example.ini", "General", $sSection)

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
